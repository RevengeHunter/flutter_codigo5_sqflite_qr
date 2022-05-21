import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/input_textfield_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // @override
  // Widget build(BuildContext context) {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.white,
  //     statusBarIconBrightness: Brightness.dark,
  //     systemNavigationBarColor: Colors.white,
  //     systemNavigationBarIconBrightness: Brightness.dark,
  //   ));
  //   return MaterialApp(
  //     title: 'QR.Flutter',
  //     theme: ThemeData.light(),
  //     debugShowCheckedModeBanner: false,
  //     home: MainScreen(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: kFontPrimaryColor,
        ),
        title: Text(
          "Vaccine Storage",
          style: TextStyle(
            color: kFontPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Register new vaccin card",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InputTextFieldWidget(
                    txtName: "FullName",
                    iconPath: 'assets/icons/bxl-user.svg',
                  ),
                  InputTextFieldWidget(
                    txtName: "DNI",
                    iconPath: 'assets/icons/bxs-id-card.svg',
                  ),
                  QrImage(
                    data:
                        "https://www.youtube.com/watch?v=fOoIKnGLaTo&list=RDfOoIKnGLaTo&start_radio=1&ab_channel=DanyR%C3%B8bel",
                    version: QrVersions.auto,
                    size: 300,
                    gapless: false,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 52.0,
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kBrandPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanerQRPage()));
                },
                child: const Text(
                  "Save Vaccine Card",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
