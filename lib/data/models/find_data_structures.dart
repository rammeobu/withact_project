class PartyItem {
  final String partyName;
  final String workName;

  const PartyItem({required this.partyName, required this.workName});
}

class WorkItem {
  final String workName;
  final String time;
  final String place;

  const WorkItem({
    required this.workName,
    required this.time,
    required this.place,
  });
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
