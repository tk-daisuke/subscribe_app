import 'package:bom_app/constants.dart';
import 'package:bom_app/service/auth_service.dart';
import 'package:bom_app/view/account_edit/account_edit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

class AccountDeleteDialog extends StatelessWidget {
  const AccountDeleteDialog({
    Key? key,
    required this.maincontext,
  }) : super(key: key);
  final BuildContext maincontext;
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: AlertDialog(
        backgroundColor: kPrimaryColor,
        insetPadding: const EdgeInsets.all(8),
        title: const Text(
          'アカウントを削除します',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              // Consumer<AuthService>(builder: (context, authService, child) {
              //   return Column(
              //     children: <Widget>[
              //       if (authService.googleUser)
              //         const Text(
              //           'セキュリティのため再度認証が必要です',
              //           style: TextStyle(fontSize: 14),
              //         ),
              //     ],
              //   );
              // }),
              const Text(
                'この操作はやり直せません',
                style: TextStyle(fontSize: 14),
              ),
              const Text(
                'よろしいですか？',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.close,
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                  context.read<AccountEditModel>().delete = false;
                },
                label: const Text(
                  'キャンセル',
                  textScaleFactor: kTextScaleFactor,
                  style: TextStyle(
                    color: kButtonText,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: kisValidFalse,
                ),
              ),
              Consumer<AuthService>(builder: (context, authService, child) {
                return ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.pop(context, true);
                    maincontext.read<AccountEditModel>().deleteAccount();
                  },
                  label: const Text(
                    '削除する',
                    textScaleFactor: kTextScaleFactor,
                    style: TextStyle(
                      color: kButtonText,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kisValidTrue,
                  ),
                  icon: const Icon(
                    Icons.delete,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
