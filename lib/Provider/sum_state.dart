import 'package:flutter_riverpod/flutter_riverpod.dart';

class SumState extends StateNotifier<int> {
  SumState() : super(0); // Initial value of sum is 0

  void updateSum(int value) {
    state = value;
  }
}
