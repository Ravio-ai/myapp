import 'package:myapp/featurs/auth/domain/entities/app_user.dart';

abstract class AuthStates {}

//initial state
class AuthInitial extends AuthStates {}

//loading state
class AuthLoading extends AuthStates {}

//Authenticated state
class AuthAuthenticated extends AuthStates {
  final AppUser user;
  AuthAuthenticated(this.user);
}

//Unauthenticated state
class AuthUnauthenticated extends AuthStates {}

//Error state
class AuthError extends AuthStates {
  final String errorMessage;
  AuthError(this.errorMessage);
}
