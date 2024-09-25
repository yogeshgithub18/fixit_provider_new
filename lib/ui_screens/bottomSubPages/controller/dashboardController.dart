import 'package:get/get.dart';


class DashBoardController extends GetxController {
  RxInt currentIndex = 0.obs;
  List<BoxModal> list = [
    BoxModal("Plumber", "assets/images/plumber.svg"),
    BoxModal("Electrical", "assets/images/electric.svg"),
    BoxModal("Plumbing", "assets/images/plumbing.svg"),
    BoxModal("Workers", "assets/images/workers.svg"),
    BoxModal("Gardeners", "assets/images/gardener.svg"),
    BoxModal("Plumber", "assets/images/plumber.svg"),
    BoxModal("Plumber", "assets/images/plumber.svg"),
    BoxModal("Electrical", "assets/images/electric.svg"),
    BoxModal("Plumbing", "assets/images/plumbing.svg"),
    BoxModal("Workers", "assets/images/workers.svg"),
    BoxModal("Gardeners", "assets/images/gardener.svg"),
    BoxModal("Plumber", "assets/images/plumber.svg"),
    BoxModal("Plumber", "assets/images/plumber.svg"),
    BoxModal("Electrical", "assets/images/electric.svg"),
    BoxModal("Plumbing", "assets/images/plumbing.svg"),
    BoxModal("Workers", "assets/images/workers.svg"),
    BoxModal("Gardeners", "assets/images/gardener.svg"),
    BoxModal("Plumber", "assets/images/plumber.svg"),
    BoxModal("Plumber", "assets/images/plumber.svg"),
    BoxModal("Electrical", "assets/images/electric.svg"),
    BoxModal("Plumbing", "assets/images/plumbing.svg"),
    BoxModal("Workers", "assets/images/workers.svg"),
    BoxModal("Gardeners", "assets/images/gardener.svg"),
    BoxModal("Plumber", "assets/images/plumber.svg"),
    BoxModal("Plumber", "assets/images/plumber.svg"),
    BoxModal("Electrical", "assets/images/electric.svg"),
    BoxModal("Plumbing", "assets/images/plumbing.svg"),
    BoxModal("Workers", "assets/images/workers.svg"),
    BoxModal("Gardeners", "assets/images/gardener.svg"),
    BoxModal("Plumber", "assets/images/plumber.svg"),
    BoxModal("Plumber", "assets/images/plumber.svg"),
    BoxModal("Electrical", "assets/images/electric.svg"),
    BoxModal("Plumbing", "assets/images/plumbing.svg"),
    BoxModal("Workers", "assets/images/workers.svg"),
    BoxModal("Gardeners", "assets/images/gardener.svg"),
    BoxModal("Plumber", "assets/images/plumber.svg"),
  ];
}

class BoxModal {
  String title;
  String image;

  BoxModal(this.title, this.image);
}
