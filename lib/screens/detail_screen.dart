import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_finder/models/event.dart';
import 'package:event_finder/widgets/info_card.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Event event;
  const DetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
            20, 12, 20, MediaQuery.of(context).padding.bottom + 16),
        child: FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF4F46E5),
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Get Tickets',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
      body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFF1A1A2E), size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: event.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: Colors.grey.shade100),
                    errorWidget: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported_outlined,
                          size: 48, color: Colors.grey),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          event.category,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4F46E5),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Title
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A2E),
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Date & Time cards
                      Row(
                        children: [
                          Expanded(
                            child: InfoCard(
                              icon: Icons.calendar_today_outlined,
                              label: 'Date',
                              value: event.date,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InfoCard(
                              icon: Icons.access_time_outlined,
                              label: 'Time',
                              value: event.time,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Location card
                      InfoCard(
                        icon: Icons.location_on_outlined,
                        label: 'Location',
                        value: '${event.location}  ·  ${event.distance}',
                        fullWidth: true,
                      ),
                      const SizedBox(height: 28),

                      const Divider(color: Color(0xFFE5E7EB), height: 1),
                      const SizedBox(height: 24),

                      const Text(
                        'About this event',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        event.description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF6B7280),
                          height: 1.65,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
