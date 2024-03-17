import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_rickandmorty/presentation/widgets/offline_mode.dart';

class OfflineBuilderWrapper extends StatelessWidget {
  const OfflineBuilderWrapper({
    super.key,
    this.offlineMode = const OfflineMode(),
    required this.onlineMode,
  });

  final Widget offlineMode;
  final Widget onlineMode;

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (context, connectivity, child) {
        final isOffline = connectivity == ConnectivityResult.none;

        return isOffline ? offlineMode : onlineMode;
      },
      child: Container(),
    );
  }
}
