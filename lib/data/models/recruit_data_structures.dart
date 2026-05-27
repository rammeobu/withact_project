class RecruitItem {
  final int id;
  final String name;
  final List<String>? timePlace;
  final String? applyStatus;
  final String? poster;

  const RecruitItem({
    required this.id,
    required this.name,
    this.timePlace,
    this.applyStatus,
    this.poster,
  });

  factory RecruitItem.fromJson(Map<String, dynamic> json) {
    return RecruitItem(
      id: json['id'],
      name: json['title'] ?? '',
    );
  }
}

class RecruitAnnouncementDataStructure {
  final List<String>? preferences;
  final List<String> position;
  final String workName;
  final String partyNameIntroduction;

  const RecruitAnnouncementDataStructure({
    required this.position,
    required this.workName,
    required this.partyNameIntroduction,
    this.preferences,
  });

  factory RecruitAnnouncementDataStructure.fromJson(Map<String, dynamic> json) {
    final roles = (json['roles'] as List<dynamic>?) ?? [];
    final positionList =
        roles.map((r) => r['roleName']?.toString() ?? '').toList();
    return RecruitAnnouncementDataStructure(
      workName: json['title'] ?? '',
      partyNameIntroduction: json['content'] ?? '',
      position: positionList,
    );
  }
}

class AnnouncementEditDataStructure {
  final String workName;
  final String partyNameIntroduction;
  final List<String>? preferences;
  final List<String> positions;

  const AnnouncementEditDataStructure({
    required this.workName,
    required this.partyNameIntroduction,
    required this.positions,
    this.preferences,
  });
}

class WorkRecruitDataStructure {
  final List<String>? profile;

  const WorkRecruitDataStructure({this.profile});
}

class RecruitListDataStructure {
  final List<RecruitItem> apply;

  const RecruitListDataStructure({required this.apply});
}
