import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:party_maker/data/models/find_data_structures.dart';

class RecentSearchedActivityNotifier extends Notifier<List<ActivityItem>> {
  static const storageKey = 'recent_searched_activities';

  @override
  List<ActivityItem> build() {
    load();
    return [];
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw == null) return;
    final decoded = jsonDecode(raw) as List;
    final persisted = decoded
        .map((e) => ActivityItem.fromJson(e as Map<String, dynamic>))
        .toList();
    final merged = [
      ...state,
      ...persisted.where((p) => !state.any((s) => s.id == p.id)),
    ];
    state = merged.length > 10 ? merged.sublist(0, 10) : merged;
  }

  void record(ActivityItem activity) {
    final updated = [
      activity,
      ...state.where((item) => item.id != activity.id),
    ];
    state = updated.length > 10 ? updated.sublist(0, 10) : updated;
    save();
  }

  void clear() {
    state = [];
    save();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      storageKey,
      jsonEncode(state.map((e) => e.toJson()).toList()),
    );
  }
}

final recentSearchedActivityProvider =
    NotifierProvider<RecentSearchedActivityNotifier, List<ActivityItem>>(
      RecentSearchedActivityNotifier.new,
    );
