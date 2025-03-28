import 'package:flutter/material.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/utils/color.dart';
import 'package:iyox_wormhole/utils/wordlist.dart';

class CodeInput extends StatefulWidget {
  const CodeInput({super.key, required this.onTap, required this.controller});

  final Function onTap;
  final TextEditingController controller;

  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  final FocusNode _focusNode = FocusNode();

  String _suggestion = '';
  double _textOffset = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateSuggestion);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _updateSuggestion() {
    final text = widget.controller.text;

    if (text.split('-').last == '') {
      setState(() {
        _suggestion = '';
      });
      return;
    }

    final suggestion = wordlist.firstWhere(
      (word) => word.toLowerCase().startsWith(text.split('-').last.toLowerCase()),
      orElse: () => '',
    );

    if (suggestion.isNotEmpty && suggestion != text) {
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: Theme.of(context).textTheme.bodyLarge),
        textDirection: TextDirection.ltr,
      )..layout();
      setState(() {
        _suggestion = text + suggestion.substring(text.split('-').last.length);
        _textOffset = textPainter.width;
      });
    } else {
      setState(() {
        _suggestion = '';
        _textOffset = 0;
      });
    }
  }

  void _acceptSuggestion() {
    if (_suggestion.isNotEmpty) {
      final length = _suggestion.length;
      widget.controller.text = _suggestion;
      widget.controller.selection = TextSelection.collapsed(offset: length);
      setState(() => _suggestion = '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge ?? const TextStyle();

    return Stack(
      children: [
        TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            filled: true,
            fillColor: themeAwareTint(
              Theme.of(context).colorScheme.surfaceContainerHigh,
              Theme.of(context).colorScheme.brightness,
              0.03,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(240),
            ),
            hintText: t.pages.receive.code_input_hint,
            prefixIcon: Icon(Icons.password),
            suffixIcon: _suggestion.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.grey),
                    onPressed: _acceptSuggestion,
                  )
                : null,
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _acceptSuggestion(),
          onTap: ()=>widget.onTap(),
        ),
        if (_suggestion.isNotEmpty)
          Positioned(
            left: 48 + _textOffset,
            top: 16,
            child: GestureDetector(
              onTap: _acceptSuggestion,
              child: Text(
                _suggestion.substring(widget.controller.text.length),
                style: textStyle.copyWith(
                    //color: Colors.grey.withOpacity(0.7),
                    color: Colors.grey.shade400),
              ),
            ),
          ),
      ],
    );
  }
}
