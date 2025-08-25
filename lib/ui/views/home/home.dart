import 'package:flutter/material.dart';

import '../../shared/constants/ui_colors.dart';
import '../../shared/constants/ui_strings.dart';
import 'pages/authors/authors.dart';
import 'pages/books/books.dart';
import 'pages/categories/categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [const BooksPage(), const AuthorsPage(), const CategoriesPage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: UiColors.white,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        elevation: 0,
        selectedFontSize: 15,
        unselectedFontSize: 13,
        selectedItemColor: UiColors.black,
        unselectedItemColor: UiColors.graphiteGray,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(width: 34, height: 34, child: Icon(Icons.menu_book_outlined)),
            activeIcon: SizedBox(width: 34, height: 34, child: Icon(Icons.menu_book)),
            label: UiStrings.books,
          ),
          BottomNavigationBarItem(
            icon: SizedBox(width: 34, height: 34, child: Icon(Icons.person_outline)),
            activeIcon: SizedBox(width: 34, height: 34, child: Icon(Icons.person)),
            label: UiStrings.authors,
          ),
          BottomNavigationBarItem(
            icon: SizedBox(width: 34, height: 34, child: Icon(Icons.category_outlined)),
            activeIcon: SizedBox(width: 34, height: 34, child: Icon(Icons.category)),
            label: UiStrings.categories,
          ),
        ],
      ),
    );
  }
}
