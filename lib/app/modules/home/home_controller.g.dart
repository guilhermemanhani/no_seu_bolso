// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$accountInfoModelAtom =
      Atom(name: '_HomeControllerBase.accountInfoModel');

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

  final _$modelAtom = Atom(name: '_HomeControllerBase.model');

  @override
  List<AccountModel>? get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(List<AccountModel>? value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  final _$expenseObsAtom = Atom(name: '_HomeControllerBase.expenseObs');

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

  final _$expenseLocalObsAtom =
      Atom(name: '_HomeControllerBase.expenseLocalObs');

  @override
  List<ExpenseByLocalModel>? get expenseLocalObs {
    _$expenseLocalObsAtom.reportRead();
    return super.expenseLocalObs;
  }

  @override
  set expenseLocalObs(List<ExpenseByLocalModel>? value) {
    _$expenseLocalObsAtom.reportWrite(value, super.expenseLocalObs, () {
      super.expenseLocalObs = value;
    });
  }

  final _$entryAtom = Atom(name: '_HomeControllerBase.entry');

  @override
  double get entry {
    _$entryAtom.reportRead();
    return super.entry;
  }

  @override
  set entry(double value) {
    _$entryAtom.reportWrite(value, super.entry, () {
      super.entry = value;
    });
  }

  final _$exitAtom = Atom(name: '_HomeControllerBase.exit');

  @override
  double get exit {
    _$exitAtom.reportRead();
    return super.exit;
  }

  @override
  set exit(double value) {
    _$exitAtom.reportWrite(value, super.exit, () {
      super.exit = value;
    });
  }

  final _$dataMapAtom = Atom(name: '_HomeControllerBase.dataMap');

  @override
  Map<String, double> get dataMap {
    _$dataMapAtom.reportRead();
    return super.dataMap;
  }

  @override
  set dataMap(Map<String, double> value) {
    _$dataMapAtom.reportWrite(value, super.dataMap, () {
      super.dataMap = value;
    });
  }

  final _$loadBanksAsyncAction = AsyncAction('_HomeControllerBase.loadBanks');

  @override
  Future<void> loadBanks() {
    return _$loadBanksAsyncAction.run(() => super.loadBanks());
  }

  final _$loadAccountsAsyncAction =
      AsyncAction('_HomeControllerBase.loadAccounts');

  @override
  Future<void> loadAccounts() {
    return _$loadAccountsAsyncAction.run(() => super.loadAccounts());
  }

  final _$loadExpenseAsyncAction =
      AsyncAction('_HomeControllerBase.loadExpense');

  @override
  Future<void> loadExpense() {
    return _$loadExpenseAsyncAction.run(() => super.loadExpense());
  }

  @override
  String toString() {
    return '''
accountInfoModel: ${accountInfoModel},
model: ${model},
expenseObs: ${expenseObs},
expenseLocalObs: ${expenseLocalObs},
entry: ${entry},
exit: ${exit},
dataMap: ${dataMap}
    ''';
  }
}
