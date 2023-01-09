// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'channels_categories_bloc.dart';

@immutable
class ChannelsCategoriesState extends Equatable {
  final List<ChannelsCategory> allChannelsCategories;
  final List<Channel> channels;
  final String channelsCategoryTitle;
  final bool isLoading;

  const ChannelsCategoriesState({
    this.allChannelsCategories = const [],
    this.channels = const [],
    this.channelsCategoryTitle = "",
    this.isLoading = false,
  });

  @override
  List<Object?> get props =>
      [channels, channelsCategoryTitle, isLoading, allChannelsCategories];

  ChannelsCategoriesState copyWith({
    List<ChannelsCategory>? allChannelsCategories,
    List<Channel>? channels,
    String? channelsCategoryTitle,
    bool? isLoading,
  }) {
    return ChannelsCategoriesState(
      allChannelsCategories:
          allChannelsCategories ?? this.allChannelsCategories,
      channels: channels ?? this.channels,
      channelsCategoryTitle:
          channelsCategoryTitle ?? this.channelsCategoryTitle,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
