part of 'channels_categories_cubit.dart';

@immutable
abstract class ChannelsCategoriesState extends Equatable {
  final bool isLoading;
  final List<ChannelsCategory>? channelsCategories;
  final String? error;
  const ChannelsCategoriesState({
    this.isLoading = true,
    this.channelsCategories,
    this.error,
  });
  @override
  List<Object?> get props => [isLoading, channelsCategories, error];
}

class ChannelsCategoriesLoading extends ChannelsCategoriesState {
  const ChannelsCategoriesLoading({
    super.isLoading = true,
  });
}

class ChannelsCategoriesLoaded extends ChannelsCategoriesState {
  const ChannelsCategoriesLoaded({
    super.isLoading = false,
    required super.channelsCategories,
  });
}

class ChannelsCategoriesError extends ChannelsCategoriesState {
  const ChannelsCategoriesError({
    super.isLoading = false,
    required super.error,
  });
}
