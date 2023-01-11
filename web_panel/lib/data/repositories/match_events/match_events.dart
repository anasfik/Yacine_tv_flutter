import 'dart:convert';

import '../../models/event_match.dart';
import '../../providers/event_matches/event_matches.dart';

class MatchEventsRepository {
  Future<List<EventMatch>> getMatchEvents() async {
    final resBody = await MatchEventsProvider.get();
    final res = jsonDecode(resBody) as Map<String, dynamic>;
    final data = (res["data"] as List).cast<Map<String, dynamic>>();
    final result = data.map((x) => EventMatch.fromMap(Map.from(x))).toList();
    return result;
  }

  Future<void> createMatchEvent(EventMatch eventMatch) async {
    final resBody = await MatchEventsProvider.post(eventMatch);
    print(resBody);
  }

  Future<void> updateMatchEvent(
    String id,
    EventMatch eventMatch,
  ) async {
    final resBody = await MatchEventsProvider.put(eventMatch, id);
    print(resBody);
  }

  Future<void> deleteMatchEvent(
    String id,
  ) async {
    final res = await MatchEventsProvider.delete(id);
    print(res);
  }
}
