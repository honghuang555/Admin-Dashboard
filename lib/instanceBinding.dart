
import 'package:admin/controllers/clientController.dart';
import 'package:get/get.dart';


class InstanceBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(ClientController());
  }
}
