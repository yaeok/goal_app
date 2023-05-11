import 'package:fill/firebase/apis/goal.dart';
import 'package:fill/model/goal/goal.dart';
import 'package:fill/state/goal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  final Goal goal;
  const DetailPage(this.goal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalState = ref.watch(goalProvider);
    List<String> text = ['最終目標', '第1目標', '第2目標', '第3目標'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: goal.goals.length,
          itemBuilder: (context, index) {
            return goal.goals[index].flg != false
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
                                      onPressed: () async {},
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
                            labelText: text[index],
                            border: const OutlineInputBorder(),
                          ),
                          child: Text(goal.goals[index].title.toString())),
                    ),
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
