
import 'package:dio/dio.dart';
import 'package:event_finder/models/event.dart';

class EventService {
  final Dio _dio = Dio();

  Future<List<Event>>? fetchEvents() async {
    try {
      final String uri = "https://events-finder.free.beeceptor.com/events";
      final response = await _dio.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => Event.fromJson(e)).toList();
      } return [];
    } catch (e) {
      throw Exception("Failed to load events: $e");
    }
  } 
}