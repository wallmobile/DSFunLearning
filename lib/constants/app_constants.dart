class AppConstants {
  // Points system
  static const int pointsPerTopicComplete = 10;
  static const int pointsPerSubjectComplete = 50;
  static const int pointsPerCertificate = 200;
  static const int pointsPerReferral = 100;
  static const int pointsPerQuizPerfect = 30;
  static const int pointsPerDailyLogin = 5;

  // Admin email
  static const String adminEmail = 'developer.techotd@gmail.com';

  // Firestore collections
  static const String usersCollection = 'users';
  static const String certificatesCollection = 'certificates';
  static const String leaderboardCollection = 'leaderboard';
  static const String referralsCollection = 'referrals';
  static const String videosCollection = 'videos';
  static const String announcementsCollection = 'announcements';

  // Theme colours
  static const int primaryColor = 0xFF4A6CF7;
  static const int secondaryColor = 0xFF6A3DE8;
  static const int accentGold = 0xFFFFC107;
  static const int bgColor = 0xFFF5F7FF;

  // Referral
  static const String referralBaseUrl = 'https://dsfunlearning.app/invite/';
}
