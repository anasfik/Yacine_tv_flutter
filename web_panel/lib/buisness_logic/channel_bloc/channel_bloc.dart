import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

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
    channelNameController = TextEditingController(text: channel.channelName);
    channelStreamUrlController =
        TextEditingController(text: channel.channelStreamUrl);
    channelImageUrlController =
        TextEditingController(text: channel.channelImage);
    channelTagsController =
        TextEditingController(text: channel.tags.join(', '));
    on<UpdateChannel>(_saveUpdate);
    on<AddedChannel>(_addChannel);
    on<DeleteChannel>(_deleteChannel);
  }

  void _saveUpdate(
    UpdateChannel event,
    Emitter<ChannelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await channelsCategoriesRepository.updateChannel(
      event.categoryId,
      channel.copyWith(
        channelName: channelNameController.text,
        channelStreamUrl: channelStreamUrlController.text,
        channelImage: channelImageUrlController.text,
        tags: channelTagsController.text
            .split(',')
            .map(
              (e) => e.trim(),
            )
            .toList(),
      ),
    );
    emit(state.copyWith(isLoading: false));
  }

  _addChannel(
    AddedChannel event,
    Emitter<ChannelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await channelsCategoriesRepository.addChannel(
      event.categoryId,
      channel.copyWith(
        channelName: channelNameController.text,
        channelStreamUrl: channelStreamUrlController.text,
        channelImage: channelImageUrlController.text,
        tags: channelTagsController.text
            .split(',')
            .map(
              (e) => e.trim(),
            )
            .toList(),
      ),
    );
    event.onSuccess();
    emit(state.copyWith(isLoading: false));
  }

  _deleteChannel(
    DeleteChannel event,
    Emitter<ChannelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await channelsCategoriesRepository.deleteChannel(
      event.categoryId,
      event.channelId,
    );
    event.onSuccess();
    emit(state.copyWith(isLoading: false));
  }
}
