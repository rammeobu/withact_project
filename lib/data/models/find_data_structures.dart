class PartyItem {
  final int id;
  final String partyName;
  final String workName;
  final int activityId;
  final int leaderId;

  const PartyItem({
    required this.id,
    required this.partyName,
    required this.workName,
    required this.activityId,
    required this.leaderId,
  });

  factory PartyItem.fromJson(Map<String, dynamic> json) {
    return PartyItem(
      id: json['id'],
      partyName: json['title'] ?? '',
      activityId: json['activityId'],
      leaderId: json['leaderId'],
      workName: '활동 ${json['activityId']}',
    );
  }
}

class WorkItem {
  final int id;
  final String workName;
  final String startDate;
  final String endDate;
  final String location;
  final String organization;
  final String category;

  const WorkItem({
    required this.id,
    required this.workName,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.organization,
    required this.category,
  });

  factory WorkItem.fromJson(Map<String, dynamic> json) {
    return WorkItem(
      id: json['id'],
      workName: json['title'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      location: json['location'] ?? '',
      organization: json['organization'] ?? '',
      category: json['category'] ?? '',
    );
  }
}

class FilterItem {
  final String title;
  final List<String> option;

  const FilterItem({required this.title, required this.option});
}

class FindPartyDataStructure {
  final List<PartyItem> partyList;

  const FindPartyDataStructure({required this.partyList});
}

class FindWorkDataStructure {
  final List<WorkItem> workList;

  const FindWorkDataStructure({required this.workList});
}

class FindPartyFilterDataStructure {
  final List<String> filterTitle;
  final List<FilterItem> filterData;
  final Map<String, List<String>> detailCategory;

  const FindPartyFilterDataStructure({
    required this.filterTitle,
    required this.filterData,
    required this.detailCategory,
  });
}

class FindWorkFilterDataStructure {
  final List<String> filterTitle;
  final List<FilterItem> filterData;
  final Map<String, List<String>> detailCategory;

  const FindWorkFilterDataStructure({
    required this.filterTitle,
    required this.filterData,
    required this.detailCategory,
  });
}
