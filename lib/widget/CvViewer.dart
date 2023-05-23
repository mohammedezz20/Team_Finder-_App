import 'package:advanced_project/SizeCalc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:path/path.dart' as path;

class CvViewer extends StatelessWidget {
  String text;
  VoidCallback function;
  var icon;
  CvViewer({super.key, required this.text,required this.icon,required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: getHeight(context, 10)),
      child: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
                color: const Color(0xffEEEEEE),
                border: Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(17)),
            child: Column(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      child: PDFView(filePath: text)),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),

                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    height: getHeight(context, 40),
                    width: double.infinity,
                    child: Padding(
                      padding:  EdgeInsets.only(left: getWidth(context, 10)),
                      child: Text(path.basenameWithoutExtension(text)
                      ,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
                      maxLines: 1,overflow: TextOverflow.ellipsis,),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: MaterialButton(
              height: getHeight(context, 28),
              minWidth: getWidth(context, 28),
              padding: EdgeInsets.zero,
              onPressed: function,
              child: Container(
                height: getHeight(context, 26),
                width: getWidth(context, 26),

                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle
                ),
                child: Icon(icon,color: Colors.white,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
