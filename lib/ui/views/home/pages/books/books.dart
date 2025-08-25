import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/constants/app_routes.dart';
import '../../../../cubit/book/get_books/get_books_cubit.dart';
import '../../../../shared/constants/ui_colors.dart';
import '../../../../shared/constants/ui_strings.dart';
import '../../widgets/search_field.dart';

part 'widgets/_book_card.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    context.read<GetBooksCubit>().getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: UiColors.background,
      child: SafeArea(
        child: Column(
          children: [
            SearchField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              onPressed: () => context.push(AppRoutes.createBook.path),
            ),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: UiColors.white,
                color: UiColors.primaryColor,
                onRefresh: () async {
                  context.read<GetBooksCubit>().getBooks(forceRefresh: true);
                },
                child: BlocBuilder<GetBooksCubit, GetBooksState>(
                  builder: (context, state) {
                    if (state is GetBooksLoading) {
                      return const Center(child: CircularProgressIndicator(color: UiColors.primaryColor));
                    }
                    if (state is GetBooksError) {
                      return Center(child: Text(state.errorMessage, style: TextStyle(color: UiColors.error)));
                    }
                    if (state is GetBooksSuccess) {
                      final books =
                          state.response
                              .where((book) => book.title?.toLowerCase().contains(_searchQuery) ?? false)
                              .toList();

                      if (books.isEmpty) {
                        return const Center(child: Text(UiStrings.bookNotFound));
                      }

                      return ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final book = books[index];
                          return _BookCard(
                            title: book.title,
                            imageBase64: book.imageBase64,
                            onTap: () => context.push(AppRoutes.bookDetails.path, extra: book),
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
