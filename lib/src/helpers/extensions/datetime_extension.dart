// ignore_for_file: unnecessary_this

import 'package:intl/intl.dart';

extension DateExt on DateTime {
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

  String toTimeToGoLabel({bool numericIntervals = false}) {
    final now = DateTime.now();
    final durationToNow = this.difference(now);

    final inDays = durationToNow.inDays;
    if (inDays >= 1) {
      if ((inDays / 7).floor() >= 1) {
        return numericIntervals ? 'In 1 week' : 'Next week';
      } else if (inDays >= 2) {
        return 'In $inDays days';
      } else {
        return numericIntervals ? 'In 1 day' : 'Tomorrow';
      }
    }

    final inHours = durationToNow.inHours;
    if (inHours >= 1) {
      if (inHours >= 2) {
        return 'In $inHours hours';
      } else {
        return numericIntervals ? 'In 1 hour' : 'In an hour';
      }
    }

    final inMinutes = durationToNow.inMinutes;
    if (inMinutes >= 1) {
      if (inMinutes >= 2) {
        return 'In $inMinutes minutes';
      } else {
        return numericIntervals ? 'In 1 minute' : 'In a minute';
      }
    }

    final inSeconds = durationToNow.inSeconds;
    return inSeconds >= 3 ? 'In $inSeconds seconds' : 'Just about now';
  }

  String toDateString([String format = 'd MMM, y - hh:mm a']) {
    return DateFormat(format).format(this);
  }
}
