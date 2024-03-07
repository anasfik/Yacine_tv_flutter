import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yacine_tv/data/models/channel.dart';

import '../config/general.dart';
import '../data/models/channels_category.dart';

class Core {
  static const _landscapeOrientations = [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  static const _portraitOrientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  ///  This function searches for channels in a list a custom category of channels.
  ///
  ///  It takes in an [Iterable] of [ChannelsCategory] objects as the first argument, representing the list of custom categories to search in.
  ///
  ///  It also takes an optional named argument [searchQuery] as a [String], representing the search query to filter the channels with.
  ///
  ///  If the search query is empty, the function returns an empty [Iterable]. Otherwise, it first maps through the categories and extracts a list of channels from each category.
  /// Then it uses the [expand] method to flatten the list of channels of all the categories.
  /// Then it calls a customChannelsSearch function with the flattened list of channels and search query as the arguments.
  static Iterable<Channel> customCategoriesChannelsSearch(
    Iterable<ChannelsCategory> categories, {
    String searchQuery = "",
  }) {
    if (searchQuery.isEmpty) {
      return [];
    }
    final allCategoriesChannels = categories
        .map((category) => category.channels)
        .expand((channels) => channels);

    return customChannelsSearch(
      allCategoriesChannels,
      searchQuery: searchQuery,
    );
  }

  /// *  CustomChannelsSearch filters a given [Iterable] of channels by checking if the channel's title or tags contain a part of the search query.
  /// The function returns an Iterable of channels that match the search query.
  ///
  /// If the input [searchQuery] is empty or the input [channels] Iterable is null, an empty Iterable is returned.
  ///
  /// Example:
  /// ```dart
  /// Iterable<Channel> channels = ...
  /// String searchQuery = "search string";
  /// Iterable<Channel> filteredChannels = customChannelsSearch(channels, searchQuery: searchQuery);
  /// ```
  static Iterable<Channel> customChannelsSearch(
    Iterable<Channel> channels, {
    String searchQuery = "",
  }) {
    if (searchQuery.isEmpty) {
      return [];
    }

    Iterable<Channel> results = channels.where((channel) {
      return channel.titleContains(searchQuery) ||
          channel.tagsContains(searchQuery);
    }).toList();

    return results;
  }

  /// This function initializes the application's services, environment variables...
  ///
  /// It uses the [dotenv] package to load the environment variables from an asset file (.env) specified in the [Configs.environmentFilePath].
  ///
  /// The function returns a [Future] that completes when the environment variables have been loaded.
  ///
  static Future<void> init() async {
    await dotenv.load(fileName: Configs.environmentFilePath);
    WidgetsFlutterBinding.ensureInitialized();
    await MobileAds.instance.initialize();
  }

  /// This function sets the screen orientation to landscape.
  ///
  /// It uses the [SystemChrome] to set the preferred orientations to landscape.
  static void setScreenOrientationToLandscape() {
    SystemChrome.setPreferredOrientations(_landscapeOrientations);
  }

  /// This function returns the device aspect ratio.
  ///
  /// It takes a [BuildContext] as the argument in order to use the [MediaQuery] to retrieve the device's size aspect ratio.
  static double deviceAspectRatio(BuildContext context) {
    return MediaQuery.of(context).size.aspectRatio;
  }

  /// This function enables full screen mode.
  ///
  /// It calls the [hideDeviceOverlays] and [setScreenOrientationToLandscape] functions to hide the device's status bar and navigation bar, and set the screen orientation to landscape.
  static void enableFullScreenMode() {
    hideDeviceOverlays();
    setScreenOrientationToLandscape();
  }

  /// This function hides the device's status bar and navigation bar.
  ///
  /// It uses the [SystemChrome] to enable overlays (which are an empty list in this case).
  static void hideDeviceOverlays() {
    const overlays = <SystemUiOverlay>[];

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: overlays,
    );
  }

  /// This function sets the screen orientation to portrait.
  ///
  /// It uses the [SystemChrome] to set the preferred orientations to portrait.
  static void setScreenOrientationToPortrait() {
    SystemChrome.setPreferredOrientations(_portraitOrientations);
  }

  /// This functions shares the app.
  /// It uses the [Share] package to share the app's share message.
  /// It takes an optional named argument [onError] as a [Function] that takes a [String] as the argument.
  /// The function is called when an error occurs while sharing the app.
  static Future<void> shareApp({
    void Function(String)? onError,
  }) async {
    try {
      await Share.share(
        Configs.appShareMessage,
      );
    } catch (e) {
      onError?.call(e.toString());
    }
  }
}
