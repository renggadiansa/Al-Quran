import 'package:get/get.dart';

import '../controllers/find_page_controller.dart';

class FindPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindPageController>(
      () => FindPageController(),
    );
  }
}
