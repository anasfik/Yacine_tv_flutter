import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yacine_tv/data/repositories/menu/menu.dart';

import '../../data/models/menu_item.dart';

part 'drawer_cubit_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  final MenuRepository repository;
  DrawerCubit(this.repository) : super(const DrawerStateLoading()) {
    loadDrawerItems();
  }

  Future<void> loadDrawerItems() async {
    try {
      emit(const DrawerStateLoading());

      final drawerItems = await repository.getMenuItems();

      emit(DrawerStateLoaded(drawerItems: drawerItems));
    } catch (e) {
      emit(DrawerStateError(error: e.toString()));
    }
  }
}
