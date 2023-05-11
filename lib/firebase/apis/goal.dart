import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fill/model/goal/goal.dart';
import 'auth.dart';

class GoalRepository {
  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('versions')
      .doc('0.0.1')
      .collection('users');

  final String userId = AuthRepository().signInUser!.uid;

  Future registerGoal(String firstGoal, String secondGoal, String thirdGoal,
      String finishGoal) async {
    final CollectionReference goalsCollection =
        usersCollection.doc(userId).collection('goals');
    final registerDate = DateTime.now();
    final data = {
      'createdAt': registerDate,
      'finishedAt': null,
      'uid': userId,
      'goals': {
        'firstGoals': [firstGoal, true],
        'secondGoals': [secondGoal, true],
        'thirdGoals': [thirdGoal, true],
        'finishGoals': [finishGoal, true],
      }
    };
    //目標を登録する
    return await goalsCollection.add(data);
  }

  Stream<List<Goal>> retrievedGoals() {
    final CollectionReference goalsCollection =
        usersCollection.doc(userId).collection('goals');
    return goalsCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Goal.fromFirestore(doc)).toList());
  }

  Future updateGoals(String docId, Goal goal) async {
    final data = {
      'goals': {
        'firstGoals': goal.goals[1],
        'secondGoals': goal.goals[2],
        'thirdGoals': goal.goals[3],
        'finishGoals': goal.goals[0],
      }
    };
    final CollectionReference goalsCollection =
        usersCollection.doc(userId).collection('goals');
    return goalsCollection.doc(docId).update(data);
  }
}
