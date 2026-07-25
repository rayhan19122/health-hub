import 'package:flutter/material.dart';
import '../models/dashboard_stats.dart';

/// Dashboard ViewModel — manages stats and loading state.
class DashboardViewModel extends ChangeNotifier {
  DashboardStats _stats = DashboardStats.demo;
  bool _isLoading = false;

  DashboardStats get stats => _stats;
  bool get isLoading => _isLoading;

  Future<void> loadStats() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network fetch
    await Future.delayed(const Duration(milliseconds: 600));
    _stats = DashboardStats.demo;

    _isLoading = false;
    notifyListeners();
  }
}
