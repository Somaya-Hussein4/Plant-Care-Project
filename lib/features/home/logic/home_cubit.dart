import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/home/data/image_picker.dart';
import 'package:graduation_project/features/home/logic/home_state.dart';
import 'package:image_picker/image_picker.dart';

class HomeCubit extends Cubit<HomeState> {
  final ImageService _imageService;

  HomeCubit(this._imageService) : super(HomeInitial());

  Future<void> handleImageSelection(ImageSource source) async {
    try {
      final path = await _imageService.pickImage(source);

      if (path != null) {
        emit(HomeNavigateToResult(path));
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void reset() => emit(HomeInitial());
}
