import 'package:decimal/decimal.dart';
import 'package:dentro_do_bolso/app/models/account_info_model.dart';
import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/expense_model.dart';
import 'package:dentro_do_bolso/app/repositories/entry/entry_repository.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service.dart';

class EntryServiceImpl implements EntryService {
  final EntryRepository _entryRepository;

  EntryServiceImpl({
    required EntryRepository entryRepository,
  }) : _entryRepository = entryRepository;

  @override
  Future<void> saveBank(String bancoNome) =>
      _entryRepository.saveBank(bancoNome);

  @override
  Future<List<BankModel>> loadBanks() => _entryRepository.loadBanks();

  @override
  Future<void> saveAccont(AccountModel accountModel) =>
      _entryRepository.saveAccont(accountModel);

  @override
  Future<void> saveLocal(String local) => _entryRepository.saveLocal(local);

  @override
  Future<void> saveReason(String reason) => _entryRepository.saveReason(reason);

  @override
  Future<void> saveExpense(ExpenseModel expenseModel) async {
    AccountModel account =
        await _entryRepository.loadAccount(expenseModel.idconta);
    // print(account);
    Decimal balanceAtt = Decimal.parse(account.saldo.toString()) +
        Decimal.parse(expenseModel.valor.toString());

    await _entryRepository.saveExpense(
      expenseModel,
      double.parse(balanceAtt.toString()),
    );
  }

  @override
  Future<AccountInfoModel> loadAccounts() async {
    List<AccountModel> listAccount = await _entryRepository.loadAccounts();
    Decimal balance = Decimal.parse('0.0');
    listAccount.forEach((element) {
      balance += Decimal.parse(element.saldo.toString());
    });
    AccountInfoModel accountInfoModel =
        AccountInfoModel(listAccount: [], balance: balance);
    accountInfoModel.listAccount.addAll(listAccount);
    return accountInfoModel;
  }

  @override
  Future<List<ExpenseModel>> loadExpense() => _entryRepository.loadExpense();

  @override
  Future<List<String>> loadAccountsList() async {
    String valueAdd;
    List<AccountModel> listAccount = await _entryRepository.loadAccounts();
    List<String> listString = [];
    listAccount.forEach(
      (account) {
        if (account.instituicao != null && account.conta != null) {
          valueAdd = account.instituicao! + ' ' + account.conta.toString();
          listString.add(valueAdd);
        } else {
          listString.add('Cadastre um banco');
        }
      },
    );
    return listString;
  }
}
