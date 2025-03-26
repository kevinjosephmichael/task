import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // ✅ Dark background
      appBar: AppBar(
        title: Text(product.title),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple], // ✅ Gradient AppBar
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // ✅ Centering content
          children: [
            // 📌 Fully Visible Product Image with White Background
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // ✅ White background for image
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.image,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.contain, // ✅ Ensuring full visibility
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 📌 Product Title & Description Section
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9, // ✅ Centering drawer
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // ✅ White background
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📌 Product Title
                    Text(
                      product.title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 8),

                    // 📌 Product Description (Newly Added)
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 📌 Centered Product Details Box with White Background
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9, // ✅ Centering drawer
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // ✅ White background
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Brand: ${product.brand}", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    Text("SKU: ${product.sku}", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    Text("Price: \$${product.price}", style: const TextStyle(fontSize: 18, color: Colors.green)),
                    Text("Discount: ${product.discountPercentage}%", style: const TextStyle(fontSize: 16, color: Colors.redAccent)),
                    Text("Rating: ${product.rating} ⭐", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    Text("Stock: ${product.stock} available", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    const SizedBox(height: 16),
                    Text("Weight: ${product.weight} kg", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    Text("Dimensions: ${product.dimensions['width']} x ${product.dimensions['height']} x ${product.dimensions['depth']} cm",
                        style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    const SizedBox(height: 16),
                    Text("Availability: ${product.availabilityStatus}", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    Text("Return Policy: ${product.returnPolicy}", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    Text("Shipping Info: ${product.shippingInformation}", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    Text("Warranty: ${product.warrantyInformation}", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 📌 Centered Reviews Section
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9, // ✅ Centering drawer
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // ✅ White background
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Customer Reviews:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(height: 8),
                    product.reviews.isEmpty
                        ? const Text("No reviews available", style: TextStyle(fontSize: 16, color: Colors.black54))
                        : Column(
                            children: product.reviews.map((review) {
                              return Card(
                                color: Colors.white,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${review.reviewerName} (${review.rating} ⭐)",
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                      ),
                                      Text(review.comment, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                                      const SizedBox(height: 4),
                                      Text("Date: ${review.date}", style: const TextStyle(fontSize: 12, color: Colors.black38)),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 📌 Centered Barcode & QR Code Section
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9, // ✅ Centering drawer
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    Image.network(
                      "https://assets.dummyjson.com/public/qr-code.png?timestamp=${DateTime.now().millisecondsSinceEpoch}",
                      width: 100,
                      height: 100,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.qr_code, size: 80, color: Colors.grey);
                      },
                    ),
                    const SizedBox(height: 8),
                    Text("Barcode: ${product.barcode}", style: const TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
