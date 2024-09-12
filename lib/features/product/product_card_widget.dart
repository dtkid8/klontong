import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klontong/features/product/detail/detail_product_page.dart';
import 'package:klontong/features/product/product.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductPage(
              product: product,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: product.image,
              errorWidget: (context, url, error) => const SizedBox.shrink(),
              placeholder: (context, url) => const CircularProgressIndicator(),
            ),
            Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
