class Project {
  String nameProject;
  String owner;
  Duration scheduledTime = const Duration(days: 1000);
  Duration elapsedTime = const Duration();

  Project({
    required this.nameProject,
    required this.owner,
    this.scheduledTime = const Duration(),
  });

  addTime(int seconds) {
    Duration time = Duration(seconds: seconds);
    elapsedTime += time;
  }
}
