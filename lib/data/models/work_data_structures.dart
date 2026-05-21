class WorkInformationApplyDataStructure {
  final String workOverview;
  final String workDetail;
  final List<String> leaderProfile;
  final List<String> position;

  const WorkInformationApplyDataStructure({
    required this.workOverview,
    required this.workDetail,
    required this.leaderProfile,
    required this.position,
  });
}

class WorkInformationDataStructure {
  final String workName;
  final String workOverview;
  final String workDetail;
  final String? poster;
  final List<String> leaderProfile;
  final List<String> position;

  const WorkInformationDataStructure({
    required this.workName,
    required this.workOverview,
    required this.workDetail,
    required this.leaderProfile,
    required this.position,
    this.poster,
  });
}

class ParticipatingPartyDataStructure {
  final String workName;
  final String workOverview;
  final String workDetail;
  final String? poster;
  final List<String> leaderProfile;
  final List<String> position;

  const ParticipatingPartyDataStructure({
    required this.workName,
    required this.workOverview,
    required this.workDetail,
    required this.leaderProfile,
    required this.position,
    this.poster,
  });
}
