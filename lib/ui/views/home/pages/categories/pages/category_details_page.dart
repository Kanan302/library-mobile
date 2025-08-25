import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../../data/entity/category/get_categories/get_categories_entity.dart';
import '../../../../../shared/constants/ui_colors.dart';
import '../../../../../shared/constants/ui_strings.dart';

class CategoryDetailsPage extends StatelessWidget {
  final GetCategoryEntity category;

  const CategoryDetailsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final uniqueAuthors = <String, dynamic>{};

    for (var author in category.authors ?? []) {
      if (author != null && author.name != null && author.name!.isNotEmpty) {
        uniqueAuthors[author.name!] = author;
      }
    }

    final authorsList = uniqueAuthors.values.toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: UiColors.background,
        appBar: AppBar(
          backgroundColor: UiColors.background,
          title: Text(category.name ?? '-'),
          titleSpacing: -1,
          bottom: const TabBar(
            dividerColor: UiColors.transparent,
            indicatorColor: UiColors.primaryColor,
            labelColor: UiColors.black,
            unselectedLabelColor: UiColors.black,
            indicatorPadding: EdgeInsets.symmetric(vertical: 4),
            labelPadding: EdgeInsets.symmetric(vertical: 1),
            tabs: [Tab(text: UiStrings.books), Tab(text: UiStrings.authors)],
          ),
        ),
        body: TabBarView(
          children: [
            category.books == null || category.books!.isEmpty
                ? const Center(child: Text(UiStrings.bookNotFound))
                : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: category.books?.length,
                  itemBuilder: (context, index) {
                    final book = category.books?[index];
                    return Card(
                      color: UiColors.white,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading:
                            book?.imageBase64 != null
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    base64Decode(book!.imageBase64!),
                                    width: 70,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : const Icon(Icons.my_library_books, size: 35),

                        title: Text(book?.title ?? '-'),
                        subtitle: Text("Book ID: ${book?.id}"),
                      ),
                    );
                  },
                ),

            authorsList.isEmpty
                ? const Center(child: Text(UiStrings.authorNotFound))
                : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: authorsList.length,
                  itemBuilder: (context, index) {
                    final author = authorsList[index];
                    return Card(
                      color: UiColors.white,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading:
                            author?.imageBase64 != null
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    base64Decode(author!.imageBase64!),
                                    width: 70,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : const Icon(Icons.person, size: 35),

                        title: Text(author.name ?? '-'),
                        subtitle: Text("Author ID: ${author.id}"),
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
