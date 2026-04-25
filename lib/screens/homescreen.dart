import 'package:event_finder/screens/detail_screen.dart';
import 'package:event_finder/services/event_service.dart';
import 'package:event_finder/widgets/event_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final EventService service = EventService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Finder')),
      body: FutureBuilder(
        future: service.fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(event: data[index]),
                      ),
                    );
                  },
                  child: EventTile(event: data[index]),
                );
              },
            );
          }
          return Center(child: Text('No events found'));
        },
      ),
    );
  }
}
