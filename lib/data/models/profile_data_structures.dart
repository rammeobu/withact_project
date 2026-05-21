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
}

class MenuDataStructure {
  final String name;
  final String? profileImage;

  const MenuDataStructure({required this.name, this.profileImage});
}
