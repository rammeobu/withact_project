class ActivityCardItem {
  final int id;
  final String name;
  final List<String> timePlace;
  final List<String> position;
  final String? poster;

  const ActivityCardItem({
    this.id = 0,
    required this.name,
    required this.timePlace,
    required this.position,
    this.poster,
  });
}

class ApplyCardItem {
  final int applicationId;
  final int partyId;
  final String name;
  final List<String> timePlace;
  final String applyStatus;
  final String introduction;
  final String spec;

  const ApplyCardItem({
    this.applicationId = 0,
    this.partyId = 0,
    required this.name,
    required this.timePlace,
    required this.applyStatus,
    this.introduction = '',
    this.spec = '',
  });
}

class HomeScreenDataStructure {
  final String? logo;
  final List<String> profileContent;
  final List<ActivityCardItem>? recruitCard;
  final List<ActivityCardItem>? participateCard;
  final List<ApplyCardItem>? applyCard;

  const HomeScreenDataStructure({
    required this.profileContent,
    this.logo,
    this.recruitCard,
    this.participateCard,
    this.applyCard,
  });
}
