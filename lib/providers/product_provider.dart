import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  /// Fetches products from the API
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://dummyjson.com/products');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('products')) {
          List<dynamic> productList = data['products'];

          _products = productList.map((item) {
            return Product(
              id: item['id']?.toString() ?? "0", // Ensure ID is a String
              title: item['title'] ?? "No Title",
              price: (item['price'] as num?)?.toDouble() ?? 0.0, // Handle null safely
              description: item['description'] ?? "No Description",
              image: (item['images'] != null && item['images'].isNotEmpty)
                  ? item['images'][0] // First image
                  : "https://via.placeholder.com/150", // Fallback image
              thumbnail: item['thumbnail'] ?? "",
              brand: item['brand'] ?? "Unknown",
              category: item['category'] ?? "Uncategorized",
              discountPercentage: (item['discountPercentage'] as num?)?.toDouble() ?? 0.0,
              rating: (item['rating'] as num?)?.toDouble() ?? 0.0,
              stock: item['stock'] ?? 0,
              sku: item['sku'] ?? "N/A",
              weight: (item['weight'] as num?)?.toDouble() ?? 0.0,
              dimensions: {
                "width": (item['dimensions']?['width'] as num?)?.toDouble() ?? 0.0,
                "height": (item['dimensions']?['height'] as num?)?.toDouble() ?? 0.0,
                "depth": (item['dimensions']?['depth'] as num?)?.toDouble() ?? 0.0,
              },
              warrantyInformation: item['warrantyInformation'] ?? "No Warranty Info",
              shippingInformation: item['shippingInformation'] ?? "No Shipping Info",
              availabilityStatus: item['availabilityStatus'] ?? "Unavailable",
              minimumOrderQuantity: item['minimumOrderQuantity'] ?? 1,
              returnPolicy: item['returnPolicy'] ?? "No Return Policy",
              barcode: item['meta']?['barcode'] ?? "No Barcode",
              qrCode: item['meta']?['qrCode'] ?? "",
              tags: (item['tags'] as List<dynamic>?)?.map((tag) => tag.toString()).toList() ?? [],
              reviews: (item['reviews'] as List<dynamic>?)?.map((e) => Review.fromJson(e)).toList() ?? [],
            );
          }).toList();
        } else {
          print("⚠ API response does not contain 'products' key");
          _products = [];
        }
      } else {
        print("⚠ API Error: ${response.statusCode} - ${response.body}");
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print("❌ Error fetching products: $error");
    }

    _isLoading = false;
    notifyListeners();
  }
}
