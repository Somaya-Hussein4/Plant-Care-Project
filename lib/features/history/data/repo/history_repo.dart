import 'package:graduation_project/features/history/data/model/history_scan_model.dart';
import 'package:graduation_project/features/history/data/source/history_remote_ds.dart';

class HistoryRepository {
  final HistoryRemoteDataSource _remote;

  HistoryRepository(this._remote);

  Future<List<HistoryScanModel>> getHistory({
    required String userId,
    required int page,
    required int limit,
  }) async {
    final response = await _remote.getHistory(
      userId: userId,
      page: page,
      limit: limit,
    );

    return response.data.scans;
  }
}
