// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_entry_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ExpenseEntryController on _ExpenseEntryControllerBase, Store {
  Computed<DateTime?>? _$selectedDateComputed;

  @override
  DateTime? get selectedDate =>
      (_$selectedDateComputed ??= Computed<DateTime?>(() => super.selectedDate,
              name: '_ExpenseEntryControllerBase.selectedDate'))
          .value;

  final _$_selectedDateAtom =
      Atom(name: '_ExpenseEntryControllerBase._selectedDate');

  @override
  DateTime? get _selectedDate {
    _$_selectedDateAtom.reportRead();
    return super._selectedDate;
  }

  @override
  set _selectedDate(DateTime? value) {
    _$_selectedDateAtom.reportWrite(value, super._selectedDate, () {
      super._selectedDate = value;
    });
  }

  final _$accountInfoModelAtom =
      Atom(name: '_ExpenseEntryControllerBase.accountInfoModel');

  @override
  AccountInfoModel? get accountInfoModel {
    _$accountInfoModelAtom.reportRead();
    return super.accountInfoModel;
  }

  @override
  set accountInfoModel(AccountInfoModel? value) {
    _$accountInfoModelAtom.reportWrite(value, super.accountInfoModel, () {
      super.accountInfoModel = value;
    });
  }

  final _$loadBanksAsyncAction =
      AsyncAction('_ExpenseEntryControllerBase.loadBanks');

  @override
  Future<void> loadBanks() {
    return _$loadBanksAsyncAction.run(() => super.loadBanks());
  }

  final _$loadAccountsAsyncAction =
      AsyncAction('_ExpenseEntryControllerBase.loadAccounts');

  @override
  Future<void> loadAccounts() {
    return _$loadAccountsAsyncAction.run(() => super.loadAccounts());
  }

  final _$saveExpenseAsyncAction =
      AsyncAction('_ExpenseEntryControllerBase.saveExpense');

  @override
  Future<void> saveExpense() {
    return _$saveExpenseAsyncAction.run(() => super.saveExpense());
  }

  final _$_ExpenseEntryControllerBaseActionController =
      ActionController(name: '_ExpenseEntryControllerBase');

  @override
  dynamic setSelectedDate(DateTime? selectedDate) {
    final _$actionInfo = _$_ExpenseEntryControllerBaseActionController
        .startAction(name: '_ExpenseEntryControllerBase.setSelectedDate');
    try {
      return super.setSelectedDate(selectedDate);
    } finally {
      _$_ExpenseEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
accountInfoModel: ${accountInfoModel},
selectedDate: ${selectedDate}
    ''';
  }
}
