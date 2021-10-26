

// class SignInWidget extends StatefulWidget {
//   const SignInWidget({Key? key}) : super(key: key);

//   @override
//   _SignInWidgetState createState() => _SignInWidgetState();
// }

// class _SignInWidgetState extends State<SignInWidget> {
//   TextEditingController? _emailController;

//   TextEditingController? _passwordController;

//   GlobalKey<FormState>? _formKeyLogin;

//   @override
//   void initState() {
//     super.initState();
//     _formKeyLogin = GlobalKey<FormState>();

//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();

//     // _emailController.text = Provider.of<SixAuthProvider>(context, listen: false).getUserEmail() ?? null;
//     // _passwordController.text = Provider.of<SixAuthProvider>(context, listen: false).getUserPassword() ?? null;
//   }

//   // @override
//   // void dispose() {
//   //   _emailController.dispose();
//   //   _passwordController.dispose();
//   //   super.dispose();
//   // }

//   // FocusNode _emailNode = FocusNode();
//   // FocusNode _passNode = FocusNode();
//   // LoginModel loginBody = LoginModel();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKeyLogin,
//       child: ListView(
//         padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
//         children: [
//           // for Email
//           Container(
//             margin: const EdgeInsets.only(
//                 left: Dimensions.MARGIN_SIZE_LARGE,
//                 right: Dimensions.MARGIN_SIZE_LARGE,
//                 bottom: Dimensions.MARGIN_SIZE_SMALL),
//             child: TextFormField(
//               decoration: buildTextFieldInputDecoration(
//                 context,
//                 labelText: 'Email',
//                 preffixIcon: const Icon(Icons.email),
//               ),
//             ),
//           ),

//           // for Password
//           Container(
//             margin: const EdgeInsets.only(
//                 left: Dimensions.MARGIN_SIZE_LARGE,
//                 right: Dimensions.MARGIN_SIZE_LARGE,
//                 bottom: Dimensions.MARGIN_SIZE_DEFAULT),
//             child: TextFormField(
//               decoration: buildTextFieldInputDecoration(
//                 context,
//                 labelText: 'Password',
//                 preffixIcon: const Icon(Icons.email),
//               ),
//             ),
//           ),

//           // for signin button
//           Container(
//             margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
//             child: CustomAsyncBtn(
//               onPress: () {},
//               btntxt: 'sign in',
//             ),
//           ),

//           // const SizedBox(height: 20),
//           // Center(
//           //     child: Text(getTranslated('OR', context),
//           //         style: titilliumRegular.copyWith(fontSize: 12))),

//           // //for order as guest
//           // GestureDetector(
//           //   onTap: () {
//           //     Navigator.pushReplacement(
//           //         context, MaterialPageRoute(builder: (_) => SixDashBoardScreen()));
//           //   },
//           //   child: Container(
//           //     margin: EdgeInsets.only(left: 50, right: 50, top: 30),
//           //     width: double.infinity,
//           //     height: 40,
//           //     alignment: Alignment.center,
//           //     decoration: BoxDecoration(
//           //       color: Colors.transparent,
//           //       borderRadius: BorderRadius.circular(6),
//           //       border: Border.all(color: ColorResources.getHint(context), width: 1.0),
//           //     ),
//           //     child: Text(getTranslated('CONTINUE_AS_GUEST', context),
//           //         style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context))),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
