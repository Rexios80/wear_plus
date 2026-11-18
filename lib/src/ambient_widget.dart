import 'package:flutter/widgets.dart';
import 'package:wear_plus/src/wear.dart';

/// Ambient modes for a Wear device
enum WearMode {
  /// The screen is active
  active,

  /// The screen is in ambient mode
  ambient,
}

/// Builds a child for [AmbientMode]
typedef AmbientModeWidgetBuilder =
    Widget Function(BuildContext context, WearMode mode, Widget? child);

/// Widget that listens for when a Wear device enters full power or ambient mode,
/// and provides this in a builder. It optionally takes an [onUpdate] function that's
/// called every time the wear device triggers an ambient update request.
@immutable
class AmbientMode extends StatefulWidget {
  /// Constructor
  const AmbientMode({
    super.key,
    required this.builder,
    this.child,
    this.onUpdate,
  });

  /// Built when the mode changes
  final AmbientModeWidgetBuilder builder;

  /// Optional child that will not get rebuilt when the mode changes
  final Widget? child;

  /// Called each time the the wear device triggers an ambient update request.
  final VoidCallback? onUpdate;

  /// Get current [WearMode].
  static WearMode wearModeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedAmbientMode>()!
        .mode;
  }

  /// Get current [AmbientDetails].
  static AmbientDetails ambientDetailsOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedAmbientMode>()!
        .details;
  }

  @override
  State<StatefulWidget> createState() => _AmbientModeState();
}

class _AmbientModeState extends State<AmbientMode> with AmbientCallback {
  var _ambientMode = WearMode.active;
  final _ambientDetails = const AmbientDetails(false, false);

  @override
  void initState() {
    super.initState();
    Wear.instance.registerAmbientCallback(this);
    _initState();
  }

  void _initState() async {
    final isAmbient = await Wear.instance.isAmbient();
    _updateMode(isAmbient);
  }

  @override
  void dispose() {
    Wear.instance.unregisterAmbientCallback(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedAmbientMode(
      mode: _ambientMode,
      details: _ambientDetails,
      child: Builder(
        builder: (context) {
          return widget.builder(context, _ambientMode, widget.child);
        },
      ),
    );
  }

  void _updateMode(bool isAmbient) {
    if (!mounted) return;
    setState(
      () => _ambientMode = isAmbient ? WearMode.ambient : WearMode.active,
    );
  }

  @override
  void onEnterAmbient(AmbientDetails ambientDetails) => _updateMode(true);

  @override
  void onExitAmbient() => _updateMode(false);

  @override
  void onUpdateAmbient() {
    _updateMode(true);
    widget.onUpdate?.call();
  }
}

class _InheritedAmbientMode extends InheritedWidget {
  const _InheritedAmbientMode({
    required this.mode,
    required this.details,
    required super.child,
  });

  final WearMode mode;
  final AmbientDetails details;

  @override
  bool updateShouldNotify(_InheritedAmbientMode old) {
    return mode != old.mode || details != old.details;
  }
}
