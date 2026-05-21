class RecruitItem {
  final String name;
  final List<String> timePlace;
  final String applyStatus;
  final String poster;

  const RecruitItem({
    required this.name,
    required this.timePlace,
    required this.applyStatus,
    required this.poster,
  });
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
