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
  Computed<String?>? _$selectedReasonsComputed;

  @override
  String? get selectedReasons => (_$selectedReasonsComputed ??=
          Computed<String?>(() => super.selectedReasons,
              name: '_ExpenseEntryControllerBase.selectedReasons'))
      .value;
  Computed<String?>? _$selectedAccountComputed;

  @override
  String? get selectedAccount => (_$selectedAccountComputed ??=
          Computed<String?>(() => super.selectedAccount,
              name: '_ExpenseEntryControllerBase.selectedAccount'))
      .value;
  Computed<String?>? _$selectedLocalComputed;

  @override
  String? get selectedLocal =>
      (_$selectedLocalComputed ??= Computed<String?>(() => super.selectedLocal,
              name: '_ExpenseEntryControllerBase.selectedLocal'))
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

  final _$_selectedReasonsAtom =
      Atom(name: '_ExpenseEntryControllerBase._selectedReasons');

  @override
  String? get _selectedReasons {
    _$_selectedReasonsAtom.reportRead();
    return super._selectedReasons;
  }

  @override
  set _selectedReasons(String? value) {
    _$_selectedReasonsAtom.reportWrite(value, super._selectedReasons, () {
      super._selectedReasons = value;
    });
  }

  final _$_selectedAccountAtom =
      Atom(name: '_ExpenseEntryControllerBase._selectedAccount');

  @override
  String? get _selectedAccount {
    _$_selectedAccountAtom.reportRead();
    return super._selectedAccount;
  }

  @override
  set _selectedAccount(String? value) {
    _$_selectedAccountAtom.reportWrite(value, super._selectedAccount, () {
      super._selectedAccount = value;
    });
  }

  final _$_selectedLocalAtom =
      Atom(name: '_ExpenseEntryControllerBase._selectedLocal');

  @override
  String? get _selectedLocal {
    _$_selectedLocalAtom.reportRead();
    return super._selectedLocal;
  }

  @override
  set _selectedLocal(String? value) {
    _$_selectedLocalAtom.reportWrite(value, super._selectedLocal, () {
      super._selectedLocal = value;
    });
  }

  final _$listAccountAtom =
      Atom(name: '_ExpenseEntryControllerBase.listAccount');

  @override
  List<AccountModel> get listAccount {
    _$listAccountAtom.reportRead();
    return super.listAccount;
  }

  @override
  set listAccount(List<AccountModel> value) {
    _$listAccountAtom.reportWrite(value, super.listAccount, () {
      super.listAccount = value;
    });
  }

  final _$listLocalAtom = Atom(name: '_ExpenseEntryControllerBase.listLocal');

  @override
  List<LocalModel> get listLocal {
    _$listLocalAtom.reportRead();
    return super.listLocal;
  }

  @override
  set listLocal(List<LocalModel> value) {
    _$listLocalAtom.reportWrite(value, super.listLocal, () {
      super.listLocal = value;
    });
  }

  final _$listReasonsAtom =
      Atom(name: '_ExpenseEntryControllerBase.listReasons');

  @override
  List<ReasonsModel> get listReasons {
    _$listReasonsAtom.reportRead();
    return super.listReasons;
  }

  @override
  set listReasons(List<ReasonsModel> value) {
    _$listReasonsAtom.reportWrite(value, super.listReasons, () {
      super.listReasons = value;
    });
  }

  final _$loadAccountsAsyncAction =
      AsyncAction('_ExpenseEntryControllerBase.loadAccounts');

  @override
  Future<void> loadAccounts() {
    return _$loadAccountsAsyncAction.run(() => super.loadAccounts());
  }

  final _$loadReasonsAsyncAction =
      AsyncAction('_ExpenseEntryControllerBase.loadReasons');

  @override
  Future<void> loadReasons() {
    return _$loadReasonsAsyncAction.run(() => super.loadReasons());
  }

  final _$loadLocalAsyncAction =
      AsyncAction('_ExpenseEntryControllerBase.loadLocal');

  @override
  Future<void> loadLocal() {
    return _$loadLocalAsyncAction.run(() => super.loadLocal());
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
  dynamic setSelectedReasons(String? selectedReasons) {
    final _$actionInfo = _$_ExpenseEntryControllerBaseActionController
        .startAction(name: '_ExpenseEntryControllerBase.setSelectedReasons');
    try {
      return super.setSelectedReasons(selectedReasons);
    } finally {
      _$_ExpenseEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedAccount(String? selectedAccount) {
    final _$actionInfo = _$_ExpenseEntryControllerBaseActionController
        .startAction(name: '_ExpenseEntryControllerBase.setSelectedAccount');
    try {
      return super.setSelectedAccount(selectedAccount);
    } finally {
      _$_ExpenseEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedLocal(String? selectedLocal) {
    final _$actionInfo = _$_ExpenseEntryControllerBaseActionController
        .startAction(name: '_ExpenseEntryControllerBase.setSelectedLocal');
    try {
      return super.setSelectedLocal(selectedLocal);
    } finally {
      _$_ExpenseEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listAccount: ${listAccount},
listLocal: ${listLocal},
listReasons: ${listReasons},
selectedDate: ${selectedDate},
selectedReasons: ${selectedReasons},
selectedAccount: ${selectedAccount},
selectedLocal: ${selectedLocal}
    ''';
  }
}
