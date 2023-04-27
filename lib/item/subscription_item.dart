import 'dart:core';

class SubscriptionItem {
  SubscriptionItem(
      {required this.docID,
      required this.name,
      required this.price,
      required this.startTime,
      required this.unit,
      required this.unitNumber,
      required this.next_reload,
      required this.lastUpdate,
      required this.memo,
      required this.isViewEnable,
      required this.isEnable});

  String docID;

  String name;
  double price;
  DateTime startTime;
  String unit;
  int unitNumber;
  int next_reload;
  DateTime lastUpdate;
  String memo;
  bool isEnable;
  bool isViewEnable;
}



//  Vod({
//     required this.name,
//     this.freeTrial = false,
//     this.freeTrialDuration = 0,
//     required this.webUrl,
//     required this.imageUrl,
//     required this.minimumPrice,
//     this.maxPrice = 0,
//     required this.lastUpdate,
//   });

//   final String name;
//   final bool freeTrial;
//   final int freeTrialDuration;
//   final String webUrl;
//   final String imageUrl;
//   final int minimumPrice;
//   final int maxPrice;
//   final Timestamp lastUpdate;
// }