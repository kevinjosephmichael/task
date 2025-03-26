import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://dummyjson.com/products');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> productList = data['products'];

        _products = productList.map((item) => Product.fromJson(item)).toList();

        _isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print("Error fetching products: $error");
      _isLoading = false;
      notifyListeners();
    }
  }
}


class Product {
  final String id;
  final String title;
  final String description;
  final String image;
  final String thumbnail;
  final String brand;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String sku;
  final double weight;
  final Map<String, double> dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final int minimumOrderQuantity;
  final String returnPolicy;
  final String barcode;
  final String qrCode;
  final List<Review> reviews; 
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.thumbnail, 
    required this.brand,
    required this.category, 
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.minimumOrderQuantity,
    required this.returnPolicy,
    required this.barcode,
    required this.qrCode,
    required this.reviews,
  });

  
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      title: json['title'] ?? "No Title",
      description: json['description'] ?? "No Description",
      image: json['images'] != null && json['images'].isNotEmpty ? json['images'][0] : "", 
      thumbnail: json['thumbnail'] ?? "", 
      brand: json['brand'] ?? "Unknown Brand",
      category: json['category'] ?? "Uncategorized", 
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      sku: json['sku'] ?? "Unknown SKU",
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      dimensions: {
        "width": (json['dimensions']?['width'] as num?)?.toDouble() ?? 0.0,
        "height": (json['dimensions']?['height'] as num?)?.toDouble() ?? 0.0,
        "depth": (json['dimensions']?['depth'] as num?)?.toDouble() ?? 0.0,
      },
      warrantyInformation: json['warrantyInformation'] ?? "No Warranty Info",
      shippingInformation: json['shippingInformation'] ?? "No Shipping Info",
      availabilityStatus: json['availabilityStatus'] ?? "Unavailable",
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 1,
      returnPolicy: json['returnPolicy'] ?? "No Return Policy",
      barcode: json['meta']?['barcode'] ?? "No Barcode",
      qrCode: json['qrCode'] ?? "https://assets.dummyjson.com/public/qr-code.png",
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e))
              .toList() ?? [],
    );
  }
}


class Review {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? "No Comment",
      date: json['date'] ?? "",
      reviewerName: json['reviewerName'] ?? "Anonymous",
      reviewerEmail: json['reviewerEmail'] ?? "No Email",
    );
  }
}
