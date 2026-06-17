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
        json['skill'] ?? json['spec'] ?? '',
        json['belong'] ?? '',
        json['major'] ?? '',
      ],
      spec: json['skill'] ?? json['spec'] ?? '',
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
      spec: json['skill'] ?? json['spec'] ?? '',
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

class ProfileState {
  final List<String> profileContent;
  final String introduction;
  final String spec;
  final List<String> favorites;
  final String? imagePath;
  final bool anonymous;

  const ProfileState({
    this.profileContent = const ['', '', '', ''],
    this.introduction = '',
    this.spec = '',
    this.favorites = const ['', '', ''],
    this.imagePath,
    this.anonymous = false,
  });

  bool get hasData =>
      profileContent.any((value) => value.isNotEmpty) ||
      introduction.isNotEmpty ||
      spec.isNotEmpty ||
      favorites.any((value) => value.isNotEmpty);

  ProfileState copyWith({
    List<String>? profileContent,
    String? introduction,
    String? spec,
    List<String>? favorites,
    String? imagePath,
    bool? anonymous,
  }) {
    return ProfileState(
      profileContent: profileContent ?? this.profileContent,
      introduction: introduction ?? this.introduction,
      spec: spec ?? this.spec,
      favorites: favorites ?? this.favorites,
      imagePath: imagePath ?? this.imagePath,
      anonymous: anonymous ?? this.anonymous,
    );
  }

  factory ProfileState.fromJson(Map<String, dynamic> json) {
    final preference = json['preference'];
    return ProfileState(
      profileContent: [
        json['name'] ?? '',
        json['skill'] ?? json['spec'] ?? '',
        json['belong'] ?? '',
        json['major'] ?? '',
      ],
      introduction: json['introduction'] ?? '',
      spec: json['spec'] ?? '',
      favorites: preference is List
          ? preference.map((value) => value.toString()).toList()
          : [if (preference != null) preference.toString()],
    );
  }
}
