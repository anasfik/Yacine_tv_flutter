part of 'channels_categories_bloc.dart';

@immutable
abstract class ChannelsCategoriesEvent {}

class ChannelsCategoryCreated extends ChannelsCategoriesEvent {
  final VoidCallback onSuccess;
  final void Function(String) onError;

  ChannelsCategoryCreated({
    required this.onError,
    required this.onSuccess,
  });
}

class ChannelsCategoryUpdated extends ChannelsCategoriesEvent {
  final VoidCallback onSuccess;
  final void Function(String) onError;
  final String categoryId;

  ChannelsCategoryUpdated({
    required this.onError,
    required this.categoryId,
    required this.onSuccess,
  });
}

class ChannelsCategoryTitleEdited extends ChannelsCategoriesEvent {
  final String newValue;
  ChannelsCategoryTitleEdited(this.newValue);
}

class NewCategoriesGetRequested extends ChannelsCategoriesEvent {
  NewCategoriesGetRequested();
}

class NewChannelCreated extends ChannelsCategoriesEvent {
  final String categoryId;
  final VoidCallback onSuccess;
  final void Function(String) onError;

  NewChannelCreated({
    required this.categoryId,
    required this.onSuccess,
    required this.onError,
  });
}

class DeleteCategory extends ChannelsCategoriesEvent {
  final String categoryId;

  final VoidCallback onSuccess;
  final void Function(String) onError;
  DeleteCategory({
    required this.categoryId,
    required this.onSuccess,
    required this.onError,
  });
}
