class ApplyItem {
  final String name;
  final List<String> timePlace;
  final String applyStatus;
  final String poster;

  const ApplyItem({
    required this.name,
    required this.timePlace,
    required this.applyStatus,
    required this.poster,
  });
}

class ApplyDataStructure {
  final String workName;
  final List<String>? profile;
  final String? poster;

  const ApplyDataStructure({required this.workName, this.profile, this.poster});
}

class ApplyListDataStructure {
  final List<ApplyItem> apply;

  const ApplyListDataStructure({required this.apply});
}

class ApplyingWorkDataStructure {
  final String workName;
  final List<String> profile;
  final String? poster;

  const ApplyingWorkDataStructure({
    required this.workName,
    required this.profile,
    this.poster,
  });
}
