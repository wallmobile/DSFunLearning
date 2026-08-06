import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_constants.dart';
import '../models/user_model.dart';
import '../models/certificate_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ── User Documents ────────────────────────────────────────────────────────
  Future<void> createUserDocument({
    required String uid,
    required String email,
    required String displayName,
    String? photoUrl,
    String? referredBy,
  }) async {
    final isAdmin =
        email.toLowerCase() == AppConstants.adminEmail.toLowerCase();
    final referralCode = const Uuid().v4().substring(0, 8).toUpperCase();

    await _db.collection(AppConstants.usersCollection).doc(uid).set({
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'referralCode': referralCode,
      'referredBy': referredBy,
      'totalPoints': 0,
      'streak': 1,
      'lastActive': FieldValue.serverTimestamp(),
      'completedTopics': [],
      'completedSubjects': [],
      'earnedCertificates': [],
      'isAdmin': isAdmin,
      'createdAt': FieldValue.serverTimestamp(),
      'totalQuizzes': 0,
      'correctAnswers': 0,
      'totalVideosWatched': 0,
      'referralCount': 0,
    });

    // Credit referrer if valid code provided
    if (referredBy != null && referredBy.isNotEmpty) {
      await _applyReferral(uid, referredBy);
    }
  }

  Future<void> _applyReferral(String newUserId, String referralCode) async {
    final query = await _db
        .collection(AppConstants.usersCollection)
        .where('referralCode', isEqualTo: referralCode)
        .limit(1)
        .get();
    if (query.docs.isEmpty) return;
    final referrerId = query.docs.first.id;
    if (referrerId == newUserId) return;

    await _db.collection(AppConstants.usersCollection).doc(referrerId).update({
      'totalPoints': FieldValue.increment(AppConstants.pointsPerReferral),
      'referralCount': FieldValue.increment(1),
    });
  }

  Stream<UserModel?> userStream(String uid) {
    return _db
        .collection(AppConstants.usersCollection)
        .doc(uid)
        .snapshots()
        .map((doc) => doc.exists ? UserModel.fromFirestore(doc) : null);
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db
        .collection(AppConstants.usersCollection)
        .doc(uid)
        .get();
    return doc.exists ? UserModel.fromFirestore(doc) : null;
  }

  Future<void> updateLastActive(String uid) async {
    final doc = await _db
        .collection(AppConstants.usersCollection)
        .doc(uid)
        .get();
    if (!doc.exists) return;

    final lastActive = (doc.data()!['lastActive'] as Timestamp?)?.toDate();
    final now = DateTime.now();
    final isNewDay =
        lastActive == null || now.difference(lastActive).inHours >= 24;

    final updates = <String, dynamic>{
      'lastActive': FieldValue.serverTimestamp(),
    };
    if (isNewDay) {
      updates['streak'] = FieldValue.increment(1);
      updates['totalPoints'] = FieldValue.increment(
        AppConstants.pointsPerDailyLogin,
      );
    }
    await _db.collection(AppConstants.usersCollection).doc(uid).update(updates);
  }

  Future<void> updateProfile({
    required String uid,
    String? displayName,
    String? photoUrl,
  }) async {
    final updates = <String, dynamic>{};
    if (displayName != null) updates['displayName'] = displayName;
    if (photoUrl != null) updates['photoUrl'] = photoUrl;
    if (updates.isNotEmpty) {
      await _db
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .update(updates);
    }
  }

  // ── Progress Tracking ─────────────────────────────────────────────────────
  Future<void> markTopicComplete({
    required String uid,
    required String className,
    required String subjectName,
    required String topicName,
    required int quizScore,
    required int totalQuestions,
    required int correctCount,
  }) async {
    final topicKey = '$className|$subjectName|$topicName';
    await _db.collection(AppConstants.usersCollection).doc(uid).update({
      'completedTopics': FieldValue.arrayUnion([topicKey]),
      'totalPoints': FieldValue.increment(AppConstants.pointsPerTopicComplete),
      'totalQuizzes': FieldValue.increment(totalQuestions),
      'correctAnswers': FieldValue.increment(correctCount),
    });
  }

  Future<bool> markSubjectComplete({
    required String uid,
    required String className,
    required String subjectName,
    required String subjectEmoji,
    required int totalTopics,
    required String userName,
    required String userEmail,
  }) async {
    final subjectKey = '$className|$subjectName';
    final userData = await _db
        .collection(AppConstants.usersCollection)
        .doc(uid)
        .get();
    if (!userData.exists) return false;

    final completed = List<String>.from(
      userData.data()!['completedSubjects'] ?? [],
    );
    if (completed.contains(subjectKey)) return false; // Already done

    await _db.collection(AppConstants.usersCollection).doc(uid).update({
      'completedSubjects': FieldValue.arrayUnion([subjectKey]),
      'totalPoints': FieldValue.increment(
        AppConstants.pointsPerSubjectComplete,
      ),
    });

    // Issue certificate
    await issueCertificate(
      uid: uid,
      userName: userName,
      userEmail: userEmail,
      className: className,
      subjectName: subjectName,
      subjectEmoji: subjectEmoji,
      totalTopics: totalTopics,
    );
    return true;
  }

  // ── Certificates ─────────────────────────────────────────────────────────
  Future<void> issueCertificate({
    required String uid,
    required String userName,
    required String userEmail,
    required String className,
    required String subjectName,
    required String subjectEmoji,
    required int totalTopics,
    int score = 100,
  }) async {
    final certKey = '$className|$subjectName';
    // Check not already issued
    final existing = await _db
        .collection(AppConstants.certificatesCollection)
        .where('userId', isEqualTo: uid)
        .where('className', isEqualTo: className)
        .where('subjectName', isEqualTo: subjectName)
        .limit(1)
        .get();
    if (existing.docs.isNotEmpty) return;

    final certRef = _db.collection(AppConstants.certificatesCollection).doc();
    final cert = CertificateModel(
      id: certRef.id,
      userId: uid,
      userName: userName,
      userEmail: userEmail,
      className: className,
      subjectName: subjectName,
      subjectEmoji: subjectEmoji,
      issuedAt: DateTime.now(),
      score: score,
      totalTopics: totalTopics,
    );
    await certRef.set(cert.toFirestore());

    await _db.collection(AppConstants.usersCollection).doc(uid).update({
      'earnedCertificates': FieldValue.arrayUnion([certKey]),
      'totalPoints': FieldValue.increment(AppConstants.pointsPerCertificate),
    });
  }

  Stream<List<CertificateModel>> userCertificatesStream(String uid) {
    return _db
        .collection(AppConstants.certificatesCollection)
        .where('userId', isEqualTo: uid)
        .orderBy('issuedAt', descending: true)
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((d) => CertificateModel.fromFirestore(d)).toList(),
        );
  }

  Future<List<CertificateModel>> getUserCertificates(String uid) async {
    final snap = await _db
        .collection(AppConstants.certificatesCollection)
        .where('userId', isEqualTo: uid)
        .orderBy('issuedAt', descending: true)
        .get();
    return snap.docs.map((d) => CertificateModel.fromFirestore(d)).toList();
  }

  // ── Leaderboard ───────────────────────────────────────────────────────────
  Stream<List<UserModel>> leaderboardStream({int limit = 100}) {
    return _db
        .collection(AppConstants.usersCollection)
        .orderBy('totalPoints', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snap) => snap.docs.map((d) => UserModel.fromFirestore(d)).toList(),
        );
  }

  // ── Admin ─────────────────────────────────────────────────────────────────
  Stream<List<UserModel>> allUsersStream() {
    return _db
        .collection(AppConstants.usersCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs.map((d) => UserModel.fromFirestore(d)).toList(),
        );
  }

  Future<void> setAdminStatus(String uid, bool isAdmin) async {
    await _db.collection(AppConstants.usersCollection).doc(uid).update({
      'isAdmin': isAdmin,
    });
  }

  Future<void> postAnnouncement({
    required String title,
    required String body,
    required String adminUid,
  }) async {
    await _db.collection(AppConstants.announcementsCollection).add({
      'title': title,
      'body': body,
      'postedBy': adminUid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> announcementsStream() {
    return _db
        .collection(AppConstants.announcementsCollection)
        .orderBy('createdAt', descending: true)
        .limit(20)
        .snapshots()
        .map(
          (snap) => snap.docs.map((d) => {'id': d.id, ...d.data()}).toList(),
        );
  }

  // ── Video links (admin managed) ───────────────────────────────────────────
  Future<void> setVideoId({
    required String subject,
    required String topic,
    required String videoId,
    required String title,
  }) async {
    final key = '${subject}__$topic';
    await _db.collection(AppConstants.videosCollection).doc(key).set({
      'subject': subject,
      'topic': topic,
      'videoId': videoId,
      'title': title,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> getVideoId(String subject, String topic) async {
    final key = '${subject}__$topic';
    final doc = await _db
        .collection(AppConstants.videosCollection)
        .doc(key)
        .get();
    return doc.exists ? doc.data()!['videoId'] as String? : null;
  }
}
