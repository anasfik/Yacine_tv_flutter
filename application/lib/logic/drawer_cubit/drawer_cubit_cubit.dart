import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yacine_tv/core/lang/en.dart';
import 'package:yacine_tv/data/repositories/menu/menu.dart';

import '../../data/models/menu_item.dart';

part 'drawer_cubit_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  /// This is the repository that will be used to fetch the drawer items.
  final MenuRepository repository;
  DrawerCubit(this.repository) : super(const DrawerStateLoading()) {
    loadDrawerItems();
  }

  /// This function is used to load the drawer items.
  /// It will emit a [DrawerStateLoaded] state if the items are loaded successfully.
  /// It will emit a [DrawerStateError] state if the items are not loaded successfully.
  /// It will emit a [DrawerStateLoading] state if the items are being loaded.
  /// Example:
  /// ```dart
  /// await loadDrawerItems();
  /// ```
  Future<void> loadDrawerItems() async {
    try {
      emit(const DrawerStateLoading());

      final drawerItems = await repository.getMenuItems();

      emit(DrawerStateLoaded(drawerItems: drawerItems));
    } catch (e) {
      emit(DrawerStateError(error: e.toString()));
    }
  }

  /// This function is used to open a link.
  /// Example:
  /// ```dart
  /// await openLink(
  ///  'https://www.google.com',
  /// onError: (error) => print(error),
  /// );
  /// ```
  Future<void> openLink(
    String link, {
    required void Function(String) onError,
  }) async {
    try {
      final didOpenLink = await launchUrl(
        Uri.parse(link),
        mode: LaunchMode.externalApplication,
      );
      if (!didOpenLink) {
        onError.call(L10n.error);
      }
    } catch (e) {
      onError.call(e.toString());
    }
  }
}
