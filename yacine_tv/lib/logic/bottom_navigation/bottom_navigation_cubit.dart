import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/navigation_item.dart';
import '../../presentation/config/const.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<int> {
  final List<NavigationItem> items = PresentationLayerConstants.navigationItems;

  BottomNavigationCubit(int initialIndex) : super(initialIndex);

  void selectScreenAt(int index) {
    emit(index);
  }
}
