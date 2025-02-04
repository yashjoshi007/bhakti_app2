library ruler_picker_bn;


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../scrollable_positioned_list/item_positions_listener.dart';
import '../scrollable_positioned_list/scrollable_positioned_list.dart';

/// Flutter package for ruler type value picker.
/// You can get horizontal and vertical ruler view with the package.
class RulerPicker extends StatefulWidget {
  const RulerPicker(
      {super.key,
      this.minValue = 10,
      this.maxValue = 120,
      this.startValue = 10,
      this.background = Colors.white,
      this.lineColor = Colors.black,
      this.padding = const EdgeInsets.all(4),
      this.direction = Axis.vertical,
      required this.onChange});

  /// event for get to ruler value
  final ValueSetter<int> onChange;

  /// set ruler background color
  final Color background;

  /// set ruler padding value
  final EdgeInsets padding;

  /// set ruler value line color
  final Color lineColor;

  /// set ruler direction
  final Axis direction;

  /// set ruler starting value position
  final int startValue;

  /// set ruler min value
  final int minValue;

  /// set ruler max value
  final int maxValue;

  @override
  RulerPickerState createState() => RulerPickerState();
}

class RulerPickerState extends State<RulerPicker> {
  final ItemScrollController controllerScroll = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Stack(children: [
        Container(
            padding: widget.padding,
            decoration: BoxDecoration(color: widget.background),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: ScrollablePositionedList.builder(
                          itemCount: 190,
                          scrollDirection: widget.direction,
                          shrinkWrap: true,
                          initialScrollIndex: 1,
                          itemScrollController: controllerScroll,
                          itemPositionsListener: itemPositionsListener,
                          itemBuilder: (context, index) {
                            return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide.none,
                                              left: BorderSide(
                                                  color: index % 10 == 0
                                                      ? widget.lineColor
                                                          .withOpacity(0.54)
                                                      : index % 5 == 0
                                                          ? widget.lineColor
                                                              .withOpacity(0.36)
                                                          : widget.lineColor
                                                              .withOpacity(
                                                                  0.12))),
                                        ),
                                        height: constraints.maxHeight *
                                                (index % 10 == 0
                                                    ? 1
                                                    : index % 5 == 0
                                                        ? 0.75
                                                        : 0.5) -
                                            16 -
                                            widget.padding.top -
                                            widget.padding.bottom,
                                        width: 1,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2))
                                  ])
                                ]);
                          })),
                  Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: Icon(Icons.arrow_drop_up,
                          color: widget.lineColor.withOpacity(0.54), size: 16))
                ])),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                width: constraints.maxWidth * 0.5,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: const [
                      0.2,
                      0.4,
                      0.6,
                      0.8
                    ],
                        colors: [
                      widget.background,
                      widget.background.withOpacity(0.75),
                      widget.background.withOpacity(0.5),
                      widget.background.withOpacity(0.25)
                    ])))),
        Align(
            alignment: Alignment.centerRight,
            child: Container(
                width: constraints.maxWidth * 0.2,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: const [
                      0.2,
                      0.4,
                      0.6,
                      0.8
                    ],
                        colors: [
                      widget.background.withOpacity(0.25),
                      widget.background.withOpacity(0.5),
                      widget.background.withOpacity(0.75),
                      widget.background
                    ]))))
      ]);
    });
  }

  int prevValue = 0;

  @override
  void initState() {
    super.initState();

    itemPositionsListener.itemPositions.addListener(() {
      var positions = itemPositionsListener.itemPositions.value;
      int? min;
      int? max;
      if (positions.isNotEmpty) {
        min = positions
            .where((ItemPosition position) => position.itemTrailingEdge > 0)
            .reduce((ItemPosition min, ItemPosition position) =>
                position.itemTrailingEdge < min.itemTrailingEdge
                    ? position
                    : min)
            .index;
        max = positions
            .where((ItemPosition position) => position.itemLeadingEdge < 1)
            .reduce((ItemPosition max, ItemPosition position) =>
                position.itemLeadingEdge > max.itemLeadingEdge ? position : max)
            .index;
        int position =
            ((((max - min))) + min).toInt() - 78 + widget.startValue;
        int value = position < widget.minValue
            ? widget.minValue
            : position > widget.maxValue
                ? widget.maxValue
                : position;
        if (prevValue != value) {
          widget.onChange(value);
          prevValue = value;
        }
        if (kDebugMode) {
          print("prevValue : $prevValue value : $value");
        }
      }
    });
  }
}
