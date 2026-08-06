import 'package:cloud_firestore/cloud_firestore.dart';

class CertificateModel {
  final String id;
  final String userId;
  final String userName;
  final String userEmail;
  final String className;
  final String subjectName;
  final String subjectEmoji;
  final DateTime issuedAt;
  final int score; // percentage 0-100
  final int totalTopics;

  const CertificateModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.className,
    required this.subjectName,
    required this.subjectEmoji,
    required this.issuedAt,
    required this.score,
    required this.totalTopics,
  });

  factory CertificateModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return CertificateModel(
      id: doc.id,
      userId: d['userId'] ?? '',
      userName: d['userName'] ?? '',
      userEmail: d['userEmail'] ?? '',
      className: d['className'] ?? '',
      subjectName: d['subjectName'] ?? '',
      subjectEmoji: d['subjectEmoji'] ?? '📚',
      issuedAt: (d['issuedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      score: d['score'] ?? 100,
      totalTopics: d['totalTopics'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'userId': userId,
    'userName': userName,
    'userEmail': userEmail,
    'className': className,
    'subjectName': subjectName,
    'subjectEmoji': subjectEmoji,
    'issuedAt': Timestamp.fromDate(issuedAt),
    'score': score,
    'totalTopics': totalTopics,
  };

  String get certificateKey => '$className|$subjectName';
}
