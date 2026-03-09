import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:note_app/base/widget/base_page.dart';
import 'package:note_app/base/widget/cubit/base_bloc_provider.dart';

import 'cubit/t_cubit.dart';
import 'cubit/t_state.dart';

@RoutePage()
class TPage extends BaseBlocProvider<TState, TCubit> {
  const TPage({super.key});

  @override
  Widget buildPage() {
    return const TScreen();
  }

  @override
  TCubit createCubit() {
    return TCubit();
  }
}

class TScreen extends StatefulWidget {
  const TScreen({super.key});

  @override
  State<TScreen> createState() => _TScreenState();
}

class _TScreenState extends BaseBlocPageState<TScreen, TState, TCubit> {
  @override
  String get title => '';

  @override
  Widget buildView(BuildContext context, TCubit cubit) {
    return const SizedBox();
  }
}
