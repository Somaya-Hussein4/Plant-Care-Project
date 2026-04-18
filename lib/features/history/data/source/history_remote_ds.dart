import 'package:graduation_project/features/history/data/api_service/history_api_service.dart';
import 'package:graduation_project/features/history/data/model/history_response_model.dart';

class HistoryRemoteDataSource {
  final HistoryApiService _apiService;

  HistoryRemoteDataSource(this._apiService);

  Future<HistoryResponseModel> getHistory({
    required int page,
    required int limit,
    required String userId,
  }) async {
    final response = await _apiService.getHistory(userId, page, limit);

    if (response.success) {
      return response;
    }

    throw Exception(response.message);
  }
}
