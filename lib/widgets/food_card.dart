import 'package:flutter/material.dart';
import 'package:food_app/core/notifications.dart';
import 'package:food_app/core/theme.dart';
import 'package:food_app/data/food_model.dart';
import 'package:food_app/widgets/add_to_cart_button.dart';
import 'package:food_app/widgets/glass_container.dart';
import 'dart:math' as math;

class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;
  final double parallaxOffset; // -1 to 1 based on page position

  const FoodCard({
    super.key,
    required this.food,
    required this.onTap,
    this.parallaxOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Food Image Area - Takes remaining space
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Soft Glow/Shadow behind the plate
                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 60,
                        spreadRadius: 10,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                ),
                // Circular Plate/Background
                Hero(
                  tag: 'plate_${food.id}',
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                    ),
                  ),
                ),
                // The Food Image itself
                Transform(
                  transform: Matrix4.translationValues(parallaxOffset * 30, 0, 0), 
                  child: Hero(
                    tag: 'image_${food.id}',
                    child: Transform.rotate(
                      angle: parallaxOffset * 0.1 * math.pi,
                      child: Container(
                        width: 320,
                        height: 320,
                        alignment: Alignment.center,
                        child: Image.asset(
                          food.imagePath,
                          fit: BoxFit.contain, // Restore full view
                          errorBuilder: (context, error, stackTrace) {
                             return Container(
                               color: Colors.grey,
                               child: const Icon(Icons.fastfood, size: 80, color: Colors.white),
                             );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Info Card - Auto sized based on content
          Padding(
            padding: const EdgeInsets.all(16.0), // Reduced margins
            child: GlassContainer(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Reduced padding
              child: Column(
                mainAxisSize: MainAxisSize.min, // Vital for preventing overflow
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    food.name,
                    style: AppTextStyles.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4), // Reduced spacing
                  
                  // Description
                  Text(
                    food.description,
                    style: AppTextStyles.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12), // Reduced spacing
                  
                  // Price and Add to Cart Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${food.price.toStringAsFixed(2)}',
                        style: AppTextStyles.price.copyWith(fontSize: 22),
                      ),
                      const SizedBox(width: 12),
                      // Compact Add to Cart Button
                      Expanded(
                        child: AnimatedAddToCartButton(
                          onTap: () {
                            AppNotifications.showSuccess(context, 'Added ${food.name} to cart!');
                          },
                          compact: true, 
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
