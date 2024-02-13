class TimeFormatter {
  const TimeFormatter._();

  static String formatTime(int minutes) {
    if (minutes < 0) {
      // Puoi gestire il caso in cui il minutaggio sia negativo secondo le tue esigenze
      return "Invalid time";
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    // Costruisci la stringa formattata
    String formattedTime =
        '$hours h ${remainingMinutes.toString().padLeft(2, '0')} min';

    return formattedTime;
  }
}
