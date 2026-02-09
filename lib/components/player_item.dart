import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munchkin/color.dart';
import 'package:munchkin/components/count_item.dart';
import 'package:munchkin/components/spa.dart';
import 'package:munchkin/munchkin_model.dart';

class PlayerItem extends StatelessWidget {
  final MunchkinModel model;
  final VoidCallback onIncrementLevel;
  final VoidCallback onDecrementLevel;
  final VoidCallback onIncrementMight;
  final VoidCallback onDecrementMight;

  const PlayerItem({
    super.key,
    required this.model,
    required this.onIncrementLevel,
    required this.onDecrementLevel,
    required this.onIncrementMight,
    required this.onDecrementMight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: greenLight, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            model.image,
            width: 48,
            height: 48,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(width: 12),

          /// имя + счётчики
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    CountItem(
                      title: 'Level',
                      count: model.level,
                      onIncrement: onIncrementLevel,
                      onDecrement: onDecrementLevel,
                    ),
                    const SizedBox(width: 12),
                    CountItem(
                      title: 'Might',
                      count: model.might,
                      onIncrement: onIncrementMight,
                      onDecrement: onDecrementMight,
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// общий счёт
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: parchment,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: bronze, width: 1.5),
            ),
            child: Text(
              "${model.level + model.might}",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
