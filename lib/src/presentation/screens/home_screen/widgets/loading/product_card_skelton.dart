import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image Placeholder
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(height: 6),

          /// Title line 1
          Container(height: 12, width: double.infinity, color: Colors.white),

          const SizedBox(height: 4),

          /// Title line 2
          Container(height: 12, width: 100, color: Colors.white),

          const SizedBox(height: 6),

          /// Price row
          Row(
            children: [
              Container(height: 12, width: 40, color: Colors.white),
              const SizedBox(width: 6),
              Container(height: 12, width: 35, color: Colors.white),
              const SizedBox(width: 6),
              Container(height: 12, width: 50, color: Colors.white),
            ],
          ),

          const SizedBox(height: 6),

          /// Rating stars
          Row(
            children: List.generate(
              5,
              (index) => Container(
                margin: const EdgeInsets.only(right: 4),
                height: 12,
                width: 12,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 6),

          /// Delivery text
          Container(height: 10, width: 120, color: Colors.white),

          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
