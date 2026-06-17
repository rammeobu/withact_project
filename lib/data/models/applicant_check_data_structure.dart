class ApplicantItem {
  final int id;
  final int userId;
  final String name;
  final String position;
  final String? skill;
  final String introduction;

  const ApplicantItem({
    required this.id,
    this.userId = 0,
    required this.name,
    required this.position,
    this.skill,
    this.introduction = '',
  });

  factory ApplicantItem.fromJson(Map<String, dynamic> json) {
    return ApplicantItem(
      id: json['id'] ?? 0,
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      name: json['userName'] ?? '',
      position: json['roleName'] ?? '',
      skill: json['skill']?.toString(),
      introduction: json['introduction'] ?? json['motivation'] ?? '',
    );
  }
}

class ApplicantCheckDataStructure {
  final List<String> position;
  final List<ApplicantItem>? applicants;

  const ApplicantCheckDataStructure({required this.position, this.applicants});
}
