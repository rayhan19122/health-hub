import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

/// Authentication ViewModel — manages login state, OTP flow, and user session.
class AuthViewModel extends ChangeNotifier {
  AuthViewModel({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  // ── State ──
  bool _isLoading = false;
  String? _errorMessage;
  String _phoneNumber = '';
  bool _otpSent = false;

  // ── Getters ──
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get phoneNumber => _phoneNumber;
  bool get otpSent => _otpSent;
  UserModel? get currentUser => _repository.currentUser;
  bool get isAuthenticated => _repository.isAuthenticated;
  String get userName => currentUser?.name ?? 'User';
  String get userRoleName => currentUser?.roleName ?? 'Patient';
  UserRole get userRole => currentUser?.role ?? UserRole.patient;

  // ── Actions ──

  void setPhoneNumber(String phone) {
    _phoneNumber = phone;
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> sendOtp() async {
    if (_phoneNumber.length < 10) {
      _errorMessage = 'Please enter a valid phone number';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.sendOtp(_phoneNumber);
      _otpSent = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to send OTP. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    if (otp.length < 6) {
      _errorMessage = 'Please enter the complete OTP';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.verifyOtp(otp);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Invalid OTP. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    await _repository.signOut();
    _otpSent = false;
    _phoneNumber = '';
    _isLoading = false;
    notifyListeners();
  }

  void goBackToLogin() {
    _otpSent = false;
    _errorMessage = null;
    notifyListeners();
  }

  /// Switch user role (demo only)
  void switchRole(UserRole role) {
    final repo = _repository;
    if (repo is MockAuthRepository) {
      repo.switchRole(role);
      notifyListeners();
    }
  }

  /// Cycle through roles (demo only)
  void cycleRole() {
    final roles = UserRole.values;
    final currentIndex = roles.indexOf(userRole);
    final nextRole = roles[(currentIndex + 1) % roles.length];
    switchRole(nextRole);
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
