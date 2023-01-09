part of 'channel_bloc.dart';

@immutable
abstract class ChannelEvent extends Equatable {}

class UpdateChannel extends ChannelEvent {
  final VoidCallback onSuccess;
  final void Function(String) onError;
  final String categoryId;
  final String channelId;

  UpdateChannel({
    required this.onSuccess,
    required this.onError,
    required this.categoryId,
    required this.channelId,
  });

  @override
  List<Object?> get props => [categoryId, channelId];
}

class AddedChannel extends ChannelEvent {
  final VoidCallback onSuccess;
  final void Function(String) onError;
  final String categoryId;

  AddedChannel({
    required this.onSuccess,
    required this.onError,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [categoryId];
}

class DeleteChannel extends ChannelEvent {
  final String channelId;
  final String categoryId;
  final VoidCallback onSuccess;
  final void Function(String) onError;
  DeleteChannel({
    required this.categoryId,
    required this.channelId,
    required this.onError,
    required this.onSuccess,
  });

  @override
  List<Object?> get props => [categoryId, channelId];
}
