import 'package:flutter/material.dart';
import 'hours.dart';
import 'minutes.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // hours wheel
          SizedBox(
              width: 70,
              child: ListWheelScrollView.useDelegate(
                  controller: _controller,
                  itemExtent: 50,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 13,
                      builder: (context, index) {
                        return MyHours(hours: index);
                      }))),

          const SizedBox(width: 10),

          // minutes wheel
          SizedBox(
              width: 70,
              child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 60,
                      builder: (context, index) {
                        return MyMinutes(mins: index);
                      }))),

          const SizedBox(width: 15),

          // am or pm
          // Container(
          //   width: 70,
          //   child: ListWheelScrollView.useDelegate(
          //     itemExtent: 50,
          //     perspective: 0.005,
          //     diameterRatio: 1.2,
          //     physics: FixedExtentScrollPhysics(),
          //     childDelegate: ListWheelChildBuilderDelegate(
          //       childCount: 2,
          //       builder: (context, index) {
          //         if (index == 0) {
          //           return AmPm(
          //             isItAm: true,
          //           );
          //         } else {
          //           return AmPm(
          //             isItAm: false,
          //           );
          //         }
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
