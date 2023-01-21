import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/channel.dart';
import '../../models/chennels_category.dart';
import '../interfaces/data_type_interface.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider implements DataTypeInterface {
  static String endPoint = "/categories";

  /// Get a response from the server and return it as a string (JSON).
  static Future<String> get() async {
    http.Response res = await http.get(
      Uri.https(
        dotenv.env['API_URL']!,
        endPoint,
      ),
    );

    return res.body;
  }

  /// Post a response from the server and return the result as a string (JSON).
  static Future<String> post(ChannelsCategory category) async {
    http.Response res = await http.post(
      Uri.https(
        dotenv.env['API_URL']!,
        endPoint,
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(category.toMap()),
    );

    return res.body;
  }

  /// Delete a category by it's id and return the result as a string (JSON).
  static delete(
    String categoryId,
  ) async {
    http.Response res = await http.delete(
      Uri.https(
        dotenv.env['API_URL']!,
        '$endPoint/$categoryId',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    return res.body;
  }

  /// Update a category by it's id and return the result as a string (JSON).
  static Future<String> put(ChannelsCategory channelsCategory) async {
    http.Response res = await http.put(
      Uri.https(
        dotenv.env['API_URL']!,
        '$endPoint/${channelsCategory.id}',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(channelsCategory.toMapWithOnlyTitle()),
    );

    return res.body;
  }

  /// Delete a channel of a category by their ids and return the result as a string (JSON).
  static deleteChannel(String categoryId, String channelId) async {
    http.Response res = await http.delete(
      Uri.https(
        dotenv.env['API_URL']!,
        '$endPoint/$categoryId/channels/$channelId',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(dotenv.env['API_URL']! + '$endPoint/$categoryId/channels/$channelId');

    return res.body;
  }

  /// Update a channel of a category by their ids and return the result as a string (JSON).
  static putChannel(String categoryId, Channel channel) async {
    final channelId = channel.id;
    http.Response res = await http.put(
      Uri.https(
        dotenv.env['API_URL']!,
        '$endPoint/$categoryId/channels/$channelId',
      ),
      body: jsonEncode(channel.toMap()),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    return res.body;
  }

  /// Post a channel of a category by their ids and return the result as a string (JSON).
  static postChannel(
    String categoryId,
    Channel channel,
  ) async {
    http.Response res = await http.post(
      Uri.https(
        dotenv.env['API_URL']!,
        '$endPoint/$categoryId/channels',
      ),
      body: jsonEncode(channel.toMap()),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    return res.body;
  }
}
