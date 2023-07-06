import 'package:get/get.dart';
import 'package:landlord/bindings/bindings.dart';
import 'package:landlord/pages/menu/menu_view.dart';
import 'package:landlord/pages/pages.dart';

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
  static String listing = '/list';
  static String location = '$listing/location';
  static String locationFilter = '$location/filter';
  static String locationDetail = '$location/detail';

  // auth
  static String auth = '/auth';
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
        page: () => LoginView(),
        binding: AuthBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    // order
    GetPage(
        name: order,
        page: () => const OrderView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: acceptedOrder,
        page: () => const OrderAcceptedView(),
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
        name: listing,
        page: () => const ListingView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
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
    GetPage(
        name: locationDetail,
        page: () => const ItemDetailView(),
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
