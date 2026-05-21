class ApplicantItem {
  final String name;
  final String position;
  final String skill;

  const ApplicantItem({
    required this.name,
    required this.position,
    required this.skill,
  });
}

class ApplicantCheckDataStructure {
  final List<String> position;
  final List<ApplicantItem>? applicants;

  const ApplicantCheckDataStructure({required this.position, this.applicants});
}
