import 'package:time/time.dart';

extension DateExtension on DateTime {
  String localeDate() {
    return '${this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}:${this.second.toString().padLeft(2, '0')}';
  }

  String localeDateWithFuso() {
    return '${this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}:${this.second.toString().padLeft(2, '0')} (${this.timeZoneName})';
  }

  DateTime getdatebystring(String date) {
    var date1 = date.split(' ')[0];
    var hour1 = date.split(' ')[1];
    var year = int.tryParse(date1.split('/')[2]);
    var month = int.tryParse(date1.split('/')[1]);
    var day = int.tryParse(date1.split('/')[0]);
    var hour = int.tryParse(hour1.split(':')[0]);
    var minute = int.tryParse(hour1.split(':')[1]);
    return DateTime(year, month, day, hour, minute);
  }

  String differenceTime(DateTime date) {
    var duration = (this.hour.hours + this.minute.minutes) - (date.hour.hours + date.minute.minutes);
    return duration.toString().split('.')[0];
  }

  String dateFormatBR() {
    return '${this.day.toString().padLeft(2, '0')}/${this.month.toString().padLeft(2, '0')}/${this.year.toString().padLeft(2, '0')}';
  }
}
