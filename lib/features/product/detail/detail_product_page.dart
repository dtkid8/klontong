import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klontong/core/extension.dart';
import 'package:klontong/features/product/detail/detail_product_card.dart';
import 'package:klontong/features/product/product.dart';

class DetailProductPage extends StatefulWidget {
  final Product product;
  const DetailProductPage({super.key, required this.product});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  Widget build(BuildContext context) {
    final Product product = widget.product;
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Detail Product"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: size.height * 0.5,
              child: Card(
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  errorWidget: (context, url, error) => const SizedBox.shrink(),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        product.name.capitalizeEachWord(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Rp ${product.harga.convertToIdr()}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "Category",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    product.categoryName.capitalizeEachWord(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Dimension",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Wrap(
                    children: [
                      DetailProductCard(label: "Width", value: product.width.toString()),
                      DetailProductCard(label: "Height", value: product.height.toString()),
                      DetailProductCard(label: "Weight", value: product.weight.toString()),
                      DetailProductCard(label: "Length", value: product.length.toString()),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
