class L10n {
  static const String appName = 'Web Panel';
  static const String welcome = 'Welcome';
  static const String add = 'Add';
  static const String delete = 'Delete';
  static const String update = 'Update';
  static const String newCategory = 'New Category';
  static const String newChannel = 'New Channel';
  static const String categoryName = 'Category Name';
  static const String channels = 'Channels';
  static const String noChannelsCategories =
      'No Channels Categories, click on the add button to add a new category';
  static const String noChannels =
      'No Channels, click on the add button to add a new channel';

  static const String addChannel = 'Add Channel';
  static const String channelsCategoriesError = 'Something went wrong';
  static const String login = 'Login';
  static const String loginError = 'Something went wrong';
  static const String loginSuccess = 'Admin Authenticated Successfully';
  static const String username = 'Username';
  static const String password = 'Password';
  static const String channelsCategories = 'Channels Categories';
  static const String mathEvents = 'Match Events';
  static const String administration = 'Administration';
  static const String menuBar = 'Menu';
  static const String settings = 'settings';
  static const String admob = 'admob';

  static String categoryAddSuccess(String categoryName) =>
      '$categoryName Added Successfully';

  static String youCanAddChannels(String categoryName) =>
      'You can add channels to $categoryName now';

  static String deleted(String channel) =>
      "Channel $channel deleted successfully";
}
