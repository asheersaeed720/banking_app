import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/utils/input_decoration.dart';
import 'package:banking_app/widgets/custom_async_btn.dart';
import 'package:banking_app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKeyLogin,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        // child: Image.asset(
                        //   'assets/images/logo.png',
                        //   height: 150,
                        //   width: 200,
                        // ),
                        child: Image.asset('assets/images/register.png', width: 120.0),
                      ),
                      const SizedBox(height: 32.0),
                      _buildNameTextField(),
                      const SizedBox(height: 18.0),
                      _buildEmailTextField(),
                      const SizedBox(height: 18.0),
                      _buildPasswordTextField(),
                      const SizedBox(height: 24.0),
                      GetBuilder(
                        builder: (_) {
                          return _authController.disableWhileLoad
                              ? const LoadingWidget()
                              : CustomAsyncBtn(
                                  btntxt: 'Sign up',
                                  onPress: () async {
                                    if (_formKeyLogin.currentState!.validate()) {
                                      _formKeyLogin.currentState!.save();
                                      FocusScopeNode currentFocus = FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      await _authController.signUpUser();
                                    }
                                  },
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 38.0,
            left: 18.0,
            child: InkWell(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      onChanged: (value) {
        _authController.userModel.name = value.trim();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: buildTextFieldInputDecoration(
        context,
        labelText: 'Name',
        preffixIcon: const Icon(Icons.person),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      onChanged: (value) {
        _authController.userModel.email = value.trim();
      },
      validator: (value) {
        bool isValidEmail =
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch('$value');
        if (value!.isEmpty) {
          return 'Required';
        } else if (!isValidEmail) {
          return 'Invalid Email';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: buildTextFieldInputDecoration(
        context,
        labelText: 'Email',
        preffixIcon: const Icon(Icons.email),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return GetBuilder<AuthController>(
      builder: (_) {
        return TextFormField(
          onChanged: (value) {
            _authController.userModel.password = value.trim();
          },
          obscureText: _authController.obscureText,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Required';
            } else if (_authController.userModel.password.length < 6) {
              return 'Too short';
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          decoration: buildPasswordInputDecoration(
            context,
            labelText: 'Password',
            suffixIcon: GestureDetector(
              onTap: () {
                _authController.obscureText = !_authController.obscureText;
              },
              child: Icon(
                _authController.obscureText ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        );
      },
    );
  }
}

// class SignUpScreen extends StatefulWidget {
//   static const String routeName = '/signup';

//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();

//   final _authController = Get.find<AuthController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             alignment: Alignment.bottomRight,
//             image: AssetImage("assets/images/login_screen_bg.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Form(
//           key: _formKeyLogin,
//           child: Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Image.asset('assets/images/register.png', width: 120.0),
//                           Text(
//                             'Register',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headline1!
//                                 .copyWith(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 34.0),
//                     _buildNameTextField(),
//                     const SizedBox(height: 18.0),
//                     _buildEmailTextField(),
//                     const SizedBox(height: 18.0),
//                     _buildPasswordTextField(),
//                     const SizedBox(height: 24.0),
//                     CustomAsyncBtn(
//                       btntxt: 'Sign up',
//                       onPress: () async {
//                         if (_formKeyLogin.currentState!.validate()) {
//                           _formKeyLogin.currentState!.save();
//                           FocusScopeNode currentFocus = FocusScope.of(context);
//                           if (!currentFocus.hasPrimaryFocus) {
//                             currentFocus.unfocus();
//                           }
//                           await _authController.signUpUser();
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNameTextField() {
//     return TextFormField(
//       onChanged: (value) {
//         _authController.userModel.name = value.trim();
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Required';
//         }
//         return null;
//       },
//       keyboardType: TextInputType.text,
//       textInputAction: TextInputAction.next,
//       decoration: buildTextFieldInputDecoration(
//         context,
//         labelText: 'Name',
//         preffixIcon: const Icon(Icons.person),
//       ),
//     );
//   }

//   Widget _buildEmailTextField() {
//     return TextFormField(
//       onChanged: (value) {
//         _authController.userModel.email = value.trim();
//       },
//       validator: (value) {
//         bool isValidEmail =
//             RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                 .hasMatch('$value');
//         if (value!.isEmpty) {
//           return 'Required';
//         } else if (!isValidEmail) {
//           return 'Invalid Email';
//         }
//         return null;
//       },
//       keyboardType: TextInputType.emailAddress,
//       textInputAction: TextInputAction.next,
//       decoration: buildTextFieldInputDecoration(
//         context,
//         labelText: 'Email',
//         preffixIcon: const Icon(Icons.email),
//       ),
//     );
//   }

//   Widget _buildPasswordTextField() {
//     return GetBuilder<AuthController>(
//       builder: (_) {
//         return TextFormField(
//           onChanged: (value) {
//             _authController.userModel.password = value.trim();
//           },
//           obscureText: _authController.obscureText,
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Required';
//             } else if (_authController.userModel.password.length < 6) {
//               return 'Too short';
//             }
//             return null;
//           },
//           keyboardType: TextInputType.visiblePassword,
//           decoration: buildPasswordInputDecoration(
//             context,
//             labelText: 'Password',
//             suffixIcon: GestureDetector(
//               onTap: () {
//                 _authController.obscureText = !_authController.obscureText;
//               },
//               child: Icon(
//                 _authController.obscureText ? Icons.visibility : Icons.visibility_off,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
