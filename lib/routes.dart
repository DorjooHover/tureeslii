import 'package:get/get.dart';
import 'package:tureeslii/bindings/bindings.dart';
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

  // auth
  static String auth = '/auth';
  static String register = '/register';
  static String registerCustom = '$register/custom';
  static String error = '/error';
  static String page404 = '/404';
  static String noData = '/noData';

// names
  static String getMainRoute() => main;
  static String getBookMarkRoute() => bookmark;
  // order
  static String getOrderRoute() => order;
  // menu
  static String getMenuRoute() => menu;
  static String getProfileRoute() => profile;
  static String getChangeCityRoute() => changeCity;
  static String getEditRoute() => editProfile;
  static String getAcceptedOrderRoute() => acceptedOrder;
  static String getNotificationRoute() => notification;
  static String getSplashRoute() => splash;
  // location
  static String getLocationRoute() => location;
  // auth
  static String getLoginRoute() => auth;
  static String getRegisterRoute() => register;
  static String getRegisterCustomRoute() => registerCustom;
  static String getErrorRoute() => error;
  static String get404Route() => page404;
  static String getNoDataRoute() => noData;

// pages
  static List<GetPage> routes = [
    GetPage(
        name: splash, page: () => const SplashView(), binding: SplashBinding()),
    GetPage(name: main, page: () => const MainView()),
    GetPage(
        name: auth,
        page: () => LoginView(),
        binding: AuthBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    // order
    GetPage(
        name: order,
        page: () => const OrderView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    GetPage(
        name: acceptedOrder,
        page: () => const OrderAcceptedView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    // menu
    GetPage(
        name: menu,
        page: () => const MenuView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    GetPage(
        name: profile,
        page: () => const ProfileView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    GetPage(
        name: changeCity,
        page: () => const ChangeCityView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    GetPage(
        name: editProfile,
        page: () => SignInView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    // location
    GetPage(
        name: location,
        page: () => const LocationView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),

    // notification
    GetPage(
        name: notification,
        page: () => const NotificationView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    GetPage(
        name: bookmark,
        page: () => const BookmarkView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    GetPage(
        name: register,
        page: () => RegisterView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    GetPage(
        name: registerCustom,
        page: () => SignInView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    GetPage(
        name: error,
        page: () => const ErrorView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    GetPage(
        name: noData,
        page: () => const NoDataView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000)),
    GetPage(
        name: page404,
        page: () => const Page404View(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1000))
  ];
}
