import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 60, 16, 16),
        color: Colors.green,
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 1,
                    child: Container(
                      height: 30,
                      color: Colors.red,
                    )
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    color: Colors.yellow,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 100,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("hello world"),
                  Text("I am Jack"),
                ],
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              alignment: WrapAlignment.center,
              children: [
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('A'),
                  ),
                  label: Text("Hamilton"),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('B'),
                  ),
                  label: Text("Lafayette"),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('H'),
                  ),
                  label: Text("Mulligan"),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('J'),
                  ),
                  label: Text("Laurens"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}