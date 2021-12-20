import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:flutter/material.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';

class LineAccount extends StatelessWidget {
  final List<AccountModel> accountList;
  const LineAccount({
    Key? key,
    required this.accountList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: accountList.length,
        itemBuilder: (context, index) {
          final account = accountList[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(
                      0,
                      3,
                    ),
                  ),
                ],
              ),
              constraints: BoxConstraints(
                minWidth: 160.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    account.instituicao!,
                  ),
                  Text(
                    account.saldo.toString(),
                    style: TextStyle(
                      color: account.saldo.toString().contains('-')
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
