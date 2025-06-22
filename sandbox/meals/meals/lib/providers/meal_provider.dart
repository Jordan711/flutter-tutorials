import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  // Not useful because any widget can just import this directly
  // More useful for dynamic data and cross widget state
  return dummyMeals;
});