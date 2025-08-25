import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:library_app/ui/shared/extension/mediaquery_extension.dart';

import '../../../../../../data/entity/author/get_authors/get_authors_entity.dart';
import '../../../../../../shared/utils/logger.dart';
import '../../../../../shared/constants/ui_colors.dart';
import '../../../../../shared/constants/ui_strings.dart';

class AuthorDetailsPage extends StatefulWidget {
  final GetAuthorsEntity author;

  const AuthorDetailsPage({super.key, required this.author});

  @override
  State<AuthorDetailsPage> createState() => _AuthorDetailsPageState();
}

class _AuthorDetailsPageState extends State<AuthorDetailsPage> {
  bool _isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _reviewController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.author.name);
    _reviewController = TextEditingController(text: widget.author.review);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.background,
      appBar: AppBar(
        backgroundColor: UiColors.background,
        titleSpacing: 0,
        title: Text(UiStrings.aboutAuthor, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
                showLog("isediting: $_isEditing");
              });
            },
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.height(context),
            children: [
              _isEditing
                  ? TextField(
                    controller: _nameController,
                    decoration: InputDecoration(border: InputBorder.none),
                    style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  )
                  : Text(widget.author.name ?? '', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),

              widget.author.imageBase64 != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      base64Decode(widget.author.imageBase64!),
                      width: 140,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                  : const Icon(Icons.person, size: 100, color: UiColors.grey),

              if (widget.author.review?.isNotEmpty ?? false) ...[
                10.vertical(context),
                _isEditing
                    ? TextField(
                      controller: _reviewController,
                      decoration: InputDecoration(border: InputBorder.none),
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    )
                    : Text(widget.author.review!, style: const TextStyle(fontSize: 16, color: Colors.black87)),
              ],

              const Divider(thickness: 1),

              Text(
                "Yazıçının yazdığı kateqoriyalar",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              if (widget.author.categories != null && widget.author.categories!.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      widget.author.categories!
                          .map((a) => a.name)
                          .where((name) => name != null && name.isNotEmpty)
                          .toSet()
                          .map(
                            (uniqueName) =>
                                _isEditing
                                    ? InputChip(
                                      label: Text(uniqueName!, style: const TextStyle(fontSize: 17)),
                                      backgroundColor: UiColors.white.withValues(alpha: 0.5),
                                      onDeleted: () {
                                        // setState(() {
                                        //   widget.author.categories!
                                        //       .removeWhere((c) => c.name == uniqueName);
                                        // });
                                      },
                                    )
                                    : Chip(
                                      label: Text(uniqueName!, style: const TextStyle(fontSize: 17)),
                                      backgroundColor: UiColors.white.withValues(alpha: 0.5),
                                    ),
                          )
                          .toList(),
                )
              else
                const Text("Kateqoriya yoxdur", style: TextStyle(color: UiColors.black)),

              const Divider(thickness: 1),

              Text("Yazıçının yazdığı kitablar", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              if (widget.author.books != null && widget.author.books!.isNotEmpty)
                Column(
                  children:
                      widget.author.books!.map((book) {
                        return Card(
                          color: UiColors.white,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            leading:
                                book.imageBase64 != null
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.memory(
                                        base64Decode(book.imageBase64!),
                                        width: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    : const Icon(Icons.book, size: 40, color: UiColors.grey),
                            title: Text(
                              book.title ?? '-',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle:
                                book.review != null && book.review!.isNotEmpty
                                    ? Text(
                                      book.review!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 16, color: UiColors.black54),
                                    )
                                    : null,
                            trailing:
                                _isEditing
                                    ? IconButton(
                                      icon: const Icon(Icons.close, color: UiColors.red),
                                      onPressed: () {
                                        setState(() {
                                          widget.author.books!.remove(book);
                                        });
                                      },
                                    )
                                    : null,
                          ),
                        );
                      }).toList(),
                )
              else
                const Text("Kitab yoxdur", style: TextStyle(color: UiColors.black54)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }
}
