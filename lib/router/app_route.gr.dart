// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_route.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    PreviewImageRoute.name: (routeData) {
      final args = routeData.argsAs<PreviewImageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PreviewImagePage(
          parameter: args.parameter,
          key: args.key,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PreviewImagePage]
class PreviewImageRoute extends PageRouteInfo<PreviewImageRouteArgs> {
  PreviewImageRoute({
    required PreviewImageParameter parameter,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          PreviewImageRoute.name,
          args: PreviewImageRouteArgs(
            parameter: parameter,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PreviewImageRoute';

  static const PageInfo<PreviewImageRouteArgs> page =
      PageInfo<PreviewImageRouteArgs>(name);
}

class PreviewImageRouteArgs {
  const PreviewImageRouteArgs({
    required this.parameter,
    this.key,
  });

  final PreviewImageParameter parameter;

  final Key? key;

  @override
  String toString() {
    return 'PreviewImageRouteArgs{parameter: $parameter, key: $key}';
  }
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
