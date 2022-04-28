import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beállításaim'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Étkezési beállítások',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              _buildSwitchListTile(
                  'Glutén mentes',
                  'Csak gluténmentes ételeket mutasson!',
                  _glutenFree, (newvalue) {
                setState(() {
                  _glutenFree = newvalue;
                });
              }),
              _buildSwitchListTile(
                  'Laktóz mentes',
                  'Csak laktózmentes ételeket mutasson!',
                  _lactoseFree, (newvalue) {
                setState(() {
                  _lactoseFree = newvalue;
                });
              }),
              _buildSwitchListTile(
                  'Vegetáriánus',
                  'Csak vegetáriánus ételeket mutasson!',
                  _vegetarian, (newvalue) {
                setState(() {
                  _vegetarian = newvalue;
                });
              }),
              _buildSwitchListTile(
                  'Vegán', 'Csak vegán ételeket mutasson!', _vegan, (newvalue) {
                setState(() {
                  _vegan = newvalue;
                });
              }),
            ],
          ),
        )
      ]),
    );
  }
}
