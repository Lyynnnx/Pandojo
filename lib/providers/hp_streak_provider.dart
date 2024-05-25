import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportolingo/models/hp_streak.dart';

class HpStreakNotifier extends StateNotifier<HpStreak> {
  HpStreakNotifier() : super(HpStreak(hp: 1, streak: 0, coins: 0));

  void updateHpStreak(int hp, int streak, int coins) {
    state = HpStreak(hp: hp, streak: streak, coins: coins);
  }
}
final hpStreakProvider = StateNotifierProvider<HpStreakNotifier, HpStreak>((ref) => HpStreakNotifier());