import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

import 'package:http/http.dart' as http; // bundle all this into the http object

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
      'flutter-prep-8a3f2-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data';
        });
      }

      if (response.body == 'null') {
        // Firebase doesn't actually return the null object, but the null string
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(
        response.body,
      ); // when no items, response.body will be null
      final List<GroceryItem> loadedItems = [];
      for (final item in listData.entries) {
        final category =
            categories.entries
                .firstWhere(
                  (catItem) => catItem.value.title == item.value['category'],
                )
                .value;
        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }

      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _error = 'Something went wrong! Please try again later';
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);

    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
      'flutter-prep-8a3f2-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Text('Unable to delete item. Please try again'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text('No Items Added Yet'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder:
            (ctx, index) => Dismissible(
              key: ValueKey(_groceryItems[index].id),
              onDismissed: (direction) {
                _removeItem(_groceryItems[index]);
              },
              child: ListTile(
                title: Text(_groceryItems[index].name),
                leading: Container(
                  height: 24,
                  width: 24,
                  color: _groceryItems[index].category.color,
                ),
                trailing: Text(_groceryItems[index].quantity.toString()),
              ),
            ),
      );
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}

/**
 * 
 * FutureBuilder doesn't really work here because any updates to the UI does not actually get updated
 * import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

import 'package:http/http.dart' as http; // bundle all this into the http object

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  late Future<List<GroceryItem>> _loadedItems;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
      'flutter-prep-8a3f2-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception(' Failed to fetch grocery items. Please try again');
    }

    if (response.body == 'null') {
      // Firebase doesn't actually return the null object, but the null string
      return [];
    }

    final Map<String, dynamic> listData = json.decode(
      response.body,
    ); // when no items, response.body will be null
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category =
          categories.entries
              .firstWhere(
                (catItem) => catItem.value.title == item.value['category'],
              )
              .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }

    return loadedItems;
  }

  void _addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);

    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
      'flutter-prep-8a3f2-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Text('Unable to delete item. Please try again'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Waiting for response
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // An error has been thrown inside the code that produces the Future
            Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.data!.isEmpty) {
            return Center(child: Text('No Items Added Yet'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder:
                  (ctx, index) => Dismissible(
                    key: ValueKey(snapshot.data![index].id),
                    onDismissed: (direction) {
                      _removeItem(snapshot.data![index]);
                    },
                    child: ListTile(
                      title: Text(snapshot.data![index].name),
                      leading: Container(
                        height: 24,
                        width: 24,
                        color: snapshot.data![index].category.color,
                      ),
                      trailing: Text(snapshot.data![index].quantity.toString()),
                    ),
                  ),
            );
          }
        },
      ),
    );
  }
}

 */