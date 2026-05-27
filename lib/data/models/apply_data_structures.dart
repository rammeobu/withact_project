class ApplyItem {
  final int id;
  final String name;
  final String applyStatus;
  final List<String>? timePlace;
  final String? poster;

  const ApplyItem({
    required this.id,
    required this.name,
    required this.applyStatus,
    this.timePlace,
    this.poster,
  });

  factory ApplyItem.fromJson(Map<String, dynamic> json) {
    return ApplyItem(
      id: json['id'],
      name: json['partyName'] ?? '',
      applyStatus: json['status']?.toString() ?? '',
    );
  }
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
