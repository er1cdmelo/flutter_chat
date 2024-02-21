class Utils {
  static String getTimeFromDate(DateTime date) {
    return "${date.hour.toString().padLeft(2, "0")}h${date.minute.toString().padLeft(2, "0")}";
  }
}
