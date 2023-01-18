import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/navigation_item.dart';
import '../../presentation/config/const.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<int> {
  final List<NavigationItem> items = PresentationLayerConstants.navigationItems;

  BottomNavigationCubit(int initialIndex) : super(initialIndex);

  // ignore: format-comment
  /// This function is used to emit a new event with the index of the selected screen.
  ///
  /// It takes an integer `index` as input, representing the index of the selected screen.
  ///
  /// ## Example
  /// ```dart
  /// selectScreenAt(1); // This will select the screen at index 1.
  /// ```
  void selectScreenAt(int index) {
    emit(index);
  }
}
