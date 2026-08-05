import 'package:flutter/material.dart';
import '../data/curriculum_data.dart';
import '../models/class_model.dart';
import '../widgets/class_card.dart';
import 'subject_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = ['Primary', 'Middle', 'Secondary', 'Senior'];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: const Color(0xFF4A6CF7),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4A6CF7), Color(0xFF6A3DE8)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                '🎒',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'DS Fun Learning',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Select Your Class',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Class 1 – 12 | All Subjects',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, groupIndex) {
                  final group = groups[groupIndex];
                  final groupClasses = CurriculumData.classes
                      .where((c) => c.group == group)
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 20,
                              decoration: BoxDecoration(
                                color: _groupColor(group),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$group School',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _groupRange(group),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.9,
                        children: groupClasses.map((classModel) {
                          return ClassCard(
                            classModel: classModel,
                            onTap: () => _navigateToSubjects(
                              context,
                              classModel,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                },
                childCount: groups.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Color _groupColor(String group) {
    switch (group) {
      case 'Primary':
        return const Color(0xFF4CAF50);
      case 'Middle':
        return const Color(0xFF2196F3);
      case 'Secondary':
        return const Color(0xFF9C27B0);
      case 'Senior':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF607D8B);
    }
  }

  String _groupRange(String group) {
    switch (group) {
      case 'Primary':
        return '(Class 1–5)';
      case 'Middle':
        return '(Class 6–8)';
      case 'Secondary':
        return '(Class 9–10)';
      case 'Senior':
        return '(Class 11–12)';
      default:
        return '';
    }
  }

  void _navigateToSubjects(BuildContext context, ClassModel classModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SubjectScreen(classModel: classModel),
      ),
    );
  }
}
