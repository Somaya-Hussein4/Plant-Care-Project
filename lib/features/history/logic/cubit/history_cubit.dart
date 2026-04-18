import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/features/history/data/model/history_scan_model.dart';
import 'package:graduation_project/features/history/data/repo/history_repo.dart';
import 'package:graduation_project/features/history/logic/cubit/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository _repository;
  final FlutterSecureStorage _storage;
  late String _userId;

  HistoryCubit(this._repository, {required FlutterSecureStorage storage})
      : _storage = storage,
        super(const HistoryState.initial());

  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  List<HistoryScanModel> _scans = [];

  Future<void> fetchHistory() async {
    emit(const HistoryState.loading());

    _userId = await _storage.read(key: 'userId') ?? '';
    _page = 1;
    _hasMore = true;
    _scans = [];

    try {
      final data = await _repository.getHistory(
        page: _page,
        limit: _limit,
        userId: _userId,
      );

      _scans = data;
      _hasMore = data.length == _limit;

      emit(HistoryState.success(
        scans: _scans,
        hasMore: _hasMore,
      ));
    } catch (e) {
      emit(HistoryState.error(e.toString()));
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore || _isLoadingMore) return;

    _isLoadingMore = true;
    _page++;

    try {
      final data = await _repository.getHistory(
        userId: _userId,
        page: _page,
        limit: _limit,
      );

      if (data.isEmpty) {
        _hasMore = false;
      } else {
        _scans.addAll(data);
      }

      emit(HistoryState.success(
        scans: List.from(_scans),
        hasMore: _hasMore,
      ));
    } catch (e) {
      emit(HistoryState.error(e.toString()));
    }

    _isLoadingMore = false;
  }
}
