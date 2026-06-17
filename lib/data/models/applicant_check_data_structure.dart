class ApplicantItem {
  final int id;
  final String name;
  final String position;
  final String? skill;

  const ApplicantItem({
    required this.id,
    required this.name,
    required this.position,
    this.skill,
  });

  factory ApplicantItem.fromJson(Map<String, dynamic> json) {
    return ApplicantItem(
      id: json['id'] ?? 0,
      name: json['userName'] ?? '',
      position: json['roleName'] ?? '',
      skill: json['skill']?.toString(),
    );
  }
}

class ApplicantCheckDataStructure {
  final List<String> position;
  final List<ApplicantItem>? applicants;

  const ApplicantCheckDataStructure({required this.position, this.applicants});
}
