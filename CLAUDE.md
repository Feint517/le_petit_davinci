 LePetitDavinci - User Selection Screen Implementation

## Task Overview
Implement a user type selection screen using the provided assets and existing button components.

## Provided Assets
1. **Logo**: `Logo.svg` - Will be provided and should be displayed at the top
2. **Illustration**: `chooseSvg.svg` - ABC characters illustration that needs floating animation
3. **Buttons**: Already exist as components in `core/widgets/`

## Screen Layout

### Structure (Top to Bottom):
1. **Logo Section**
   - Display `Logo.svg` using `SvgPicture.asset`
   - Center aligned
   - Add appropriate top padding

2. **Illustration Section**
   - Display the provided SVG illustration (`chooseSvg.svg`)
   - Center aligned
   - Responsive sizing
   - **Floating animation**: Gentle up and down movement using `flutter_animate`

3. **Question Text**
   - Text: "Qui utilise l'application ?"
   - Large, bold font
   - Blue color from ColorManager
   - Center aligned

4. **Two Selection Buttons**
   - **Parent Button**: 
     - Text: "Je suis un parent"
     - Blue style
     - Navigate to parent flow on tap
   - **Child Button**: 
     - Text: "C'est mon enfant"
     - Orange/yellow style
     - Navigate to child flow on tap

## Implementation Details

### File Location
```
lib/features/onboarding/
├── controllers/
│   └── user_selection_controller.dart
├── bindings/
│   └── user_selection_binding.dart
├── views/
│   └── user_selection_page.dart
```

### Controller
```dart
class UserSelectionController extends GetxController {
  void onParentSelected() {
    Get.toNamed(Routes.PARENT_ONBOARDING);
  }
  
  void onChildSelected() {
    Get.toNamed(Routes.CHILD_SETUP);
  }
}
```

### View Implementation
```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class UserSelectionPage extends GetView<UserSelectionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundLight, // Light blue background
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Gap(40.h),
              // Logo from assets
              SvgPicture.asset(
                AssetsManager.logo, // Logo.svg
                height: 60.h,
              ),
              const Spacer(flex: 1),
              // SVG Illustration with floating animation
              SvgPicture.asset(
                AssetsManager.chooseSvg, // chooseSvg.svg
                height: 300.h,
              ).animate(
                onPlay: (controller) => controller.repeat(reverse: true),
              ).moveY(
                begin: 0,
                end: -10,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
              ),
              const Spacer(flex: 1),
              // Question text
              Text(
                StringsManager.whoUsesApp, // "Qui utilise l'application ?"
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.primary,
                ),
              ),
              Gap(40.h),
              // Parent button (use existing button component)
              PrimaryButton( // or whatever the button component is named
                text: StringsManager.iAmParent, // "Je suis un parent"
                onPressed: controller.onParentSelected,
                backgroundColor: ColorManager.primaryBlue,
              ),
              Gap(16.h),
              // Child button (use existing button component)
              PrimaryButton( // or whatever the button component is named
                text: StringsManager.itsMyChild, // "C'est mon enfant"
                onPressed: controller.onChildSelected,
                backgroundColor: ColorManager.primaryOrange,
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Key Requirements
1. **Assets**: 
   - Logo: `Logo.svg` (referenced as `AssetsManager.logo`)
   - Illustration: `chooseSvg.svg` (referenced as `AssetsManager.chooseSvg`)
2. **Animation**: Add floating animation to the SVG illustration using `flutter_animate`
3. **Buttons**: Import and use the existing button components from `core/widgets/`
4. **Colors**: Use `ColorManager` for all colors
5. **Strings**: Use `StringsManager` for all text
6. **Spacing**: Use `Gap` widget (not SizedBox)
7. **Responsive**: Use `.h`, `.w`, `.sp` from screenutil for all dimensions
8. **Background**: Light blue/cyan color from ColorManager

### Don't Forget
- Import `flutter_animate` package for the floating animation
- Add route to `app_routes.dart`
- Add GetPage to `app_pages.dart`
- Create binding and add to route
- All text must come from StringsManager
- All colors must come from ColorManager
- All assets must be referenced through AssetsManager
- The SVG should have a smooth floating animation