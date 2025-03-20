sealed class BaseState {}

class BaseInitialState extends BaseState {}

class BaseSuccessState<T> extends BaseState {
  T? data;

  BaseSuccessState({this.data});
}

class BaseLoadingState extends BaseState {}

class BaseHideLoadingState extends BaseState {}

class BaseNavigationState<T> extends BaseState {
  T? arguments;
  String route;

  BaseNavigationState(this.route, [this.arguments]);
}

class BaseErrorState extends BaseState {
  String errorMessage;
  Exception? exception;

  BaseErrorState({required this.errorMessage, this.exception});
}
