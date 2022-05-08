import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/countdown_controller.dart';

class TomatoIcon extends StatefulWidget {
  final Rx<stateRound> state;
  const TomatoIcon(this.state, {Key? key}) : super(key: key);

  @override
  State<TomatoIcon> createState() => _TomatoIconState();
}

class _TomatoIconState extends State<TomatoIcon> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButton(
          onPressed: null,
          icon: widget.state.value == stateRound.done
              ? Image.asset('assets/icons/tomatoDone.png')
              : Image.asset('assets/icons/tomatoUndone.png')),
    );
  }
}
