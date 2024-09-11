import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${substring(0,1).toUpperCase()}${substring(1).toLowerCase()}";
  }
  String capitalizeEachWord(){
    return split(" ").isNotEmpty ?  split(" ").map((e) => e.capitalize()).toList().join(" ") : capitalize();
  }
}

extension IntExtension on int {
  String convertToIdr() {
    NumberFormat format =
        NumberFormat.currency(locale: "id", symbol: "", decimalDigits: 0);
    return format.format(this);
  }
}