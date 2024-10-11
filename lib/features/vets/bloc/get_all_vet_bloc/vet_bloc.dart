import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import 'package:pawpal/features/vets/bloc/get_all_vet_bloc/vet_evet.dart';
import 'package:pawpal/features/vets/bloc/get_all_vet_bloc/vet_state.dart';
import 'package:pawpal/features/vets/models/vetModel.dart';

class VetBloc extends Bloc<VetEvent, VetState> {
  final FirestoreService _firestoreService;
  
  VetBloc(this._firestoreService) : super(VetInitial()) {
    on<VetListRequested>((event, emit) async {
      emit(VetListLoading());
      try {
        // Fetch the full vet list
        final List<VetModel> vetList = await _firestoreService.getVetList();

        // Emit the success state for all vets, preserving top-rated vets if already available
        final currentState = state;
        if (currentState is VetListSuccess) {
          emit(VetListSuccess(vetList: vetList, topRatedVets: currentState.topRatedVets));
        } else {
          emit(VetListSuccess(vetList: vetList));
        }
      } catch (e) {
        emit(VetListFailure('Failed to get vet data: $e'));
      }
    });

    // Handle fetching top-rated vets separately
    on<TopRatedVetsRequested>((event, emit) async {
      emit(TopRatedVetsLoading());
      try {
        // Filter top-rated vets from the full list
        final List<VetModel> topRatedVets = event.allVets
            .where((vet) => vet.rating > 3.0)
            .toList();
        topRatedVets.sort((a, b) => b.rating.compareTo(a.rating));

        // Emit success state for top-rated vets
        emit(VetListSuccess(
          vetList: event.allVets, 
          topRatedVets: topRatedVets,
        ));
      } catch (e) {
        emit(TopRatedVetsFailure('Failed to get top-rated vet data: $e'));
      }
    });
  }
}
