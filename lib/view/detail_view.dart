import 'package:fill/firebase/apis/goal.dart';
import 'package:fill/state/goal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goal = ref.watch(goalProvider);
    final goalList = [
      {
        'text': '最終目標',
        'title': goal.goals[0].title,
        'flg': goal.goals[0].flg,
      },
      {
        'text': '第1目標',
        'title': goal.goals[1].title,
        'flg': goal.goals[1].flg,
      },
      {
        'text': '第2目標',
        'title': goal.goals[2].title,
        'flg': goal.goals[2].flg,
      },
      {
        'text': '第3目標',
        'title': goal.goals[3].title,
        'flg': goal.goals[3].flg,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: goalList.length,
          itemBuilder: (context, index) {
            return goalList[index]['flg'] != false
                ? Dismissible(
                    key: Key(index.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.green.shade300,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.delete),
                      ),
                    ),
                    onDismissed: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: const Text(
                                '更新後、取り消しができません。\n本当によろしいですか？',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: TextButton(
                                      onPressed: () async {
                                        final updateGoal = ref
                                            .read(goalProvider.notifier)
                                            .updateItemFlg(index, false);
                                        GoalRepository().updateGoals(
                                            goal.id.toString(), updateGoal);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('達成')),
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsetsDirectional.all(15),
                      child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: goalList[index]['text'].toString(),
                            border: const OutlineInputBorder(),
                          ),
                          child: Text(goalList[index]['title'].toString())),
                    ),
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
