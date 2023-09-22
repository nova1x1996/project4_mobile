import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/providers/AccountProvider.dart';
import 'package:project_hk4_mobile/providers/DoctorProvider.dart';
import 'package:project_hk4_mobile/screens/alldoctor/alldoctor.dart';
import 'package:project_hk4_mobile/screens/booking/booking.dart';
import 'package:project_hk4_mobile/screens/booking/confirmbooking.dart';
import 'package:project_hk4_mobile/screens/login/login_main.dart';
import 'package:project_hk4_mobile/screens/homepage/homepage.dart';
import 'package:project_hk4_mobile/screens/main/mainpage.dart';
import 'package:project_hk4_mobile/screens/myaccount/category/edit_account.dart';
import 'package:project_hk4_mobile/screens/myaccount/category/edit_account_pass.dart';
import 'package:project_hk4_mobile/screens/myaccount/my_account.dart';
import 'package:project_hk4_mobile/screens/payment/payment_history.dart';
import 'package:project_hk4_mobile/screens/payment/payment_success.dart';
import 'package:project_hk4_mobile/screens/register/register.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AccountProvider()),
          ChangeNotifierProvider(
            create: (context) => DoctorProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            dialogBackgroundColor: Colors.white,
            appBarTheme:
                AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: PaymentSuccessPage.routeName,
          routes: {
            MyAccountPage.routeName: (context) => const MyAccountPage(),
            MainPage.routeName: (context) => const MainPage(),
            LoginMain.routeName: (context) => const LoginMain(),
            BookingPage.routeName: (context) => const BookingPage(),
            ConfirmBooking.routeName: (context) => const ConfirmBooking(),
            PaymentSuccessPage.routeName: (context) =>
                const PaymentSuccessPage()
            // EditAccountPage.routeName: (context) => const EditAccountPage(),
          },
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                // return MaterialPageRoute(
                //     builder: (context) => PaymentSuccessPage());
                return MaterialPageRoute(builder: (context) => MainPage());
              case PaymentHistory.routeName:
                return PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 700),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return PaymentHistory();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    Animation<Offset> offsetAnimation =
                        SlideLeftToRight(animation);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                );
              case EditAccountPage.routeName:
                return PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 700),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return EditAccountPage();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    Animation<Offset> offsetAnimation =
                        SlideLeftToRight(animation);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                );

              case LoginMain.routeName:
                return MaterialPageRoute(builder: (context) => LoginMain());
              case EditAccountPass.routeName:
                return MaterialPageRoute(
                    builder: (context) => EditAccountPass());
              case RegisterPage.routeName:
                return MaterialPageRoute(builder: (context) => RegisterPage());
              default:
                return null;
            }
          },
        ));
  }

  Animation<Offset> SlideLeftToRight(Animation<double> animation) {
    const begin = Offset(1.0, 0.0); // từ phải qua
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return offsetAnimation;
  }
}
