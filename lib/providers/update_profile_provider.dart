import 'dart:developer';
import 'package:bhakti_app/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UpdateProfileProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController yatraName = TextEditingController();
  TextEditingController initiatedName = TextEditingController();
  TextEditingController initiationDate = TextEditingController();
  TextEditingController message = TextEditingController();
  final ImagePicker picker = ImagePicker();
  int selectedGender = 1;
  int selectedMarital = 1;
  String imagePath = "", downloadUrl = "";
  bool showError = false,
      validStatus = false,
      textError = false,
      imgStatus = false,
      valueFirst = true,
      isLoading = false,
      isInitiated = false,
      isButtonDisabled = false;
  XFile? image;
  final focusNode = FocusNode();
  CountryCode? countryCode;
  String? nameValid,
      dateValid,
      emailValid,
      phoneNumberValid,
      stateValid,
      cityValid,
      yatraNameValid,
      initiatedNameValid,
      initiatedDateValid,
      code,
      spiritualSelectedItems,
      userProfilePictureUrl,
      appVersion;
  final formKey = GlobalKey<FormState>();
  List<String> items = [];
  dynamic countrySelected;
  SharedPreferences? preferences;
  UserModel? userModel;
  List countryItems = [];
  List<String>? splitPhoneNum;

  Future<void> fetchSpiritualMasters() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ));
      await remoteConfig.fetchAndActivate();
      String getLinkOfDrawerURL = remoteConfig.getString('SpiritualMasters');

      // Parse the JSON string into a dynamic object
      dynamic jsonResult = jsonDecode(getLinkOfDrawerURL);

      // Check if the parsed JSON is a List<dynamic>
      if (jsonResult is List<dynamic>) {
        // Extract the names from the parsed JSON
        List<String> spiritualMasters = jsonResult
            .map((item) => item['spiritual_master_name'] as String)
            .toList();

        items = spiritualMasters;

        log('items $items');
        log('spiritualMasters $spiritualMasters');
        notifyListeners();
      } else {
        log('Error: JSON result is not a list');
      }
    } catch (e) {
      log('Error fetching remote config: $e');
    }
  }

  spiritualOnChanged(String? newValue) {
    spiritualSelectedItems = newValue;
    notifyListeners();
  }

  Future<String?> getDefaultPic(context) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 5)));
      await remoteConfig.fetchAndActivate();

      String defaultUserProfilePictureUrl =
          remoteConfig.getString('DefaultProfilePicture');
      userProfilePictureUrl = defaultUserProfilePictureUrl;
      return userProfilePictureUrl;
    } catch (e) {
      log('Error fetching remote config: $e');
      return language(context, appFonts.errorFetchingRemoteConfig);
    }
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString(eJsonAssets.countries);

    final data = await json.decode(response);

    countryItems = data;
    countrySelected = countryItems[0];
    notifyListeners();
  }

  Future<String> resizeAndEncodeImage(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;
    img.Image resizedImage = img.copyResize(image, width: 512, height: 512);
    List<int> resizedImageBytes = img.encodePng(resizedImage);
    return base64Encode(resizedImageBytes);
  }

  Future<void> saveData(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (formKey.currentState!.validate()) {
      showLoading(context);
      isLoading = true;
      notifyListeners();
      try {
        String newUrl = "";
        if (image != null) {
          String base64Image = await resizeAndEncodeImage(File(image!.path));
          newUrl = base64Image;
          Reference reference =
              FirebaseStorage.instance.ref().child(image!.name);
          var file = File(image!.path);
          UploadTask uploadTask = reference.putFile(file);
          await uploadTask.then((res) async {
            await res.ref.getDownloadURL().then((images) async {
              newUrl = images;
              notifyListeners();
            }, onError: (err) {});
          });
        }
        final countrySelectedCode = countrySelected['code'];
        Map<String, dynamic> body = {
          "name": name.text,
          "date_of_birth": dob.text,
          "gender": selectedGender == 1 ? "male" : "female",
          "email": emailId.text,
          "mobile_number":
              phoneNum.text.isNotEmpty ? "$countryCode-${phoneNum.text}" : null,
          "country": countrySelectedCode,
          "state": state.text,
          "city": city.text,
          "yatra_name": yatraName.text,
          "initiated": isInitiated,
          "initiated_name": initiatedName.text,
          "spiritual_master": spiritualSelectedItems,
          "intitiation_date": initiationDate.text,
          "marital_status": selectedMarital == 1 ? "married" : "unmarried",
          "profile_picture_url": newUrl == "" ? downloadUrl : newUrl
        };
        await apiServices
            .postApi(context, api.profileUpdate, body, isToken: true)
            .then((value) async {
          hideLoading(context);

          isLoading = false;
          notifyListeners();
          if (value.isSuccess!) {
            pref.setString(session.user,
                json.encode(UserModel.fromJson(value.data['data'])));
            userModel = UserModel.fromJson(value.data['data']);
            notifyListeners();
            newUrl = "";
            image = null;
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              value.message,
              style: appCss.dmDenseBlack16
                  .textColor(appColor(context).appTheme.black),
            )));
          }
        });
      } catch (e) {
        isLoading = false;
        hideLoading(context);
        notifyListeners();
        log("CATCH : $e");
      }
    }
  }

  cameraButton(context) async {
    Navigator.pop(context);
    image = await picker.pickImage(source: ImageSource.camera);
    imagePath = image!.path;
    imgStatus = true;
    notifyListeners();
  }

  cityTextField(value) {
    if (value!.isNotEmpty) {
      cityValid = null;
      notifyListeners();
      return null;
    }
  }

  dobValidator(value) {
    if (value!.isNotEmpty) {
      dateValid = null;
      notifyListeners();
      return null;
    }
  }

  femaleGender(value) {
    selectedGender = value!;
    notifyListeners();
  }

  initiatedDateValidator(value) {
    if (value!.isNotEmpty) {
      initiatedDateValid = null;
      notifyListeners();
      return null;
    }
  }

  initiatedNameValidator(value) {
    if (value!.isNotEmpty) {
      initiatedNameValid = null;
      notifyListeners();
      return null;
    }
  }

  // Function to update marital status
  void maritalStatusChanged(int? newValue) {
    selectedMarital = newValue!;
    notifyListeners(); // Notify listeners to update UI
  }

  nameTextField(value, context) {
    if (value!.isEmpty) {
      nameValid = language(context, appFonts.enterCorrectName);
      notifyListeners();
      return language(context, appFonts.enterCorrectName);
    } else {
      nameValid = null;
      notifyListeners();
      return null;
    }
  }

  phoneNumberValidator(value) {
    if (value!.isNotEmpty) {
      phoneNumberValid = null;
      notifyListeners();
      return null;
    }
    return null;
  }

  countryCodeOnChanged(value) {
    log('message $value');
    countryCode = value;
    notifyListeners();
  }

  selectState(value) {
    if (value!.isNotEmpty) {
      stateValid = null;
      notifyListeners();
      return null;
    }
  }

  yatraNameValidator(value) {
    if (value!.isNotEmpty) {
      yatraNameValid = null;
      notifyListeners();
      return null;
    }
  }

  profilePicUpdate(context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              children: [
                ListTile(
                    onTap: () => cameraButton(context),
                    title: Text(language(context, appFonts.camera),
                        style: appCss.dmDenseRegular14
                            .textColor(appColor(context).appTheme.black)),
                    leading: Icon(Icons.camera_alt,
                        color: appColor(context).appTheme.black)),
                ListTile(
                    onTap: () => galleryButton(context),
                    title: Text(language(context, appFonts.gallery),
                        style: appCss.dmDenseRegular14
                            .textColor(appColor(context).appTheme.black)),
                    leading: Icon(Icons.image,
                        color: appColor(context).appTheme.black))
              ]);
        });
  }

  maleGender(value) {
    selectedGender = value!;
    notifyListeners();
  }

  yesInitiated(value) {
    isInitiated = value;
    notifyListeners();
  }

  noInitiated(value) {
    isInitiated = value;
    notifyListeners();
  }

  emailValidator(value, context) {
    if (value!.isNotEmpty &&
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      emailValid = language(context, appFonts.enterValidEmail);
      notifyListeners();
      return language(context, appFonts.enterValidEmail);
    }
  }

  void validateEmail(String value, BuildContext context) {
    final validationMessage = emailValidator(value, context);
    if (emailValid != validationMessage) {
      emailValid = validationMessage;
      notifyListeners();
    }
  }

  final DateRangePickerController pickerController =
      DateRangePickerController();

  dobTextPicker(context) {}

  selectCountry(value) {
    countrySelected = value;
    log('countrySelected ${countrySelected['code']}');
    notifyListeners();
  }

  galleryButton(context) async {
    Navigator.pop(context);
    image = await picker.pickImage(source: ImageSource.gallery);
    imagePath = image!.path;
    imgStatus = true;
    notifyListeners();
  }

  onReady(context) async {
    getDefaultPic(context);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    appVersion = version;
    readJson();
    // saveData(context);

    fetchSpiritualMasters();
    notifyListeners();
    preferences = await SharedPreferences.getInstance();
    await Future.delayed(DurationsClass.s1);
    userModel =
        UserModel.fromJson(json.decode(preferences!.getString(session.user)!));
    downloadUrl = userModel!.profilePictureUrl ?? "";
    name.text = userModel!.name ?? "";
    dob.text = userModel!.dateOfBirth ?? "";
    selectedGender = userModel!.gender != null
        ? userModel!.gender == "male"
            ? 1
            : 2
        : 1;
    emailId.text = userModel!.email ?? "";
    String phone = userModel!.mobileNumber ?? "";
    int index = countryItems.indexWhere((element) {
      return element['code'] == userModel!.country;
    });
    countrySelected =
        userModel!.country != null ? countryItems[index] : countryItems[0];
    state.text = userModel!.state ?? "";
    city.text = userModel!.city ?? "";
    yatraName.text = userModel!.yatraName ?? "";
    initiatedName.text = userModel!.initiatedName ?? "";
    isInitiated = userModel!.initiated ?? true;
    initiationDate.text = userModel!.intitiationDate ?? "";
    spiritualSelectedItems =
        userModel!.spiritualMaster ?? userModel!.spiritualMaster![0];
    selectedMarital = userModel!.maritalStatus != null
        ? userModel!.maritalStatus == "married"
            ? 1
            : 2
        : 1;

    countryCode = CountryCode(dialCode: phone.split("-")[0]);
    if (phone != "") {
      phoneNum.text = phone.split("-")[1];
    }

    notifyListeners();
  }

  void onSubmit(BuildContext context) {
    isButtonDisabled = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      isButtonDisabled = false;
      notifyListeners();
    });
    contactUs(context);
    notifyListeners();
  }

  contactUs(context) async {
    if (message.text.isNotEmpty || emailId.text.isNotEmpty) {
      Map body = {
        "email": emailId.text,
        "message": message.text,
        "app_version": appVersion
      };
      await apiServices
          .postApi(context, api.contactUs, body, isToken: true)
          .then((value) async {
        if (message.text.isNotEmpty) {
          if (value.isSuccess!) {
            notifyListeners();
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return Dialog(
                      insetPadding:
                          const EdgeInsets.symmetric(horizontal: Sizes.s10),
                      backgroundColor: appColor(context).appTheme.trans,
                      alignment: Alignment.center,
                      child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.4,
                          padding: const EdgeInsets.all(Insets.i10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                              color: appColor(context).appTheme.whiteColor),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(language(context, appFonts.alert),
                                    style: appCss.philosopherBold28.textColor(
                                        appColor(context).appTheme.oneText)),
                                Text(
                                    textAlign: TextAlign.center,
                                    language(context, value.message),
                                    style: appCss.dmDenseRegular16.textColor(
                                        appColor(context).appTheme.lightText)),
                                const VSpace(Insets.i20),
                                CommonButton(
                                    onTap: () => Navigator.pop(context),
                                    width: Insets.i80,
                                    text: language(context, appFonts.ok))
                              ])));
                });
            message.text = "";
          } else {
            showCustomSnackBar(context, language(context, value.message));
          }
        } else {
          showCustomSnackBar(
              context, language(context, appFonts.pleaseEnterMessage));
        }
      });
    } else {
      showCustomSnackBar(
          context, language(context, appFonts.pleaseEnterBothEmailAndMessage));
    }
  }

  void showCustomSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message,
            style: appCss.dmDenseRegular16
                .textColor(appColor(context).appTheme.black)),
        duration: const Duration(seconds: 3)));
  }
}
