import 'package:flutter/material.dart';
import 'package:food_app/core/notifications.dart';
import 'package:food_app/core/theme.dart';
import 'package:food_app/data/food_model.dart';
import 'package:food_app/widgets/add_to_cart_button.dart';
import 'package:food_app/widgets/glass_container.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';

class DetailsScreen extends StatelessWidget {
  final FoodItem food;

  const DetailsScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
             child: Container(
               decoration: BoxDecoration(
                 gradient: RadialGradient(
                   center: const Alignment(0, -0.5),
                   radius: 0.8,
                   colors: [
                     AppColors.primary.withOpacity(0.1),
                     AppColors.background,
                   ],
                 ),
               ),
             ),
          ),
          
          Column(
            children: [
              // Header & Image Section
              Expanded(
                flex: 5,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Back Button
                    Positioned(
                      top: 50,
                      left: 20,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: GlassContainer(
                          padding: const EdgeInsets.all(12),
                          borderRadius: BorderRadius.circular(15),
                          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                    
                    // Main Hero Image
                    Hero(
                      tag: 'image_${food.id}',
                      child: Image.asset(
                        food.imagePath,
                        width: 300,
                        height: 300,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                           return Container(
                             width: 300,
                             height: 300,
                             decoration: const BoxDecoration(
                               shape: BoxShape.circle,
                               color: Colors.grey, 
                             ),
                             child: const Icon(Icons.fastfood, size: 100, color: Colors.white),
                           );
                        },
                      )
                      .animate()
                      .scale(duration: 600.ms, curve: Curves.easeOutBack)
                      .rotate(begin: -0.1, end: 0, duration: 600.ms),
                    ),
                  ],
                ),
              ),

              // Details Section
              Expanded(
                flex: 4,
                child: GlassContainer(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Expanded(
                         child: SingleChildScrollView(
                           physics: const BouncingScrollPhysics(),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Expanded(
                                     child: Text(
                                       food.name,
                                       style: AppTextStyles.displayLarge.copyWith(fontSize: 28),
                                     ),
                                   ),
                                   Text(
                                     '\$${food.price.toStringAsFixed(2)}',
                                     style: AppTextStyles.price.copyWith(fontSize: 28),
                                   ),
                                 ],
                               ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),

                               const SizedBox(height: 16),

                               Text(
                                 food.description,
                                 style: AppTextStyles.bodyLarge,
                               ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

                               const SizedBox(height: 24),

                               Text('Ingredients', style: AppTextStyles.titleMedium)
                                   .animate().fadeIn(delay: 200.ms),
                               
                               const SizedBox(height: 12),
                               
                               SizedBox(
                                 height: 50,
                                 child: ListView.separated(
                                   scrollDirection: Axis.horizontal,
                                   itemCount: food.ingredients.length,
                                   separatorBuilder: (_, __) => const SizedBox(width: 8),
                                   itemBuilder: (context, index) {
                                     return Chip(
                                       backgroundColor: AppColors.surface,
                                       label: Text(
                                         food.ingredients[index],
                                         style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                                       ),
                                       side: BorderSide.none,
                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                     ).animate().scale(delay: (200 + index * 50).ms, duration: 300.ms);
                                   },
                                 ),
                               ),
                               const SizedBox(height: 20), // Bottom padding for scroll content
                             ],
                           ),
                         ),
                       ),
                       
                       const SizedBox(height: 10),
                       
                       AnimatedAddToCartButton(
                         onTap: () {
                           AppNotifications.showSuccess(context, 'Added ${food.name} to cart!');
                         },
                       ).animate().slideY(begin: 1.0, end: 0, delay: 400.ms, duration: 500.ms, curve: Curves.easeOutQuint),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
