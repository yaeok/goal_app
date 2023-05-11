import 'package:fill/firebase/apis/goal.dart';
import 'package:fill/model/goal/goal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goalListProvider = StreamProvider<List<Goal>>((ref) {
  return GoalRepository().retrievedGoals();
});

final goalProvider = StateProvider.autoDispose((ref) {
  return null;
});
