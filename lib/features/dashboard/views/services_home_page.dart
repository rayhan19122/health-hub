import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/cards/service_card.dart';
import '../../../core/widgets/cards/stat_card.dart';
import '../../../core/widgets/animations/fade_slide_animation.dart';
import '../../../features/authentication/viewmodels/auth_viewmodel.dart';
import '../../../routes/route_names.dart';
import '../viewmodels/dashboard_viewmodel.dart';

/// Services home page with greeting, service cards, stats, and emergency banner.
class ServicesHomePage extends StatefulWidget {
  const ServicesHomePage({super.key});

  @override
  State<ServicesHomePage> createState() => _ServicesHomePageState();
}

class _ServicesHomePageState extends State<ServicesHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardViewModel>().loadStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final auth = context.watch<AuthViewModel>();
    final dashboard = context.watch<DashboardViewModel>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 28,
        vertical: 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              FadeSlideAnimation(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${auth.userName.split(' ').first} 👋',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Healthcare Services',
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onSurface,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Service cards
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 100),
                child: _buildServiceCards(context, isMobile),
              ),
              const SizedBox(height: 32),

              // Quick stats
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 200),
                child: _buildQuickStats(context, dashboard, isMobile),
              ),
              const SizedBox(height: 24),

              // Emergency banner
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 300),
                child: _buildEmergencyBanner(context),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCards(BuildContext context, bool isMobile) {
    final cards = [
      ServiceCard(
        title: 'Hospital Beds',
        description: 'Find and reserve hospital beds in real-time across Dhaka',
        icon: const Icon(Icons.hotel_rounded, size: 24, color: AppColors.primary),
        accentColor: AppColors.primary,
        statusText: '47 hospitals live',
        statusColor: AppColors.success,
        onTap: () => context.goNamed(RouteNames.hospitalBeds),
      ),
      ServiceCard(
        title: 'Ambulance',
        description: 'Book emergency ambulance and track in real-time',
        icon: const Icon(Icons.local_shipping_rounded, size: 24, color: AppColors.error),
        accentColor: AppColors.error,
        statusText: '12 available',
        statusColor: AppColors.success,
        onTap: () => context.goNamed(RouteNames.ambulanceHome),
      ),
      ServiceCard(
        title: 'Blood Bank',
        description: 'Search blood availability and request emergency units',
        icon: const Icon(Icons.water_drop_rounded, size: 24, color: AppColors.bloodBank),
        accentColor: AppColors.bloodBank,
        statusText: '8 banks online',
        statusColor: AppColors.success,
        onTap: () => context.goNamed(RouteNames.bloodBankHome),
      ),
    ];

    if (isMobile) {
      return Column(
        children: cards.map((c) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: c,
        )).toList(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: cards.map((c) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: c == cards.last ? 0 : 16,
              ),
              child: c,
            ),
          )).toList(),
        );
      },
    );
  }

  Widget _buildQuickStats(BuildContext context, DashboardViewModel dashboard, bool isMobile) {
    final stats = dashboard.stats;
    final statCards = [
      StatCard(
        value: '${stats.bedsAvailable}',
        label: 'Beds Available',
        valueColor: AppColors.primary,
      ),
      StatCard(
        value: '${stats.ambulancesReady}',
        label: 'Ambulances Ready',
        valueColor: AppColors.error,
      ),
      StatCard(
        value: '${stats.bloodUnits}',
        label: 'Blood Units',
        valueColor: AppColors.bloodBank,
      ),
      StatCard(
        value: '${stats.hospitalsLive}',
        label: 'Hospitals',
        valueColor: AppColors.success,
      ),
    ];

    final crossAxisCount = isMobile ? 2 : 4;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: isMobile ? 1.3 : 1.5,
      children: statCards,
    );
  }

  Widget _buildEmergencyBanner(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.goNamed(RouteNames.ambulanceHome),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFC62828), Color(0xFFD50000)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                ),
                child: const Center(
                  child: Icon(Icons.phone_rounded, size: 22, color: Colors.white),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Emergency? Call 999',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Tap for immediate emergency assistance',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '→',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
