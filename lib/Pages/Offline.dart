import 'package:flutter/material.dart';

import '../vars/Globals.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: AppTheme.currentTheme.brightness == Brightness.dark ? Colors.black : Colors.white,
      child: Center(child: Text("No Internt Connection",style: style.copyWith(fontSize: 25,fontWeight: FontWeight.w900),),),
    );
  }
}
