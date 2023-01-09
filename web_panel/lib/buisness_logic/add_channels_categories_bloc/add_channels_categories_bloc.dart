import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'add_channels_categories_event.dart';
part 'add_channels_categories_state.dart';

class AddChannelsCategoriesBloc
    extends Bloc<AddChannelsCategoriesEvent, AddChannelsCategoriesState> {
  AddChannelsCategoriesBloc() : super(AddChannelsCategoriesState()) {
    on<AddChannelsCategoriesEvent>((event, emit) {});
  }
}
