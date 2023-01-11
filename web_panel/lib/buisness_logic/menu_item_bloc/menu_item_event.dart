part of 'menu_item_bloc.dart';

class MenuItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MenuItemAdded extends MenuItemEvent {
  final wd.VoidCallback onSuccess;
  final void Function(String) onError;

  MenuItemAdded({
    required this.onSuccess,
    required this.onError,
  });
}

class MenuItemUpdated extends MenuItemEvent {
  final wd.VoidCallback onSuccess;
  final void Function(String) onError;
  final String itemId;

  MenuItemUpdated({
    required this.itemId,
    required this.onSuccess,
    required this.onError,
  });
}
class MenuItemDeleted extends MenuItemEvent {
  final wd.VoidCallback onSuccess;
  final void Function(String) onError;
  final String itemId;

  MenuItemDeleted({
    required this.itemId,
    required this.onSuccess,
    required this.onError,
  });
}
