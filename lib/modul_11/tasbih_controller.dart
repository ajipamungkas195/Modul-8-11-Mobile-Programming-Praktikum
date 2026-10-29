import 'package:get/get.dart';

class TasbihController extends GetxController {
  // .obs menandakan bahwa variabel ini reaktif (observable)
  var counter = 0.0.obs;
  var progress = 0.0.obs;
  final double maxCount = 33;

  void incrementCounter() {
    if (counter < maxCount) {
      counter.value++;
      progress.value = (counter.value / maxCount) * 100;
    }
  }

  void resetCounter() {
    counter.value = 0.0;
    progress.value = 0.0;
  }
}