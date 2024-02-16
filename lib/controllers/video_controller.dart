import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/video_model.dart';
import 'package:movie_app/services/apis/networking.dart';

class VideoController {
  final _networking = GetIt.I<NetWorkingManager>();
  final _isVideoLoading = false.obs;
  String videoId = '';

  //--------------------------------------------------------
  Future<String> fetchVideos(int movieId) async {
    try {
      _isVideoLoading.value = true;

      final response = await _networking.apiCall(
        methodCall: MethodCall.get,
        endpoint: '$movieId/videos',
        queryParameters: {
          'language': 'en-US',
        },
      );

      if (response == null || response.statusCode == null) {
        _isVideoLoading.value = false;
        return '';
      }

      final extractedData = response.data;
      final videoModel = VideoModel.fromJson(extractedData);

      if (videoModel.results == null || videoModel.results!.isEmpty) {
        _isVideoLoading.value = false;
        return '';
      }

      final trailerVideo = videoModel.results!
          .where((element) => element.type!.toLowerCase() == 'trailer')
          .toList()
          .first;
      videoId = videoId + trailerVideo.key!;
      print("videoUrl:$videoId");
      _isVideoLoading.value = false;
      return '';
    } catch (error) {
      _isVideoLoading.value = false;
      rethrow;
    }
  }
}
