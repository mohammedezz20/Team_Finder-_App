import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/Colors.dart';

class choosePickType extends StatelessWidget {

var pickByCamera;
var pickByGallery;

choosePickType({required this.pickByCamera, required this.pickByGallery});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pick Image From',
              style:
              Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed:pickByGallery,
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                        buttonColor),
                  ),
                  child: const Text('Gallery'),
                ),
                ElevatedButton(
                  onPressed: pickByCamera,
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                        buttonColor),
                  ),
                  child: const Text('Camera'),
                ),
              ],
            ),
          ],
        ),
      ),
    );;
  }
}
