import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/constants/app_routes.dart';
import '../../../../cubit/author/get_authors/get_authors_cubit.dart';
import '../../../../shared/constants/ui_colors.dart';
import '../../../../shared/constants/ui_strings.dart';
import '../../widgets/search_field.dart';

part 'widgets/_author_card.dart';

class AuthorsPage extends StatefulWidget {
  const AuthorsPage({super.key});

  @override
  State<AuthorsPage> createState() => _AuthorsPageState();
}

class _AuthorsPageState extends State<AuthorsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    context.read<GetAuthorsCubit>().getAuthors();
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
              onPressed: () => context.push(AppRoutes.createAuthor.path),
            ),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: UiColors.white,
                color: UiColors.primaryColor,
                onRefresh: () async {
                  context.read<GetAuthorsCubit>().getAuthors(forceRefresh: true);
                },
                child: BlocBuilder<GetAuthorsCubit, GetAuthorsState>(
                  builder: (context, state) {
                    if (state is GetAuthorsLoading) {
                      return const Center(child: CircularProgressIndicator(color: UiColors.primaryColor));
                    }
                    if (state is GetAuthorsError) {
                      return Center(child: Text(state.errorMessage, style: TextStyle(color: UiColors.error)));
                    }
                    if (state is GetAuthorsSuccess) {
                      final authors =
                          state.response
                              .where((author) => author.name?.toLowerCase().contains(_searchQuery) ?? false)
                              .toList();

                      if (authors.isEmpty) {
                        return const Center(child: Text(UiStrings.authorNotFound));
                      }

                      return ListView.builder(
                        itemCount: authors.length,
                        itemBuilder: (context, index) {
                          final author = authors[index];
                          return _AuthorCard(
                            title: author.name,
                            imageBase64: author.imageBase64,
                            onTap: () => context.push(AppRoutes.authorDetails.path, extra: author),
                          );
                        },
                      );
                    }

                    return SizedBox.shrink();
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
