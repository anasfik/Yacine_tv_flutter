import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/menu_item.dart';
import '../../data/repositories/menu/menu.dart';
import 'package:flutter/widgets.dart' as wd;

part 'menu_item_event.dart';
part 'menu_item_state.dart';

class MenuItemBloc extends Bloc<MenuItemEvent, MenuItemState> {
  final MenuRepository menuRepository;
  final MenuItem item;

  late final wd.TextEditingController titleController;
  late final wd.TextEditingController iconController;
  late final wd.TextEditingController linkController;

  MenuItemBloc({
    required this.menuRepository,
    required this.item,
  }) : super(MenuItemState()) {
    _initControllers(item);
    on<MenuItemAdded>(_menuItemAdded);
    on<MenuItemDeleted>(_menuItemDeleted);
    on<MenuItemUpdated>(_menuItemUpdated);
  }

  FutureOr<void> _menuItemAdded(
    MenuItemAdded event,
    Emitter<MenuItemState> emit,
  ) async {
    final createdItem = _createdItem();
    await menuRepository.createMenuItem(createdItem);

    event.onSuccess();
  }

  MenuItem _createdItem() {
    return MenuItem(
      id: "_",
      title: titleController.text,
      icon: iconController.text,
      link: linkController.text,
    );
  }

  FutureOr<void> _menuItemUpdated(
    MenuItemUpdated event,
    Emitter<MenuItemState> emit,
  ) async {
    final item = _createdItem();
    await menuRepository.updateMenuItem(item, event.itemId);
    event.onSuccess();
  }

  FutureOr<void> _menuItemDeleted(
    MenuItemDeleted event,
    Emitter<MenuItemState> emit,
  ) async {
    await menuRepository.deleteMenuItem(event.itemId);
    event.onSuccess();
  }

  void _initControllers(MenuItem item) {
    titleController = wd.TextEditingController(text: item.title);
    iconController = wd.TextEditingController(text: item.icon);
    linkController = wd.TextEditingController(text: item.link);
  }
}
