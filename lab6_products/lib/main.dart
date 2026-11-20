import 'package:flutter/material.dart';

// ==========================================
// 1. Immutable Product Model (Instruction 1)
// ==========================================
class Product {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.rating,
    required this.price,
  });

  final String id;
  final String title;
  final String description;
  final double rating;
  final String price;
}

// ==========================================
// Main Application Entry Point
// ==========================================
void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 6 - Product Data',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5E3A)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const ProductListScreen(),
    );
  }
}

// ==========================================
// 2. Product List Screen (Instructions 2 & 3)
// ==========================================
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  // In-memory list of sample products matching the lab illustration
  static const List<Product> sampleProducts = [
    Product(
      id: 'P-001',
      title: 'Wireless Mouse',
      description: 'Comfortable wireless mouse for daily work and gaming.',
      rating: 4.5,
      price: '₱599',
    ),
    Product(
      id: 'P-002',
      title: 'Notebook Set',
      description: 'Durable spiral-bound grid notebooks for study and project notes.',
      rating: 4.2,
      price: '₱120',
    ),
    Product(
      id: 'P-003',
      title: 'Desk Lamp',
      description: 'Adjustable LED warm/cool desk light with USB charging port.',
      rating: 4.7,
      price: '₱850',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E5E3A),
        elevation: 2,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          itemCount: sampleProducts.length,
          itemBuilder: (context, index) {
            final product = sampleProducts[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                // Instruction 4: Pass selected Product as constructor argument
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Circular graphic frame
                      Container(
                        width: 56.0,
                        height: 56.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F2EC),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Container(
                            width: 26.0,
                            height: 26.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF1E5E3A),
                                width: 2.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      // Product Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'Rating ${product.rating}',
                              style: const TextStyle(
                                fontSize: 13.0,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Text(
                              product.price,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E5E3A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==============================================================
// 3. Product Detail Screen Receiving Data (Instruction 4 & 5)
// ==============================================================
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  // Explicit constructor parameter receiving the passed model
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E5E3A),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Large circular product avatar
              Center(
                child: Container(
                  width: 130.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F2EC),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF1E5E3A),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28.0),

              // Title
              Center(
                child: Text(
                  product.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E5E3A),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // Description Section
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5E3A),
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF2C3E50),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24.0),

              // Rating
              Text(
                'Rating: ${product.rating} / 5',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 8.0),

              // Identifier / Product Key (Addresses Editorial note)
              Text(
                'Product key: ${product.id}',
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}