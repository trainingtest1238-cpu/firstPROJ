import 'package:first/models/photo.dart';
import 'package:first/services/http_service.dart';

class PhotoService {
  final httpService = HttpService();
  Future<List<Photo>> fetchPhotos() async {
    final data = await httpService.getRequest('https://picsum.photos/v2/list');
    return (data as List)
        .map((e) => Photo.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
