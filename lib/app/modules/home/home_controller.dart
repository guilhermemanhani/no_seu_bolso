import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/expense_model.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final EntryService _entryService;

  _HomeControllerBase({
    required EntryService entryService,
  }) : _entryService = entryService;

  @observable
  ObservableList<AccountModel> account = <AccountModel>[].asObservable();

  @action
  Future<void> loadBanks() async {
    var result = await _entryService.loadBanks();
    print(result);
    // await _entrySservice.save('itau');
  }

  @action
  Future<void> loadAccount() async {
    account.addAll(await _entryService.loadAccount().asObservable());
    print(account);
  }

  @action
  Future<void> loadExpense() async {
    var result2 = await _entryService.loadExpense();
    // print(result2);
  }

  @action
  Future<void> saveAccont() async {
    AccountModel accountModel =
        AccountModel(conta: 123456, idbanco: 1, saldo: 1000, id: 0);
    await _entryService.saveAccont(accountModel);
  }

  @action
  Future<void> saveExpense() async {
    ExpenseModel expenseModel = ExpenseModel(
      idlancamento: 0,
      valor: 100,
      datahora: DateTime.now(),
      descricao: 'descricao',
      idconta: 1,
      localid: 1,
      motivoid: 1,
    );
    await _entryService.saveExpense(expenseModel);
  }
}
