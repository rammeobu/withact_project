class PartyItem {
  final int id;
  final String partyName;
  final String activityName;
  final int activityId;
  final int leaderId;

  const PartyItem({
    required this.id,
    required this.partyName,
    required this.activityName,
    required this.activityId,
    required this.leaderId,
  });

  factory PartyItem.fromJson(Map<String, dynamic> json) {
    return PartyItem(
      id: json['id'] ?? 0,
      partyName: json['title'] ?? '',
      activityId: json['activityId'] ?? 0,
      leaderId: json['leaderId'] ?? 0,
      activityName: (json['activityTitle'] ?? '').toString().isNotEmpty
          ? json['activityTitle'].toString()
          : '활동 ${json['activityId'] ?? 0}',
    );
  }
}

class PartyRole {
  final int id;
  final String roleName;
  final int targetCount;
  final int currentCount;

  const PartyRole({
    required this.id,
    required this.roleName,
    required this.targetCount,
    required this.currentCount,
  });

  factory PartyRole.fromJson(Map<String, dynamic> json) {
    return PartyRole(
      id: json['id'] ?? 0,
      roleName: json['roleName'] ?? '',
      targetCount: json['targetCount'] ?? 0,
      currentCount: json['currentCount'] ?? 0,
    );
  }
}

class ActivityItem {
  final int id;
  final String activityName;
  final String startDate;
  final String endDate;
  final String location;
  final String organization;
  final String category;

  const ActivityItem({
    required this.id,
    required this.activityName,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.organization,
    required this.category,
  });

  factory ActivityItem.fromJson(Map<String, dynamic> json) {
    return ActivityItem(
      id: json['id'] ?? 0,
      activityName: json['title'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      location: json['location'] ?? '',
      organization: json['organization'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': activityName,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'organization': organization,
      'category': category,
    };
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

class FindActivityDataStructure {
  final List<ActivityItem> activityList;

  const FindActivityDataStructure({required this.activityList});
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

class FindActivityFilterDataStructure {
  final List<String> filterTitle;
  final List<FilterItem> filterData;
  final Map<String, List<String>> detailCategory;

  const FindActivityFilterDataStructure({
    required this.filterTitle,
    required this.filterData,
    required this.detailCategory,
  });
}
