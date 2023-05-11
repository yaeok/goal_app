import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String? title;
  final bool? flg;

  Item({
    this.title,
    this.flg,
  });
}

class Goal {
  final String? id;
  final List<Item> goals;

  Goal({
    this.id,
    required this.goals,
  });

  factory Goal.fromFirestore(DocumentSnapshot snap) {
    final data = snap.data()! as Map;
    final String id = data['docId'] ?? '';
    final Map<String, dynamic> itemData = data['goals'] ?? {};
    final Item firstGoal = Item(
      title: itemData['firstGoals'][0] ?? '',
      flg: itemData['firstGoals'][1] ?? 0,
    );
    final Item secondGoal = Item(
      title: itemData['secondGoals'][0] ?? '',
      flg: itemData['secondGoals'][1] ?? 0,
    );
    final Item thirdGoal = Item(
      title: itemData['thirdGoals'][0] ?? '',
      flg: itemData['thirdGoals'][1] ?? 0,
    );
    final Item finishGoal = Item(
      title: itemData['finishGoals'][0] ?? '',
      flg: itemData['finishGoals'][1] ?? 0,
    );
    final List<Item> goals = [finishGoal, firstGoal, secondGoal, thirdGoal];
    return Goal(
      id: id,
      goals: goals,
    );
  }
}
