import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_finder/models/event.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final Event event;
  const EventTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event image
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: event.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: Colors.grey.shade100),
                  errorWidget: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported_outlined,
                        size: 40, color: Colors.grey),
                  ),
                ),
              ),
              // Category badge
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    event.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  event.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),

                // Date & time row
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 14, color: Color(0xFF6B7280)),
                    const SizedBox(width: 5),
                    Text(
                      event.date,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.access_time_outlined,
                        size: 14, color: Color(0xFF6B7280)),
                    const SizedBox(width: 5),
                    Text(
                      event.time,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Location & distance row
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 14, color: Color(0xFF6B7280)),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        event.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        event.distance,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF374151),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}