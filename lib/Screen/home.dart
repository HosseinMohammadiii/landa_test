import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_landa_test/DataFeature/Account/auth_manager.dart';
import 'package:flutter_landa_test/DataFeature/Account/bloc/account_bloc.dart';
import 'package:flutter_landa_test/DataFeature/Account/bloc/account_event.dart';
import 'package:flutter_landa_test/DataFeature/Account/bloc/account_state.dart';
import 'package:flutter_landa_test/Screen/authentication.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool>? isAllInfo;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountBloc>(context).add(DisplayUserInformationEvent());
    isAllInfo = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              showDialogLogOut(context);
            },
            child: const Icon(Icons.logout)),
        title: const Text(
          'کاربران ثبت شده',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xffAA8453),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            //Check error and try again
            if (state is AccountErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ارتباط برقرار نشد',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '.لطفا از وصل بودن اینترنت مطمئن شوید',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        elevation: WidgetStatePropertyAll(0),
                        fixedSize: WidgetStatePropertyAll(
                          Size(150, 45),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.red,
                        ),
                      ),
                      onPressed: () {
                        //Reconnect to the Server to Display the Content of the Pages
                        context
                            .read<AccountBloc>()
                            .add(DisplayUserInformationEvent());
                      },
                      child: const Text(
                        'تلاش دوباره',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            //Check user information loading
            if (state is UserInfoLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xffAA8453),
                ),
              );
            }
            //Check display user information
            if (state is UserInfoResponseState) {
              return state.displayUserInfo.fold(
                (error) {
                  //Display error message
                  return Center(child: Text(error));
                },
                (userInfo) {
                  // Initialize isAllInfo list based on userInfo length
                  if (isAllInfo!.isEmpty) {
                    isAllInfo = List<bool>.filled(userInfo.length, false);
                  }
                  //Display user informations
                  return RefreshIndicator(
                    color: const Color(0xffAA8453),
                    onRefresh: () async {
                      context
                          .read<AccountBloc>()
                          .add(DisplayUserInformationEvent());
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverList.builder(
                          itemCount: userInfo.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: isAllInfo![index] ? 200 : 110,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'images/logo.svg',
                                    height: 90,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _textUserInfo(
                                          title: 'UserName',
                                          userInfo: userInfo[index].userName,
                                          isShowIcon: true,
                                          index: index,
                                        ),
                                        const Spacer(),
                                        _textUserInfo(
                                          title: 'FirstName',
                                          userInfo: userInfo[index].firstName,
                                          index: index,
                                        ),
                                        const Spacer(),
                                        _textUserInfo(
                                          title: 'Email',
                                          userInfo: userInfo[index].email,
                                          index: index,
                                        ),
                                        if (isAllInfo![index]) ...[
                                          const Spacer(),
                                          _textUserInfo(
                                            title: 'Mobile',
                                            userInfo: userInfo[index].mobile,
                                            index: index,
                                          ),
                                          const Spacer(),
                                          _textUserInfo(
                                            title: 'Language',
                                            userInfo: userInfo[index].language,
                                            index: index,
                                          ),
                                          const Spacer(),
                                          _textUserInfo(
                                            title: 'Currency',
                                            userInfo: userInfo[index].currency,
                                            index: index,
                                          ),
                                        ],
                                      ],
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
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // Widget for display user information value
  Widget _textUserInfo({
    required String userInfo,
    required String title,
    bool? isShowIcon,
    required int index,
  }) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            userInfo,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Visibility(
          visible: isShowIcon ?? false,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isAllInfo![index] = !isAllInfo![index];
              });
            },
            child: isAllInfo![index]
                ? const Icon(Icons.keyboard_arrow_up_rounded, size: 30)
                : const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
          ),
        ),
      ],
    );
  }

  //Future Function For Display Dialog to LogOut Account
  Future<void> showDialogLogOut(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Colors.white,
          title: const Text(
            'آیا می خواهید از حسابتان خارج شوید؟',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'SN',
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey[500]),
              ),
              child: const Text(
                'خیر',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SN',
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            TextButton(
              onPressed: () async {
                AuthManager().logOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthenticationScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Color(0xffAA8453),
                ),
              ),
              child: const Text(
                'بله',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SN',
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
