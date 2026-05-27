class PartyMemberProfileDataStructure {
  final String? profileImage;
  final List<String> profileContent;
  final String introduction;
  final String spec;
  final List<String> preferences;
  final List<String> positions;

  const PartyMemberProfileDataStructure({
    required this.profileContent,
    required this.introduction,
    required this.spec,
    required this.preferences,
    required this.positions,
    this.profileImage,
  });
}

class ProfileAndDetailEditDataStructure {
  final List<String> profileContent;
  final String introduction;
  final String spec;
  final List<String> preference;

  const ProfileAndDetailEditDataStructure({
    required this.profileContent,
    required this.introduction,
    required this.spec,
    required this.preference,
  });

  factory ProfileAndDetailEditDataStructure.fromJson(Map<String, dynamic> json) {
    return ProfileAndDetailEditDataStructure(
      profileContent: [
        json['name'] ?? '',
        json['skill'] ?? '',
        json['belong'] ?? '',
        json['major'] ?? '',
      ],
      spec: json['skill'] ?? '',
      introduction: json['introduction'] ?? '',
      preference: (json['preference'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}

class ApplicantProfileDataStructure {
  final String name;
  final String introduction;
  final String spec;

  const ApplicantProfileDataStructure({
    required this.name,
    required this.introduction,
    required this.spec,
  });

  factory ApplicantProfileDataStructure.fromJson(Map<String, dynamic> json) {
    return ApplicantProfileDataStructure(
      name: json['name'] ?? '',
      introduction: json['introduction'] ?? '',
      spec: json['skill'] ?? '',
    );
  }
}

class MenuDataStructure {
  final String name;
  final String? profileImage;

  const MenuDataStructure({required this.name, this.profileImage});

  factory MenuDataStructure.fromJson(Map<String, dynamic> json) {
    return MenuDataStructure(
      name: json['name'] ?? '',
      profileImage: json['profileImage'],
    );
  }
}
