//app file



import '../config.dart';
import '../screens/auth_screen/email_sign_up_screen/email_sign_up_screen.dart';



class AppRoute {

  Map<String, Widget Function(BuildContext)> route = {
    routeName.splash :(p0) => const SplashScreen(),
    routeName.homeScreen :(p0) => const HomeScreen(),
    routeName.commonBottomNavigationBar :(p0) => const CommonBottomNavigationBar(),
    routeName.emailSignUpScreen :(p0) => const EmailSignUpScreen(),
    routeName.phoneLoginScreen :(p0) => const PhoneLoginScreen(),
    routeName.loginAuthScreen :(p0) => const LoginAuthScreen(),

  };


}
