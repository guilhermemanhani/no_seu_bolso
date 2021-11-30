import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/expense_model.dart';

abstract class EntryService {
  Future<void> saveBank(String bancoNome);
  Future<List<BankModel>> loadBanks();
  Future<void> saveAccont(AccountModel accountModel);
  Future<void> saveLocal(String local);
  Future<void> saveReason(String reason);
  Future<void> saveExpense(ExpenseModel expenseModel);
  Future<List<AccountModel>> loadAccount();
  Future<List<ExpenseModel>> loadExpense();
}
