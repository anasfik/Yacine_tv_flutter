extension TimeFormattedExtension on DateTime {
  String timeFormatted() {
    final padLeftedhour = hour.toString().padLeft(2, '0');
    final padLeftedminute = minute.toString().padLeft(2, '0');

    return "$padLeftedhour:$padLeftedminute";
  }

  bool isToday() {
    final now = DateTime.now();
    
    return now.year == year && now.month == month && now.day == day;
  }
}
