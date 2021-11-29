import 'package:dentro_do_bolso/app/models/conta_model.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  // final TasksService _tasksService;
  final EntryService _entryService;

  _HomeControllerBase({
    required EntryService entryService,
  }) : _entryService = entryService;

  @action
  Future<void> loadTotalTasks() async {
    var result = await _entryService.loadBanks();
    print(result);
    // await _entryService.save('itau');
  }

  @action
  Future<void> saveAccont() async {
    ContaModel contaModel =
        ContaModel(conta: 123456, idbanco: 10, saldo: 1000, id: 0);
    await _entryService.saveAccont(contaModel);
  }
}
