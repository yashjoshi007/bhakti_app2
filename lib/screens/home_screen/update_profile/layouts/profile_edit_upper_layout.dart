import 'package:bhakti_app/config.dart';

class ProfileEditUpperLayout extends StatelessWidget {
  const ProfileEditUpperLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      UpdateProfilePicture(),
      UpdateNameTextBox(),
      UpdateDateOfBirthBox(),
      UpdateGenderRadioBox(),
      UpdateEmailTextBox(),
      UpdatePhoneNumberTextBox(),
      UpdateCountryDropDownBox(),
      UpdateStateTextFieldBox()
    ]);
  }
}
