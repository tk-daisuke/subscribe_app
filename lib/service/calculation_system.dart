import 'package:bom_app/item/calculation.dart';
import 'package:bom_app/item/enum.dart';
import 'package:bom_app/item/price.dart';
import 'package:bom_app/service/local/ja_messages.dart';
import 'package:timeago/timeago.dart' as timeago;

class CalculationSystem {
  Calculation perMoney(
      {required int index, required int par, required double price}) {
    final reload = [Date.day, Date.weeklys, Date.month, Date.year];
// 30.416
// 52.1429
//365.2425
    switch (reload[index]) {
      case Date.day:
        return Calculation(
            days: price / par,
            weeklys: price * 7 / par,
            month: price * 30 / par, // 30.416
            years: price * 365 / par); //365.2425
      case Date.weeklys:
        return Calculation(
          days: price / 7 / par,
          weeklys: price / par,
          month: price * 4 / par, // 4.345
          years: price * 52 / par, // 52.1429
        );
      case Date.month:
        return Calculation(
          days: price / 30 / par, //30.416
          weeklys: price / 4 / par, // 4.345
          month: price / par,
          years: price * 12 / par,
        );
      case Date.year:
        return Calculation(
          days: price / 365 / par, //365.2425
          weeklys: price / 52 / par, // 52.1429
          month: price / 12 / par,
          years: price / par,
        );
    }
    // notifyListeners();
  }

  // 18 == 1 20 == 0  19 == 0
  String getContract({
    required DateTime startTime,
  }) {
    final start = DateTime(startTime.year, startTime.month, startTime.day);
    final date = DateTime.now();
    final now = DateTime(date.year, date.month, date.day);
    final difference = now.difference(start).inDays;
    timeago.setLocaleMessages('ja', JaCustomMessages());
    final fifteenAgo = now.subtract(Duration(days: difference));
    return timeago.format(fifteenAgo, locale: 'ja');
  }

  int getContractDay({required DateTime startTime, }) {
    final start = DateTime(startTime.year, startTime.month, startTime.day);
    final date = DateTime.now();
    final now = DateTime(date.year, date.month, date.day);
    final difference = now.difference(start).inDays;
    return difference;
  }

  double totalMoney({
    required int index,
    required int par,
    required double price,
    required DateTime startTime,
  }) {
    final reload = [Date.day, Date.weeklys, Date.month, Date.year];
    final start = DateTime(startTime.year, startTime.month, startTime.day);
    final date = DateTime.now();
    final now = DateTime(date.year, date.month, date.day);
    final difference = now.difference(start).inDays;
    final toDay = difference;
    switch (reload[index]) {
      case Date.day:
        return price / par * toDay; //365.2425
      case Date.weeklys:
        return price / 7 / par * toDay;
      case Date.month:
        return price / 30 / par * toDay;
      case Date.year:
        return price / 365 / par * toDay; //365.2425

    }
  }

