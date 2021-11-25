import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  // final TasksService _tasksService;

  @action
  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      // _tasksService.getToday(),
      // _tasksService.getTomorrow(),
      // _tasksService.getWeek(),
    ]);
    // final todayTasks = allTasks[0] as List<TaskModel>;
    // final tomorrowTasks = allTasks[1] as List<TaskModel>;
    // final weekTasks = allTasks[2] as WeekTaskModel;

    // todayTotalTasks = TotalTasksModel(
    //   totalTasks: todayTasks.length,
    //   totalTasksFinish: todayTasks.where((task) => task.finished).length,
    // );

    // tomorrowTotalTasks = TotalTasksModel(
    //   totalTasks: tomorrowTasks.length,
    //   totalTasksFinish: tomorrowTasks.where((task) => task.finished).length,
    // );

    // weekTotalTasks = TotalTasksModel(
    //   totalTasks: weekTasks.tasks.length,
    //   totalTasksFinish: weekTasks.tasks.where((task) => task.finished).length,
    // );
    // notifyListeners();
  }
}
