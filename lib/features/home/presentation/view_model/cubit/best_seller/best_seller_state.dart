
import 'package:equatable/equatable.dart';
import '../../../../../../core/base_state/base_state.dart';

class BestSellerState extends Equatable {
  final BaseState? baseState;

  const BestSellerState({
    this.baseState,
  });

  BestSellerState copyWith({
    BaseState? baseState,
  }) {
    return BestSellerState(
      baseState: baseState ?? this.baseState,
    );
  }

  @override
  List<Object?> get props => [baseState];
}

sealed class BestSellerAction {}


final class GetDataAction extends BestSellerAction {}

