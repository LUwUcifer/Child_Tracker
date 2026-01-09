import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/child_provider.dart';
import '../utils/colors.dart';
import '../widgets/child_details_tab.dart';
import '../widgets/map_tab.dart';
import '../widgets/history_tab.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final childProvider = context.watch<ChildProvider>();
    
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.8, -0.5),
                radius: 1.5,
                colors: [
                  AppColors.primary.withOpacity(0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: Column(
              children: [
                // Custom App Bar
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.background.withOpacity(0.8),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.borderPurple,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                            child: const Text(
                              'SafeTrack',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              // Notifications
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.borderPurple,
                                  ),
                                ),
                                child: IconButton(
                                  icon: Badge(
                                    isLabelVisible: childProvider.alertChildrenCount > 0,
                                    label: Text(childProvider.alertChildrenCount.toString()),
                                    backgroundColor: AppColors.alert,
                                    child: const Icon(Icons.notifications_outlined),
                                  ),
                                  onPressed: () {},
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Profile/Logout
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.borderPurple,
                                  ),
                                ),
                                child: PopupMenuButton(
                                  icon: const Icon(Icons.person_outline, color: AppColors.textPrimary),
                                  color: AppColors.surface,
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Text('Logout', style: TextStyle(color: AppColors.textPrimary)),
                                      onTap: () {
                                        Future.delayed(Duration.zero, () {
                                          context.read<AuthProvider>().logout();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Stats Cards
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              number: childProvider.children.length.toString(),
                              label: 'Tracking',
                              color: AppColors.tracking,
                              icon: Icons.person_pin_circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              number: childProvider.safeChildrenCount.toString(),
                              label: 'Safe',
                              color: AppColors.safe,
                              icon: Icons.check_circle_outline,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              number: childProvider.alertChildrenCount.toString(),
                              label: 'Alerts',
                              color: AppColors.alert,
                              icon: Icons.warning_amber_rounded,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Tab Bar
                Container(
                  color: AppColors.background.withOpacity(0.8),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondary,
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    tabs: const [
                      Tab(text: 'Children', icon: Icon(Icons.people_outline, size: 20)),
                      Tab(text: 'Map', icon: Icon(Icons.map_outlined, size: 20)),
                      Tab(text: 'History', icon: Icon(Icons.history, size: 20)),
                    ],
                  ),
                ),
                
                // Tab Views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      ChildDetailsTab(),
                      MapTab(),
                      HistoryTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String number;
  final String label;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.number,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.1),
            AppColors.surface.withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            number,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: color,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
