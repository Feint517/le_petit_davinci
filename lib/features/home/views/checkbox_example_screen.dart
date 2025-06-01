import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/widgets/checkbox_widget.dart';

/// Écran d'exemple pour montrer l'utilisation du widget CheckboxWidget
class CheckboxExampleScreen extends StatefulWidget {
  const CheckboxExampleScreen({super.key});

  @override
  State<CheckboxExampleScreen> createState() => _CheckboxExampleScreenState();
}

class _CheckboxExampleScreenState extends State<CheckboxExampleScreen> {
  // Pour les cases individuelles
  bool _isOption1Selected = false;
  bool _isOption2Selected = false;
  
  // Pour le groupe de cases à cocher
  List<String> _selectedGroupValues = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemples de cases à cocher'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cases à cocher individuelles',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
            Gap(16.h),
            
            // Exemple de cases à cocher individuelles
            CheckboxWidget(
              title: '5 minutes',
              subtitle: 'Juste pour m\'amuser',
              iconPath: SvgAssets.letterA,
              isSelected: _isOption1Selected,
              onTap: () {
                setState(() {
                  _isOption1Selected = !_isOption1Selected;
                });
              },
            ),
            
            CheckboxWidget(
              title: '10 minutes',
              subtitle: 'Un petit défi',
              iconPath: SvgAssets.letterB,
              isSelected: _isOption2Selected,
              onTap: () {
                setState(() {
                  _isOption2Selected = !_isOption2Selected;
                });
              },
            ),
            
            Gap(32.h),
            
            Text(
              'Groupe de cases à cocher (sélection unique)',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
            Gap(16.h),
            
            // Exemple de groupe avec sélection unique
            CheckboxGroup(
              options: [
                CheckboxOption(
                  value: '5',
                  title: '5 minutes',
                  subtitle: 'Juste pour m\'amuser',
                  iconPath: SvgAssets.compassIcon,
                ),
                CheckboxOption(
                  value: '10',
                  title: '10 minutes',
                  subtitle: 'Un petit défi',
                  iconPath: SvgAssets.compassIcon,
                ),
                CheckboxOption(
                  value: '15',
                  title: '15 minutes ou +',
                  subtitle: 'Je veux apprendre beaucoup',
                  iconPath: SvgAssets.compassIcon,
                ),
              ],
              onSelectionChanged: (values) {
                setState(() {
                  _selectedGroupValues = values;
                });
                debugPrint('Sélection: $values');
              },
              multipleSelection: false,
            ),
            
            Gap(20.h),
            Text('Sélection actuelle: ${_selectedGroupValues.join(", ")}'),
          ],
        ),
      ),
    );
  }
}
