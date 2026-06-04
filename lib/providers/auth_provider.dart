import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authStateProvider = StreamProvider<bool>((ref) {
  return ref.watch(authRepositoryProvider).isLoggedIn();
});

final userIdProvider = Provider<String?>((ref) {
  final isLoggedIn = ref.watch(authStateProvider).value ?? false;
  if (!isLoggedIn) return null;
  return ref.read(authRepositoryProvider).currentUserId;
});
