import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/chennels_category.dart';
import '../interfaces/data_type_interface.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider implements DataTypeInterface {
  @override
  String get endPoint => "/categories";

  static Future<String> get() async {
    http.Response res = await http.get(
      Uri.http(
        dotenv.env['API_URL']!,
        '/categories',
      ),
      // headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      // },
    );

    return res.body;
  }

  static Future<String> post(Map<String, dynamic> data) async {
    http.Response res = await http.post(
      Uri.http(
        dotenv.env['API_URL']!,
        '/categories',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data),
    );

    return res.body;
  }

  static delete(String categoryId) async {
    final res = await http.delete(
      Uri.http(
        dotenv.env['API_URL']!,
        '/categories/$categoryId',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(res);
  }

  static put(
    String categoryId,
    ChannelsCategory channelsCategory,
  ) async {
    http.Response res = await http.put(
      Uri.http(
        dotenv.env['API_URL']!,
        '/categories/$categoryId',
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
        '/categories/$categoryId/channels/$channelId',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    return res.body;
  }

  static putChannel(
    String categoryId,
    Channel channel,
  ) async {
    final channelId = channel.id;
    http.Response res = await http.put(
      Uri.http(
        dotenv.env['API_URL']!,
        '/categories/$categoryId/channels/$channelId',
      ),
      body: jsonEncode(channel.toMap()),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    return res.body;
  }

  static deleteCategory(
    String categoryId,
  ) async {
    http.Response res = await http.delete(
      Uri.http(
        dotenv.env['API_URL']!,
        '/categories/$categoryId',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    return res.body;
  }

  static postChannel(
    String categoryId,
    Channel channel,
  ) async {
    http.Response res = await http.post(
      Uri.http(
        dotenv.env['API_URL']!,
        '/categories/$categoryId/channels',
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
