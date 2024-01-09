enum TimeWidow {
  day,
  week;

  TimeWidow fromValue(String timeWidowValue) {
    return TimeWidow.values.byName(timeWidowValue);
  }
}
