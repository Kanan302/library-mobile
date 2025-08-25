part of '../books.dart';

class _BookCard extends StatelessWidget {
  final String? title;
  final String? imageBase64;
  final void Function() onTap;

  const _BookCard({this.title, this.imageBase64, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: UiColors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: UiColors.white,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: UiColors.red,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                flex: 2,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                label: UiStrings.delete,
                icon: Icons.delete,
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading:
                imageBase64 != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(base64Decode(imageBase64!), width: 70, fit: BoxFit.cover),
                    )
                    : const Icon(Icons.my_library_books, size: 35, color: UiColors.grey),
            title: Text(title ?? '-', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
