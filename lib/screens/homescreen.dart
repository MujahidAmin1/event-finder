import 'package:event_finder/main.dart';
import 'package:event_finder/screens/add_event_screen.dart';
import 'package:event_finder/screens/detail_screen.dart';
import 'package:event_finder/screens/search_screen.dart';
import 'package:event_finder/services/event_service.dart';
import 'package:event_finder/themes/app_colors.dart';
import 'package:event_finder/themes/slide_up_page_route.dart';
import 'package:event_finder/widgets/event_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final EventService service = EventService();

  // FAB scale-in animation
  late final AnimationController _fabCtrl;
  late final Animation<double> _fabScale;

  @override
  void initState() {
    super.initState();
    _fabCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fabScale = CurvedAnimation(parent: _fabCtrl, curve: Curves.elasticOut);
    // Delay FAB entrance slightly
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _fabCtrl.forward();
    });
  }

  @override
  void dispose() {
    _fabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Finder'),
        actions: [
          // Theme toggle
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, anim) => RotationTransition(
                turns: Tween(begin: 0.75, end: 1.0).animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                key: ValueKey(isDark),
                size: 24,
                color: cs.onSurface,
              ),
            ),
            onPressed: () => themeNotifier.toggleTheme(),
          ),
          // Search
          IconButton(
            icon: Icon(Icons.search, size: 28, color: cs.onSurface),
            onPressed: () {
              service.fetchEvents()!.then((events) {
                Navigator.push(
                  context,
                  SlideUpPageRoute(
                    page: SearchScreen(events: events),
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: service.fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: cs.primary),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No events found',
                style: TextStyle(color: cs.onSurface.withOpacity(0.6)),
              ),
            );
          }
          final allEvents = snapshot.data!;
          return _StaggeredEventList(
            events: allEvents,
            onTap: (event) => Navigator.push(
              context,
              SlideUpPageRoute(page: DetailScreen(event: event)),
            ),
          );
        },
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabScale,
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            SlideUpPageRoute(page: const AddEventScreen()),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// ── Staggered event list ─────────────────────────────────────
class _StaggeredEventList extends StatefulWidget {
  final List events;
  final ValueChanged onTap;

  const _StaggeredEventList({required this.events, required this.onTap});

  @override
  State<_StaggeredEventList> createState() => _StaggeredEventListState();
}

class _StaggeredEventListState extends State<_StaggeredEventList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 400 + (widget.events.length * 100).clamp(0, 800),
      ),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      itemCount: widget.events.length,
      itemBuilder: (context, index) {
        final start = (index * 0.1).clamp(0.0, 0.6);
        final end = (start + 0.4).clamp(start, 1.0);

        final slide = Tween<Offset>(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _ctrl,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ));

        final fade = CurvedAnimation(
          parent: _ctrl,
          curve: Interval(start, end, curve: Curves.easeOut),
        );

        return SlideTransition(
          position: slide,
          child: FadeTransition(
            opacity: fade,
            child: GestureDetector(
              onTap: () => widget.onTap(widget.events[index]),
              child: EventTile(event: widget.events[index]),
            ),
          ),
        );
      },
    );
  }
}
