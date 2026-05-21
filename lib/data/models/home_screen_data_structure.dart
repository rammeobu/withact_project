class WorkCardItem {
  final String name;
  final List<String> timePlace;
  final List<String> position;
  final String? poster;

  const WorkCardItem({
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
  final List<WorkCardItem>? recruitCard;
  final List<WorkCardItem>? participateCard;
  final List<ApplyCardItem>? applyCard;

  const HomeScreenDataStructure({
    required this.profileContent,
    this.logo,
    this.recruitCard,
    this.participateCard,
    this.applyCard,
  });
}
