import 'package:flutter/material.dart';
import 'package:food_app/core/theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedAddToCartButton extends StatefulWidget {
  final bool compact;
  final VoidCallback onTap;

  const AnimatedAddToCartButton({super.key, required this.onTap, this.compact = false});

  @override
  State<AnimatedAddToCartButton> createState() => _AnimatedAddToCartButtonState();
}

class _AnimatedAddToCartButtonState extends State<AnimatedAddToCartButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
          height: widget.compact ? 48 : 56, // Smaller if compact
          padding: EdgeInsets.symmetric(horizontal: widget.compact ? 16 : 24),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: widget.compact ? MainAxisSize.max : MainAxisSize.min, // maximize width if compact (inside Expanded)
            children: [
              const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20)
                  .animate(target: _isPressed ? 1 : 0)
                  .shake(duration: 300.ms),
              if (!widget.compact) ...[ // Adjust text for compact mode
                const SizedBox(width: 12),
                Text(
                  'Add to Cart',
                  style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
                ),
              ] else ...[
                 const SizedBox(width: 8),
                 Text(
                  'Add',
                  style: AppTextStyles.titleMedium.copyWith(color: Colors.white, fontSize: 16),
                 ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
