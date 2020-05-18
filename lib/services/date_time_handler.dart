
class DateTimeHandler {
  static String formatTimestamp(DateTime date) {
    DateTime now = DateTime.now();
    int diffDays = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;

    String formattedTime;
    switch (diffDays) {
      case 0:
        formattedTime = '${date.hour}:${date.minute}';
        break;
      case 1:
        formattedTime = 'yesterday';
        break;
      default:
        formattedTime = '${date.day}/${date.month}/${date.year}';
        break;
    }

    return formattedTime;
  }
}