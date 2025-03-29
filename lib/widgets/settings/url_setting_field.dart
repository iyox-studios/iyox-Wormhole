import 'package:flutter/material.dart';

class UrlSettingField extends StatefulWidget {
  final String label;
  final IconData icon;
  final String initialValue;
  final String defaultValue;
  final ValueChanged<String> onSave;
  final String? resetTooltip;

  const UrlSettingField({
    super.key,
    required this.label,
    required this.icon,
    required this.initialValue,
    required this.defaultValue,
    required this.onSave,
    this.resetTooltip,
  });

  @override
  State<UrlSettingField> createState() => _UrlSettingFieldState();
}

class _UrlSettingFieldState extends State<UrlSettingField> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late bool _isDefault;

  @override
  void initState() {
    super.initState();
    _isDefault = (widget.initialValue == widget.defaultValue);
    _controller =
        TextEditingController(text: _isDefault ? '' : widget.initialValue);
    _controller.addListener(_handleTextChange);
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleTextChange() {
    final currentText = _controller.text;
    final bool controllerValueImpliesDefault = currentText.isEmpty;
    final String valueToSave =
        controllerValueImpliesDefault ? widget.defaultValue : currentText;

    final bool newDefaultStatus = (valueToSave == widget.defaultValue);
    if (newDefaultStatus != _isDefault && mounted) {
      setState(() {
        _isDefault = newDefaultStatus;
      });
    }

    widget.onSave(valueToSave);
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void _reset() {
    _controller.removeListener(_handleTextChange);
    _controller.text = '';
    if (mounted) {
      setState(() {
        _isDefault = true;
      });
    }
    widget.onSave(widget.defaultValue);
    _controller.addListener(_handleTextChange);
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _focusNode.removeListener(_handleFocusChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String tooltip = widget.resetTooltip ?? 'Reset to default';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        style: null,
        // Standard text style
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: _isDefault ? widget.defaultValue : null,
          labelStyle: null,
          hintStyle: null,
          prefixIcon: Icon(widget.icon),
          border: const OutlineInputBorder(),
          suffixIcon: !_isDefault
              ? IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: tooltip,
                  onPressed: _reset,
                )
              : null,
        ),
        keyboardType: TextInputType.url,
      ),
    );
  }
}
