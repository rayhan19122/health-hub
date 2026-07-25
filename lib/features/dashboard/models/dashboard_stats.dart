/// HealthHub — Dashboard Stats Model
class DashboardStats {
  const DashboardStats({
    required this.bedsAvailable,
    required this.ambulancesReady,
    required this.bloodUnits,
    required this.hospitalsLive,
  });

  final int bedsAvailable;
  final int ambulancesReady;
  final int bloodUnits;
  final int hospitalsLive;

  /// Demo data
  static const demo = DashboardStats(
    bedsAvailable: 22,
    ambulancesReady: 12,
    bloodUnits: 156,
    hospitalsLive: 47,
  );
}
