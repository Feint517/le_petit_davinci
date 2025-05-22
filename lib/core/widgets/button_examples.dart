import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/widgets/buttons.dart';
import 'package:le_petit_davinci/core/widgets/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/pill_button.dart';

/// A widget that demonstrates various button styles and configurations
class ButtonExamples extends StatefulWidget {
  const ButtonExamples({super.key});

  @override
  State<ButtonExamples> createState() => _ButtonExamplesState();
}

class _ButtonExamplesState extends State<ButtonExamples> {
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Button Examples
            const Text(
              'Custom Buttons',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Button Variants
            const Text('Button Variants:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                CustomButton(
                  label: 'Primary',
                  onPressed: () {},
                ),
                CustomButton(
                  label: 'Secondary',
                  variant: ButtonVariant.secondary,
                  onPressed: () {},
                ),
                CustomButton(
                  label: 'Ghost',
                  variant: ButtonVariant.ghost,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Button Sizes
            const Text('Button Sizes:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                CustomButton(
                  label: 'Small',
                  size: ButtonSize.sm,
                  onPressed: () {},
                ),
                CustomButton(
                  label: 'Medium',
                  size: ButtonSize.md,
                  onPressed: () {},
                ),
                CustomButton(
                  label: 'Large',
                  size: ButtonSize.lg,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Buttons with Icons
            const Text('Buttons with Icons:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                CustomButton(
                  label: 'Left Icon',
                  icon: const Icon(Icons.favorite),
                  iconPosition: IconPosition.left,
                  onPressed: () {},
                ),
                CustomButton(
                  label: 'Right Icon',
                  icon: const Icon(Icons.arrow_forward),
                  iconPosition: IconPosition.right,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Button States
            const Text('Button States:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                CustomButton(
                  label: 'Disabled',
                  disabled: true,
                  onPressed: () {},
                ),
                CustomButton(
                  label: 'Loading',
                  isLoading: _isLoading,
                  onPressed: _toggleLoading,
                ),
                CustomButton(
                  label: 'Full Width',
                  width: double.infinity,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Icon Buttons
            const Text('Icon Buttons:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                CustomIconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: const Icon(Icons.favorite),
                  variant: ButtonVariant.secondary,
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: const Icon(Icons.close),
                  variant: ButtonVariant.ghost,
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: const Icon(Icons.refresh),
                  isLoading: _isLoading,
                  onPressed: _toggleLoading,
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // Pill Button Examples
            const Text(
              'Pill Buttons (with hover effects)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Pill Button Variants
            const Text('Pill Button Variants:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                PillButton(
                  label: 'Primary',
                  onPressed: () {},
                ),
                PillButton(
                  label: 'Secondary',
                  variant: ButtonVariant.secondary,
                  onPressed: () {},
                ),
                PillButton(
                  label: 'Ghost',
                  variant: ButtonVariant.ghost,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Pill Button Sizes
            const Text('Pill Button Sizes:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                PillButton(
                  label: 'Small',
                  size: ButtonSize.sm,
                  onPressed: () {},
                ),
                PillButton(
                  label: 'Medium',
                  size: ButtonSize.md,
                  onPressed: () {},
                ),
                PillButton(
                  label: 'Large',
                  size: ButtonSize.lg,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Pill Buttons with Icons
            const Text('Pill Buttons with Icons:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                PillButton(
                  label: 'Play',
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {},
                ),
                PillButton(
                  label: 'Next',
                  icon: const Icon(Icons.arrow_forward),
                  iconPosition: IconPosition.right,
                  onPressed: () {},
                ),
                PillButton(
                  label: 'Login',
                  icon: const Icon(Icons.login),
                  variant: ButtonVariant.secondary,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Pill Button States
            const Text('Pill Button States:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                PillButton(
                  label: 'Disabled',
                  disabled: true,
                  onPressed: () {},
                ),
                PillButton(
                  label: 'Loading',
                  isLoading: _isLoading,
                  onPressed: _toggleLoading,
                ),
                PillButton(
                  label: 'Full Width',
                  width: double.infinity,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleLoading,
        child: Icon(_isLoading ? Icons.stop : Icons.refresh),
      ),
    );
  }
}