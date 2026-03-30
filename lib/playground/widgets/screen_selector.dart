import 'package:flutter/material.dart';

/// Dropdown + "New" button that lets the user pick an existing screen
/// contract from bundled assets or start with a fresh template.
class ScreenSelector extends StatelessWidget {
  final List<String> availableScreens;
  final String? selectedScreen;
  final ValueChanged<String?> onScreenSelected;
  final VoidCallback onNewPressed;

  const ScreenSelector({
    super.key,
    required this.availableScreens,
    this.selectedScreen,
    required this.onScreenSelected,
    required this.onNewPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedScreen,
              hint: const Text('Load a screen...'),
              isDense: true,
              items: availableScreens
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: onScreenSelected,
            ),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: onNewPressed,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('New'),
        ),
      ],
    );
  }
}
