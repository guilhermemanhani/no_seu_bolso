import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/expense_model.dart';
import 'package:dentro_do_bolso/app/repositories/entry/entry_repository.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service.dart';

class EntryServiceImpl implements EntryService {
  final EntryRepository _entryRepository;

  EntryServiceImpl({
    required EntryRepository entryRepository,
  }) : _entryRepository = entryRepository;

  @override
  Future<void> saveBank(String bancoNome) =>
      _entryRepository.saveBank(bancoNome);

  @override
  Future<List<BankModel>> loadBanks() => _entryRepository.loadBanks();

  @override
  Future<void> saveAccont(AccountModel accountModel) =>
      _entryRepository.saveAccont(accountModel);

  @override
  Future<void> saveLocal(String local) => _entryRepository.saveLocal(local);

  @override
  Future<void> saveReason(String reason) => _entryRepository.saveReason(reason);

  @override
  Future<void> saveExpense(ExpenseModel expenseModel) =>
      _entryRepository.saveExpense(expenseModel);

  @override
  Future<List<AccountModel>> loadAccount() => _entryRepository.loadAccount();

  Future<List<ExpenseModel>> loadExpense() => _entryRepository.loadExpense();
}
