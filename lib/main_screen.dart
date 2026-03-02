import 'package:flutter/material.dart';
import 'package:munchkin/color.dart';
import 'package:munchkin/components/player_item.dart';
import 'package:munchkin/munchkin_model.dart';
import 'package:munchkin/players_store.dart';
import 'package:munchkin/rule_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final store = PlayersStore();
  bool loading = true;
  final List<int> _availableDragons = [];

  @override
  void initState() {
    super.initState();
    _resetDragonPool();
    store.load().then((_) {
      setState(() => loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: parchment,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: parchment,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RuleScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(4),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              'Munchkin',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            color: bronze,
            tooltip: 'Очистить значения',
            onPressed: () async {
              await store.resetStats();
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            color: bronze,
            tooltip: 'Удалить всех',
            onPressed: () async {
              await store.clear();
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            color: bronze,
            tooltip: 'Добавить игрока',
            onPressed: () {
              _showAddPlayerSheet(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: store.players.length,
        itemBuilder: (context, index) {
          final player = store.players[index];
          return Dismissible(
              key: ValueKey(index),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              onDismissed: (direction) async {
                await store.remove(index);
                setState(() {});
              },
              child: PlayerItem(
                index: index,
            model: player,
            onIncrementLevel: () => setState(
              () => player.level < 10 ? player.level++ : player.level,
            ),
                onDecrementLevel: () =>
                    setState(() =>
                    player.level != 1 ? player.level-- : player.level),
            onIncrementMight: () => setState(() => player.might++),
            onDecrementMight: () {
              setState(() {
                if (player.might > 0) {
                  player.might--;
                }
              });
            },
                onLongPress: (i, name) {
                  _showAddPlayerSheet(
                      context, renameMode: true, renameIndex: i, oldName: name);
                },
              )
          );
        },
      ),
    );
  }

  void _showAddPlayerSheet(BuildContext context, {
    bool renameMode = false,
    int? renameIndex,
    String? oldName,
  }) {
    final controller = TextEditingController(text: oldName);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: parchment,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  !renameMode ? 'Добавить игрока' : 'Переименовать игрока',
                  style: TextStyle(
                    fontSize: 20,
                    color: darkGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: controller,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Имя игрока',
                    labelStyle: const TextStyle(color: darkGreen),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bronze, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: greenLight),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    foregroundColor: parchment,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    final name = controller.text.trim();
                    if (name.isEmpty) return;
                    Navigator.pop(context, name);
                  },
                  child: const Text(
                    'Сохранить',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((result) {
      if (result != null && result is String) {
        // 👇 сюда приходит имя
        if (renameMode && renameIndex != null) {
          _rename(renameIndex, result);
        } else {
        _addPlayer(result);
        }
      }
    });
  }

  void _resetDragonPool() {
    _availableDragons.clear();
    _availableDragons.addAll(List.generate(13, (index) => index + 1));
    _availableDragons.shuffle();
  }

  void _rename(int index, String newName) async {
    setState(() {
      store.rename(index, newName);
    });
  }

  void _addPlayer(String name) {
    if (_availableDragons.isEmpty) {
      _resetDragonPool();
    }
    final dragonIndex = _availableDragons.removeLast();

    setState(() {
      store.players.add(
        MunchkinModel(
          name: name,
          level: 1,
          might: 0,
          image: "assets/images/dragon_$dragonIndex.png",
        ),
      );
    });
  }
}
