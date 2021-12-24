import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/expense_by_local_model.dart';
import 'package:dentro_do_bolso/app/models/expense_model.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service.dart';
import 'package:mobx/mobx.dart';
import 'package:dentro_do_bolso/app/models/account_info_model.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final EntryService _entryService;

  _HomeControllerBase({
    required EntryService entryService,
  }) : _entryService = entryService;

  @observable
  AccountInfoModel? accountInfoModel;

  @observable
  List<AccountModel>? model;

  @observable
  List<ExpenseModel>? expenseObs;

  @observable
  List<ExpenseByLocalModel>? expenseLocalObs;

  @observable
  double entry = 0.1;

  @observable
  double exit = 0.1;

  @action
  Future<void> loadBanks() async {
    try {
      // Loader.show();
      model = await _entryService.loadAccountsList().asObservable();

      var result = await _entryService.loadBanks();
    } on Exception catch (e) {
      // TODO
    } finally {
      // Loader.hide();
    }
    // print(result);
    // await _entrySservice.save('itau');
  }

  @action
  Future<void> loadAccounts() async {
    try {
      // Loader.show();
      accountInfoModel = await _entryService.loadAccounts().asObservable();
    } on Exception catch (e) {
      // TODO
    } finally {
      // Loader.hide();
    }
    // print(accountInfoModel);
  }

  @action
  Future<void> loadExpense() async {
    try {
      // Loader.show();
      var result2 = await _entryService.loadExpense();
    } on Exception catch (e) {
      // TODO
    } finally {
      // Loader.hide();
    }
    // print(result2);
  }

  Future<void> findPeriod() async {
    expenseObs = await _entryService.getMonth().asObservable();
    if (expenseObs != null) {
      expenseObs!.forEach((element) {
        if (element.tpagamento == 1) {
          entry += element.valor;
        } else {
          exit += element.valor;
        }
      });
    }
  }

  Future<void> getExpenseByLocal() async {
    expenseLocalObs = await _entryService.getExpenseByLocal();
    print(expenseLocalObs);
  }
}
