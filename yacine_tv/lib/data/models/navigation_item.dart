import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class NavigationItem extends Equatable {
  final String name;
  final IconData icon;
  final Widget screen;

  @override
  List<Object?> get props => [name, icon, screen];

  const NavigationItem({
    required this.name,
    required this.icon,
    required this.screen,
  });
}
