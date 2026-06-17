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
      id: json['id'] ?? 0,
      name: json['partyName'] ?? '',
      applyStatus: switch (json['status']?.toString()) {
        'PENDING' => '대기 중',
        'APPROVED' => '합격',
        'REJECTED' => '불합격',
        final status => status ?? '',
      },
    );
  }
}

class ApplyDataStructure {
  final String activityName;
  final List<String>? profile;
  final String? poster;

  const ApplyDataStructure({required this.activityName, this.profile, this.poster});
}

class ApplyListDataStructure {
  final List<ApplyItem> apply;

  const ApplyListDataStructure({required this.apply});
}

class ApplyingActivityDataStructure {
  final String activityName;
  final List<String> profile;
  final String? poster;

  const ApplyingActivityDataStructure({
    required this.activityName,
    required this.profile,
    this.poster,
  });
}
