import 'package:flutter/material.dart';
import '../widgets/menu_item.dart';
import '../models/menu_item_model.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _searchQuery = '';
  bool _showVegOnly = false;
  bool _showNonVegOnly = false;

  List<MenuItemModel> get filteredItems {
    return menuItems.where((item) {
      final matchesSearch = item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(_searchQuery.toLowerCase());
      
      if (_showVegOnly) {
        return matchesSearch && item.isVeg;
      } else if (_showNonVegOnly) {
        return matchesSearch && !item.isVeg;
      }
      
      return matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Menu'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search menu items...',
                    hintStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    FilterChip(
                      selected: _showVegOnly,
                      label: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: _showVegOnly ? const Color(0xFF2D0C57) : Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Veg Only',
                            style: TextStyle(
                              color: _showVegOnly ? const Color(0xFF2D0C57) : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _showVegOnly = selected;
                          if (selected) {
                            _showNonVegOnly = false;
                          }
                        });
                      },
                      selectedColor: const Color(0xFFFFD700),
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      selected: _showNonVegOnly,
                      label: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: _showNonVegOnly ? const Color(0xFF2D0C57) : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Non-Veg Only',
                            style: TextStyle(
                              color: _showNonVegOnly ? const Color(0xFF2D0C57) : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _showNonVegOnly = selected;
                          if (selected) {
                            _showVegOnly = false;
                          }
                        });
                      },
                      selectedColor: const Color(0xFFFFD700),
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      body: filteredItems.isEmpty
          ? const Center(
              child: Text(
                'No items found',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return MenuItem(
                  name: item.name,
                  description: item.description,
                  price: item.price,
                  image: item.image,
                  isVeg: item.isVeg,
                );
              },
            ),
    );
  }
} 