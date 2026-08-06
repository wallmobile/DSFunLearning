import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String referralCode;
  final String? referredBy;
  final int totalPoints;
  final int streak;
  final DateTime? lastActive;
  final List<String> completedTopics; // "className|subjectName|topicName"
  final List<String> completedSubjects; // "className|subjectName"
  final List<String> earnedCertificates;
  final bool isAdmin;
  final DateTime createdAt;
  final int totalQuizzes;
  final int correctAnswers;
  final int totalVideosWatched;
  final int referralCount;

  const UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.referralCode,
    this.referredBy,
    this.totalPoints = 0,
    this.streak = 0,
    this.lastActive,
    this.completedTopics = const [],
    this.completedSubjects = const [],
    this.earnedCertificates = const [],
    this.isAdmin = false,
    required this.createdAt,
    this.totalQuizzes = 0,
    this.correctAnswers = 0,
    this.totalVideosWatched = 0,
    this.referralCount = 0,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: d['email'] ?? '',
      displayName: d['displayName'] ?? '',
      photoUrl: d['photoUrl'],
      referralCode: d['referralCode'] ?? '',
      referredBy: d['referredBy'],
      totalPoints: d['totalPoints'] ?? 0,
      streak: d['streak'] ?? 0,
      lastActive: (d['lastActive'] as Timestamp?)?.toDate(),
      completedTopics: List<String>.from(d['completedTopics'] ?? []),
      completedSubjects: List<String>.from(d['completedSubjects'] ?? []),
      earnedCertificates: List<String>.from(d['earnedCertificates'] ?? []),
      isAdmin: d['isAdmin'] ?? false,
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      totalQuizzes: d['totalQuizzes'] ?? 0,
      correctAnswers: d['correctAnswers'] ?? 0,
      totalVideosWatched: d['totalVideosWatched'] ?? 0,
      referralCount: d['referralCount'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'email': email,
    'displayName': displayName,
    'photoUrl': photoUrl,
    'referralCode': referralCode,
    'referredBy': referredBy,
    'totalPoints': totalPoints,
    'streak': streak,
    'lastActive': lastActive != null ? Timestamp.fromDate(lastActive!) : null,
    'completedTopics': completedTopics,
    'completedSubjects': completedSubjects,
    'earnedCertificates': earnedCertificates,
    'isAdmin': isAdmin,
    'createdAt': Timestamp.fromDate(createdAt),
    'totalQuizzes': totalQuizzes,
    'correctAnswers': correctAnswers,
    'totalVideosWatched': totalVideosWatched,
    'referralCount': referralCount,
  };

  UserModel copyWith({
    String? displayName,
    String? photoUrl,
    int? totalPoints,
    int? streak,
    DateTime? lastActive,
    List<String>? completedTopics,
    List<String>? completedSubjects,
    List<String>? earnedCertificates,
    int? totalQuizzes,
    int? correctAnswers,
    int? totalVideosWatched,
    int? referralCount,
  }) => UserModel(
    uid: uid,
    email: email,
    displayName: displayName ?? this.displayName,
    photoUrl: photoUrl ?? this.photoUrl,
    referralCode: referralCode,
    referredBy: referredBy,
    totalPoints: totalPoints ?? this.totalPoints,
    streak: streak ?? this.streak,
    lastActive: lastActive ?? this.lastActive,
    completedTopics: completedTopics ?? this.completedTopics,
    completedSubjects: completedSubjects ?? this.completedSubjects,
    earnedCertificates: earnedCertificates ?? this.earnedCertificates,
    isAdmin: isAdmin,
    createdAt: createdAt,
    totalQuizzes: totalQuizzes ?? this.totalQuizzes,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    totalVideosWatched: totalVideosWatched ?? this.totalVideosWatched,
    referralCount: referralCount ?? this.referralCount,
  );

  double get quizAccuracy =>
      totalQuizzes == 0 ? 0 : (correctAnswers / totalQuizzes) * 100;

  String topicKey(String className, String subject, String topic) =>
      '$className|$subject|$topic';

  String subjectKey(String className, String subject) => '$className|$subject';
}
