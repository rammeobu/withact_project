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
  final String name;
  final List<String> timePlace;
  final String applyStatus;

  const ApplyCardItem({
    required this.name,
    required this.timePlace,
    required this.applyStatus,
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
