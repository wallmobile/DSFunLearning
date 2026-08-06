import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/curriculum_data.dart';
import '../providers/auth_provider.dart' as ap;
import '../models/class_model.dart';
import 'subject_screen.dart';

class LearningPathScreen extends StatelessWidget {
  const LearningPathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ap.AuthProvider>().userModel;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            automaticallyImplyLeading: false,
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
                        const Text('🗺️', style: TextStyle(fontSize: 36)),
                        const SizedBox(height: 8),
                        const Text(
                          'My Learning Path',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Track your progress across all classes',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (user == null)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
                  final classModel = CurriculumData.classes[i];
                  final subjects = CurriculumData.getSubjects(
                    classModel.classNumber,
                  );
                  int completedSubjects = subjects
                      .where(
                        (s) => user.completedSubjects.contains(
                          '${classModel.label}|${s.name}',
                        ),
                      )
                      .length;
                  int totalTopics = subjects.fold(
                    0,
                    (sum, s) => sum + s.topics.length,
                  );
                  int completedTopics = subjects.fold(
                    0,
                    (sum, s) =>
                        sum +
                        s.topics
                            .where(
                              (t) => user.completedTopics.contains(
                                '${classModel.label}|${s.name}|$t',
                              ),
                            )
                            .length,
                  );

                  return _ClassProgressCard(
                    classModel: classModel,
                    completedSubjects: completedSubjects,
                    totalSubjects: subjects.length,
                    completedTopics: completedTopics,
                    totalTopics: totalTopics,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SubjectScreen(classModel: classModel),
                      ),
                    ),
                  );
                }, childCount: CurriculumData.classes.length),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class _ClassProgressCard extends StatelessWidget {
  final ClassModel classModel;
  final int completedSubjects;
  final int totalSubjects;
  final int completedTopics;
  final int totalTopics;
  final VoidCallback onTap;

  const _ClassProgressCard({
    required this.classModel,
    required this.completedSubjects,
    required this.totalSubjects,
    required this.completedTopics,
    required this.totalTopics,
    required this.onTap,
  });

  Color get _color {
    switch (classModel.group) {
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

  @override
  Widget build(BuildContext context) {
    final progress = totalTopics == 0 ? 0.0 : completedTopics / totalTopics;
    final isComplete = completedSubjects == totalSubjects;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isComplete
              ? Border.all(
                  color: Colors.green.withValues(alpha: 0.4),
                  width: 1.5,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: _color.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: _color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  classModel.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        classModel.label,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      if (isComplete) ...[
                        const SizedBox(width: 8),
                        const Text('✅', style: TextStyle(fontSize: 14)),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$completedTopics/$totalTopics topics · $completedSubjects/$totalSubjects subjects done',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(_color),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${(progress * 100).round()}%',
              style: TextStyle(
                color: _color,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
