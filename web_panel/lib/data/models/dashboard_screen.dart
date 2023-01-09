// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends Equatable {
  final String title;
  final Widget screen;
  final IconData icon;

  const DashBoardScreen({
    required this.title,
    required this.screen,
    required this.icon,
  });

  @override
  List<Object?> get props => [title, screen, icon];
}
