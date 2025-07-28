import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/base_state/base_state.dart';

class HomeStates extends Equatable {
  final BaseState? homeData;
  const HomeStates({this.homeData});
  HomeStates copyWith({BaseState? homeData}) {
    return HomeStates(homeData: homeData ?? this.homeData);
  }

  @override
  List<Object?> get props => [homeData];
}
