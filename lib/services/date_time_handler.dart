
class DateTimeHandler {
  static String formatTimestamp(DateTime date) {
    DateTime now = DateTime.now();
    int diffDays = 0;
    if (now.year == date.year && now.month == date.month && now.day == date.day) {
        diffDays = 0;
    } else {
      diffDays = 2;
    }

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