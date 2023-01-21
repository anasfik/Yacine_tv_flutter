import 'dart:convert';

import '../../models/event_matches.dart';
import '../../providers/event_matches/event_matches.dart';

class MatchEventsRepository {
  Future<List<EventMatch>> getMatchEvents() async {
    final resBody = await MatchEventsProvider.get();
    final res = jsonDecode(resBody) as Map<String, dynamic>;
    final data = (res["data"] as List).cast<Map<String, dynamic>>();
    final result = data.map((x) => EventMatch.fromMap(Map.from(x))).toList();
    
    return result;
  }
}
