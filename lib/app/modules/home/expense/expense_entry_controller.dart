import 'package:dentro_do_bolso/app/models/expense_model.dart';
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
  List<String> listAccount = [];

  @action
  Future<void> loadBanks() async {
    var result = await _entryService.loadBanks();
    print(result);
    // await _entrySservice.save('itau');
  }

  @action
  Future<void> loadAccounts() async {
    listAccount = await _entryService.loadAccountsList().asObservable();
    print(listAccount);
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
