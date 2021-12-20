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

  final _$saveAccontAsyncAction = AsyncAction('_HomeControllerBase.saveAccont');

  @override
  Future<void> saveAccont() {
    return _$saveAccontAsyncAction.run(() => super.saveAccont());
  }

  @override
  String toString() {
    return '''
accountInfoModel: ${accountInfoModel},
model: ${model}
    ''';
  }
}
