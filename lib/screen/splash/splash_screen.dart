import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:note_app/base/widget/base_page.dart';
import 'package:note_app/main.dart';
import 'package:note_app/screen/splash/splash_controller.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends BasePageState<SplashScreen, SplashController> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeUtil.themeType,
      builder: (context, val, child) => Scaffold(
        backgroundColor: appTheme.background,
        body: Stack(
          children: [
            // ValueListenableBuilder(
            //   valueListenable: controller.isScale,
            //   builder: (context, value, child) => Center(
            //     child: AnimatedScale(
            //       scale: value ? 1 : 0,
            //       duration: const Duration(milliseconds: 1000),
            //       child: ImageAssetCustom(
            //         imagePath: val == ThemeType.dark
            //             ? ImagesAssets.addGroupIcon
            //             : ImagesAssets.appleIcon,
            //         size: 36.w,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  @override
  SplashController initController() => SplashController(this);

  @override
  Widget buildBody() => const SizedBox();
}
