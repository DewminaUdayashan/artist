import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class AnimatedBg extends StatefulWidget {
  const AnimatedBg({Key? key}) : super(key: key);

  @override
  State<AnimatedBg> createState() => _AnimatedBgState();
}

class _AnimatedBgState extends State<AnimatedBg> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      behaviour: RandomParticleBehaviour(
        options: const ParticleOptions(
          spawnMaxSpeed: 80,
          spawnMinSpeed: 10,
          baseColor: Colors.deepPurpleAccent,
          spawnMaxRadius: 14,
        ),
      ),
      vsync: this,
      child: const SizedBox.shrink(),
    );
  }
}
