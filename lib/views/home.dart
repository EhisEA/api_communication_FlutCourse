import 'dart:convert';
import 'dart:developer';

import 'package:api_communication_flut_course/views/gol.dart' as l;
import 'package:api_communication_flut_course/views/rol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:http/http.dart';
// import 'package:http';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  login() async {
    l.She();
    Pan();
    setState(() {
      isLoading = true;
    });

    Response response = await post(
      Uri.parse("https://dwellings-app.herokuapp.com/api/login"),
      body: {
        "phoneNumber": _phoneController.text,
        "password": _passwordController.text,
      },
    );

    Map<String, dynamic> result = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        FlutterToastr.show(
          "Login Complete",
          context,
          backgroundColor: Colors.green,
          textStyle: const TextStyle(color: Colors.white),
        );
        break;
      default:
        FlutterToastr.show(
          "Login Failed : ${result["message"]} ",
          context,
          backgroundColor: Colors.red,
          duration: 5,
          textStyle: const TextStyle(color: Colors.white),
        );
    }
    // if(response.statusCode==)

    log(response.body);
    log(response.statusCode.toString());
    // await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  label: Text("Phone"),
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : login,
                child: isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : const Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.centerRight,
//                     end: Alignment.centerLeft,
//                     colors: [
//                       // Color(0xffF9E177),
//                       // Color(0xffFFBE94),
//                       Color(0xff7A541A),
//                       Color(0xff674A3D)
//                     ],
//                   ),
//                 ),
//                 child: Image.asset(
//                   "assets/images/back.png",
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//             Container(
//               decoration: const BoxDecoration(
//                 // backgroundBlendMode: BlendMode.colorDodge,
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     // Color(0xffF9E177),
//                     // Color(0xffFFBE94),
//                     Colors.transparent,
//                     Colors.transparent,
//                     Colors.black
//                   ],
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Expanded(child: Icon(Icons.abc)),
//                   Text(
//                     "Our timeline is filled with performances "
//                     "& infomations you wouldn’t want to miss out on.",
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
