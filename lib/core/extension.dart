extension StringParsing on String {
  String capitalize() {
    return "${substring(0,1).toUpperCase()}${substring(1).toLowerCase()}";
  }
  String capitalizeEachWord(){
    return split(" ").isNotEmpty ?  split(" ").map((e) => e.capitalize()).toList().join(" ") : capitalize();
  }
}