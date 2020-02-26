import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _fabSize = 56.0;

class FabButtonAnimations extends StatelessWidget {
  final Widget childOpen;
  final Color color;
  const FabButtonAnimations(this.childOpen, this.color);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      transitionDuration: Duration(milliseconds: 800),
      openBuilder: (BuildContext context, VoidCallback _) {
        return childOpen;
      },
      closedElevation: 6.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_fabSize / 2.0),
        ),
      ),
      closedColor: color,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return SizedBox(
          height: _fabSize,
          width: _fabSize,
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
