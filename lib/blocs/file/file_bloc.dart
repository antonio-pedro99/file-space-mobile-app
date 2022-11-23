import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  FileBloc() : super(FileInitial()) {
    on<FileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
