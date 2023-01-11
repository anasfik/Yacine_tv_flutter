part of 'menu_bloc_bloc.dart';

@immutable
class MenuBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}



class MenuItemsRequested extends MenuBlocEvent {
  MenuItemsRequested();
}
