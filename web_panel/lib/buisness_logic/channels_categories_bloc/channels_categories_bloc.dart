import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:web_panel/data/models/chennels_category.dart';

import '../../data/repositories/channels_categories_repository/channels_categories_repository.dart';

part 'channels_categories_event.dart';
part 'channels_categories_state.dart';

class ChannelsCategoriesBloc
    extends Bloc<ChannelsCategoriesEvent, ChannelsCategoriesState> {
  final ChannelsCategoriesRepository channelsCategoriesRepository;
  ChannelsCategoriesBloc(this.channelsCategoriesRepository)
      : super(ChannelsCategoriesState()) {
    on<ChannelsCategoriesEvent>((event, emit) {});
  }
  Future<List<ChannelsCategory>> all() async {
    return await channelsCategoriesRepository.getChannelsCategories();
    try {} catch (e) {
      throw Exception(e.toString());
    }
  }
}
