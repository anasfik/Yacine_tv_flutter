part of 'drawer_cubit_cubit.dart';

abstract class DrawerState extends Equatable {
  final bool isLoading;
  final List<MenuItem>? drawerItems;
  final String? error;
  @override
  List<Object?> get props => [isLoading, drawerItems, error];

  const DrawerState({
    this.isLoading = true,
    this.drawerItems,
    this.error,
  });
}

class DrawerStateLoading extends DrawerState {
  const DrawerStateLoading({
    super.isLoading = true,
  });
}

class DrawerStateLoaded extends DrawerState {
  const DrawerStateLoaded({
    required super.drawerItems,
  });
}

class DrawerStateError extends DrawerState {
  const DrawerStateError({
    required super.error,
  });
}
