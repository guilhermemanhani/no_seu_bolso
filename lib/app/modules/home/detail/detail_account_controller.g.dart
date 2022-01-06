// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_account_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailAccountController on _DetailAccountControllerBase, Store {
  Computed<DateTime?>? _$selectedInitialDateComputed;

  @override
  DateTime? get selectedInitialDate => (_$selectedInitialDateComputed ??=
          Computed<DateTime?>(() => super.selectedInitialDate,
              name: '_DetailAccountControllerBase.selectedInitialDate'))
      .value;
  Computed<DateTime?>? _$selectedFinalDateComputed;

  @override
  DateTime? get selectedFinalDate => (_$selectedFinalDateComputed ??=
          Computed<DateTime?>(() => super.selectedFinalDate,
              name: '_DetailAccountControllerBase.selectedFinalDate'))
      .value;

  final _$expenseObsAtom =
      Atom(name: '_DetailAccountControllerBase.expenseObs');

  @override
  List<ExpenseModel>? get expenseObs {
    _$expenseObsAtom.reportRead();
    return super.expenseObs;
  }

  @override
  set expenseObs(List<ExpenseModel>? value) {
    _$expenseObsAtom.reportWrite(value, super.expenseObs, () {
      super.expenseObs = value;
    });
  }

  final _$_initialDateAtom =
      Atom(name: '_DetailAccountControllerBase._initialDate');

  @override
  DateTime? get _initialDate {
    _$_initialDateAtom.reportRead();
    return super._initialDate;
  }

  @override
  set _initialDate(DateTime? value) {
    _$_initialDateAtom.reportWrite(value, super._initialDate, () {
      super._initialDate = value;
    });
  }

  final _$_finalDateAtom =
      Atom(name: '_DetailAccountControllerBase._finalDate');

  @override
  DateTime? get _finalDate {
    _$_finalDateAtom.reportRead();
    return super._finalDate;
  }

  @override
  set _finalDate(DateTime? value) {
    _$_finalDateAtom.reportWrite(value, super._finalDate, () {
      super._finalDate = value;
    });
  }

  final _$findPeriodAsyncAction =
      AsyncAction('_DetailAccountControllerBase.findPeriod');

  @override
  Future<void> findPeriod() {
    return _$findPeriodAsyncAction.run(() => super.findPeriod());
  }

  final _$deleteAsyncAction =
      AsyncAction('_DetailAccountControllerBase.delete');

  @override
  Future<void> delete(ExpenseModel expenseModel) {
    return _$deleteAsyncAction.run(() => super.delete(expenseModel));
  }

  final _$_DetailAccountControllerBaseActionController =
      ActionController(name: '_DetailAccountControllerBase');

  @override
  dynamic setSelectedInitialDate(DateTime? initialDate) {
    final _$actionInfo =
        _$_DetailAccountControllerBaseActionController.startAction(
            name: '_DetailAccountControllerBase.setSelectedInitialDate');
    try {
      return super.setSelectedInitialDate(initialDate);
    } finally {
      _$_DetailAccountControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedFinalDate(DateTime? selectedFinalDate) {
    final _$actionInfo = _$_DetailAccountControllerBaseActionController
        .startAction(name: '_DetailAccountControllerBase.setSelectedFinalDate');
    try {
      return super.setSelectedFinalDate(selectedFinalDate);
    } finally {
      _$_DetailAccountControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String dealMoneyValue(String value) {
    final _$actionInfo = _$_DetailAccountControllerBaseActionController
        .startAction(name: '_DetailAccountControllerBase.dealMoneyValue');
    try {
      return super.dealMoneyValue(value);
    } finally {
      _$_DetailAccountControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
expenseObs: ${expenseObs},
selectedInitialDate: ${selectedInitialDate},
selectedFinalDate: ${selectedFinalDate}
    ''';
  }
}
