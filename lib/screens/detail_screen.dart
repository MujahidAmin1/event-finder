import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_finder/models/event.dart';
import 'package:event_finder/themes/app_colors.dart';
import 'package:event_finder/widgets/info_card.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Event event;
  const DetailScreen({super.key, required this.event});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));


    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: cs.surface.withOpacity(0.9),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: cs.onSurface,
                    size: 20,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.event.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: isDark ? AppColors.surfaceDark : Colors.grey.shade100,
                ),
                errorWidget: (_, __, ___) => Container(
                  color: isDark ? AppColors.surfaceDark : Colors.grey.shade200,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 48,
                    color: isDark ? AppColors.hintDark : Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SlideTransition(
              position: _slide,
              child: FadeTransition(
                opacity: _fade,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.accentSoftDark
                              : AppColors.accentSoftLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.event.category,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: cs.primary,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Title
                      Text(
                        widget.event.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: cs.onSurface,
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
                              value: widget.event.date,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InfoCard(
                              icon: Icons.access_time_outlined,
                              label: 'Time',
                              value: widget.event.time,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Location card
                      InfoCard(
                        icon: Icons.location_on_outlined,
                        label: 'Location',
                        value:
                            '${widget.event.location}  ·  ${widget.event.distance}',
                        fullWidth: true,
                      ),
                      const SizedBox(height: 28),

                      Divider(
                        color: cs.outline,
                        height: 1,
                      ),
                      const SizedBox(height: 24),

                      Text(
                        'About this event',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        widget.event.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                          height: 1.65,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          12,
          20,
          MediaQuery.of(context).padding.bottom + 16,
        ),
        child: FilledButton(
          onPressed: () {
            Flushbar(
              message: 'Tickets booked successfully!',
              icon: const Icon(Icons.confirmation_num, color: Colors.white),
              duration: const Duration(seconds: 2),
              backgroundColor: cs.primary,
              borderRadius: BorderRadius.circular(12),
              margin: const EdgeInsets.all(16),
              flushbarStyle: FlushbarStyle.FLOATING,
              flushbarPosition: FlushbarPosition.BOTTOM,
            ).show(context);
          },
          child: const Text('Get Tickets'),
        ),
      ),
    );
  }
}
