import 'package:fill/firebase/apis/goal.dart';
import 'package:fill/model/goal/goal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goalListProvider = StreamProvider<List<Goal>>((ref) {
  return GoalRepository().retrievedGoals();
});

final goalProvider =
    StateNotifierProvider<GoalNotifier, Goal>((ref) => GoalNotifier());

class GoalNotifier extends StateNotifier<Goal> {
  GoalNotifier() : super(Goal(goals: []));

  Goal updateItemFlg(int index, bool? newFlg) {
    if (index >= 0 && index < state.goals.length) {
      final updatedGoals = List<Item>.from(state.goals);
      updatedGoals[index] = Item(title: state.goals[index].title, flg: newFlg);
      state = state.copyWith(goals: updatedGoals);
    }
    return state;
  }
}
