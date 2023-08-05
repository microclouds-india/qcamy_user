import 'package:flutter/material.dart';
import 'package:qcamyapp/views/authentication/mobileAuth.view.dart';
import 'package:qcamyapp/views/authentication/verifyOtp.view.dart';
import 'package:qcamyapp/views/help/helpPage.dart';
import 'package:qcamyapp/views/home/drawerViews/enquire_product.dart';
import 'package:qcamyapp/views/home/drawerViews/exchange_product.dart';
import 'package:qcamyapp/views/home/drawerViews/firmware/firmware.view.dart';
import 'package:qcamyapp/views/home/drawerViews/my_orders/order_details.view.dart';
import 'package:qcamyapp/views/home/drawerViews/my_orders/orders.view.dart';
import 'package:qcamyapp/views/home/drawerViews/my_rentals/rental.view.dart';
import 'package:qcamyapp/views/home/drawerViews/my_repairs/my_repairs.view.dart';
import 'package:qcamyapp/views/home/drawerViews/photograher_bookings/photographer_bookings.view.dart';
import 'package:qcamyapp/views/home/drawerViews/profile.view.dart';
import 'package:qcamyapp/views/home/drawerViews/notification.view.dart';
import 'package:qcamyapp/views/home/drawerViews/show_enquire_product.dart';
import 'package:qcamyapp/views/home/drawerViews/show_exchange_product.dart';
import 'package:qcamyapp/views/home/drawerViews/wish_list.view.dart';
import 'package:qcamyapp/views/home/homeTabViews/address/addAddress.view.dart';
import 'package:qcamyapp/views/home/homeTabViews/address/address.view.dart';
import 'package:qcamyapp/views/home/homeTabViews/apply/application.view.dart';
import 'package:qcamyapp/views/home/homeTabViews/brands/brand_products.view.dart';
import 'package:qcamyapp/views/home/homeTabViews/cart/cart.view.dart';
import 'package:qcamyapp/views/home/homeTabViews/categories/accessories.view.dart';
import 'package:qcamyapp/views/home/homeTabViews/payment/orderResponse.view.dart';
import 'package:qcamyapp/views/home/homeTabViews/payment/payment.view.dart';
import 'package:qcamyapp/views/home/homeTabViews/payment/selectAddress.view.dart';
import 'package:qcamyapp/views/home/photographerTabViews/bookPhotographer.view.dart';
import 'package:qcamyapp/views/home/photographerTabViews/photographerProfile.view.dart';
import 'package:qcamyapp/views/home/photographerTabViews/searchPhotographer.view.dart';
import 'package:qcamyapp/views/home/rentalShopsTabViews/searchRentalProduct.view.dart';
import 'package:qcamyapp/views/home/rentalShopsTabViews/searchRentalShops.view.dart';
import 'package:qcamyapp/views/home/searchEquipment.dart';
import 'package:qcamyapp/views/main.view.dart';
import 'package:qcamyapp/views/splashscreen/splash.view.dart';
import 'package:qcamyapp/views/tutorial/tutorialScreen.dart';

import '../repository/select language/languageNotifier.dart';
import '../views/all reviews/allreviews.dart';
import '../views/authentication/profileSetup.view.dart';
import '../views/home/drawerViews/firmware/search_firmware.view.dart';
import '../views/home/drawerViews/my_rentals/rental_details.view.dart';
import '../views/home/drawerViews/my_repairs/my_repair_details.view.dart';
import '../views/home/homeTabViews/cart/single_item_cart.view.dart';

import '../views/home/homeTabViews/main_search/home_search.view.dart';
import '../views/home/homeTabViews/product_details/product_details.view.dart';
import '../views/home/photographerTabViews/showAllPhotographers.view.dart';
import '../views/home/rentalShopsTabViews/bookEquipment.view.dart';
import '../views/home/rentalShopsTabViews/equipmentDetails.view.dart';
import '../views/home/rentalShopsTabViews/searchEquipments.view.dart';
import '../views/home/rentalShopsTabViews/showAllRentalShops.view.dart';
import '../views/language/languageselectScreen.dart';
import '../views/privecy policy/privecypolicy.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/splashView': (context) => const SplashView(),
  '/mobileAuthView': (context) => const MobileAuthView(),
  '/verifyOTPView': (context) => const VerifyOTPView(),
  '/mainHomeView': (context) => HomeView(),
  '/searchPhotographerView': (context) => const SearchPhotographerView(),
  '/photographerProfileView': (context) => const PhotographerProfileView(),
  '/searchRentalShopView': (context) => const SearchRentalShopsView(),
  '/searchEquipmentsView': (context) => const SearchEquipmentsView(),
  '/bookPhotographerView': (context) => BookPhotographerView(),
  '/equipmentDetailsView': (context) => const EquipmentDetailsView(),
  '/bookEquipmentView': (context) => BookEquipmentView(),
  '/accessoriesView': (context) => const AccessoriesView(),
  '/showAllPhotographersView': (context) => const ShowAllPhotographersView(),
  '/showAllRentalShopsView': (context) => const ShowAllRentalShopsView(),
  // '/cameraView': (context) => const CameraView(),
  // '/usedProductsView': (context) => const UsedProductsView(),
  '/offerProductDetailsView': (context) => OfferProductDetailsView(),
  '/cartView': (context) => CartView(),
  // '/paymentOptionsView': (context) => const PaymentOptionsView(),
  '/addAddressView': (context) => AddAddressView(),
  '/addressView': (context) => const AddressView(),
  '/selectAddressView': (context) => const SelectAddressView(),
  '/profileView': (context) => const ProfileView(),
  '/notificationView': (context) => const NotificationView(),
  '/ordersView': (context) => const OrdersView(),
  '/orderDetailsView': (context) => OrderDetailsView(),
  '/rentalsView': (context) => const RentalsView(),
  '/photographerBookingsView': (context) => const PhotographerBookingsView(),
  '/profileSetupView': (context) => const ProfileSetupView(),
  '/orderResponseView': (context) => const OrderResponseView(),
  '/homeSearchView': (context) => const HomeSearchView(),
  '/rentalDetailsView': (context) => const RentalDetailsView(),
  '/myCameraRepairsView': (context) => const MyCameraRepairsView(),
  '/myCameraRepairDetailsView': (context) => const MyCameraRepairDetailsView(),
  '/singleItemPurchaseDetailsView': (context) => const SingleItemPurchaseDetailsView(),
  '/applicationView': (context) => ApplicationView(),
  '/firmwareDownloadView': (context) => const FirmwareDownloadView(),
  '/searchFirmwareView': (context) => const SearchFirmwareView(),
  '/brandProductsView': (context) => const BrandProductsView(),
  '/wishListView': (context) => const WishListView(),
  '/enquireProduct': (context) => const EnquireProduct(),
  '/exchangeProduct': (context) => const ExchangeProduct(),
  '/searchEquipment': (context) => const SearchEquipment(),
  '/showEnquireProduct': (context) => const ShowEnquireProduct(),
  '/showExchangeProduct': (context) => const ShowExchangeProduct(),
  '/searchRentalProductView': (context) => const SearchRentalProductView(),
  '/helpPage': (context) => HelpPage(),
  '/privecypolicy':(context) => const PrivecyPolicyScreen(),
  '/allreviewsscreen':(context) => AllReviewsScreen(),
  '/selectLanguage':(context) => LanguageSelectionScreen(), 
  '/QuestionAnswerScreen':(context)=>QuestionAnswerScreen(),
};
