import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:flutter/material.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:intl/intl.dart';

class LineAccount extends StatefulWidget {
  final List<AccountModel> accountList;
  const LineAccount({
    Key? key,
    required this.accountList,
  }) : super(key: key);

  @override
  State<LineAccount> createState() => _LineAccountState();
}

class _LineAccountState extends State<LineAccount> {
  var formatter = NumberFormat.decimalPattern('pt-BR');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.accountList.length,
        itemBuilder: (context, index) {
          final account = widget.accountList[index];
          return InkWell(
            onDoubleTap: () => print('nova tela'),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
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
                      formatter.format(
                        DecimalIntl(
                          Decimal.parse(account.saldo.toString()),
                        ),
                      ),
                      // account.saldo.toString(),
                      style: TextStyle(
                        color: account.saldo.toString().contains('-')
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
