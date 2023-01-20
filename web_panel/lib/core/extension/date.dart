extension TimeFormattedExtension on DateTime {
  // ignore: format-comment
  /// This function returns the time formatted in the format "HH:mm"
  ///
  /// It pads left the hour and minute values with zero if they are single digits.
  ///
  /// ## Example
  /// ```dart
  /// final date = DateTime.now();
  /// print(date.timeFormatted()); // output: "23:12"
  /// ```
 
  String timeFormatted() {
    final padLeftedhour = hour.toString().padLeft(2, '0');
    final padLeftedminute = minute.toString().padLeft(2, '0');

    return "$padLeftedhour:$padLeftedminute";
  }

String formattedForHumans() {
    final padLeftedhour = hour.toString().padLeft(2, '0');
    final padLeftedminute = minute.toString().padLeft(2, '0');
    final padLeftedday = day.toString().padLeft(2, '0');
    final padLeftedmonth = month.toString().padLeft(2, '0');

    return "$padLeftedday/$padLeftedmonth/$year $padLeftedhour:$padLeftedminute";
}
  // ignore: format-comment
  /// This function returns whether the date is today or not.
  ///
  /// It compares the year, month and day of the current date and the provided date
  ///
  /// ## Example
  /// ```dart
  /// final date = DateTime.now();
  /// print(date.isToday()); // output: true
  /// ```
  bool isToday() {
    final now = DateTime.now();

    return now.year == year && now.month == month && now.day == day;
  }
}
