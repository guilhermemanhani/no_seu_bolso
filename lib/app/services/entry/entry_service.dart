import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/conta_model.dart';

abstract class EntryService {
  Future<void> saveBank(String bancoNome);
  Future<List<BankModel>> loadBanks();
  Future<void> saveAccont(ContaModel contaModel);
}
