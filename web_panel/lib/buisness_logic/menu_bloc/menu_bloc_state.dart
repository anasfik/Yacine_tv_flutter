part of 'menu_bloc_bloc.dart';

@immutable
class MenuBlocState extends Equatable {
  final List<MenuItem>? menuItems;
  final bool isLoading;

  const MenuBlocState({
    this.isLoading = false,
    this.menuItems,
  });

  @override
  List<Object?> get props => [isLoading, menuItems];

  MenuBlocState copyWith({
    List<MenuItem>? menuItems,
    bool? isLoading,
  }) {
    return MenuBlocState(
      menuItems: menuItems ?? this.menuItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
