import 'package:flutter/material.dart';

void main() {
  runApp(const ItemListApp());
}

class ItemListApp extends StatelessWidget {
  const ItemListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 3 - Input and List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5E3A)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final TextEditingController _itemController = TextEditingController();
  final List<String> _items = <String>[];

  void _addItem() {
    final text = _itemController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _items.add(text);
      });
      _itemController.clear();
    }
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E5E3A),
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. TextField with exact hint "Enter Item"
              TextField(
                controller: _itemController,
                decoration: InputDecoration(
                  hintText: 'Enter Item',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF1E5E3A),
                      width: 2.0,
                    ),
                  ),
                ),
                onSubmitted: (_) => _addItem(),
              ),
              const SizedBox(height: 12.0),

              // 2. ADD Button
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5E3A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: _addItem,
                  child: const Text(
                    'ADD',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // 3. Dynamic Item List
              Expanded(
                child: _items.isEmpty
                    ? const Center(
                        child: Text(
                          'No items added yet.',
                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                              vertical: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F2EC),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 18.0,
                                  height: 18.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1E5E3A),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 14.0),
                                Expanded(
                                  child: Text(
                                    _items[index],
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0xFF1E5E3A),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}