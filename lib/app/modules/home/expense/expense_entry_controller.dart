import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/expense_model.dart';
import 'package:dentro_do_bolso/app/models/local_model.dart';
import 'package:dentro_do_bolso/app/models/reasons_model.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service.dart';
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
  List<AccountModel> listAccount = [];

  @observable
  List<LocalModel> listLocal = [];

  @observable
  List<ReasonsModel> listReasons = [];

  @action
  Future<void> loadAccounts() async {
    listAccount = await _entryService.loadAccountsList().asObservable();
    // print(listAccount);
  }

  @action
  Future<void> loadReasons() async {
    listReasons = await _entryService.loadReasons().asObservable();
    // print(listReasons);
  }

  @action
  Future<void> loadLocal() async {
    listLocal = await _entryService.loadLocal().asObservable();
  }

  @action
  Future<void> saveExpense() async {
    ExpenseModel expenseModel = ExpenseModel(
      idlancamento: 0,
      valor: -100.43,
      datahora: DateTime.now(),
      descricao: 'descricao',
      idconta: 2,
      localid: 2,
      motivoid: 1,
    );
    await _entryService.saveExpense(expenseModel);
  }
}
