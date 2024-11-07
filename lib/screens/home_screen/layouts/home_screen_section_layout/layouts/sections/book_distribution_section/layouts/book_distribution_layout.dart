import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // For debounce

import 'package:bhakti_app/config.dart';

class BookDistributionLayout extends StatelessWidget {
  const BookDistributionLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DebouncedBookDistribution(
            controller: homeScreenPvr.smallBookCtrl,
            textTwo: language(context, appFonts.smallBooks),
            homeScreenProvider: homeScreenPvr,
          ),
          const HSpace(Insets.i10),
          DebouncedBookDistribution(
            controller: homeScreenPvr.mediumBookCtrl,
            textTwo: language(context, appFonts.mediumBooks),
            homeScreenProvider: homeScreenPvr,
          ),
          const HSpace(Insets.i10),
          DebouncedBookDistribution(
            controller: homeScreenPvr.largeBookCtrl,
            textTwo: language(context, appFonts.largeBooks),
            homeScreenProvider: homeScreenPvr,
          ),
        ],
      );
    });
  }
}

class DebouncedBookDistribution extends StatefulWidget {
  final TextEditingController controller;
  final String textTwo;
  final HomeScreenProvider homeScreenProvider;

  const DebouncedBookDistribution({
    Key? key,
    required this.controller,
    required this.textTwo,
    required this.homeScreenProvider,
  }) : super(key: key);

  @override
  _DebouncedBookDistributionState createState() =>
      _DebouncedBookDistributionState();
}

class _DebouncedBookDistributionState extends State<DebouncedBookDistribution> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    // Cancel any existing debounce timer
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    // Start a new debounce timer that waits for 500 milliseconds
    _debounce = Timer(const Duration(milliseconds: 3000), () {
      // This code executes once the user has stopped typing for 500ms
      FocusManager.instance.primaryFocus?.unfocus(); // Dismiss keyboard
      widget.homeScreenProvider.setLoading(true);
      widget.homeScreenProvider.updateData(context);
      widget.homeScreenProvider.notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonBookDistribution(
      onChanged: (value) {
        // No direct update call here, since _onTextChanged handles it
      },
      controller: widget.controller,
      textTwo: widget.textTwo,
    );
  }
}


// import 'package:bhakti_app/config.dart';

// class BookDistributionLayout extends StatelessWidget {
//   const BookDistributionLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HomeScreenProvider>(
//         builder: (context, homeScreenPvr, child) {
//       return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//         CommonBookDistribution(
//             onChanged: (value) {
//               FocusManager.instance.primaryFocus?.unfocus();
//               homeScreenPvr.notifyListeners();
//               homeScreenPvr.setLoading(true);
//               homeScreenPvr.updateData(context);
//             },
//             controller: homeScreenPvr.smallBookCtrl,
//             textTwo: language(context, appFonts.smallBooks)),
//         const HSpace(Insets.i10),
//         CommonBookDistribution(
//             onChanged: (value) {
//               FocusManager.instance.primaryFocus?.unfocus();
//               homeScreenPvr.notifyListeners();
//               homeScreenPvr.setLoading(true);
//               homeScreenPvr.updateData(context);
//             },
//             controller: homeScreenPvr.mediumBookCtrl,
//             textTwo: language(context, appFonts.mediumBooks)),
//         const HSpace(Insets.i10),
//         CommonBookDistribution(
//             onChanged: (value) {
//               FocusManager.instance.primaryFocus?.unfocus();
//               homeScreenPvr.notifyListeners();
//               homeScreenPvr.setLoading(true);
//               homeScreenPvr.updateData(context);
//             },
//             controller: homeScreenPvr.largeBookCtrl,
//             textTwo: language(context, appFonts.largeBooks))
//       ]);
//     });
//   }
// }
