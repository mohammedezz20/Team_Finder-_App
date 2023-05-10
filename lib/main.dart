import 'dart:io';
import 'package:advanced_project/res/assets_res.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appcubit.dart';
import 'package:advanced_project/shared/cubit/loginCubit/logincubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'Screens/authScreen.dart';

String? imagePath;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

   imagePath = await saveAssetImageToDevice();

  runApp(const MyApp());
}

XFile ImageFile = XFile(imagePath!);
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<Logincubit>(
          create: (context) => Logincubit()..imageFile=ImageFile,
        ),
        BlocProvider<AppCubit>(
          create: (context) => AppCubit()..loadUserData(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: child,
          );
        },
        child:  const AuthScreen(),
      ),
    );
  }
}




Future<String> saveAssetImageToDevice() async {
  // Get the directory for the app's document path
  Directory? appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;

  // Create the image file path
  String imagePath = '$appDocPath/default.png';

  // Check if the image file already exists
  File imageFile = File(imagePath);
  if (await imageFile.exists()) {
    return imagePath;
  }

  // Read the image data from assets
  ByteData imageData = await rootBundle.load(AssetsRes.DEFAULT);

  // Save the image data to the device
  await imageFile.writeAsBytes(imageData.buffer.asUint8List());

  return imagePath;
}