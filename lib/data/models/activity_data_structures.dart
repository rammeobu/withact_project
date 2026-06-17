class ActivityInformationApplyDataStructure {
  final String activityOverview;
  final String activityDetail;
  final List<String> leaderProfile;
  final List<String> position;

  const ActivityInformationApplyDataStructure({
    required this.activityOverview,
    required this.activityDetail,
    required this.leaderProfile,
    required this.position,
  });
}

class ActivityInformationDataStructure {
  final String activityName;
  final String activityOverview;
  final String activityDetail;
  final String? poster;
  final List<String> leaderProfile;
  final List<String> position;

  const ActivityInformationDataStructure({
    required this.activityName,
    required this.activityOverview,
    required this.activityDetail,
    required this.leaderProfile,
    required this.position,
    this.poster,
  });
}

class ParticipatingPartyDataStructure {
  final String activityName;
  final String activityOverview;
  final String activityDetail;
  final String? poster;
  final List<String> leaderProfile;
  final List<String> position;

  const ParticipatingPartyDataStructure({
    required this.activityName,
    required this.activityOverview,
    required this.activityDetail,
    required this.leaderProfile,
    required this.position,
    this.poster,
  });
}
