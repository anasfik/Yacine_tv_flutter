import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:web_panel/data/models/chennels_category.dart';

import '../../data/repositories/channels_categories_repository/channels_categories_repository.dart';

part 'channels_categories_event.dart';
part 'channels_categories_state.dart';

class ChannelsCategoriesBloc
    extends Bloc<ChannelsCategoriesEvent, ChannelsCategoriesState> {
  final ChannelsCategoriesRepository channelsCategoriesRepository;

  ChannelsCategoriesBloc(this.channelsCategoriesRepository)
      : super(const ChannelsCategoriesState()) {
    on<ChannelsCategoryCreated>(_createChannelCategory);
    on<ChannelsCategoryTitleEdited>(_editChannelCategoryTitle);
    on<NewCategoriesGetRequested>(_newCategoriesGetRequested);
    on<DeleteCategory>(_deleteCategory);
    add(NewCategoriesGetRequested());
  }

  void _createChannelCategory(
    ChannelsCategoryCreated event,
    Emitter<ChannelsCategoriesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await channelsCategoriesRepository.createChannelsCategory(
      ChannelsCategory(
        id: "_",
        categoryTitle: state.channelsCategoryTitle,
        channels: [],
      ),
    );
    event.onSuccess();
    emit(state.copyWith(isLoading: false));
  }

  void _editChannelCategoryTitle(
    ChannelsCategoryTitleEdited event,
    Emitter<ChannelsCategoriesState> emit,
  ) {
    emit(state.copyWith(channelsCategoryTitle: event.newValue));
  }

  _newCategoriesGetRequested(
    NewCategoriesGetRequested event,
    Emitter<ChannelsCategoriesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final channelsCategories =
        await channelsCategoriesRepository.getChannelsCategories();

    emit(
      state.copyWith(
        isLoading: false,
        allChannelsCategories: channelsCategories,
      ),
    );
  }

  _deleteCategory(
    DeleteCategory event,
    Emitter<ChannelsCategoriesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await channelsCategoriesRepository.deleteChannelsCategory(event.categoryId);
    event.onSuccess();
    emit(state.copyWith(isLoading: false));
  }
}
