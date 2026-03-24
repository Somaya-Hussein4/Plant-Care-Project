import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/home/data/image_picker.dart';
import 'package:graduation_project/features/home/logic/home_state.dart';
import 'package:image_picker/image_picker.dart';

class HomeCubit extends Cubit<HomeState> {
  final ImageService _imageService;
  HomeCubit(this._imageService) : super(HomeInitial());

  Future<void> handleImageSelection(ImageSource source) async {
    try {
      // 1. You could emit(HomeLoading()) here if the picker is slow
      final path = await _imageService.pickImage(source);

      if (path != null) {
        // 2. Success: Trigger navigation
        emit(HomeNavigateToResult(path));

        // 3. Reset: Go back to Initial so the user can click again later
        emit(HomeInitial());
      }
    } catch (e) {
      // Handle any errors, maybe emit a HomeError state
      print('Error picking image: $e');
    }
  }
}
