import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/expense_by_local_model.dart';
import 'package:dentro_do_bolso/app/models/expense_model.dart';
import 'package:dentro_do_bolso/app/models/local_model.dart';
import 'package:dentro_do_bolso/app/models/reasons_model.dart';

abstract class EntryRepository {
  Future<void> saveBank(String nomeBanco);
  Future<List<BankModel>> loadBanks();
  Future<void> saveAccont(AccountModel accountModel);
  Future<void> saveLocal(String local);
  Future<void> saveReason(String reason);
  Future<void> saveExpense(ExpenseModel expenseModel, double balanceAtt);
  Future<List<AccountModel>> loadAccounts();
  Future<List<ExpenseModel>> loadExpense();
  Future<AccountModel> loadAccount(int idconta);
  Future<List<LocalModel>> loadLocal();
  Future<List<ReasonsModel>> loadReasons();
  Future<List<ExpenseModel>> getExpenseByPeriod(DateTime start, DateTime end);
  Future<List<ExpenseByLocalModel>> getExpenseByLocal(
      DateTime start, DateTime end);
}
