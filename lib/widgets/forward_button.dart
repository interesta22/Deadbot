
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ForwardButton extends StatelessWidget {
  final Function() onTap;
  const ForwardButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight() {
      if (Theme.of(context).textTheme.bodyLarge!.color == Colors.black) {
        return true;
      } else
        return false;
    }

    // ignore: unused_local_variable
    bool Is = isLight();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Ionicons.chevron_forward_outline,
        ),
      ),
    );
  }
}
