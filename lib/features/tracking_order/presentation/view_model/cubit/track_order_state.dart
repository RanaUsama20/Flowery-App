part of 'track_order_cubit.dart';

class TrackOrderState extends Equatable {
 final  BaseState? trackOrderState;
 const  TrackOrderState({this.trackOrderState});
  TrackOrderState copyWith({BaseState? trackOrderState}) {
    return TrackOrderState(
        trackOrderState: trackOrderState ?? this.trackOrderState);
  }

  @override
  List<Object?> get props => [trackOrderState];
}
