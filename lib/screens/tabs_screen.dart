import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import '../screens/favourites_screen.dart';
import '../screens/categories_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  TabsScreen(this.favouriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  // final List<Widget> _pages = [
  //   CategoriesScreen(),
  //   FavouritesScreen(),
  // ];

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Kategóriák',
      },
      {
        'page': FavouritesScreen(widget.favouriteMeals),
        'title': 'Kedvencek',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
        ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amberAccent,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType
            .fixed, // here you can use .shifting animation.
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.category,
            ),
            label: 'Kategóriák',
            // title: Text('Kategoriak'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.star,
            ),
            label: 'Kedvencek',
            // title: Text('Kategoriak'),
          ),
        ],
      ),
    );
  }
}
