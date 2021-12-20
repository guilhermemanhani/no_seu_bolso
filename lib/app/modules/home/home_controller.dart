import 'package:dentro_do_bolso/app/models/account_model.dart';
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
  Future<void> saveAccont() async {
    AccountModel accountModel = AccountModel(
      conta: 16521,
      idbanco: 1,
      saldo: 2500.45,
      id: 0,
    );
    await _entryService.saveAccont(accountModel);
  }
}
