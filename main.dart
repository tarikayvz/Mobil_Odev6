import 'package:flutter/material.dart';

void main() {
  runApp(ProductApp());
}

// Ürün Modeli
class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

// Örnek ürün listesi
List<Product> products = [
  Product(name: 'Laptop', price: 1500),
  Product(name: 'Telefon', price: 800),
  Product(name: 'Tablet', price: 500),
  Product(name: 'Kamera', price: 300),
  Product(name: 'Kulaklık', price: 100),
  // Daha fazla ürün ekleyebilirsiniz
];

// Ana Uygulama Widget’ı
class ProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ürün Listesi',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductScreen(),
    );
  }
}

// Ürün Sayfası için StatefulWidget
class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int selectedIndex = -1; // Başlangıçta hiçbir ürün seçilmemiş

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Listesi'),
      ),
      body: Column(
        children: [
          _buildHorizontalListView(),
          Expanded(child: _buildGridView()),
        ],
      ),
    );
  }

  // Horizontal ListView Oluşturma
  Widget _buildHorizontalListView() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selectedIndex == index ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  products[index].name,
                  style: TextStyle(
                    color: selectedIndex == index ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // GridView Oluşturma
  Widget _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Her satırda iki öğe
        childAspectRatio: 2, // Öğe oranı
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? Colors.orange[200]
                  : Colors.grey[200],
              border: Border.all(
                color:
                    selectedIndex == index ? Colors.orange : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  products[index].name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '\$${products[index].price.toString()}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
