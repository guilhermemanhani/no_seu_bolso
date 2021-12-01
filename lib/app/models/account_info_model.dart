import 'package:decimal/decimal.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';

class AccountInfoModel {
  final Decimal balance;
  final List<AccountModel> listAccount;
  AccountInfoModel({
    required this.balance,
    required this.listAccount,
  });
}
