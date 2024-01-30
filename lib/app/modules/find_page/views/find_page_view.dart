import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/find_page_controller.dart';

class FindPageView extends GetView<FindPageController> {
  const FindPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FindPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FindPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
