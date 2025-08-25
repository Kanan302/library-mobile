import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:library_app/ui/shared/extension/mediaquery_extension.dart';

import '../../../../../../data/entity/book/get_books/get_books_entity.dart';
import '../../../../../../shared/utils/logger.dart';
import '../../../../../shared/constants/ui_colors.dart';
import '../../../../../shared/constants/ui_strings.dart';

class BookDetailsPage extends StatefulWidget {
  final GetBookEntity book;

  const BookDetailsPage({super.key, required this.book});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  bool _isEditing = false;

  late TextEditingController _titleController;
  late TextEditingController _reviewController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _reviewController = TextEditingController(text: widget.book.review);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.background,
      appBar: AppBar(
        backgroundColor: UiColors.background,
        titleSpacing: 0,
        title: Text(UiStrings.aboutBook, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
            spacing: 10.height(context),
            children: [
              Center(
                child:
                    widget.book.imageBase64 != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            base64Decode(widget.book.imageBase64!),
                            width: 120,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        )
                        : const Icon(Icons.my_library_books, size: 80, color: UiColors.grey),
              ),
              10.vertical(context),
               Text(widget.book.title ?? '-', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

              if (widget.book.review?.isNotEmpty ?? false) ...[
                _isEditing
                    ? TextField(
                      controller: _reviewController,
                      decoration: InputDecoration(border: InputBorder.none),
                      style: TextStyle(fontSize: 17, color: Colors.black87),
                      maxLines: 3,
                    )
                    : Text(widget.book.review!, style: const TextStyle(fontSize: 17, color: Colors.black87)),
              ],

              const Divider(),

              Text("📚 Kateqoriya:", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              Text(widget.book.category?.name ?? '-', style: const TextStyle(fontSize: 16)),

              10.vertical(context),

              Text("✍️ Yazıçı:", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.book.author?.imageBase64 != null && widget.book.author!.imageBase64!.isNotEmpty)
                    ClipOval(
                      child: Image.memory(
                        base64Decode(widget.book.author!.imageBase64!),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const Icon(Icons.edit_off, size: 40, color: UiColors.grey),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.book.author?.name ?? '-', style: const TextStyle(fontSize: 16)),
                        Text(
                          widget.book.author?.review ?? '-',
                          style: const TextStyle(fontSize: 15, color: UiColors.black54),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              10.vertical(context),

              Text("👥 Oxucuların sayı:", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              Text("${widget.book.users?.length ?? 0} nəfər", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _reviewController.dispose();
    super.dispose();
  }
}
