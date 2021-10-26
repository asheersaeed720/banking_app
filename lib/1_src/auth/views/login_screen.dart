import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/1_src/auth/views/signup_screen.dart';
import 'package:banking_app/utils/app_theme.dart';
import 'package:banking_app/utils/input_decoration.dart';
import 'package:banking_app/widgets/custom_async_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class SixAuthScreen extends StatefulWidget {
//   static const String routeName = '/six-auth';

//   const SixAuthScreen({Key? key, this.initialPage = 0}) : super(key: key);

//   final int initialPage;

//   @override
//   State<SixAuthScreen> createState() => _SixAuthScreenState();
// }

// class _SixAuthScreenState extends State<SixAuthScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // Provider.of<SixProfileProvider>(context, listen: false).initAddressTypeList();
//     // Provider.of<SixAuthProvider>(context, listen: false).isRemember;
//     // PageController _pageController = PageController(initialPage: widget.initialPage);
//     // NetworkInfo.checkConnectivity(context);

//     return Scaffold(
//       body: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 30),

//               // for logo with text
//               Image.asset(
//                 'assets/icons/debit_cards.png',
//                 height: 150,
//                 width: 200,
//               ),

//               // for decision making section like signin or register section
//               Padding(
//                 padding: const EdgeInsets.all(Dimensions.MARGIN_SIZE_LARGE),
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Positioned(
//                       bottom: 0,
//                       right: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
//                       left: 0,
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         //margin: EdgeInsets.only(right: Dimensions.FONT_SIZE_LARGE),
//                         height: 1,
//                         // color: ColorResources.getGainsBoro(context),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: Column(
//                         children: [
//                           const Text('Sign in'),
//                           Container(
//                             height: 1,
//                             width: 40,
//                             margin: const EdgeInsets.only(top: 8),
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // show login or register widget
//               Expanded(
//                 child: PageView.builder(
//                   itemCount: 1,
//                   controller: PageController(),
//                   itemBuilder: (context, index) {
//                     return const SignInWidget();
//                     // if (authProvider.selectedIndex == 0) {
//                     //   return const SignInWidget();
//                     // } else {
//                     //   return const SignInWidget();
//                     // }
//                   },
//                   onPageChanged: (index) {},
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Dimensions {
//   static const double FONT_SIZE_EXTRA_SMALL = 10.0;
//   static const double FONT_SIZE_SMALL = 12.0;
//   static const double FONT_SIZE_DEFAULT = 14.0;
//   static const double FONT_SIZE_LARGE = 16.0;
//   static const double FONT_SIZE_EXTRA_LARGE = 18.0;
//   static const double FONT_SIZE_OVER_LARGE = 24.0;

//   static const double PADDING_SIZE_EXTRA_SMALL = 5.0;
//   static const double PADDING_SIZE_SMALL = 10.0;
//   static const double PADDING_SIZE_DEFAULT = 15.0;
//   static const double PADDING_SIZE_LARGE = 20.0;
//   static const double PADDING_SIZE_EXTRA_LARGE = 25.0;

//   static const double MARGIN_SIZE_EXTRA_SMALL = 5.0;
//   static const double MARGIN_SIZE_SMALL = 10.0;
//   static const double MARGIN_SIZE_DEFAULT = 15.0;
//   static const double MARGIN_SIZE_LARGE = 20.0;
//   static const double MARGIN_SIZE_EXTRA_LARGE = 25.0;

//   static const double ICON_SIZE_EXTRA_SMALL = 12.0;
//   static const double ICON_SIZE_SMALL = 18.0;
//   static const double ICON_SIZE_DEFAULT = 24.0;
//   static const double ICON_SIZE_LARGE = 32.0;
//   static const double ICON_SIZE_EXTRA_LARGE = 40.0;
// }

class LogInScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.bottomRight,
            image: AssetImage("assets/images/login_screen_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKeyLogin,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to our app!',
                      style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Nice to see you again.',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 42.0),
                    _buildEmailTextField(),
                    const SizedBox(height: 18.0),
                    _buildPasswordTextField(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot password?',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                    fontSize: 14.0,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    GetBuilder<AuthController>(
                      builder: (_) {
                        return CustomAsyncBtn(
                          btntxt: 'Login',
                          onPress: _authController.disableWhileLoad
                              ? null
                              : () async {
                                  if (_formKeyLogin.currentState!.validate()) {
                                    _formKeyLogin.currentState!.save();
                                    FocusScopeNode currentFocus = FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    await _authController.logInUser();
                                  }
                                },
                        );
                      },
                    ),
                    const SizedBox(height: 18.0),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Already have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: AppTheme.buttonColor),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(SignUpScreen.routeName),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
