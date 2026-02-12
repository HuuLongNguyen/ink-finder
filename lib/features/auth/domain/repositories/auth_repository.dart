abstract class AuthRepository {
  Future<void> signInWithEmail(String email, String password);
  Future<void> signUpStudio({
    required String email,
    required String password,
    required String studioName,
    required String ownerName,
    required String phone,
    required String address,
    required List<String> specializations,
  });
  Future<void> signOut();
  Stream<String?> get authStateChanges;
}

class MockAuthRepository implements AuthRepository {
  @override
  Stream<String?> get authStateChanges => Stream.value(null);

  @override
  Future<void> signInWithEmail(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    // Implementation would go here
  }

  @override
  Future<void> signUpStudio({
    required String email,
    required String password,
    required String studioName,
    required String ownerName,
    required String phone,
    required String address,
    required List<String> specializations,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // Implementation would go here
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Implementation would go here
  }
}
