
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;

class CvViewer extends StatelessWidget {

 String  text;
 CvViewer({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffEEEEEE),
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
            ),
            child: ClipRRect( borderRadius: BorderRadius.circular(15),
                child: PDFView(filePath: text)),
          ),

          Container(
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
            height: 40.h,
width: double.infinity,
child: Text(path.basenameWithoutExtension(text)),
          ),

        ],
      ),
    );
  }
}
