import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'multiplication_event.dart';
part 'multiplication_state.dart';

class MultiplicationBloc
    extends Bloc<MultiplicationEvent, MultiplicationState> {
  MultiplicationBloc() : super(MultiplicationInitial()) {
    on<MultiplicationEvent>((event, emit) {});
  }
}
