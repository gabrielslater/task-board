String getDateString() {
  var now = DateTime.now();
  var hour = now.hour;
  var hourString = hour > 12
      ? (hour - 12).toString()
      : hour == 0
          ? 12.toString()
          : hour.toString();
  var amPm = hour < 12 ? 'AM' : 'PM';

  return '${now.year.toString()}-'
      '${now.month.toString().padLeft(2, '0')}-'
      '${now.day.toString().padLeft(2, '0')} '
      '${hourString.padLeft(2, '0')}:'
      '${now.minute.toString().padLeft(2, '0')}:'
      '${now.second.toString().padLeft(2, '0')}'
      ' $amPm';
}
