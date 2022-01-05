import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/expense_by_local_model.dart';
import 'package:dentro_do_bolso/app/models/expense_model.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:dentro_do_bolso/app/models/account_info_model.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final EntryService _entryService;
  var formatter = NumberFormat.decimalPattern('pt-BR');

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

  @observable
  var dataMapExit = <String, double>{}.asObservable();

  @observable
  var dataMapEntry = <String, double>{}.asObservable();

  // @observable
  // bool _loading = false;

  // @computed
  // bool get getLoading => _loading;

  // @action
  // setLoading(bool loading) => _loading = loading;

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

  @action
  Future<void> loadHome() async {
    loadAccounts();
    findPeriod();
    getExpenseByLocal();
  }

  @action
  Future<void> findPeriod() async {
    expenseObs = await _entryService.getMonth().asObservable();
    if (expenseObs != null) {
      exit = 0.0;
      entry = 0.0;
    }

    if (expenseObs != null) {
      expenseObs!.forEach(
        (element) {
          if (element.tpagamento == 1) {
            entry += element.valor;
          } else {
            exit += element.valor;
          }
        },
      );
    }
  }

  @action
  Future<void> getExpenseByLocal() async {
    expenseLocalObs = await _entryService.getExpenseByLocal().asObservable();
    dataMapExit = <String, double>{}.asObservable();
    dataMapEntry = <String, double>{}.asObservable();
    if (expenseLocalObs != null) {
      for (var local in expenseLocalObs!) {
        if (local.tpagamento == 0) {
          dataMapExit[local.local] = local.soma;
        } else if (local.tpagamento == 1) {
          dataMapEntry[local.local] = local.soma;
        }
      }
    }
  }

  @action
  String mathValueBudget() {
    if (exit == 0.0 || entry == 0.0) {
      return "0";
    } else {
      return formatter.format(DecimalIntl(
          Decimal.parse(((exit / entry) * 100).toStringAsFixed(2))));
    }
  }

  @action
  String dealMoneyValue(String value) {
    return value.contains(",")
        ? value[value.length - 2] == ','
            ? "R\$ ${value}0"
            : "R\$ $value"
        : "R\$ $value,00";
  }
}
