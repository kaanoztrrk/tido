import 'package:TiDo/common/widget/appbar/appbar.dart';
import 'package:TiDo/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final isTurkish = Localizations.localeOf(context).languageCode == 'tr';
    return Scaffold(
      body: ListView(
        children: [
          ViAppBar(
            centerTitle: true,
            showBackArrow: true,
            title: Text(AppLocalizations.of(context)!.privacy_policy),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                  children: [
                    TextSpan(
                        text: isTurkish
                            ? "Gizlilik Politikası\n"
                            : "Privacy Policy\n",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        text: isTurkish
                            ? "Bu gizlilik politikası, mobil cihazlar için geliştirilen TiDo uygulaması (bundan böyle 'Uygulama' olarak anılacaktır) için geçerlidir. Uygulama, Mehmet Kaan Öztürk (bundan böyle 'Hizmet Sağlayıcı' olarak anılacaktır) tarafından ücretsiz bir hizmet olarak oluşturulmuştur. Bu hizmet 'OLDUĞU GİBİ' kullanıma sunulmuştur.\n\n"
                            : "This privacy policy applies to the TiDo app (hereby referred to as 'Application') for mobile devices that was created by Mehmet Kaan Öztürk (hereby referred to as 'Service Provider') as a Free service. This service is intended for use 'AS IS'.\n\n"),
                    TextSpan(
                        text: isTurkish
                            ? "Bilgi Toplama ve Kullanım\n"
                            : "Information Collection and Use\n",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        text: isTurkish
                            ? "Uygulamayı indirdiğinizde ve kullandığınızda bazı bilgiler toplanabilir. Bu bilgiler şunları içerebilir:\nE-posta adresiniz\nAdınız\nGoogle Play giriş bilgileriniz\n\n"
                            : "The Application collects information when you download and use it. This information may include:\nYour email address\nYour name\nYour Google Play login information\n\n"),
                    TextSpan(
                        text: isTurkish ? "Veri Paylaşımı\n" : "Data Sharing\n",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        text: isTurkish
                            ? "Kişisel verileriniz kesinlikle üçüncü şahıslarla paylaşılmamaktadır. Veriler yalnızca uygulama içinde kullanılır ve herhangi bir dış kaynağa aktarılmaz.\n\n"
                            : "Your personal data is not shared with third parties. The data is used solely within the application and is not transferred to any external sources.\n\n"),
                    TextSpan(
                        text: isTurkish
                            ? "Veri Saklama Politikası\n"
                            : "Data Retention Policy\n",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        text: isTurkish
                            ? "Hizmet Sağlayıcı, kullanıcı tarafından sağlanan verileri uygulama kullanıldığı sürece ve makul bir süre boyunca saklar. Görevler şifrelenmiş şekilde güvenli bir şekilde saklanır. Eğer sağladığınız verilerin silinmesini isterseniz, lütfen info.theviacoder@gmail.com adresinden iletişime geçin.\n\n"
                            : "The Service Provider will retain User Provided data for as long as you use the Application and for a reasonable time thereafter. Tasks are securely stored in an encrypted form. If you'd like them to delete User Provided Data that you have provided via the Application, please contact them at info.theviacoder@gmail.com and they will respond in a reasonable time.\n\n"),
                    TextSpan(
                        text: isTurkish ? "İletişim\n" : "Contact Us\n",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        text: isTurkish
                            ? "Eğer uygulama kullanımı sırasında gizlilikle ilgili sorularınız varsa, lütfen bizimle iletişime geçin: "
                            : "If you have any questions regarding privacy while using the Application, please contact us: "),
                    TextSpan(
                      text: "info.theviacoder@gmail.com",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                        text: isTurkish
                            ? "\n\nVeri Güvenliği\n"
                            : "\n\nData Security\n",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        text: isTurkish
                            ? "Kişisel verilerinizin güvenliği bizim için çok önemlidir. Endüstri standartlarına uygun güvenlik önlemleri alınmıştır. Ancak, internet üzerinden veri iletiminin tamamen güvenli olduğunu garanti edemeyiz.\n\n"
                            : "The security of your personal data is very important to us. Industry-standard security measures have been implemented. However, we cannot guarantee that the data transmission over the internet is completely secure.\n\n"),
                    TextSpan(
                        text: isTurkish
                            ? "Çerezler ve İzleme Teknolojileri\n"
                            : "Cookies and Tracking Technologies\n",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        text: isTurkish
                            ? "Uygulama, kullanıcı deneyimini geliştirmek için çerezler veya diğer izleme teknolojileri kullanmamaktadır.\n\n"
                            : "The Application does not use cookies or other tracking technologies to improve user experience.\n\n"),
                    TextSpan(
                        text: isTurkish
                            ? "Uluslararası Veri Transferi\n"
                            : "International Data Transfer\n",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        text: isTurkish
                            ? "Verileriniz, herhangi bir yurtdışına transfer edilmez ve yalnızca bulunduğunuz bölgede saklanır.\n\n"
                            : "Your data is not transferred internationally and is stored only in your region.\n\n"),
                    TextSpan(
                        text: isTurkish
                            ? "Gizlilik Politikasındaki Değişiklikler\n"
                            : "Changes to the Privacy Policy\n",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        text: isTurkish
                            ? "Bu gizlilik politikasında herhangi bir değişiklik yapmamız durumunda, bu değişiklikler uygulamamızda yayımlanacaktır. Kullanıcıların, gizlilik politikasını düzenli olarak gözden geçirmeleri tavsiye edilir.\n\n"
                            : "If we make any changes to this privacy policy, those changes will be published in our Application. Users are advised to review the privacy policy regularly.\n\n"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
