import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/expense_model.dart';
import 'package:dentro_do_bolso/app/models/local_model.dart';
import 'package:dentro_do_bolso/app/models/reasons_model.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'expense_entry_controller.g.dart';

class ExpenseEntryController = _ExpenseEntryControllerBase
    with _$ExpenseEntryController;

abstract class _ExpenseEntryControllerBase with Store {
  final EntryService _entryService;

  _ExpenseEntryControllerBase({
    required EntryService entryService,
  }) : _entryService = entryService;

  @observable
  DateTime? _selectedDate;

  @computed
  DateTime? get selectedDate => _selectedDate;

  @action
  setSelectedDate(DateTime? selectedDate) => _selectedDate = selectedDate;

  @observable
  String? _selectedReasons;

  @computed
  String? get selectedReasons => _selectedReasons;

  @action
  setSelectedReasons(String? selectedReasons) =>
      _selectedReasons = selectedReasons;

  @observable
  String? _selectedAccount;

  @computed
  String? get selectedAccount => _selectedAccount;

  @action
  setSelectedAccount(String? selectedAccount) =>
      _selectedAccount = selectedAccount;

  @observable
  String? _selectedLocal;

  @computed
  String? get selectedLocal => _selectedLocal;

  @action
  setSelectedLocal(String? selectedLocal) => _selectedLocal = selectedLocal;

  @observable
  int? _idLocal;

  @computed
  int? get selectedIdLocal => _idLocal;

  @action
  setIdLocal(int? idLocal) => _idLocal = idLocal;

  @observable
  String? _selectedBank;

  @computed
  String? get selectedBank => _selectedBank;

  @action
  setSelectedBank(String? selectedBank) => _selectedBank = selectedBank;

  @observable
  int? _idBank;

  @computed
  int? get selectedIdBank => _idBank;

  @action
  setIdBank(int? idBank) => _idBank = idBank;

  @observable
  int? _idAcccount;

  @observable
  bool _operationType = true;

  @computed
  bool get operationType => _operationType;

  @action
  setOperation(bool operationType) => _operationType = operationType;

  @computed
  int? get selectedIdAcccount => _idAcccount;

  @action
  setIdAcccount(int? idAcccount) => _idAcccount = idAcccount;

  @observable
  int? _idReasons;

  @computed
  int? get selectedIdReasons => _idReasons;

  @action
  setIdReasonst(int? idReasons) => _idReasons = idReasons;

  @observable
  List<AccountModel> listAccount = [];

  @observable
  List<LocalModel> listLocal = [];

  @observable
  List<ReasonsModel> listReasons = [];

  @observable
  List<BankModel> listBank = [];

  @action
  Future<void> loadAccounts() async {
    try {
      listAccount = await _entryService.loadAccountsList().asObservable();
    } on Exception catch (e) {
      print(e);
      // setError('Erro ao cadastrar task');
    }
    // print(listAccount);
  }

  @action
  Future<void> loadReasons() async {
    try {
      listReasons = await _entryService.loadReasons().asObservable();
      // print(listReasons);
    } on Exception catch (e) {
      print(e);
      // setError('Erro ao cadastrar task');
    }
  }

  @action
  Future<void> loadLocal() async {
    try {
      listLocal = await _entryService.loadLocal().asObservable();
    } on Exception catch (e) {
      print(e);
      // setError('Erro ao cadastrar task');
    }
  }

  @action
  Future<void> loadBank() async {
    try {
      listBank = await _entryService.loadBanks().asObservable();
    } on Exception catch (e) {
      print(e);
      // setError('Erro ao cadastrar task');
    }
  }

  @action
  Future<void> saveExpense(String description, double value) async {
    try {
      if (_selectedDate != null) {
        if (_idLocal != null) {
          if (_idAcccount != null) {
            ExpenseModel expenseModel = ExpenseModel(
              idlancamento: 0,
              valor: value,
              datahora: _selectedDate!,
              descricao: description,
              idconta: _idAcccount!,
              localid: _idLocal!,
              tpagamento: _operationType == true ? 0 : 1,
              motivoid: _idReasons,
            );
            await _entryService.saveExpense(expenseModel);
          } else {
            // conta vazio
          }
        } else {
          // local vazio
        }
      } else {
        // data vazia
      }
    } on Exception catch (e) {
      print(e);
      // setError('Erro ao cadastrar task');
    }
  }

  @action
  Future<void> saveAccont(String account, double value) async {
    try {
      if (_idBank != null) {
        AccountModel accountModel = AccountModel(
            conta: int.parse(account), idbanco: _idBank!, saldo: value, id: 0);
        await _entryService.saveAccont(accountModel);
        loadAccounts();
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @action
  Future<void> saveBank(String bank) async {
    await _entryService.saveBank(bank);
    loadBank();
  }

  @action
  Future<void> saveLocal(String local) async {
    await _entryService.saveLocal(local);
    loadLocal();
  }

  @action
  Future<void> saveReasons(String reasons) async {
    await _entryService.saveReason(reasons);
    loadReasons();
  }
}
