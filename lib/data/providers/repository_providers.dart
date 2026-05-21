import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/data/network/api_client.dart';
import 'package:party_maker/data/repositories/account_repository.dart';
import 'package:party_maker/data/repositories/apply_repository.dart';
import 'package:party_maker/data/repositories/find_repository.dart';
import 'package:party_maker/data/repositories/recruit_repository.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return AccountRepository(ref.read(apiClientProvider));
});

final applyRepositoryProvider = Provider<ApplyRepository>((ref) {
  return ApplyRepository(ref.read(apiClientProvider));
});

final recruitRepositoryProvider = Provider<RecruitRepository>((ref) {
  return RecruitRepository(ref.read(apiClientProvider));
});

final findRepositoryProvider = Provider<FindRepository>((ref) {
  return FindRepository(ref.read(apiClientProvider));
});
