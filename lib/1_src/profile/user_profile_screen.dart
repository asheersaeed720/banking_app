import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/utils/custom_dialog.dart';
import 'package:banking_app/utils/input_decoration.dart';
import 'package:banking_app/widgets/custom_async_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routeName = '/user-profile';

  UserProfileScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            'assets/images/toolbar_background.jpg',
            fit: BoxFit.fill,
            height: 452.0,
          ),
          Container(
            padding: const EdgeInsets.only(top: 40, left: 15),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Profile',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18.0, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                InkWell(
                  onTap: () => showAlertDialog(
                    context,
                    'Logout',
                    'Are you sure, want to logout',
                    () {
                      _authController.signOutUser();
                    },
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<AuthController>(
            builder: (_) {
              return Container(
                padding: const EdgeInsets.only(top: 55),
                child: Column(
                  children: [
                    Column(
                      children: [
                        _buildProfilePic(),
                        const SizedBox(height: 8.0),
                        Text(
                          '${_authController.currentUserData['name']}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 20.0, color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              _buildNameTextField(context),
                              const SizedBox(height: 20.0),
                              CustomAsyncBtn(
                                height: 46.0,
                                btntxt: 'Update',
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePic() {
    return Container(
      margin: const EdgeInsets.only(top: 25.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        shape: BoxShape.circle,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/images/dummy_profile.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            right: -10,
            child: CircleAvatar(
              backgroundColor: const Color(0xff8DBFF6),
              radius: 14,
              child: IconButton(
                onPressed: () {},
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.edit, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameTextField(context) {
    // TextEditingController userNameController = TextEditingController();
    // userNameController.text = authPvd.user['user']['username'];
    // authPvd.userReg.username = authPvd.user['user']['username'];
    return TextFormField(
      // controller: userNameController,
      onChanged: (value) {
        // authPvd.userReg.username = value;
      },
      validator: (value) => value!.isEmpty ? "Required" : null,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: buildTextFieldInputDecoration(context,
          labelText: 'Name', preffixIcon: const Icon(Icons.person)),
    );
  }
}
