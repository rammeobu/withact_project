class ApplyItem {
  final int id;
  final int partyId;
  final int roleId;
  final int? activityId;
  final String name;
  final String applyStatus;
  final String introduction;
  final String spec;
  final List<String>? timePlace;
  final String? poster;

  const ApplyItem({
    required this.id,
    this.partyId = 0,
    this.roleId = 0,
    this.activityId,
    required this.name,
    required this.applyStatus,
    this.introduction = '',
    this.spec = '',
    this.timePlace,
    this.poster,
  });

  ApplyItem copyWith({String? poster}) => ApplyItem(
        id: id,
        partyId: partyId,
        roleId: roleId,
        activityId: activityId,
        name: name,
        applyStatus: applyStatus,
        introduction: introduction,
        spec: spec,
        timePlace: timePlace,
        poster: poster ?? this.poster,
      );

  factory ApplyItem.fromJson(Map<String, dynamic> json) {
    return ApplyItem(
      id: json['id'] ?? 0,
      partyId: (json['partyId'] as num?)?.toInt() ?? 0,
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      activityId: (json['activityId'] as num?)?.toInt(),
      name: json['partyName'] ?? '',
      applyStatus: switch (json['status']?.toString()) {
        'PENDING' => '대기 중',
        'APPROVED' => '합격',
        'REJECTED' => '불합격',
        final status => status ?? '',
      },
      introduction: json['introduction'] ?? json['motivation'] ?? '',
      spec: json['skill']?.toString() ?? '',
      poster: json['imageUrl'] ?? json['activityImageUrl'] ?? json['poster'],
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
