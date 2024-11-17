import 'package:cloud_firestore/cloud_firestore.dart';

import '../src/user_entitiy.dart';

class PremiumService {
  final FirebaseFirestore firestore;

  PremiumService({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  /// Kullanıcının premium üyeliğe geçişini sağlar.
  Future<void> upgradeToPremium(String userId,
      {bool removeAds = false, bool extraFeatures = false}) async {
    try {
      // hasAdsRemoved alanını sadece diğer iki özellikten biri aktif olduğunda aç
      bool hasAdsRemoved = (removeAds || extraFeatures);

      // Kullanıcı verisini güncelle
      await firestore.collection('users').doc(userId).update({
        'hasAdsRemoved': hasAdsRemoved,
        'hasExtraFeatures': extraFeatures,
        'hasFullAccess': true, // Tüm premium özelliklere erişim sağla
      });
    } catch (e) {
      // Hata durumunda burada gerekli işlemleri yapabilirsiniz.
      print('Premium geçişinde hata: $e');
    }
  }

  /// Kullanıcının premium üyeliğini iptal eder.
  Future<void> downgradeFromPremium(String userId) async {
    try {
      // Kullanıcı verisini güncelle
      await firestore.collection('users').doc(userId).update({
        'hasAdsRemoved': false,
        'hasExtraFeatures': false,
        'hasFullAccess': false, // Premium özellikleri iptal et
      });
    } catch (e) {
      // Hata durumunda burada gerekli işlemleri yapabilirsiniz.
      print('Premium iptalinde hata: $e');
    }
  }

  /// Kullanıcı bilgilerini al
  Future<UserModelEntity> getUser(String userId) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModelEntity.fromDocument(doc.data() as Map<String, dynamic>);
      } else {
        throw Exception('Kullanıcı bulunamadı');
      }
    } catch (e) {
      // Hata durumunda burada gerekli işlemleri yapabilirsiniz.
      print('Kullanıcı bilgilerini alırken hata: $e');
      rethrow;
    }
  }
}
