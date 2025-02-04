import 'package:bhakti_app/config.dart';

class AppArray {
  List bookList = [];
  List localBookList = [];
  List combineList = [];
  int selectedIndex = 0;

  List<Map<String, dynamic>> rulesList = [
    {'rule': appFonts.noMeat, 'isOn': false},
    {'rule': appFonts.noIntox, 'isOn': false},
    {'rule': appFonts.noIllicit, 'isOn': false},
    {'rule': appFonts.noGambling, 'isOn': false},
    {'rule': appFonts.onlyPrasadam, 'isOn': false}
  ];

  List<Map<String, dynamic>> settingList = [
    {
      'image': eSvgAssets.setting5,
      'rule': appFonts.parameters,
      'navigate': const SettingParameters()
    },
    {
      'image': eSvgAssets.book1,
      'rule': appFonts.booksReadingPresently,
      'navigate': const BookReadPresentlyScreen()
    },
    {
      'image': eSvgAssets.shareMySadhana,
      'rule': appFonts.shareMyShadhana,
      'navigate': const ShareMySadhana()
    },
    {
      'image': eSvgAssets.profileUser,
      'rule': appFonts.shareWithMe,
      'navigate': const SharingWithMe()
    },
    {
      'image': eSvgAssets.key,
      'rule': appFonts.bhaktiStepsAccessKey,
      'navigate': ""
    },
    {
      'image': eSvgAssets.notification,
      'rule': appFonts.notification,
      'navigate': const NotificationLayouts()
    },
    {
      'image': eSvgAssets.setting2,
      'rule': appFonts.homepageSectionPriorities,
      'navigate': const HomePageSection()
    }
  ];

  List<Map<String, dynamic>> homePageSectionList = [
    {'svgImage': eSvgAssets.dragIcon, 'name': appFonts.sleep, 'isOn': true},
    {'svgImage': eSvgAssets.dragIcon, 'name': appFonts.worship, 'isOn': true},
    {'svgImage': eSvgAssets.dragIcon, 'name': appFonts.chanting, 'isOn': true},
    {
      'svgImage': eSvgAssets.dragIcon,
      'name': appFonts.regulations,
      'isOn': true
    },
    {
      'svgImage': eSvgAssets.dragIcon,
      'name': appFonts.association,
      'isOn': true
    },
    {
      'svgImage': eSvgAssets.dragIcon,
      'name': appFonts.bookReading,
      'isOn': true
    },
    {
      'svgImage': eSvgAssets.dragIcon,
      'name': appFonts.bookDistribution,
      'isOn': true
    },
    {'svgImage': eSvgAssets.dragIcon, 'name': appFonts.notes, 'isOn': true}
  ];

  List<Map<String, dynamic>> notificationSettingList = [
    {'name': appFonts.mailNotifications, 'isOn': false},
    {'name': appFonts.appNotifications, 'isOn': false},
    {'name': appFonts.sMSNotifications, 'isOn': false}
  ];
  List<Map<String, dynamic>> manglaArtiTypeList = [
    {'artiType': appFonts.guruAstaka, 'isOn': false},
    {'artiType': appFonts.narasimhaArti, 'isOn': false},
    {'artiType': appFonts.tulasiArtiParikrama, 'isOn': false},
    {'artiType': appFonts.guruArti, 'isOn': false},
    {'artiType': appFonts.bhogaOffering, 'isOn': false}
  ];

  List<Map<String, dynamic>> sandhyaTypeList = [
    {'artiType': appFonts.sandhyaArti, 'isOn': false},
    {'artiType': appFonts.narasimhaArti, 'isOn': false},
    {'artiType': appFonts.bhogaOffering, 'isOn': false}
  ];

  List drawerList = [
    {
      "icon": eSvgAssets.home1,
      'fillIcon': eSvgAssets.home01,
      "name": appFonts.home
    },
    {
      "icon": eSvgAssets.user1,
      'fillIcon': eSvgAssets.user01,
      "name": appFonts.profile
    },
    {
      "icon": eSvgAssets.link,
      'fillIcon': eSvgAssets.link01,
      "name": appFonts.bhaktiStepsCertifications,
      'list': [
        {
          "icon": eSvgAssets.link,
          'fillIcon': eSvgAssets.link01,
          "name": appFonts.shraddavan
        },
        {
          "icon": eSvgAssets.link,
          'fillIcon': eSvgAssets.link01,
          "name": appFonts.krishnaSevaka
        },
        {
          "icon": eSvgAssets.link,
          'fillIcon': eSvgAssets.link01,
          "name": appFonts.krishnaSadhaka
        },
        {
          "icon": eSvgAssets.link,
          'fillIcon': eSvgAssets.link01,
          "name": appFonts.srilaPrabhupadaAshraya
        },
        {
          "icon": eSvgAssets.link,
          'fillIcon': eSvgAssets.link01,
          "name": appFonts.srilaGuruCaranaAshraya
        },
      ]
    },
    {
      "icon": eSvgAssets.docText,
      'fillIcon': eSvgAssets.document,
      "name": appFonts.myDocuments
    },
    {
      "icon": eSvgAssets.information,
      'fillIcon': eSvgAssets.info1,
      "name": appFonts.iSkcon
    },
    {
      "icon": eSvgAssets.link,
      'fillIcon': eSvgAssets.link01,
      "name": appFonts.aboutUs,
      "list": [
        {
          "icon": eSvgAssets.link,
          'fillIcon': eSvgAssets.link01,
          "name": appFonts.bhaktiSteps
        },
        {
          "icon": eSvgAssets.link,
          'fillIcon': eSvgAssets.link01,
          "name": appFonts.cdm
        },
        {
          "icon": eSvgAssets.link,
          'fillIcon': eSvgAssets.link01,
          "name": appFonts.aCBhaktiVedantaSwami
        }
      ]
    },
    {
      "icon": eSvgAssets.callCalling,
      'fillIcon': eSvgAssets.callCalling1,
      "name": appFonts.contactUs
    },
    {
      "icon": eSvgAssets.callCalling,
      'fillIcon': eSvgAssets.callCalling1,
      "name": appFonts.supportUs
    },
  ];

  var bottomNavyList = [
    {
      "icon": eSvgAssets.unSelectHome,
      "title": appFonts.home,
      "icon2": eSvgAssets.home,
    },
    {
      "icon": eSvgAssets.category,
      "title": appFonts.dashboard,
      "icon2": eSvgAssets.selectCategory
    },
    {
      "icon": eSvgAssets.monitoring,
      "title": appFonts.monitoring,
      "icon2": eSvgAssets.selectMonitor
    },
    {
      "icon": eSvgAssets.setting,
      "title": appFonts.setting,
      "icon2": eSvgAssets.selectSetting
    }
  ];
}
