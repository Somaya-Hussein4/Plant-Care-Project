import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation_project/core/services/user_device_service.dart';
import 'package:graduation_project/features/auth/data/repo/auth_repository.dart';
import 'package:graduation_project/features/auth/logic/cubit/auth_state.dart';
import 'package:graduation_project/generated/l10n.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  final UserDeviceService _deviceService;

  AuthCubit(this.repository, {UserDeviceService? deviceService})
      : _deviceService = deviceService ?? UserDeviceService(),
        super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    try {
      final response = await repository.login(email, password);

      final user = response.data.user;
      if (user == null) {
        emit(AuthState.failure(S.current.userDataNotFound));
        return;
      }

      try {
        await FirebaseAuth.instance.signInAnonymously();
        final firebaseUid = FirebaseAuth.instance.currentUser?.uid ?? '';
        _deviceService.initAndSaveUserDevice(firebaseUid);
      } catch (e) {}

      emit(AuthState.success(user));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> signup(String name, String email, String password) async {
    emit(const AuthState.loading());
    try {
      final response = await repository.signup(name, email, password);

      final user = response.data.user;
      if (user == null) {
        emit(AuthState.failure(S.current.userDataNotFound));
        return;
      }

      try {
        await FirebaseAuth.instance.signInAnonymously();
        final firebaseUid = FirebaseAuth.instance.currentUser?.uid ?? '';
        _deviceService.initAndSaveUserDevice(firebaseUid);
      } catch (e) {}

      emit(AuthState.success(user));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> refreshToken() async {
    try {
      await repository.refreshToken();
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthState.loading());
      await repository.logout();
      emit(AuthState.loggedOut());
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> googleSignIn() async {
    emit(const AuthState.loading());
    try {
      final googleSignIn = GoogleSignIn(
        serverClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID'],
      );
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        emit(const AuthState.initial());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        emit(AuthState.failure(S.current.userDataNotFound));
        return;
      }

      final response = await repository.googleLogin(idToken);
      final user = response.data.user;
      if (user == null) {
        emit(AuthState.failure(S.current.userDataNotFound));
        return;
      }

      try {
        await FirebaseAuth.instance.signInAnonymously();
        final firebaseUid = FirebaseAuth.instance.currentUser?.uid ?? '';
        _deviceService.initAndSaveUserDevice(firebaseUid);
      } catch (e) {}

      emit(AuthState.success(user));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<String> _getFirebaseUid() async {
    await FirebaseAuth.instance.signInAnonymously();
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }
}
