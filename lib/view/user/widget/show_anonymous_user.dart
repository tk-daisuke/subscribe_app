import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:flutter/material.dart';

class ShowAnonymousUser extends StatelessWidget {
  const ShowAnonymousUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
  Icons.account_circle_rounded,
),
      title: Row(
        children: const <Widget>[
          Expanded(
            child: const AutoSizeText(
              'ゲストアカウント',
              style: const TextStyle(
                color: kTextColor,
                fontFamily: 'Robot',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              maxFontSize: 25,
              maxLines: 1,
            ),
          ),
        ],
      ),
      subtitle: Container(),
    );
  }
}



          // IconButton(
          //   icon: const FaIcon(
          //     FontAwesomeIcons.questionCircle,
          //     color: kTextColor,
          //   ),
          //   onPressed: () {
          //     // showDialog(
          //     //     context: context,
          //     //     builder: (context) {
          //     //       return AlertDialog(
          //     //         contentPadding: const EdgeInsets.symmetric(
          //     //             vertical: 10, horizontal: 20),
          //     //         backgroundColor: kPrimaryColor,
          //     //         title: SingleChildScrollView(
          //     //           scrollDirection: Axis.horizontal,
          //     //           child: Row(
          //     //             mainAxisAlignment: MainAxisAlignment.center,
          //     //             children: const <Widget>[
          //     //               Text(
          //     //                 '登録について',
          //     //                 style: TextStyle(
          //     //                     color: kTextColor,
          //     //                     fontWeight: FontWeight.bold),
          //     //               ),
          //     //               const Padding(
          //     //                   padding: const EdgeInsets.only(left: 20),
          //     //                   child: const FaIcon(FontAwesomeIcons.user)),
          //     //             ],
          //     //           ),
          //     //         ),
          //     //         content: SingleChildScrollView(
          //     //           child: ListBody(
          //     //             children: const <Widget>[
          //     //               Text('メールアドレスもしくはSNS連携をすることで'),
          //     //               Text('アプリを消してもデータを復旧出来ます。'),
          //     //             ],
          //     //           ),
          //     //         ),
          //     //         actions: <Widget>[
          //     //           TextButton(
          //     //             onPressed: () {
          //     //               Navigator.pop(context);
          //     //             },
          //     //             child: const Text(
          //     //               'OK',
          //     //               style: TextStyle(
          //     //                 color: kTextColor,
          //     //               ),
          //     //             ),
          //     //           ),
          //     //         ],
          //     //       );
          //     //     });
          //   },
          // )