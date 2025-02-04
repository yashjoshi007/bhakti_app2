import 'package:bhakti_app/config.dart';

class CustomDraw extends CustomPainter {
  late Paint painter;
  late double radius;
  late double textWidth;

  CustomDraw(Color color, this.textWidth, {this.radius = 0}) {
    painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width - ((size.width - textWidth) / 1.07), 0);

    path.lineTo(size.width - radius, 0);
    path.cubicTo(size.width - radius, 0, size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height - radius);
    path.cubicTo(size.width, size.height - radius, size.width, size.height,
        size.width - radius, size.height);

    path.lineTo(radius, size.height);
    path.cubicTo(radius, size.height, 0, size.height, 0, size.height - radius);

    path.lineTo(0, radius);
    path.cubicTo(0, radius, 0, 0, radius, 0);
    path.lineTo(((size.width - textWidth) / 16), 0);

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomTitleWidget extends StatefulWidget {
  final double height;
  final double width;
  final double? radius;
  final String title;
  final Widget child;
  final Color? color;

  const CustomTitleWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.title,
      required this.child,
      required this.color,
      this.radius});

  @override
  State<CustomTitleWidget> createState() => _CustomTitleWidgetState();
}

class _CustomTitleWidgetState extends State<CustomTitleWidget> {
  GlobalKey textKey = GlobalKey();
  double textHeight = 0.0;
  double textWidth = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final textKeyContext = textKey.currentContext;
        if (textKeyContext != null) {
          final box = textKeyContext.findRenderObject() as RenderBox;
          textHeight = box.size.height;
          textWidth = box.size.width;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topLeft,
        children: [
          CustomPaint(
              painter: CustomDraw(widget.color!, textWidth,
                  radius: widget.radius ?? 0),
              child: Container(
                  color: const Color.fromRGBO(195, 94, 210, 0.06),
                  height: widget.height,
                  width: widget.width,
                  child: widget.child)),
          Positioned(
              top: -textHeight / 2,
              left: Sizes.s20,
              child: Padding(
                  key: textKey,
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.s8),
                  child: Text(widget.title,overflow: TextOverflow.ellipsis,
                      style: appCss.dmDenseRegular14
                          .textColor(appColor(context).appTheme.lightText))))
        ]);
  }
}
