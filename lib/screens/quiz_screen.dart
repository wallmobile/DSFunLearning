import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/questions_data.dart';
import '../models/class_model.dart';
import '../models/question_model.dart';
import '../providers/auth_provider.dart' as ap;
import '../services/firestore_service.dart';

class QuizScreen extends StatefulWidget {
  final ClassModel classModel;
  final SubjectModel subject;
  final String topic;

  const QuizScreen({
    super.key,
    required this.classModel,
    required this.subject,
    required this.topic,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Question> _allQuestions;
  late List<Question> _mcqs;
  late List<Question> _fillups;
  late List<Question> _qnas;

  int _mcqScore = 0; // updated by MCQ answer callbacks
  bool _topicMarkedComplete = false;

  Color get _color {
    try {
      final hex = widget.subject.color.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return Colors.blueGrey;
    }
  }

  @override
  void initState() {
    super.initState();
    _allQuestions = QuestionsData.getQuestions(
      widget.subject.name,
      widget.topic,
    );
    _mcqs = _allQuestions.where((q) => q.type == QuestionType.mcq).toList();
    _fillups = _allQuestions
        .where((q) => q.type == QuestionType.fillup)
        .toList();
    _qnas = _allQuestions.where((q) => q.type == QuestionType.qna).toList();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChange);
  }

  void _onTabChange() {
    // Auto-mark complete when user finishes all 3 tabs (reaches Q&A tab)
    if (_tabController.index == 2 && !_topicMarkedComplete) {
      _markTopicComplete();
    }
  }

  Future<void> _markTopicComplete() async {
    final uid = context.read<ap.AuthProvider>().firebaseUser?.uid;
    if (uid == null) return;
    _topicMarkedComplete = true;
    await FirestoreService().markTopicComplete(
      uid: uid,
      className: widget.classModel.label,
      subjectName: widget.subject.name,
      topicName: widget.topic,
      quizScore: _mcqs.isEmpty ? 100 : (_mcqScore * 100) ~/ _mcqs.length,
      totalQuestions: _mcqs.length,
      correctCount: _mcqScore,
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(children: [Text('✅ Topic completed! +10 points')]),
          backgroundColor: Color(0xFF4CAF50),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            backgroundColor: _color,
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
                    colors: [_color, _color.withValues(alpha: 0.7)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 48, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.subject.emoji,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.topic,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.subject.name} · ${widget.classModel.label}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _CountChip(
                              label: '${_mcqs.length} MCQ',
                              color: _color,
                            ),
                            const SizedBox(width: 8),
                            _CountChip(
                              label: '${_fillups.length} Fill-ups',
                              color: _color,
                            ),
                            const SizedBox(width: 8),
                            _CountChip(
                              label: '${_qnas.length} Q&A',
                              color: _color,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              tabs: const [
                Tab(text: '🔘  MCQ'),
                Tab(text: '✏️  Fill-ups'),
                Tab(text: '💬  Q & A'),
              ],
            ),
          ),
        ],
        body: _allQuestions.isEmpty
            ? _buildComingSoon()
            : TabBarView(
                controller: _tabController,
                children: [
                  _MCQTab(questions: _mcqs, color: _color),
                  _FillupTab(questions: _fillups, color: _color),
                  _QnATab(questions: _qnas, color: _color),
                ],
              ),
      ),
    );
  }

  Widget _buildComingSoon() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('📝', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 16),
          Text(
            'Questions Coming Soon!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for practice questions.',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MCQ TAB
// ─────────────────────────────────────────────
class _MCQTab extends StatefulWidget {
  final List<Question> questions;
  final Color color;
  const _MCQTab({required this.questions, required this.color});

  @override
  State<_MCQTab> createState() => _MCQTabState();
}

class _MCQTabState extends State<_MCQTab> {
  final Map<int, int?> _selected = {};
  final Map<int, bool> _revealed = {};
  int get _score => _selected.entries.where((e) {
    final q = widget.questions[e.key];
    return e.value == q.correctIndex;
  }).length;

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return _empty('No MCQ questions for this topic yet.');
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.questions.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ScoreBanner(
              score: _score,
              total: widget.questions.length,
              color: widget.color,
            ),
          );
        }
        final idx = i - 1;
        final q = widget.questions[idx];
        return _MCQCard(
          question: q,
          index: idx,
          selectedOption: _selected[idx],
          revealed: _revealed[idx] ?? false,
          color: widget.color,
          onSelect: (opt) => setState(() => _selected[idx] = opt),
          onReveal: () => setState(() => _revealed[idx] = true),
        );
      },
    );
  }
}

