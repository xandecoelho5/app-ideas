import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _hoursController = TextEditingController();

  DateTime? _eventDate;
  TimeOfDay? _eventHour;
  final _firstDate = DateTime.now();
  final _lastDate = DateTime.now().add(const Duration(days: 30));

  Future<void> onDateFieldTap() async {
    _eventDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    _dateController.text = _eventDate == null
        ? ''
        : _eventDate.toString().split(' ')[0].replaceAll('-', '/');
    _dateController.text = _eventDate.toString();
  }

  Future<void> onHourFieldTap() async {
    _eventHour = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    _hoursController.text =
        _eventHour == null ? '' : _eventHour!.format(context);
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_hoursController.text.isEmpty) {
        _eventHour = const TimeOfDay(hour: 0, minute: 0);
        _hoursController.text = _eventHour!.format(context);
      }
      _formKey.currentState!.save();
    }
  }

  String? validateField(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'Please enter the $field';
    }
    return null;
  }

  DateTime? _parseDate(String? text) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return localizations.parseCompactDate(text);
  }

  bool _isValidAcceptableDate(DateTime? date) {
    return date != null &&
        !date.isBefore(_firstDate) &&
        !date.isAfter(_lastDate);
  }

  String? _validateDate(String? text) {
    final DateTime? date = _parseDate(text);
    if (date == null) {
      return 'Invalid format';
    } else if (!_isValidAcceptableDate(date)) {
      return 'Out of range.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: _dateController,
              onTap: onDateFieldTap,
              decoration: const InputDecoration(
                labelText: 'Event Date',
                border: OutlineInputBorder(),
              ),
              validator: _validateDate,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Event Name',
                border: OutlineInputBorder(),
              ),
              validator: (v) => validateField(v, 'event name'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _hoursController,
              onTap: onHourFieldTap,
              decoration: const InputDecoration(
                labelText: 'Optional time',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onSubmit,
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
