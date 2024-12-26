

// final addBodTaskProvider =
//     StateNotifierProvider<AddBodTask, AsyncValue<AddTaskResponseModel?>>((ref) {
//   final dio = DioClientExtension
//       .client; // Assuming DioClientExtension provides a Dio client instance
//   return AddBodTask(dio);
// });
//
// class AddBodTask extends StateNotifier<AsyncValue<AddTaskResponseModel?>> {
//   final Dio dio;
//   bool? isLoading = false;
//
//   AddBodTask(this.dio) : super(const AsyncValue.data(null));
//
//
// }
