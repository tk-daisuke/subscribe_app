// import 'package:bom_app/service/calculation_system.dart';
// import 'package:bom_app/view/add/add_model.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class NextReload extends StatelessWidget {
//   const NextReload({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AddModel>(builder: (context, addModel, child) {
//       final selectNow = CalculationSystem().nextUpdate(
//           reloadTime: addModel.selectUnitNumber,
//           startTime: addModel.reloadTime,
//           countValue: int.parse(addModel.selectDay));
//       return Row(
//         children: [
//           const SizedBox(
//             width: 50,
//             height: 36,
//           ),
//           const Text('次回 ：'),
//           const Icon(Icons.skip_next),
//           Text(
//               // ignore: lines_longer_than_80_chars
//               '${DateFormat('yyyy年M月d日').
//format(selectNow ?? DateTime.now())}'),
//         ],
//       );
//     });
//   }
// }
