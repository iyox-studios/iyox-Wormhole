import 'package:flutter/material.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/utils/wordlist.dart';
import 'package:iyox_wormhole/widgets/app_bar.dart';
import 'package:iyox_wormhole/widgets/large_icon_button.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({super.key});

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String _suggestion = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateSuggestion);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateSuggestion);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateSuggestion() {
    final input = _controller.text;
    if (input.isEmpty) {
      setState(() => _suggestion = '');
      return;
    }
    // Find the first matching word from the list (case insensitive)
    final match = wordlist.firstWhere(
          (word) => word.toLowerCase().startsWith(input.toLowerCase()),
      orElse: () => '',
    );
    setState(() {
      _suggestion = match;
    });
  }

  void _acceptSuggestion() {
    if (_suggestion.isNotEmpty &&
        _suggestion.toLowerCase().startsWith(_controller.text.toLowerCase())) {
      setState(() {
        _controller.text = _suggestion;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
        _suggestion = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: t.common.page_titles.receive,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          //alignment: Alignment.centerLeft,
          children: [
            // Underlay for suggestion text.
            /*GestureDetector(
              onTap: _acceptSuggestion,
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodySmall!,
                  children: [
                    // Display the user-typed part.
                    TextSpan(text: _controller.text),
                    // If there is a suggestion that continues the input, display it.
                    if (_suggestion.isNotEmpty &&
                        _suggestion.toLowerCase().startsWith(
                            _controller.text.toLowerCase()) &&
                        _controller.text.isNotEmpty)
                      TextSpan(
                        text: _suggestion.substring(_controller.text.length),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                      ),
                  ],
                ),
              ),
            ),
            // The actual text field.
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              //style: Theme.of(context).textTheme.bodyLarge!.copyWith(color:Colors.transparent),
              decoration: InputDecoration(
                hintText: 'Type a fruit...',
                // Suffix icon appears when a suggestion is available.
                suffixIcon: _suggestion.isNotEmpty &&
                    _suggestion.toLowerCase().startsWith(
                        _controller.text.toLowerCase())
                    ? IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: _acceptSuggestion,
                )
                    : null,
              ),
            ),
            */
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: lightenOrDarken(Theme.of(context).colorScheme.surfaceContainerHigh, 0.03),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(240),
                ),
                hintText: 'Enter Code',
                prefixIcon: Icon(Icons.password)
              ),
            ),
            SizedBox.fromSize(size: Size.fromHeight(20)),
            LargeIconButton(onPressed: ()=>{}, label: Text('Receive File'), icon: Icons.sim_card_download_outlined)
          ],
        ),
      ),
    );
  }

  Color lightenOrDarken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);

    final lightness = Theme.of(context).brightness == Brightness.dark ? hsl.lightness + amount : hsl.lightness - amount;
    final hslTinted = hsl.withLightness((lightness).clamp(0.0, 1.0));

    return hslTinted.toColor();
  }
}
