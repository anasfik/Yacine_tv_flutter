import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/lang/en.dart';
import '../../data/models/channels_category.dart';
import '../../data/repositories/categories/categories.dart';

part 'channels_categories_state.dart';

class ChannelsCategoriesCubit extends Cubit<ChannelsCategoriesState> {
  final ChannelsCategoriesRepository repository;

  ChannelsCategoriesCubit(this.repository)
      : super(const ChannelsCategoriesLoading()) {
    loadChannelsCategories();
  }

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
