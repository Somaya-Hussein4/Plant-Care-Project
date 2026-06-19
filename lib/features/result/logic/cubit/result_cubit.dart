import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/result/data/repo/result_repo.dart';

import 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  final ResultRepository _repository;

  ResultCubit(this._repository) : super(const ResultState.initial());

  Future<void> scan(String imagePath) async {
    emit(const ResultState.loading());

    try {
      final result = await _repository.uploadAndScan(imagePath);
      emit(ResultState.success(result));
    } on ScanException catch (e) {
      emit(ResultState.error(e.type, e.message));
    } catch (e, stack) {
      emit(const ResultState.error('UNKNOWN', 'An unknown error occurred.'));
    }
  }
}
