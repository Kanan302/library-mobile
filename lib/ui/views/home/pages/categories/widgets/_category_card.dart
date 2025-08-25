part of '../categories.dart';

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function()? onTap;

  const _CategoryCard({required this.title, required this.subTitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: UiColors.black54,
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
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                flex: 2,
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                label: UiStrings.delete,
                icon: Icons.delete,
              ),
            ],
          ),
          child: ListTile(title: Text(title), subtitle: Text(subTitle), onTap: onTap),
        ),
      ),
    );
  }
}
