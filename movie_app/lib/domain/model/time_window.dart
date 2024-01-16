enum TimeWindow {
  day,
  week;

  TimeWindow fromValue(String timeWidowValue) {
    return TimeWindow.values.byName(timeWidowValue);
  }
}
