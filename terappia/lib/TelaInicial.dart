import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              expandedHeight: 80.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
              ),
            )
          ],
        ),
      )
    );
  }

}