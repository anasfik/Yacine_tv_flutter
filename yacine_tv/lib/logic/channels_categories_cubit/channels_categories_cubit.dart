import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/channels_category.dart';
import '../../data/repositories/categories/categories.dart';

part 'channels_categories_state.dart';

class ChannelsCategoriesCubit extends Cubit<ChannelsCategoriesState> {
  /// This is the repository that will be used to fetch the channels categories.
  final ChannelsCategoriesRepository repository;

  ChannelsCategoriesCubit(this.repository)
      : super(const ChannelsCategoriesLoading()) {
    loadChannelsCategories();
  }

  /// This function is used to load the channels categories.
  /// It will emit a [ChannelsCategoriesLoaded] state if the categories are loaded successfully.
  /// It will emit a [ChannelsCategoriesError] state if the categories are not loaded successfully.
  /// It will emit a [ChannelsCategoriesLoading] state if the categories are being loaded.
  /// Example:
  /// ```dart
  /// await loadChannelsCategories();
  /// ```
  Future<void> loadChannelsCategories() async {
    try {
      emit(const ChannelsCategoriesLoading());

      final categories = await repository.getChannelsCategories();

      emit(ChannelsCategoriesLoaded(channelsCategories: categories));
    } catch (e) {
      emit(ChannelsCategoriesError(error: e.toString()));
    }
  }
}
