import 'package:flutter/material.dart';
import 'package:munchkin/color.dart';

class RuleScreen extends StatelessWidget {
  const RuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: parchment,
        title: const Text('Munchkin — правила игры', style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            RuleText(
              '1. Цель игры',
              'Цель игры — первым достичь 10 уровня. '
                  'Последний уровень можно получить только за победу над монстром '
                  '(если карта не говорит обратное).',
            ),

            RuleText(
              '2. Подготовка к игре',
              'Каждый игрок начинает с 1 уровня и получает 8 карт: '
                  '4 карты из колоды Дверей и 4 карты из колоды Сокровищ. '
                  'Игрок может сразу выложить классы, расы и предметы.',
            ),

            RuleText(
              '3. Ход игрока',
              'Ход состоит из четырёх фаз: '
                  'Вышибаем дверь → Бой (если есть) → Мародёрство → Конец хода.',
            ),

            RuleText(
              '4. Вышибаем дверь',
              'Игрок берёт верхнюю карту из колоды Дверей и вскрывает её. '
                  'Если это монстр — начинается бой. '
                  'Если проклятие — оно применяется немедленно. '
                  'Иначе карта берётся в руку.',
            ),

            RuleText(
              '5. Бой',
              'Сравнивается сила игрока (уровень + бонусы предметов) '
                  'и сила монстра. Другие игроки могут вмешиваться, '
                  'усиливая монстра или помогая игроку.',
            ),

            RuleText(
              '6. Победа или бегство',
              'Если игрок сильнее — он убивает монстра, получает уровни и сокровища. '
                  'Если слабее — он может попытаться убежать, бросив кубик. '
                  'При неудаче применяются плохие последствия.',
            ),

            RuleText(
              '7. Мародёрство',
              'Если в этот ход не было боя, игрок может сыграть монстра с руки '
                  'или взять карту из колоды Дверей в закрытую.',
            ),

            RuleText(
              '8. Классы и расы',
              'Классы и расы дают специальные способности и бонусы. '
                  'Игрок может иметь только один класс и одну расу, '
                  'если карта не позволяет иное.',
            ),

            RuleText(
              '9. Проклятия',
              'Проклятия разыгрываются немедленно и могут отнимать уровни, '
                  'предметы, классы или расы.',
            ),
          ],
        ),
      ),
    );
  }
}

class RuleText extends StatelessWidget {
  final String title;
  final String text;

  const RuleText(this.title, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
  }
}
