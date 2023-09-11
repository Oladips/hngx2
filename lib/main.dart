import 'package:flutter/material.dart';
import 'package:hng_stage_2/component/core/app_router.dart';
import 'package:hng_stage_2/component/theme/app_theme.dart';
import 'package:hng_stage_2/screens/home/pages/home_page.dart';

import 'component/core/base_navigator.dart';

void main() {
  runApp(const HngStage2());
}

class HngStage2 extends StatelessWidget {
  const HngStage2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HNG Stage 2',
      navigatorKey: BaseNavigator.key,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(),
        extensions: const [HngTextTheme.fallback()],
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        final scale = mediaQuery.textScaleFactor.clamp(0.85, 0.87);
        final pixelRatio = mediaQuery.devicePixelRatio.clamp(1.0, 1.0);

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: scale,
            devicePixelRatio: pixelRatio,
          ),
          child: child!,
        );
      },
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: HomePage.routeName,
    );
  }
}
