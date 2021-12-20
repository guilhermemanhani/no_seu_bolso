import 'package:dentro_do_bolso/app/core/ui/extensions/theme_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/text_icon_button.dart';
import 'package:flutter/material.dart';

class DialogAccount extends StatelessWidget {
  final String message;
  final String title;
  final Function onTapBanco;
  final Function onTapConta;

  const DialogAccount({
    Key? key,
    required this.message,
    required this.title,
    required this.onTapBanco,
    required this.onTapConta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              message,
              style: TextStyle(
                color: context.grey,
              ),
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.only(bottom: 12),
      actions: [
        TextIconButton(
          icon: Icons.account_balance_outlined,
          title: 'Banco',
          color: context.darkBlue,
          width: 100,
          onTap: () {
            Navigator.pop(context);
            onTapBanco();
          },
        ),
        TextIconButton(
          icon: Icons.payment,
          title: 'Conta',
          color: context.darkBlue,
          width: 100,
          onTap: () {
            Navigator.pop(context);
            onTapConta();
          },
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
      title: Text(
        title,
        style: TextStyle(
          color: context.darkBlue,
        ),
      ),
    );
  }
}
