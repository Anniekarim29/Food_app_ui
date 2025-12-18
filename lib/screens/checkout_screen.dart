import 'package:flutter/material.dart';
import 'package:food_app/core/theme.dart';
import 'package:food_app/widgets/glass_container.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _processing = false;
  bool _success = false;

  void _processCheckout() async {
    setState(() => _processing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _processing = false;
      _success = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) Navigator.pop(context); // Go back home
  }

  @override
  void initState() {
    super.initState();
    // Simulate immediate checkout start for demo or just user interaction
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background
           Positioned.fill(
             child: Container(
               decoration: BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.topLeft,
                   end: Alignment.bottomRight,
                   colors: [
                     AppColors.surface,
                     AppColors.background,
                   ],
                 ),
               ),
             ),
           ),

           Center(
             child: _success ? _buildSuccess() : _buildOrderSummary(),
           ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GlassContainer(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Checkout', style: AppTextStyles.displayLarge)
                .animate().fadeIn().slideY(begin: -0.5, end: 0),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal', style: AppTextStyles.bodyLarge),
                Text('\$56.50', style: AppTextStyles.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery', style: AppTextStyles.bodyLarge),
                Text('\$5.00', style: AppTextStyles.titleMedium),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Divider(color: Colors.white24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: AppTextStyles.titleLarge),
                Text('\$61.50', style: AppTextStyles.price.copyWith(fontSize: 24)),
              ],
            ),
            const SizedBox(height: 48),
            GestureDetector(
              onTap: _processing ? null : _processCheckout,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: _processing 
                    ? const SizedBox(
                        height: 24, width: 24, 
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      )
                    : Text(
                        'Pay Now', 
                        style: AppTextStyles.titleMedium.copyWith(color: Colors.white)
                      ),
                ),
              ),
            ).animate().scale(delay: 200.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 10,
              )
            ],
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 50),
        ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
        const SizedBox(height: 32),
        Text('Order Placed!', style: AppTextStyles.displayLarge)
            .animate().fadeIn(delay: 300.ms).slideY(begin: 0.5, end: 0),
        const SizedBox(height: 16),
        Text('Your food is on the way.', style: AppTextStyles.bodyLarge)
            .animate().fadeIn(delay: 500.ms),
      ],
    );
  }
}
