import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/constants/app_routes.dart';
import '../../../../cubit/category/get_categories/get_categories_cubit.dart';
import '../../../../shared/constants/ui_colors.dart';
import '../../../../shared/constants/ui_strings.dart';
import '../../widgets/search_field.dart';

part 'widgets/_category_card.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    context.read<GetCategoriesCubit>().getCategories();
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
              onPressed: () => context.push(AppRoutes.createCategory.path),
            ),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: UiColors.white,
                color: UiColors.primaryColor,
                onRefresh: () async {
                  context.read<GetCategoriesCubit>().getCategories(forceRefresh: true);
                },
                child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
                  builder: (context, state) {
                    if (state is GetCategoriesLoading) {
                      return const Center(child: CircularProgressIndicator(color: UiColors.primaryColor));
                    }
                    if (state is GetCategoriesError) {
                      return Center(child: Text(state.errorMessage, style: TextStyle(color: UiColors.error)));
                    }
                    if (state is GetCategoriesSuccess) {
                      final categories =
                          state.response
                              .where((category) => category.name?.toLowerCase().contains(_searchQuery) ?? false)
                              .toList();

                      if (categories.isEmpty) {
                        return const Center(child: Text(UiStrings.bookNotFound));
                      }

                      return ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          final uniqueAuthorsMap = <String, dynamic>{};
                          for (var author in category.authors ?? []) {
                            if (author != null && author.name != null && author.name!.isNotEmpty) {
                              uniqueAuthorsMap[author.name!] = author;
                            }
                          }
                          final uniqueAuthorsList = uniqueAuthorsMap.values.toList();

                          return _CategoryCard(
                            title: category.name ?? '-',
                            subTitle:
                                "Kitabların sayı: ${category.books?.length}, Yazıçıların sayı: ${uniqueAuthorsList.length}",
                            onTap: () => context.push(AppRoutes.categoryDetails.path, extra: category),
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
