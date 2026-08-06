import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/questions_data.dart';
import '../data/video_data.dart';
import '../models/class_model.dart';
import '../providers/auth_provider.dart' as ap;
import '../services/firestore_service.dart';
import 'quiz_screen.dart';
import 'video_player_screen.dart';
import 'certificate_screen.dart';

class TopicScreen extends StatelessWidget {
  final ClassModel classModel;
  final SubjectModel subject;

  const TopicScreen({
    super.key,
    required this.classModel,
    required this.subject,
  });

  Future<void> _claimCertificate(BuildContext context, user) async {
    if (user == null) return;
    final fs = FirestoreService();
    await fs.markSubjectComplete(
      uid: user.uid,
      className: classModel.label,
      subjectName: subject.name,
      subjectEmoji: subject.emoji,
      totalTopics: subject.topics.length,
      userName: user.displayName,
      userEmail: user.email,
    );
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🏆', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 12),
              const Text(
                'Certificate Earned!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'You completed ${subject.name}!\n+200 bonus points awarded.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CertificateScreen()),
                );
              },
              child: const Text('View Certificate'),
            ),
          ],
        ),
      );
    }
  }

  Color get _subjectColor {
    try {
      final hex = subject.color.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: _subjectColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _subjectColor,
                      _subjectColor.withValues(alpha: 0.65),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          subject.emoji,
                          style: const TextStyle(fontSize: 36),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subject.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${classModel.label} · ${subject.topics.length} Topics',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
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
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Builder(
                builder: (context) {
                  final user = context.watch<ap.AuthProvider>().userModel;
                  final completedTopics = user?.completedTopics ?? [];

                  int completedCount = subject.topics
                      .where(
                        (t) => completedTopics.contains(
                          '${classModel.label}|${subject.name}|$t',
                        ),
                      )
                      .length;
                  final allDone = completedCount == subject.topics.length;
                  final hasCert =
                      user?.completedSubjects.contains(
                        '${classModel.label}|${subject.name}',
                      ) ??
                      false;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress summary
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: _subjectColor.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Progress',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  '$completedCount / ${subject.topics.length} topics',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _subjectColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: subject.topics.isEmpty
                                    ? 0
                                    : completedCount / subject.topics.length,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation(
                                  _subjectColor,
                                ),
                                minHeight: 8,
                              ),
                            ),
                            if (allDone && !hasCert) ...[
                              const SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: () =>
                                    _claimCertificate(context, user),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFCC00),
                                  foregroundColor: Colors.black87,
                                  minimumSize: const Size(double.infinity, 44),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Text('🏆'),
                                label: const Text(
                                  'Claim Certificate!',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ] else if (hasCert) ...[
                              const SizedBox(height: 12),
                              OutlinedButton.icon(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CertificateScreen(),
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: _subjectColor,
                                  side: BorderSide(color: _subjectColor),
                                  minimumSize: const Size(double.infinity, 44),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(Icons.workspace_premium),
                                label: const Text('View Certificate'),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Text(
                        'Topics',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: subject.topics.length,
                        separatorBuilder: (context2, index2) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final topic = subject.topics[index];
                          final hasQuestions = QuestionsData.getQuestions(
                            subject.name,
                            topic,
                          ).isNotEmpty;
                          final isCompleted = completedTopics.contains(
                            '${classModel.label}|${subject.name}|$topic',
                          );
                          final videoId = VideoData.getDefaultVideoId(
                            subject.name,
                            topic,
                          );

                          return _TopicTile(
                            index: index + 1,
                            title: topic,
                            color: _subjectColor,
                            hasQuestions: hasQuestions,
                            isCompleted: isCompleted,
                            videoId: videoId,
                            onTapQuiz: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizScreen(
                                  classModel: classModel,
                                  subject: subject,
                                  topic: topic,
                                ),
                              ),
                            ),
                            onTapVideo: videoId == null
                                ? null
                                : () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => VideoPlayerScreen(
                                        subject: subject.name,
                                        topic: topic,
                                        videoId: videoId,
                                        classModel: classModel,
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicTile extends StatelessWidget {
  final int index;
  final String title;
  final Color color;
  final bool hasQuestions;
  final bool isCompleted;
  final String? videoId;
  final VoidCallback onTapQuiz;
  final VoidCallback? onTapVideo;

  const _TopicTile({
    required this.index,
    required this.title,
    required this.color,
    required this.hasQuestions,
    required this.isCompleted,
    this.videoId,
    required this.onTapQuiz,
    this.onTapVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: isCompleted
            ? Border.all(color: Colors.green.withValues(alpha: 0.5), width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green.withValues(alpha: 0.15)
                  : color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.green, size: 20)
                  : Text(
                      '$index',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (videoId != null)
                      _ActionChip(
                        icon: Icons.play_circle_outline,
                        label: 'Video',
                        color: const Color(0xFFFF5722),
                        onTap: onTapVideo!,
                      ),
                    if (videoId != null) const SizedBox(width: 8),
                    if (hasQuestions)
                      _ActionChip(
                        icon: Icons.quiz_outlined,
                        label: 'Quiz',
                        color: color,
                        onTap: onTapQuiz,
                      )
                    else
                      Text(
                        'Coming soon',
                        style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (isCompleted)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.workspace_premium,
                color: Color(0xFFFFCC00),
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
