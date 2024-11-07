import 'dart:developer';
import 'package:bhakti_app/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SetUpProfileProvider extends ChangeNotifier {
  final TextEditingController name = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController emailId = TextEditingController();
  final TextEditingController phoneNum = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController initiatedName = TextEditingController();
  final TextEditingController yatraName = TextEditingController();
  final TextEditingController initiatedDate = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final DateRangePickerController pickerController =
      DateRangePickerController();

  bool onChange = false;
  bool onChange1 = false;
  bool imgStatus = false;
  FirebaseStorage storage = FirebaseStorage.instance;

  XFile? image;
  int? selectedGender;
  int? selectedMarital;
  CountryCode? countryCode;

  String imagePath = "", downloadUrl = "";
  bool showError = false;
  bool validStatus = false;
  bool textError = false;
  bool value = false;
  bool valueFirst = true, isLoading = false;
  String? nameValid,
      dateValid,
      emailValid,
      phoneNumberValid,
      stateValid,
      cityValid,
      yatraNameValid,
      initiatedNameValid,
      initiatedDateValid;

  String? selectedItems;
  List<String> masterItems = [];

  final setupFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> setupScaffoldKey = GlobalKey<ScaffoldState>();
  List countryItems = [];
  dynamic countrySelected;
  SharedPreferences? preferences;
  UserModel? userModel;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/countries.json');
    final data = await json.decode(response);
    countryItems = data;
    countrySelected = countryItems[0];
    notifyListeners();
  }

  onPersonalInfoExpansionChanged() {
    notifyListeners();
    onChange = !onChange;
  }

  onContactInfoExpansionChanged() {
    onChange1 = !onChange1;
  }

  cityValidator(value) {
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

  maleGender(value) {
    selectedGender = value!;
    notifyListeners();
  }

  femaleGender(value) {
    selectedGender = value!;
    notifyListeners();
  }

  initiatedNameValidator(value) {
    if (value!.isNotEmpty) {
      initiatedNameValid = null;
      notifyListeners();
      return null;
    }
  }

  nameValidator(value, context) {
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

  phoneNumValidator(value) {
    if (value!.isNotEmpty) {
      phoneNumberValid = null;
      notifyListeners();
      return null;
    }
    return null;
  }

  phoneOnChanged(value, context) {
    countryCode = value;
    notifyListeners();
  }

  profilePicture(context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              children: [
                ListTile(
                    onTap: () async {
                      Navigator.pop(context);
                      image =
                          await picker.pickImage(source: ImageSource.camera);
                      imagePath = image!.path;
                      imgStatus = true;

                      notifyListeners();
                    },
                    title: Text(language(context, appFonts.camera),
                        style: appCss.dmDenseRegular14
                            .textColor(appColor(context).appTheme.black)),
                    leading: Icon(Icons.camera_alt,
                        color: appColor(context).appTheme.black)),
                ListTile(
                    onTap: () async {
                      Navigator.pop(context);
                      image =
                          await picker.pickImage(source: ImageSource.gallery);
                      imagePath = image!.path;
                      imgStatus = true;
                      notifyListeners();
                    },
                    title: Text(language(context, appFonts.gallery),
                        style: appCss.dmDenseRegular14
                            .textColor(appColor(context).appTheme.black)),
                    leading: Icon(Icons.image,
                        color: appColor(context).appTheme.black))
              ]);
        });
  }

  stateValidator(value) {
    if (value!.isNotEmpty) {
      stateValid = null;
      notifyListeners();
      return null;
    }
  }

  countryOnChanged(value) {
    countrySelected = value;
    notifyListeners();
  }

  Future<String> resizeAndEncodeImage(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;
    img.Image resizedImage = img.copyResize(image, width: 512, height: 512);
    List<int> resizedImageBytes = img.encodePng(resizedImage);
    return base64Encode(resizedImageBytes);
  }

  bool isSetupComplete() {
    return name.text.isNotEmpty;
  }

  Future<void> saveData(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (setupFormKey.currentState!.validate()) {
      if (setupFormKey.currentState?.validate() ?? false) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', name.text);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const CommonBottomNavigationBar()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please complete all required fields')));
      }

      showLoading(context);
      notifyListeners();
      try {
        String newUrl = "";
        if (image != null) {
          log("asdasd asd asd");
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
            }, onError: (err) {
              log(" error error $err");
            });
          });
        }
        Map<String, dynamic> body = {
          "name": name.text,
          "date_of_birth": dob.text,
          "gender": selectedGender != null
              ? selectedGender == 1
                  ? "male"
                  : "female"
              : "",
          "email": emailId.text,
          "mobile_number":
              phoneNum.text.isNotEmpty ? "$countryCode-${phoneNum.text}" : "",
          "country": countrySelected['code'],
          "state": state.text,
          "city": city.text,
          "yatra_name": yatraName.text,
          "initiated": value,
          "initiated_name": initiatedName.text,
          "spiritual_master": masterItems[0],
          "intitiation_date": initiatedDate.text,
          "marital_status": selectedMarital != null
              ? selectedMarital == 1
                  ? "married"
                  : "unmarried"
              : "",
          "profile_picture_url": newUrl == "" ? downloadUrl : newUrl
        };

        log("message $body");
        await apiServices
            .postApi(context, api.profileUpdate, body, isToken: true)
            .then((value) async {
          hideLoading(context);
          notifyListeners();
          if (value.isSuccess!) {
            pref.setString(session.user,
                json.encode(UserModel.fromJson(value.data['data'])));
            userModel = UserModel.fromJson(value.data['data']);
            notifyListeners();
            final commonApi =
                Provider.of<CommonApiProvider>(context, listen: false);

            await commonApi.selfApi(context);

            newUrl = "";
            image = null;
            Navigator.pushNamedAndRemoveUntil(
                context, routeName.commonBottomNavigationBar, (route) => false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.message,
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.black))));
          }
        });
      } catch (e) {
        log("error error eeeeee $e");
        hideLoading(context);
        notifyListeners();
      }
    }
  }

  onReady(context) async {
    readJson();
    notifyListeners();
    final splashPvr = Provider.of<SplashScreenProvider>(context, listen: false);
    splashPvr.fetchSpiritualMasters(context);
    preferences = await SharedPreferences.getInstance();

    await Future.delayed(DurationsClass.s1);
    String? userData = preferences!.getString(session.user);
    if (userData != null) {
      userModel = UserModel.fromJson(json.decode(userData));
    } else {
      userModel = UserModel();
    }

    name.text = userModel!.name ?? "";
    initiatedName.text = userModel!.initiatedName ?? "";
    emailId.text = userModel!.email ?? "";
    dob.text = userModel!.dateOfBirth ?? "";
    selectedGender = userModel!.gender != null
        ? userModel!.gender == "male"
            ? 1
            : 2
        : 1;
    phoneNum.text = userModel!.mobileNumber ?? "";
    int index = countryItems.indexWhere((element) {
      return element['code'] == userModel!.country;
    });
    countrySelected =
        userModel!.country != null ? countryItems[index] : countryItems[0];
    state.text = userModel!.state ?? "";
    city.text = userModel!.city ?? "";
    yatraName.text = userModel!.yatraName ?? "Mathura";
    downloadUrl = userModel!.profilePictureUrl ?? "";
    selectedMarital = userModel!.maritalStatus != null
        ? userModel!.maritalStatus == "married"
            ? 1
            : 2
        : 1;
    selectedItems = userModel!.spiritualMaster ?? masterItems[0];
    notifyListeners();
  }
}
