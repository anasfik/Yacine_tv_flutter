import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/navigation_item.dart';
import '../../presentation/screens/home/home.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<int> {
  final List<NavigationItem> items = const <NavigationItem>[
    NavigationItem(
      icon: Icons.live_tv,
      name: 'Live TV',
      screen: Home(),
    ),
    NavigationItem(
      icon: Icons.sports_football,
      name: 'Match',
      screen: Scaffold(),
    ),
  ];

  BottomNavigationCubit(int initialIndex) : super(initialIndex);
  void selectScreenAt(int index) {
    emit(index);
  }
}
