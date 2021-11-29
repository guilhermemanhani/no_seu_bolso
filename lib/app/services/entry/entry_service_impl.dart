import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/conta_model.dart';
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
  Future<void> saveAccont(ContaModel contaModel) =>
      _entryRepository.saveAccont(contaModel);
}
