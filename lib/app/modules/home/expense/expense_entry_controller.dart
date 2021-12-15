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
  int? _idLocal;

  @computed
  int? get selectedIdLocal => _idLocal;

  @action
  setIdLocal(int? idLocal) => _idLocal = idLocal;

  @observable
  int? _idAcccount;

  @observable
  bool _operationType = false;

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

  @action
  Future<void> loadAccounts() async {
    try {
      listAccount = await _entryService.loadAccountsList().asObservable();
    } on Exception catch (e) {
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
      // setError('Erro ao cadastrar task');
    }
  }

  @action
  Future<void> loadLocal() async {
    try {
      listLocal = await _entryService.loadLocal().asObservable();
    } on Exception catch (e) {
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
      // setError('Erro ao cadastrar task');
    }
  }
}
