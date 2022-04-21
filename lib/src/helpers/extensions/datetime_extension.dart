extension DateHelpers on DateTime {
  String toTimeAgoLabel({bool numericIntervals = false}) {
    final now = DateTime.now();
    final durationSinceNow = now.difference(this);

    final inDays = durationSinceNow.inDays;
    if (inDays >= 1) {
      if ((inDays / 7).floor() >= 1) {
        return numericIntervals ? '1 week ago' : 'Last week';
      } else if (inDays >= 2) {
        return '$inDays days ago';
      } else {
        return numericIntervals ? '1 day ago' : 'Yesterday';
      }
    }

    final inHours = durationSinceNow.inHours;
    if (inHours >= 1) {
      if (inHours >= 2) {
        return '$inHours hours ago';
      } else {
        return numericIntervals ? '1 hour ago' : 'An hour ago';
      }
    }

    final inMinutes = durationSinceNow.inMinutes;
    if (inMinutes >= 1) {
      if (inMinutes >= 2) {
        return '$inMinutes minutes ago';
      } else {
        return numericIntervals ? '1 minute ago' : 'A minute ago';
      }
    }

    final inSeconds = durationSinceNow.inSeconds;
    return inSeconds >= 3 ? '$inSeconds seconds ago' : 'Just now';
  }
}
