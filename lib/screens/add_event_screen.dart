import 'package:another_flushbar/flushbar.dart';
import 'package:event_finder/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedCategory;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  static const List<String> _categories = [
    'Tech',
    'Music',
    'Sports',
    'Food',
    'Art',
    'Business',
    'Health',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: isDark
              ? ColorScheme.dark(
                  primary: AppColors.accentLight,
                  onPrimary: Colors.white,
                  surface: AppColors.surfaceDark,
                )
              : const ColorScheme.light(
                  primary: AppColors.accent,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: isDark
              ? ColorScheme.dark(
                  primary: AppColors.accentLight,
                  onPrimary: Colors.white,
                )
              : const ColorScheme.light(
                  primary: AppColors.accent,
                  onPrimary: Colors.white,
                ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  String get _formattedDate {
    if (_selectedDate == null) return 'Select date';
    return '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
  }

  String get _formattedTime {
    if (_selectedTime == null) return 'Select time';
    final h = _selectedTime!.hourOfPeriod == 0 ? 12 : _selectedTime!.hourOfPeriod;
    final m = _selectedTime!.minute.toString().padLeft(2, '0');
    final period = _selectedTime!.period == DayPeriod.am ? 'AM' : 'PM';
    return '$h:$m $period';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: cs.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              _label('Title', cs),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: _inputDecoration(
                  hint: 'e.g. Flutter Dev Meetup',
                  icon: Icons.title_outlined,
                  isDark: isDark,
                ),
                style: TextStyle(color: cs.onSurface, fontSize: 15),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Title is required' : null,
              ),

              const SizedBox(height: 20),

              // Category
              _label('Category', cs),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: _inputDecoration(
                  hint: 'Select a category',
                  icon: Icons.category_outlined,
                  isDark: isDark,
                ),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedCategory = v),
                validator: (v) => v == null ? 'Please select a category' : null,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: isDark ? AppColors.hintDark : AppColors.hintLight,
                ),
                dropdownColor: cs.surface,
                style: TextStyle(
                  color: cs.onSurface,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 20),

              // Date & Time
              _label('Date & Time', cs),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _pickerTile(
                      icon: Icons.calendar_today_outlined,
                      label: _formattedDate,
                      hasValue: _selectedDate != null,
                      onTap: _pickDate,
                      isDark: isDark,
                      cs: cs,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _pickerTile(
                      icon: Icons.access_time_outlined,
                      label: _formattedTime,
                      hasValue: _selectedTime != null,
                      onTap: _pickTime,
                      isDark: isDark,
                      cs: cs,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Location
              _label('Location', cs),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDecoration(
                  hint: 'e.g. San Francisco, CA',
                  icon: Icons.location_on_outlined,
                  isDark: isDark,
                ),
                style: TextStyle(color: cs.onSurface, fontSize: 15),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Location is required' : null,
              ),

              const SizedBox(height: 36),

              // Submit
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await Flushbar(
                        message: 'Event added successfully!',
                        icon: const Icon(Icons.check_circle,
                            color: Colors.white),
                        duration: const Duration(seconds: 2),
                        backgroundColor: cs.primary,
                        borderRadius: BorderRadius.circular(12),
                        margin: const EdgeInsets.all(16),
                        flushbarStyle: FlushbarStyle.FLOATING,
                        flushbarPosition: FlushbarPosition.BOTTOM,
                      ).show(context);
                      if (context.mounted) Navigator.pop(context);
                    }
                  },
                  child: const Text('Create Event'),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text, ColorScheme cs) => Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: cs.onSurface.withOpacity(0.8),
        ),
      );

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    required bool isDark,
  }) {
    // Let the theme handle borders; only override prefix icon & hint
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: isDark ? AppColors.hintDark : AppColors.hintLight,
        size: 20,
      ),
    );
  }

  Widget _pickerTile({
    required IconData icon,
    required String label,
    required bool hasValue,
    required VoidCallback onTap,
    required bool isDark,
    required ColorScheme cs,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outline),
          ),
          child: Row(
            children: [
              Icon(icon,
                  size: 18,
                  color: hasValue
                      ? cs.primary
                      : (isDark ? AppColors.hintDark : AppColors.hintLight)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: hasValue
                        ? cs.onSurface
                        : (isDark ? AppColors.hintDark : AppColors.hintLight),
                    fontWeight:
                        hasValue ? FontWeight.w500 : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
}
