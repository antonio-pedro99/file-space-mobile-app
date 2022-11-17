import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {Key? key,
      this.onTap,
      required this.category,
      required this.icon,
      required this.color})
      : super(key: key);

  final String category;
  final IconData icon;
  final Color color;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: color),
              child: Icon(icon)),
          const SizedBox(height: 8),
          Text(category)
        ],
      ),
    );
  }
}
