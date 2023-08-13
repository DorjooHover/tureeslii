import 'package:get/get.dart';
import 'package:tureeslii/bindings/bindings.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/pages/menu/menu_view.dart';
import 'package:tureeslii/pages/pages.dart';

class Routes {
// routes
  static String splash = '/splash';
  static String main = '/';
  static String bookmark = '/bookmark';
  static String order = '/order';
  static String acceptedOrder = '$order/accepted';
  // menu
  static String menu = '/menu';
  static String profile = '$menu/profile';
  static String changeCity = '$menu/changeCity';
  static String editProfile = '$profile/edit';
  // notification
  static String notification = '/notification';
  // location
  static String location = '/location';
  static String locationFilter = '$location/filter';

  // auth
  static String auth = '/auth';
  static String login = '/login';
  static String register = '/register';
  static String registerCustom = '$register/custom';
  static String error = '/error';
  static String page404 = '/404';
  static String noData = '/noData';

// pages
  static List<GetPage> routes = [
    GetPage(
        name: splash, page: () => const SplashView(), binding: SplashBinding()),
    GetPage(name: main, page: () => const MainView()),
    GetPage(
        name: auth,
        page: () => AuthView(),
        binding: AuthBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: login,
        page: () => const LoginView(),
        binding: AuthBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    // order
    GetPage(
        name: order,
        page: () => OrderView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: acceptedOrder,
        page: () {
          RentRequest res = Get.arguments;
          return OrderAcceptedView(data: res);
        },
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    // menu
    GetPage(
        name: menu,
        page: () => const MenuView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: profile,
        page: () => const ProfileView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: changeCity,
        page: () => const ChangeCityView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: editProfile,
        page: () => SignInView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    // location
    GetPage(
        name: location,
        page: () => const LocationView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: locationFilter,
        page: () => const FilterView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),

    // notification
    GetPage(
        name: notification,
        page: () => const NotificationView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: bookmark,
        page: () => const BookmarkView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: register,
        page: () => RegisterView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: registerCustom,
        page: () => SignInView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: error,
        page: () => const ErrorView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: noData,
        page: () => const NoDataView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: page404,
        page: () => const Page404View(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300))
  ];
}
