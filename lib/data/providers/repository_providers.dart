import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/data/models/profile_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';
import 'package:party_maker/data/network/token_storage.dart';
import 'package:party_maker/data/repositories/account_repository.dart';
import 'package:party_maker/data/repositories/apply_repository.dart';
import 'package:party_maker/data/repositories/find_repository.dart';
import 'package:party_maker/data/repositories/notify_repository.dart';
import 'package:party_maker/data/repositories/recruit_repository.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

class CurrentUserNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void setUserId(int? id) {
    state = id;
  }

  void clear() {
    state = null;
  }
}

final currentUserProvider = NotifierProvider<CurrentUserNotifier, int?>(
  CurrentUserNotifier.new,
);

class LoggedInNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setLoggedIn(bool value) {
    state = value;
  }
}

final loggedInProvider = NotifierProvider<LoggedInNotifier, bool>(
  LoggedInNotifier.new,
);

class ProfileNotifier extends Notifier<ProfileState> {
  @override
  ProfileState build() => const ProfileState();

  void setProfile(ProfileState profile) {
    state = profile;
  }

  void setCard({
    required List<String> profileContent,
    String? imagePath,
    required bool anonymous,
  }) {
    state = state.copyWith(
      profileContent: profileContent,
      imagePath: imagePath,
      anonymous: anonymous,
    );
  }

  void setDetail({
    required String introduction,
    required String spec,
    required List<String> favorites,
  }) {
    state = state.copyWith(
      introduction: introduction,
      spec: spec,
      favorites: favorites,
    );
  }
}

final profileProvider = NotifierProvider<ProfileNotifier, ProfileState>(
  ProfileNotifier.new,
);

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return AccountRepository(
    ref.read(apiClientProvider),
    ref.read(tokenStorageProvider),
  );
});

final applyRepositoryProvider = Provider<ApplyRepository>((ref) {
  return ApplyRepository(
    ref.read(apiClientProvider),
    ref.read(findRepositoryProvider),
  );
});

final recruitRepositoryProvider = Provider<RecruitRepository>((ref) {
  return RecruitRepository(
    ref.read(apiClientProvider),
    ref.read(findRepositoryProvider),
  );
});

final findRepositoryProvider = Provider<FindRepository>((ref) {
  return FindRepository(ref.read(apiClientProvider));
});

final notifyRepositoryProvider = Provider<NotifyRepository>((ref) {
  return NotifyRepository(ref.read(apiClientProvider));
});
