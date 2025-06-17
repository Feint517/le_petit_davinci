import 'package:get/get.dart';

enum SectionType { stars, badges, titles }

class RewardsController extends GetxController {
  // Or use an enum for clarity:
  var selectedSection = SectionType.stars.obs;
}
