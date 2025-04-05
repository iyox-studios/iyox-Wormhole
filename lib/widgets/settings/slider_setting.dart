import 'package:flutter/material.dart';

class SliderSetting extends StatefulWidget {
  final String label;
  final IconData icon;
  final double min;
  final double max;
  final int divisions;
  final int initialValue;
  final ValueChanged<int> onSave;

  const SliderSetting({
    super.key, // Added key
    required this.label,
    required this.icon,
    required this.min,
    required this.max,
    required this.divisions,
    required this.initialValue,
    required this.onSave,
  });

  @override
  State<SliderSetting> createState() => _SliderSettingState();
}

class _SliderSettingState extends State<SliderSetting> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(widget.icon),
            title: Text(widget.label),
            trailing: Text(
              _currentValue.round().toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Slider(
            value: _currentValue,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions,
            label: _currentValue.round().toString(),
            onChanged: (double value) {
              if (mounted) {
                setState(() {
                  _currentValue = value;
                });
              }
            },
            onChangeEnd: (double value) {
              widget.onSave(value.round());
            },
          ),
        ],
      ),
    );
  }
}
