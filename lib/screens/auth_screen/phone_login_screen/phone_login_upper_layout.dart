import 'package:bhakti_app/config.dart';

class PhoneLoginUpperLayout extends StatelessWidget {
  const PhoneLoginUpperLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhoneLoginProvider>(
        builder: (context, phoneLoginPvr, child) {
      return Column(children: [
        PhoneLoginWidget().buildLogoAndText(context),
        VSpace(MediaQuery.of(context).size.height * 0.2),
        PhoneLoginWidget().buildPhoneNumberInput(phoneLoginPvr, context)
      ]);
    });
  }
}
