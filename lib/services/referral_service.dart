import 'package:share_plus/share_plus.dart';
import '../constants/app_constants.dart';

class ReferralService {
  static String buildReferralLink(String referralCode) =>
      '${AppConstants.referralBaseUrl}$referralCode';

  Future<void> shareReferral({
    required String referralCode,
    required String userName,
  }) async {
    final link = buildReferralLink(referralCode);
    await Share.share(
      '🎒 Join me on DS Fun Learning!\n\n'
      'Use my referral code *$referralCode* while signing up '
      'and we both earn bonus points!\n\n'
      '👉 $link',
      subject: 'Learn with DS Fun Learning',
    );
  }
}
