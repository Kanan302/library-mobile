import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:library_app/ui/shared/extension/mediaquery_extension.dart';

import '../../../../../../data/entity/book/get_books/get_books_entity.dart';
import '../../../../../../shared/utils/logger.dart';
import '../../../../../cubit/book/get_books/get_books_cubit.dart';
import '../../../../../shared/constants/ui_colors.dart';

class CreateCategoryPage extends StatefulWidget {
  const CreateCategoryPage({super.key});

  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  final TextEditingController _newCategoryController = TextEditingController();
  GetBookEntity? _selectedBook;
  List<GetBookEntity> _books = [];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<GetBooksCubit>();
    cubit.getBooks();
    _books = cubit.state is GetBooksSuccess ? (cubit.state as GetBooksSuccess).response : [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.background,
      appBar: AppBar(backgroundColor: UiColors.background, title: const Text('Yeni kateqoriya yarat')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _newCategoryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: UiColors.black),
                  ),
                  labelText: "Kateqoriyanın adı",
                  labelStyle: const TextStyle(fontSize: 18),
                ),
              ),
              10.vertical(context),

              BlocBuilder<GetBooksCubit, GetBooksState>(
                builder: (context, state) {
                  if (state is GetBooksLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is GetBooksError) {
                    return Text('Xəta: ${state.errorMessage}', style: const TextStyle(color: Colors.red));
                  }
                  if (state is GetBooksSuccess) {
                    _books = state.response;
                    return DropdownButtonFormField<GetBookEntity>(
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                      hint: const Text("Kitab seçin"),
                      value: _selectedBook,
                      items:
                          _books.map((book) {
                            return DropdownMenuItem(value: book, child: Text(book.title ?? '-'));
                          }).toList(),
                      onChanged: (book) {
                        setState(() {
                          _selectedBook = book;
                        });
                        if (book != null) {
                          showLog("Seçilmiş kitab ID: ${book.id}");
                        }
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newCategoryController.dispose();
    super.dispose();
  }
}
