import 'package:flutter/material.dart';

class FoodRow extends StatelessWidget {
  const FoodRow({
    super.key,
    this.thumbnail,
    required this.name,
    required this.kcal,
  });

  final String? thumbnail;
  final String name;
  final int kcal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: ShapeDecoration(
              color: const Color(0xFFD6D9E0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Stack(
                children: [
                  Image.asset(
                    thumbnail != null
                        ? thumbnail!
                        : 'assets/icons/foodThumbnail.png',
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.7),
                  ),
                  const Center(
                    child: Text(
                      '이미지 준비중',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF2D3142),
                    fontSize: 16,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.20,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '$kcal kcals',
                  style: const TextStyle(
                    color: Color(0xFF9C9DB9),
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
