import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_panel/data/models/menu_item.dart';

import '../../data/repositories/menu/menu.dart';
import 'package:meta/meta.dart';

part 'menu_bloc_event.dart';
part 'menu_bloc_state.dart';

class MenuBloc extends Bloc<MenuBlocEvent, MenuBlocState> {
  final MenuRepository menuRepository;

  MenuBloc(this.menuRepository) : super(const MenuBlocState()) {
    on<MenuItemsRequested>(_menuItemsRequested);
    add(MenuItemsRequested());
  }

  FutureOr<void> _menuItemsRequested(
    MenuItemsRequested event,
    Emitter<MenuBlocState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final items = await menuRepository.getMatchEvents();
    print(items);
    emit(state.copyWith(menuItems: items, isLoading: false));
  }
}
