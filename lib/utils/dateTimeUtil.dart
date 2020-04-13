class DateTimeUtil {
  static DateTime parseTimeFromUTCToLocal(DateTime utc) {
    return utc.toLocal();
  }

  static String parseTimeFromUTCToLocalString(DateTime utc) {
    DateTime local = parseTimeFromUTCToLocal(utc);
    return "${local.year.toString()}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}";
  }

  // static String parseTimeFromNow(DateTime utc) {
  //   DateTime local = utc.toLocal();
  // }
}
