import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../data/models/channel.dart';
import '../../data/models/chennels_category.dart';
import '../../data/repositories/channels_categories_repository/channels_categories_repository.dart';

part 'channel_event.dart';
part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final Channel channel;

  final ChannelsCategoriesRepository channelsCategoriesRepository;

  late final TextEditingController channelNameController;
  late final TextEditingController channelStreamUrlController;
  late final TextEditingController channelImageUrlController;
  late final TextEditingController channelTagsController;

  ChannelBloc(this.channel, this.channelsCategoriesRepository)
      : super(const ChannelState()) {
    _initControllers(channel);

    on<UpdateChannel>(_saveUpdate);
    on<AddedChannel>(_addChannel);
    on<DeleteChannel>(_deleteChannel);
  }

  void _saveUpdate(UpdateChannel event, Emitter<ChannelState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await channelsCategoriesRepository.updateChannel(
        event.categoryId,
        _channelFromControllers(),
      );
      event.onSuccess.call();
    } catch (e) {
      event.onError.call(e.toString());
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  _addChannel(AddedChannel event, Emitter<ChannelState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await channelsCategoriesRepository.addChannel(
        event.categoryId,
        _channelFromControllers(),
      );
      event.onSuccess();
    } catch (e) {
      event.onError(e.toString());
    }
    emit(state.copyWith(isLoading: false));
  }

  _deleteChannel(DeleteChannel event, Emitter<ChannelState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await channelsCategoriesRepository.deleteChannel(
        event.categoryId,
        event.channelId,
      );
      event.onSuccess();
    } catch (e) {
      event.onError(e.toString());
    }
    emit(state.copyWith(isLoading: false));
  }

  Channel _channelFromControllers() {
    return channel.copyWith(
      channelName: channelNameController.text,
      channelStreamUrl: channelStreamUrlController.text,
      channelImage: channelImageUrlController.text,
      tags: channelTagsController.text
          .split(',')
          .map(
            (e) => e.trim(),
          )
          .toList(),
    );
  }

  void _initControllers(Channel chan) {
    channelNameController = TextEditingController(text: chan.channelName);
    channelStreamUrlController =
        TextEditingController(text: chan.channelStreamUrl);
    channelImageUrlController = TextEditingController(text: chan.channelImage);
    channelTagsController = TextEditingController(text: chan.tags.join(', '));
  }
}
