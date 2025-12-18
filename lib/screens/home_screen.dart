import 'package:flutter/material.dart';
import 'package:food_app/core/theme.dart';
import 'package:food_app/data/food_model.dart';
import 'package:food_app/screens/details_screen.dart';
import 'package:food_app/screens/checkout_screen.dart';
import 'package:food_app/widgets/food_card.dart';
import 'package:food_app/widgets/glass_container.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onFoodTap(FoodItem food) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => DetailsScreen(food: food),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Gradient Elements
          Positioned(
            top: -100,
            left: -100,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.15),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withOpacity(0.1),
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello',
                            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.primary),
                          ),
                          Text(
                            'Food Delivery',
                            style: AppTextStyles.displayLarge,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (_) => const CheckoutScreen())
                        ),
                        child: GlassContainer(
                          padding: const EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(12),
                          child: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),

                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _pageController,
                    itemCount: mockFoodItems.length,
                    itemBuilder: (context, index) {
                      double offset = index - _currentPage;
                      double scale = 1.0 - (offset.abs() * 0.1);
                      double opacity = 1.0 - (offset.abs() * 0.5).clamp(0.0, 0.6);
                      
                      // "Wheel/Half-Round" Animation Logic (Restored)
                      double dy = (offset.abs() * offset.abs()) * 40; // Curve depth
                      double rotation = offset * -0.15; // Rotation factor
                      double dx = offset * 10; // Spacing adjustment

                      return Transform(
                         transform: Matrix4.identity()
                           ..translate(dx, dy) 
                           ..rotateZ(rotation), 
                         alignment: Alignment.center,
                         child: Transform.scale(
                           scale: scale,
                           child: Opacity(
                             opacity: opacity,
                             child: FoodCard(
                               food: mockFoodItems[index],
                               onTap: () {
                                 // Smart interaction: Scroll to side item or open details
                                 if (index == _currentPage.round()) {
                                   _onFoodTap(mockFoodItems[index]);
                                 } else {
                                   _pageController.animateToPage(
                                     index,
                                     duration: const Duration(milliseconds: 600),
                                     curve: Curves.easeOutQuint,
                                   );
                                 }
                               },
                               parallaxOffset: offset,
                             ),
                           ),
                         ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
