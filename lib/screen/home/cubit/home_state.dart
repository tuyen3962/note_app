import 'package:note_app/base/widget/cubit/base_state.dart';

class HomeState extends BaseState {
  const HomeState({super.isLoading});

  HomeState copyWith({bool? isLoading}) {
    return HomeState(isLoading: isLoading ?? this.isLoading);
  }
}
