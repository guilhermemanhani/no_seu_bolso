import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/conta_model.dart';

abstract class EntryRepository {
  Future<void> saveBank(String nomeBanco);
  Future<List<BankModel>> loadBanks();
  Future<void> saveAccont(ContaModel contaModel);
}
