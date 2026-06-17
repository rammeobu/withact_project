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
      id: json['id'] ?? 0,
      name: json['title'] ?? '',
    );
  }
}

class RecruitAnnouncementDataStructure {
  final List<String>? preferences;
  final List<String> position;
  final List<int> targets;
  final List<int> currents;
  final String activityName;
  final String partyNameIntroduction;
  final List<String> leaderProfile;
  final int? activityId;

  const RecruitAnnouncementDataStructure({
    required this.position,
    required this.activityName,
    required this.partyNameIntroduction,
    this.targets = const [],
    this.currents = const [],
    this.leaderProfile = const [],
    this.preferences,
    this.activityId,
  });

  factory RecruitAnnouncementDataStructure.fromJson(Map<String, dynamic> json) {
    final roles = (json['roles'] as List<dynamic>?) ?? [];
    final positionList =
        roles.map((r) => r['roleName']?.toString() ?? '').toList();
    final targetList =
        roles.map((r) => (r['targetCount'] as num?)?.toInt() ?? 1).toList();
    final currentList =
        roles.map((r) => (r['currentCount'] as num?)?.toInt() ?? 0).toList();
    final leaderName = json['leaderName']?.toString() ?? '';
    final leaderSkill = json['leaderSkill']?.toString() ?? '';
    final leader = leaderName.isEmpty && leaderSkill.isEmpty
        ? <String>[]
        : [leaderName, leaderSkill];
    return RecruitAnnouncementDataStructure(
      activityName: json['activityTitle'] ?? json['title'] ?? '',
      partyNameIntroduction: json['content'] ?? '',
      position: positionList,
      targets: targetList,
      currents: currentList,
      leaderProfile: leader,
      activityId: (json['activityId'] as num?)?.toInt(),
    );
  }
}

class AnnouncementEditDataStructure {
  final String activityName;
  final String partyNameIntroduction;
  final List<String>? preferences;
  final List<String> positions;

  const AnnouncementEditDataStructure({
    required this.activityName,
    required this.partyNameIntroduction,
    required this.positions,
    this.preferences,
  });
}

class ActivityRecruitDataStructure {
  final int? activityId;
  final String partyIntroduction;
  final List<String> preferences;
  final List<String> roleNames;
  final List<int> roleCounts;
  final int? leaderId;

  const ActivityRecruitDataStructure({
    this.activityId,
    this.partyIntroduction = '',
    this.preferences = const [],
    this.roleNames = const [],
    this.roleCounts = const [],
    this.leaderId,
  });
}

class RecruitListDataStructure {
  final List<RecruitItem> apply;

  const RecruitListDataStructure({required this.apply});
}