class _MCQCard extends StatelessWidget {
  final Question question;
  final int index;
  final int? selectedOption;
  final bool revealed;
  final Color color;
  final ValueChanged<int> onSelect;
  final VoidCallback onReveal;

  const _MCQCard({
    required this.question,
    required this.index,
    required this.selectedOption,
    required this.revealed,
    required this.color,
    required this.onSelect,
    required this.onReveal,
  });

  @override
  Widget build(BuildContext context) {
    final options = question.options ?? [];
    final answered = selectedOption != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Q${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    question.question,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Options
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: List.generate(options.length, (i) {
                Color optColor = Colors.grey[100]!;
                Color borderColor = Colors.grey[300]!;
                Color textColor = Colors.grey[800]!;
                IconData? icon;
                if (answered || revealed) {
                  if (i == question.correctIndex) {
                    optColor = Colors.green[50]!;
                    borderColor = Colors.green;
                    textColor = Colors.green[800]!;
                    icon = Icons.check_circle_rounded;
                  } else if (i == selectedOption &&
                      i != question.correctIndex) {
                    optColor = Colors.red[50]!;
                    borderColor = Colors.red;
                    textColor = Colors.red[800]!;
                    icon = Icons.cancel_rounded;
                  }
                } else if (selectedOption == i) {
                  optColor = color.withValues(alpha: 0.1);
                  borderColor = color;
                  textColor = color;
                }
                return GestureDetector(
                  onTap: answered || revealed ? null : () => onSelect(i),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: optColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: borderColor, width: 1.5),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + i),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: borderColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            options[i],
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (icon != null)
                          Icon(
                            icon,
                            color: i == question.correctIndex
                                ? Colors.green
                                : Colors.red,
                            size: 18,
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          // Hint & explanation
          if (!answered && !revealed)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: _HintButton(
                hint: question.hint,
                color: color,
                onReveal: onReveal,
              ),
            ),
          if (answered || revealed)
            _ExplanationBox(explanation: question.explanation, color: color),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FILL-UPS TAB
// ─────────────────────────────────────────────
class _FillupTab extends StatefulWidget {
  final List<Question> questions;
  final Color color;
  const _FillupTab({required this.questions, required this.color});

  @override
  State<_FillupTab> createState() => _FillupTabState();
}

class _FillupTabState extends State<_FillupTab> {
  final Map<int, TextEditingController> _controllers = {};
  final Map<int, bool?> _results =
      {}; // true=correct, false=wrong, null=not checked
  final Map<int, bool> _hintShown = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.questions.length; i++) {
      _controllers[i] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _check(int idx) {
    final input = _controllers[idx]!.text.trim().toLowerCase();
    final answer = widget.questions[idx].answer.trim().toLowerCase();
    setState(() => _results[idx] = input == answer || answer.contains(input));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return _empty('No fill-in-the-blank questions for this topic yet.');
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.questions.length,
      itemBuilder: (context, idx) {
        final q = widget.questions[idx];
        final result = _results[idx];
        final hintShown = _hintShown[idx] ?? false;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.08),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${idx + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        q.question,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controllers[idx],
                            enabled: result == null,
                            decoration: InputDecoration(
                              hintText: 'Type your answer...',
                              filled: true,
                              fillColor: result == null
                                  ? Colors.grey[50]
                                  : (result == true)
                                  ? Colors.green[50]
                                  : Colors.red[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: result == null
                                      ? Colors.grey[300]!
                                      : (result == true)
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: widget.color,
                                  width: 2,
                                ),
                              ),
                              suffixIcon: result != null
                                  ? Icon(
                                      (result == true)
                                          ? Icons.check_circle_rounded
                                          : Icons.cancel_rounded,
                                      color: (result == true)
                                          ? Colors.green
                                          : Colors.red,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (result == null)
                          ElevatedButton(
                            onPressed: () => _check(idx),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.color,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                            child: const Text('Check'),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (result == null && !hintShown)
                      _HintButton(
                        hint: q.hint,
                        color: widget.color,
                        onReveal: () => setState(() => _hintShown[idx] = true),
                      ),
                    if (result == null && hintShown)
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber[300]!),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.lightbulb_rounded,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                q.hint,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.amber[900],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (result != null) ...[
                      if (result == false)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green[300]!),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_rounded,
                                color: Colors.green,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Answer: ${q.answer}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      _ExplanationBox(
                        explanation: q.explanation,
                        color: widget.color,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// Q&A TAB
// ─────────────────────────────────────────────
class _QnATab extends StatefulWidget {
  final List<Question> questions;
  final Color color;
  const _QnATab({required this.questions, required this.color});

  @override
  State<_QnATab> createState() => _QnATabState();
}

class _QnATabState extends State<_QnATab> {
  final Set<int> _expanded = {};
  final Set<int> _hintShown = {};

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return _empty('No Q&A questions for this topic yet.');
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.questions.length,
      itemBuilder: (context, idx) {
        final q = widget.questions[idx];
        final isExpanded = _expanded.contains(idx);
        final hintShown = _hintShown.contains(idx);

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.vertical(
                    top: const Radius.circular(16),
                    bottom: isExpanded
                        ? Radius.zero
                        : const Radius.circular(16),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Q${idx + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        q.question,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Hint + Show Answer buttons
              if (!isExpanded)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hintShown)
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.amber[300]!),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.lightbulb_rounded,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  q.hint,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.amber[900],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Row(
                        children: [
                          if (!hintShown)
                            OutlinedButton.icon(
                              onPressed: () =>
                                  setState(() => _hintShown.add(idx)),
                              icon: const Icon(
                                Icons.lightbulb_outline_rounded,
                                size: 16,
                              ),
                              label: const Text('Get Hint'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.amber[700],
                                side: BorderSide(color: Colors.amber[400]!),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () => setState(() => _expanded.add(idx)),
                            icon: const Icon(
                              Icons.visibility_rounded,
                              size: 16,
                            ),
                            label: const Text('Show Answer'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.color,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              // Answer
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.task_alt_rounded,
                            color: widget.color,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Answer',
                            style: TextStyle(
                              color: widget.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        q.answer,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          height: 1.6,
                        ),
                      ),
                      _ExplanationBox(
                        explanation: q.explanation,
                        color: widget.color,
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () => setState(() => _expanded.remove(idx)),
                        icon: const Icon(
                          Icons.visibility_off_rounded,
                          size: 16,
                        ),
                        label: const Text('Hide Answer'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// SHARED WIDGETS
// ─────────────────────────────────────────────
class _HintButton extends StatefulWidget {
  final String hint;
  final Color color;
  final VoidCallback onReveal;
  const _HintButton({
    required this.hint,
    required this.color,
    required this.onReveal,
  });

  @override
  State<_HintButton> createState() => _HintButtonState();
}

class _HintButtonState extends State<_HintButton> {
  bool _shown = false;

  @override
  Widget build(BuildContext context) {
    if (_shown) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.amber[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.amber[300]!),
        ),
        child: Row(
          children: [
            const Icon(Icons.lightbulb_rounded, color: Colors.amber, size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                widget.hint,
                style: TextStyle(fontSize: 13, color: Colors.amber[900]),
              ),
            ),
          ],
        ),
      );
    }
    return OutlinedButton.icon(
      onPressed: () {
        setState(() => _shown = true);
        widget.onReveal();
      },
      icon: const Icon(Icons.lightbulb_outline_rounded, size: 16),
      label: const Text('Get Hint'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.amber[700],
        side: BorderSide(color: Colors.amber[400]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class _ExplanationBox extends StatelessWidget {
  final String explanation;
  final Color color;
  const _ExplanationBox({required this.explanation, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              explanation,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreBanner extends StatelessWidget {
  final int score;
  final int total;
  final Color color;
  const _ScoreBanner({
    required this.score,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.emoji_events_rounded, color: color, size: 22),
          const SizedBox(width: 8),
          Text(
            'Score: $score / $total',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: color,
            ),
          ),
          const Spacer(),
          Text(
            'Answer all to see your score',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class _CountChip extends StatelessWidget {
  final String label;
  final Color color;
  const _CountChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

Widget _empty(String msg) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey[500], fontSize: 15),
      ),
    ),
  );
}
