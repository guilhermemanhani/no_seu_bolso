import 'package:dentro_do_bolso/app/models/expense_model.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'detail_account_controller.g.dart';

class DetailAccountController = _DetailAccountControllerBase
    with _$DetailAccountController;

abstract class _DetailAccountControllerBase with Store {
  final EntryService _entryService;
  _DetailAccountControllerBase({
    required EntryService entryService,
  }) : _entryService = entryService;

  @observable
  List<ExpenseModel>? expenseObs;

  @observable
  DateTime? _initialDate;

  @computed
  DateTime? get selectedInitialDate => _initialDate;

  @action
  setSelectedInitialDate(DateTime? initialDate) => _initialDate = initialDate;

  @observable
  DateTime? _finalDate;

  @computed
  DateTime? get selectedFinalDate => _finalDate;

  @action
  setSelectedFinalDate(DateTime? selectedFinalDate) =>
      _finalDate = selectedFinalDate;

  final int id = Modular.args.data;

  @action
  Future<void> findPeriod() async {
    expenseObs = await _entryService
        .getExpenseByPeriodByAccount(id, _initialDate, _finalDate)
        .asObservable();
    // if (expenseObs != null) {
    //   exit = 0.0;
    //   entry = 0.0;
    // }

    // if (expenseObs != null) {
    //   expenseObs!.forEach((element) {
    //     if (element.tpagamento == 1) {
    //       entry += element.valor;
    //     } else {
    //       exit += element.valor;
    //     }
    //   });
    // }
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
