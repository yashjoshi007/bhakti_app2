import 'package:bhakti_app/config.dart';

class ProfileEditBottomLayout extends StatelessWidget {
  const ProfileEditBottomLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context, updateProfilePvr, child) {
      return Column(children: [
        const UpdateCityTextFieldBox(),
        const UpdateYatraNameTextBox(),
        const UpdateInitiatedStatusBox(),
        updateProfilePvr.isInitiated == true
            ? const UpdateInitiatedNameTextBox()
            : Container(),
        const UpdateSpiritualMasterBox(),
        const UpdateInitiatedDateBox(),
        const UpdateMaritalStatusBox()
      ]);
    });
  }
}