  Price totalPriceResult(List<Price> result) {
    var daysTotal = 0.0;
    var weeksTotal = 0.0;
    var monthsTotal = 0.0;
    var yearsTotal = 0.0;

    //初期化
    daysTotal = 0;
    weeksTotal = 0;
    monthsTotal = 0;
    yearsTotal = 0;
    for (final item in result) {
      if (item.isActive != false) {
        daysTotal = item.day + daysTotal;
      }
    }
    for (final item in result) {
      if (item.isActive != false) {
        weeksTotal = item.week + weeksTotal;
      }
    }
    for (final item in result) {
      if (item.isActive != false) {
        monthsTotal = item.month + monthsTotal;
      }
    }
    for (final item in result) {
      if (item.isActive != false) {
        yearsTotal = item.year + yearsTotal;
      }
    }
    return Price(
        day: daysTotal,
        month: monthsTotal,
        week: weeksTotal,
        year: yearsTotal,
        isActive: true);
  }

//   List<DateTime> daysList = <DateTime>[];
//   List<DateTime> weeksList = <DateTime>[];
//   List<DateTime> monthList = <DateTime>[];
//   List<DateTime> yearsList = <DateTime>[];
//   int i = 0;
//   DateTime? nextUpdate({
//     required int reloadTime,
//     required DateTime startTime,
//     required int countValue,
//   }) {
//     final date = DateTime.now();
//     final now = DateTime(date.year, date.month, date.day);
//     final start = DateTime(startTime.year, startTime.month, startTime.day);

//     // 現時刻とスタート時間の日数差を計算
//     final difference = now.difference(startTime).inDays;

// // for ( futureDate.CompareTo(date) > 0; date = date.AddDays(1.0))

//     switch (reloadTime) {
//       case 0:
//         List<DateTime> calculateDaysInterval(
//             DateTime startDate, DateTime endDate, int countValue) {
//                // ignore: parameter_assignments
//               startDate = Jiffy(startDate).add(days: countValue).dateTime;
//                endDate = Jiffy(endDate).add(days: countValue).dateTime;
//           for (
//                0 <= startDate.compareTo(startDate);

//          ) {
//             daysList.add(startDate.add(Duration(days: i)));
//           }
//           print(daysList);

//           print(daysList.last);
//           return daysList;
//         }
//         return calculateDaysInterval(start, now, countValue).last;
//       case 1:
//         List<DateTime> calculateDaysInterval(
//             DateTime startDate, DateTime endDate, int countValue) {
//           for (i = 0;
//               i <= endDate.difference(startDate).inDays;
//               i + countValue) {
//             weeksList.add(Jiffy(startDate).add(weeks: i).dateTime);
//           }
//           print(weeksList);

//           print(weeksList.last);
//           return weeksList;
//         }
//         return calculateDaysInterval(start, now, countValue).last;
//       case 2:
//         List<DateTime> calculateDaysInterval(
//             DateTime startDate, DateTime endDate, int countValue) {
//           for (i = 0;
//               i <= endDate.difference(startDate).inDays;
//               i + countValue) {
//             monthList.add(Jiffy(startDate).add(months: i).dateTime);
//           }
//           print(monthList);

//           print(monthList.last);
//           return monthList;
//         }
//         return calculateDaysInterval(start, now, countValue).last;
//       case 3:
//         List<DateTime> calculateDaysInterval(
//             DateTime startDate, DateTime endDate, int countValue) {
//           for (i = 0;
//               i <= endDate.difference(startDate).inDays;
//               i + countValue) {
//             yearsList.add(Jiffy(startDate).add(years: i).dateTime);
//           }
//           print(yearsList);

//           print(yearsList.last);
//           return yearsList;
//         }
//         return calculateDaysInterval(start, now, countValue).last;
//     }
//     // notifyListeners();
//   }

  // String getContractDay({
  //   required DateTime startTime,
  // }) {
  //   final now = DateTime.now();
  //   _jp;
  //   // final difference = now.difference(startTime).inDays;
  //   // Jiffy.locale('ja');
  //   return Jiffy(Jiffy(startTime)).fromNow();
  // }

  // DateTime? nextUpdate({
  //   required int reloadTime,
  //   required DateTime startTime,
  //   required int countValue,
  // }) {
  //   final date = DateTime.now();
  //   final now = DateTime(date.year, date.month, date.day);
  //   final start = DateTime(startTime.year, startTime.month, startTime.day);
  //   // 現時刻とスタート時間の日数差を計算
  //   final difference = now.difference(startTime).inDays;
  //   final dayDiff = Jiffy(start).add(days: difference).dateTime;
  //   final vsDay = Jiffy(start).add(days: countValue).dateTime;
  //   final vsWeek = Jiffy(start).add(weeks: countValue).dateTime;
  //   final vsMonth = Jiffy(start).add(months: countValue).dateTime;
  //   final vsYear = Jiffy(start).add(years: countValue).dateTime;

  //   switch (reloadTime) {
  //     case 0:
  //       if (dayDiff.isAfter(vsDay)) {
  //         return Jiffy(start).add(days: difference + countValue).dateTime;
  //       } else {
  //         return Jiffy(start).add(days: countValue).dateTime;
  //       }
  //     case 1:
  //       if (dayDiff.isAfter(vsWeek)) {
  //         return Jiffy(start)
  //             .add(weeks: countValue, days: difference - now.day + 1)
  //             .dateTime;
  //       } else {
  //         return Jiffy(start).add(weeks: countValue).dateTime;
  //       }
  //     case 2:
  //       if (dayDiff.isAfter(vsMonth)) {
  //         return Jiffy(start)
  //             .add(months: countValue, days: difference - now.day + 1)
  //             .dateTime;
  //       } else {
  //         return Jiffy(start)
  //             .add(
  //               months: countValue,
  //             )
  //             .dateTime;
  //       }
  //     case 3:
  //       if (dayDiff.isAfter(vsYear)) {
  //         return Jiffy(start)
  //             .add(years: countValue, days: difference - now.day + 1)
  //             .dateTime;
  //       } else {
  //         return Jiffy(start).add(years: countValue).dateTime;
  //       }
  //   }
  //   // notifyListeners();
  // }
}
