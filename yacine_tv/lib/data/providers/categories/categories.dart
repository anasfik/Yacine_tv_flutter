import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../../interfaces/data_type.dart';
import '../../models/channel.dart';
import '../../models/channels_category.dart';

class CategoriesProvider implements DataTypeInterface {
  static String endPoint = "/categories";

  static Future<String> get() async {
    http.Response res = await http.get(
      Uri.http(
        dotenv.env['API_URL']!,
        endPoint,
      ),
    );

    return res.body;
  }

  static Future<String> post(ChannelsCategory category) async {
    http.Response res = await http.post(
      Uri.http(
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

  static delete(
    String categoryId,
  ) async {
    http.Response res = await http.delete(
      Uri.http(
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

  // static Future<void> delete(String categoryId) async {
  //   final res = await http.delete(
  //     Uri.http(
  //       dotenv.env['API_URL']!,
  //       '$endPoint/$categoryId',
  //     ),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //     },
  //   );
  //   print(res);
  // }

  static Future<String> put(ChannelsCategory channelsCategory) async {
    print(channelsCategory.id);
    print(channelsCategory.categoryTitle);

    http.Response res = await http.put(
      Uri.http(
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

  static deleteChannel(String categoryId, String channelId) async {
    http.Response res = await http.delete(
      Uri.http(
        dotenv.env['API_URL']!,
        '$endPoint/$categoryId/channels/$channelId',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    return res.body;
  }

  static putChannel(String categoryId, Channel channel) async {
    final channelId = channel.id;
    http.Response res = await http.put(
      Uri.http(
        dotenv.env['API_URL']!,
        '$endPoint/$categoryId/channels/$channelId',
      ),
      body: jsonEncode(channel.toMap()),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(res.body);
    return res.body;
  }

  static postChannel(
    String categoryId,
    Channel channel,
  ) async {
    http.Response res = await http.post(
      Uri.http(
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
