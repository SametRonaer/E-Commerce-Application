import 'package:flutter/material.dart';

class ProductDefinitionWindow extends StatelessWidget {
  const ProductDefinitionWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
              ),
              title: const Text('Tabs Demo'),
            ),
            const TabBarView(
              children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
