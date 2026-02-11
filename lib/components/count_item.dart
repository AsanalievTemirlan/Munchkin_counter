import 'package:flutter/material.dart';
import 'package:munchkin/color.dart';

class CountItem extends StatelessWidget {
  const CountItem({
    super.key,
    required this.title,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  final String title;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 36,
          height: 36,
          child: IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            color: count > 0 ? bronze : Colors.grey.shade400,
            padding: EdgeInsets.zero,
            onPressed: count > 0 ? onDecrement : null,
          ),
        ),
        Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: greenLight,
              ),
            ),
            Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 36,
          height: 36,
          child: IconButton(
            icon: const Icon(Icons.keyboard_arrow_up),
            color: bronze,
            padding: EdgeInsets.zero,
            onPressed: onIncrement,
          ),
        ),

      ],
    );
  }
}
