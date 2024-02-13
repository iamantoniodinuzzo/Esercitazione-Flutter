import 'package:intl/intl.dart';

class CurrencyFormatter {
  const CurrencyFormatter._();

  static String formatCurrency(double value) {
    // Verifica se il valore è superiore a un miliardo o un milione
    if (value >= 1e9) {
      // Se il valore è maggiore o uguale a un miliardo, formatta con il suffisso "mld."
      var formatBillion = NumberFormat('#,##0.##', Intl.defaultLocale);
      return '${formatBillion.format(value / 1e9)} Mld';
    } else if (value >= 1e6) {
      // Se il valore è maggiore o uguale a un milione, formatta con il suffisso "mln."
      var formatMillion = NumberFormat('#,##0.##', Intl.defaultLocale);
      return '${formatMillion.format(value / 1e6)} M';
    } else {
      // Altrimenti, formatta come una valuta normale
      var formatCurrency =
          NumberFormat.simpleCurrency(locale: Intl.defaultLocale);
      return formatCurrency.format(value);
    }
  }
}
