import '../config.dart';

class StatefulWrapper extends StatefulWidget {
  final Function? onInit, onDispose;
  final Widget? child;

  const StatefulWrapper(
      {super.key, @required this.onInit, @required this.child, this.onDispose});

  @override
  State<StatefulWrapper> createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit!();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!();
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}
