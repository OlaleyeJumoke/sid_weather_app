DateTime getDateTime(int timestampInSeconds, int timezone) {
  // return DateTime as in the given timezone
  return DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000,
          isUtc: true)
      .add(Duration(seconds: timezone));
}

