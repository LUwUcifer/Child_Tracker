import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/child_provider.dart';
import '../models/location_history.dart';
import '../utils/colors.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  String? _selectedChildId;

  @override
  Widget build(BuildContext context) {
    final childProvider = context.watch<ChildProvider>();
    final children = childProvider.children;
    
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.8, 0.8),
          radius: 1.5,
          colors: [
            AppColors.primaryLight.withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        children: [
          // Filter section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.background.withOpacity(0.5),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.borderPurple,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter by Child',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'All Children',
                        isSelected: _selectedChildId == null,
                        onTap: () {
                          setState(() {
                            _selectedChildId = null;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      ...children.map((child) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _FilterChip(
                            label: child.name,
                            isSelected: _selectedChildId == child.id,
                            onTap: () {
                              setState(() {
                                _selectedChildId = child.id;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // History list
          Expanded(
            child: _buildHistoryList(childProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(ChildProvider childProvider) {
    List<LocationHistory> history = _selectedChildId == null
        ? childProvider.locationHistory
        : childProvider.getChildHistory(_selectedChildId!);
    
    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No location history yet',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'History will appear as children move',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    // Group history by date
    final groupedHistory = <String, List<LocationHistory>>{};
    for (var entry in history) {
      final dateKey = DateFormat('yyyy-MM-dd').format(entry.timestamp);
      if (!groupedHistory.containsKey(dateKey)) {
        groupedHistory[dateKey] = [];
      }
      groupedHistory[dateKey]!.add(entry);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: groupedHistory.length,
      itemBuilder: (context, index) {
        final dateKey = groupedHistory.keys.elementAt(index);
        final entries = groupedHistory[dateKey]!;
        final date = DateTime.parse(dateKey);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date header
            Padding(
              padding: EdgeInsets.only(bottom: 16, top: index > 0 ? 16 : 0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _formatDate(date),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.borderPurple,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // History entries for this date
            ...entries.map((entry) {
              final child = childProvider.children.firstWhere(
                (c) => c.id == entry.childId,
              );
              return _HistoryCard(
                entry: entry,
                childName: child.name,
              );
            }).toList(),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return 'Today';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? AppColors.primaryGradient
              : LinearGradient(
                  colors: [
                    AppColors.surface,
                    AppColors.surface,
                  ],
                ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.borderPurple,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final LocationHistory entry;
  final String childName;

  const _HistoryCard({
    required this.entry,
    required this.childName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            entry.isInSafeZone
                ? AppColors.safe.withOpacity(0.05)
                : AppColors.alert.withOpacity(0.05),
            AppColors.surface.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: entry.isInSafeZone
              ? AppColors.safe.withOpacity(0.2)
              : AppColors.alert.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Status indicator
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: entry.isInSafeZone
                    ? AppColors.safe.withOpacity(0.2)
                    : AppColors.alert.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                entry.isInSafeZone
                    ? Icons.check_circle
                    : Icons.warning_amber_rounded,
                size: 20,
                color: entry.isInSafeZone ? AppColors.safe : AppColors.alert,
              ),
            ),
            const SizedBox(width: 16),
            
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        childName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: entry.isInSafeZone
                              ? AppColors.safe.withOpacity(0.2)
                              : AppColors.alert.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          entry.isInSafeZone ? 'Safe' : 'Alert',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: entry.isInSafeZone ? AppColors.safe : AppColors.alert,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('HH:mm:ss').format(entry.timestamp),
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        entry.safeZoneName ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (entry.distanceFromZone != null) ...[
                        Text(
                          ' • ',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${entry.distanceFromZone!.round()}m',
                          style: TextStyle(
                            fontSize: 13,
                            color: entry.isInSafeZone ? AppColors.safe : AppColors.alert,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            
            // Arrow icon
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
