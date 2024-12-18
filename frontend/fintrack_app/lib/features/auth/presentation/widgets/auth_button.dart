import 'package:flutter/material.dart';

final class AuthButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

final class _AuthButtonState extends State<AuthButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    // Replace this with your custom gradient color if `primary20` is defined elsewhere
    final gradientColors = _isHovering
        ? [
            const Color.fromRGBO(173, 178, 255, 1),
            const Color.fromRGBO(173, 178, 255, 0.8),
          ]
        : [
            const Color.fromRGBO(143, 148, 251, 1),
            const Color.fromRGBO(143, 148, 251, 0.6),
          ];

    // Use primary20 gradient if available
    final primary20Gradient = LinearGradient(
      colors: gradientColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return MouseRegion(
      onEnter: (_) => _updateHoverState(true),
      onExit: (_) => _updateHoverState(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: primary20Gradient,
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _updateHoverState(bool isHovering) {
    setState(() => _isHovering = isHovering);
  }
}
