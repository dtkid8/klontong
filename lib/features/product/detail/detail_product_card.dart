import 'package:flutter/material.dart';

class DetailProductCard extends StatelessWidget {
  final String label;
  final String value;
  const DetailProductCard({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(label),
            Text(value),
          ],
        ),
      ),
    );
  }
}
