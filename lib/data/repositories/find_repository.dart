import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';

class FindRepository {
  final ApiClient client;
  FindRepository(this.client);

  Future<List<WorkItem>> getWorkList(List<FilterItem> filters) async {
    throw UnimplementedError();
  }

  Future<List<PartyItem>> getPartyList(List<FilterItem> filters) async {
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>> getWorkDetail(String workId) async {
    throw UnimplementedError();
  }

  Future<List<FilterItem>> getWorkFilters() async {
    throw UnimplementedError();
  }

  Future<List<FilterItem>> getPartyFilters() async {
    throw UnimplementedError();
  }
}
