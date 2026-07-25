import '../models/user_model.dart';

/// Abstract auth repository — allows swapping Firebase for mock.
abstract class AuthRepository {
  Future<void> sendOtp(String phoneNumber);
  Future<UserModel> verifyOtp(String otp);
  Future<void> signOut();
  UserModel? get currentUser;
  bool get isAuthenticated;
  Stream<UserModel?> get authStateChanges;
}

/// Mock implementation for development without Firebase.
class MockAuthRepository implements AuthRepository {
  UserModel? _currentUser;

  static const _demoUsers = {
    'patient': UserModel(
      uid: 'demo-patient-001',
      name: 'Rahim Uddin',
      phone: '+880 1712 345 678',
      role: UserRole.patient,
    ),
    'admin': UserModel(
      uid: 'demo-admin-001',
      name: 'Dr. Karim',
      phone: '+880 1812 345 678',
      role: UserRole.hospitalAdmin,
      hospitalId: 'dhaka-medical',
    ),
    'super': UserModel(
      uid: 'demo-super-001',
      name: 'Admin',
      phone: '+880 1912 345 678',
      role: UserRole.superAdmin,
    ),
  };

  @override
  Future<void> sendOtp(String phoneNumber) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<UserModel> verifyOtp(String otp) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Any 6-digit code works for demo
    _currentUser = _demoUsers['patient']!;
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  @override
  UserModel? get currentUser => _currentUser;

  @override
  bool get isAuthenticated => _currentUser != null;

  @override
  Stream<UserModel?> get authStateChanges => Stream.value(_currentUser);

  /// Switch role for demo purposes
  void switchRole(UserRole role) {
    switch (role) {
      case UserRole.patient:
        _currentUser = _demoUsers['patient'];
      case UserRole.hospitalAdmin:
        _currentUser = _demoUsers['admin'];
      case UserRole.superAdmin:
        _currentUser = _demoUsers['super'];
    }
  }
}
