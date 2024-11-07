import 'package:bhakti_app/config.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final String? svgIcon;
  final ValueChanged<bool>? onExpansionChanged;
  final bool? isExpanded;

  const CustomExpansionTile(
      {super.key,
      required this.title,
      required this.children,
      this.svgIcon,
      this.isExpanded,
      this.onExpansionChanged});

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Column(children: [
        GestureDetector(
            onTap: () => widget.onExpansionChanged!.call(!widget.isExpanded!),
            child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Row(children: [
                    const HSpace(Insets.i10),
                    SvgPicture.asset(widget.isExpanded!
                        ? eSvgAssets.link01
                        : widget.svgIcon!),
                    const HSpace(Insets.i10),
                    Text(widget.title,
                        style: appCss.dmDenseRegular16.textColor(
                            widget.isExpanded!
                                ? appColor(context).appTheme.primary
                                : appColor(context).appTheme.lightText))
                  ]),
                  SvgPicture.asset(
                          widget.isExpanded!
                              ? eSvgAssets.arrowUp
                              : eSvgAssets.arrowDown1,
                          colorFilter: ColorFilter.mode(
                              widget.isExpanded!
                                  ? appColor(context).appTheme.primary
                                  : appColor(context).appTheme.lightText,
                              BlendMode.srcIn))
                      .paddingOnly(right: 10)
                ])
                .decorated(
                    gradient: LinearGradient(
                        colors: widget.isExpanded!
                            ? [
                                appColor(context)
                                    .appTheme
                                    .primary
                                    .withOpacity(0.3),
                                appColor(context)
                                    .appTheme
                                    .primary
                                    .withOpacity(0.05)
                              ]
                            : [
                                appColor(context).appTheme.trans,
                                appColor(context).appTheme.trans
                              ]))
                .height(50)),
        AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: widget.isExpanded! ? null : 0,
            child: widget.isExpanded!
                ? Column(children: widget.children)
                : Container())
      ]);
    });
  }
}
