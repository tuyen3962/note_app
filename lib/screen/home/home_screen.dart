import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:note_app/base/widget/base_page.dart';
import 'package:note_app/base/widget/cubit/base_bloc_provider.dart';

import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

@RoutePage()
class HomePage extends BaseBlocProvider<HomeState, HomeCubit> {
  const HomePage({super.key});

  @override
  Widget buildPage() {
    return const HomeScreen();
  }

  @override
  HomeCubit createCubit() {
    return HomeCubit();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState
    extends BaseBlocPageState<HomeScreen, HomeState, HomeCubit> {
  @override
  String get title => '';

  @override
  Widget buildView(BuildContext context, HomeCubit cubit) {
    return const SizedBox();
  }
}
