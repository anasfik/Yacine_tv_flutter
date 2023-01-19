import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:web_panel/data/models/chennels_category.dart';
import '../../data/models/channel.dart';
import '../../data/repositories/channels_categories_repository/channels_categories_repository.dart';

part 'channels_categories_event.dart';
part 'channels_categories_state.dart';

class ChannelsCategoriesBloc
    extends Bloc<ChannelsCategoriesEvent, ChannelsCategoriesState> {
  /// [ChannelsCategoriesRepository] is used to get data from the database.
  final ChannelsCategoriesRepository channelsCategoriesRepository;

  /// [categoryTitleController] is used to get the title of the category from the text field.
  late final TextEditingController categoryTitleController;

  ChannelsCategoriesBloc(this.channelsCategoriesRepository)
      : super(const ChannelsCategoriesState()) {
    categoryTitleController = TextEditingController();
    on<ChannelsCategoryCreated>(_createChannelCategory);
    on<ChannelsCategoryUpdated>(_channelsCategoryUpdated);
    on<ChannelsCategoryTitleEdited>(_editChannelCategoryTitle);
    on<NewCategoriesGetRequested>(_newCategoriesGetRequested);
    on<DeleteCategory>(_deleteCategory);

    //  Request data as soon as the bloc is created.
    add(NewCategoriesGetRequested());
  }

  /// Returns the number of categories formatted.
  String channelsCategoriesLength() {
    int length = state.allChannelsCategories.length;

    return "$length categories";
  }

  /// This function is responsible for updating the state of the [ChannelsCategoriesBloc] when the title of the category is edited.
  /// It uses the [categoryTitleController] to get the new title of the category on every change.
  void _editChannelCategoryTitle(
    ChannelsCategoryTitleEdited event,
    Emitter<ChannelsCategoriesState> emit,
  ) {
    emit(state.copyWith(channelsCategoryTitle: event.newValue));
  }

  /// This function is responsible for creating a new channel category using the state of the [ChannelsCategoriesBloc].
  ///
  /// It uses the [channelsCategoriesRepository] to create the category by calling its [createChannelsCategory] method.
  ///
  /// The category  is constructed using the [ChannelsCategory] class.
  void _createChannelCategory(
    ChannelsCategoryCreated event,
    Emitter<ChannelsCategoriesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await channelsCategoriesRepository.createChannelsCategory(
        ChannelsCategory(
          id: "_",
          categoryTitle: state.channelsCategoryTitle,
          channels: [],
        ),
      );
      event.onSuccess();
    } catch (e) {
      event.onError(e.toString());
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// This function is responsible for updating a channel category using the state of the [ChannelsCategoriesBloc].
  /// It uses the [channelsCategoriesRepository] to update the category by calling its [updateChannelsCategory] method.
  void _channelsCategoryUpdated(
    ChannelsCategoryUpdated event,
    Emitter<ChannelsCategoriesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await channelsCategoriesRepository.updateChannelsCategory(
      ChannelsCategory(
        channels: [],
        id: event.categoryId,
        categoryTitle: state.channelsCategoryTitle,
      ),
    );
    event.onSuccess();
    emit(state.copyWith(isLoading: false));
  }

  /// This function is responsible for requesting the data from the database.
  /// It uses the [channelsCategoriesRepository] to get the data by calling its [getChannelsCategories] method.
  /// It then updates the state of the [ChannelsCategoriesBloc] by calling the [emit] method (simulating a reload of the page).
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

  /// This function is responsible for deleting a channel category using the state of the [ChannelsCategoriesBloc].
  /// It uses the [channelsCategoriesRepository] to delete the category by calling its [deleteChannelsCategory] method.
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
