import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/home/home_page.dart';
import 'package:note_app/screen/preview_image/preview_image_page.dart';
import 'package:note_app/screen/preview_image/preview_image_parameter.dart';
import 'package:note_app/screen/splash/splash_screen.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: PreviewImageRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
