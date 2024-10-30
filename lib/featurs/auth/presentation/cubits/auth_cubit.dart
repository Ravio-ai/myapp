import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/featurs/auth/domain/entities/app_user.dart';
import 'package:myapp/featurs/auth/domain/repos/auth_repo.dart';
import 'package:myapp/featurs/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  //check if user is already authenticated
  void checkAuth() async {
    _currentUser = await authRepo.getCurrentUser();
    if (_currentUser != null) {
      emit(AuthAuthenticated(_currentUser!));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  //get currentUser
  AppUser? get currentUser => _currentUser;

  //login with emain and password
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final AppUser? user =
          await authRepo.loginWithEmailAndPassword(email, password);
      _currentUser = user;
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(" Error logging in: $e "));
      emit(AuthUnauthenticated());
    }
  }

  //register with email and password
  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final AppUser? user =
          await authRepo.registerWithEmailAndPassword(name, email, password);
      _currentUser = user;
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(" Error logging in: $e "));
      emit(AuthUnauthenticated());
    }
  }

  //logout
  Future<void> logout() async {
    authRepo.logout();
    emit(AuthUnauthenticated());
  }
}
