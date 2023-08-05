import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:qcamyapp/repository/adBanner/sliderAdBanner.notifier.dart';
import 'package:qcamyapp/repository/addReview/addReview.notifier.dart';
import 'package:qcamyapp/repository/authentication/auth.notifier.dart';
import 'package:qcamyapp/repository/book_photographer/book_photographer.notifier.dart';
import 'package:qcamyapp/repository/cart/cart.notifier.dart';
import 'package:qcamyapp/repository/categories/categories.notifier.dart';
import 'package:qcamyapp/repository/enquire_product/enquire_product.notifier.dart';
import 'package:qcamyapp/repository/enquire_product_details/enquire_product_details.notifier.dart';
import 'package:qcamyapp/repository/equipment_search/equipment_search.notifier.dart';
import 'package:qcamyapp/repository/exchange_product/exchange_product.notifier.dart';
import 'package:qcamyapp/repository/exchange_product_details/exchange_product_details.notifier.dart';
import 'package:qcamyapp/repository/firmware/firmware.notifier.dart';
import 'package:qcamyapp/repository/firmwareSearch/firmwareSearch.notifier.dart';
import 'package:qcamyapp/repository/help/help.notifier.dart';
import 'package:qcamyapp/repository/image%20picker/imagePicker.dart';
import 'package:qcamyapp/repository/location/update_location.notifier.dart';
import 'package:qcamyapp/repository/myOrders/my_orders.notifier.dart';
import 'package:qcamyapp/repository/notification/notification.notifier.dart';
import 'package:qcamyapp/repository/otp%20verification/otpVerification.notifier.dart';
import 'package:qcamyapp/repository/productsDetails/product_details.notifier.dart';
import 'package:qcamyapp/repository/refresh/refresh.notifier.dart';
import 'package:qcamyapp/repository/remove_wishlist/remove_wishlist.notifier.dart';
import 'package:qcamyapp/repository/rentalShopSearch/rentalShopSearch.notifier.dart';
import 'package:qcamyapp/repository/rental_equipment_detail/rental_equi_details.notifier.dart';
import 'package:qcamyapp/repository/rental_equipments/rental_equipments.notifier.dart';
import 'package:qcamyapp/repository/return%20policy/notifier.dart';
import 'package:qcamyapp/repository/search/search.notifier.dart';
import 'package:qcamyapp/repository/search/showAll.notifier.dart';
import 'package:qcamyapp/repository/specifications/specifications.notifier.dart';
import 'package:qcamyapp/repository/supportQuestions/supportQuestions.notifier.dart';
import 'package:qcamyapp/repository/together_product/together_product.notifier.dart';
import 'package:qcamyapp/repository/trackingStatus/trackingStatus.notifier.dart';
import 'package:qcamyapp/repository/userProfile/userProfile.notifier.dart';
import 'package:qcamyapp/repository/wishlist_items_showing/wishlist_item_showing.notifier.dart';

import '../repository/accessories/accessories.notifier.dart';
import '../repository/address/address.notifier.dart';
import '../repository/brands/brands.notifier.dart';
import '../repository/buy_now/buy_now.notifier.dart';
import '../repository/camera_repair/cameraRepair.notifier.dart';
import '../repository/coupon/coupon.notifier.dart';
import '../repository/date picker/datepicker.dart';
import '../repository/home_search/home_search.notifier.dart';
import '../repository/hot_products/hot_products.notifier.dart';
import '../repository/my_rentals/my_rentals.notifier.dart';
import '../repository/my_repairs/my_repairs.notifier.dart';
import '../repository/new_products/new_products.notifier.dart';
import '../repository/photographer_Bookings/photographer_bookings.notifier.dart';
import '../repository/photographer_profile/profile.notifier.dart';
import '../repository/privecy policy/notifier/notifier.dart';
import '../repository/related_products/related_products.notifier.dart';
import '../repository/rental_booking/rental_booking.notifier.dart';
import '../repository/select language/languageNotifier.dart';
import '../repository/singleAdBanner/singleAdBanner.notifier.dart';
import '../repository/todays_deals/todays_deals.notifier.dart';
import '../repository/wish_list/wish_list.notifier.dart';
import '../views/order invoice/orderInvoice.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AuthNotifier>(create: (context) => AuthNotifier()),
  ChangeNotifierProvider<OTPNotifier>(create: (context) => OTPNotifier()),
  ChangeNotifierProvider<CameraRepairNotifier>(create: (context) => CameraRepairNotifier()),
  ChangeNotifierProvider<SliderAdBannerNotifier>(create: (context) => SliderAdBannerNotifier()),
  ChangeNotifierProvider<AccessoriesNotifier>(create: (context) => AccessoriesNotifier()),
  ChangeNotifierProvider<SearchNotifier>(create: (context) => SearchNotifier()),
  ChangeNotifierProvider<ShowAllNotifier>(create: (context) => ShowAllNotifier()),
  ChangeNotifierProvider<SingleAdBannerNotifier>(create: (context) => SingleAdBannerNotifier()),
  ChangeNotifierProvider<PhotographerProfileNotifier>(create: (context) => PhotographerProfileNotifier()),
  ChangeNotifierProvider<BookPhotographerNotifier>(create: (context) => BookPhotographerNotifier()),
  ChangeNotifierProvider<UpdateLocation>(create: (context) => UpdateLocation()),
  ChangeNotifierProvider<RefreshNotifier>(create: (context) => RefreshNotifier()),
  ChangeNotifierProvider<RentalEquipmentsNotifier>(create: (context) => RentalEquipmentsNotifier()),
  ChangeNotifierProvider<RentalEquipmentDetailsNotifier>(create: (context) => RentalEquipmentDetailsNotifier()),
  ChangeNotifierProvider<CartNotifier>(create: (context) => CartNotifier()),
  ChangeNotifierProvider<CategoryNotifier>(create: (context) => CategoryNotifier()),
  ChangeNotifierProvider<ViewProductNotifier>(create: (context) => ViewProductNotifier()),
  ChangeNotifierProvider<NotificationNotifier>(create: (context) => NotificationNotifier()),
  ChangeNotifierProvider<UserProfileNotifier>(create: (context) => UserProfileNotifier()),
  ChangeNotifierProvider<OrderNotifier>(create: (context) => OrderNotifier()),
  ChangeNotifierProvider<AddressNotifier>(create: (context) => AddressNotifier()),
  ChangeNotifierProvider<MyOrdersNotifier>(create: (context) => MyOrdersNotifier()),
  ChangeNotifierProvider<HomeSearchNotifier>(create: (context) => HomeSearchNotifier()),
  ChangeNotifierProvider<PhotographerBookingsNotifier>(create: (context) => PhotographerBookingsNotifier()),
  ChangeNotifierProvider<RentalBookingNotifier>(create: (context) => RentalBookingNotifier()),
  ChangeNotifierProvider<MyRentalBookingsNotifier>(create: (context) => MyRentalBookingsNotifier()),
  ChangeNotifierProvider<TodaysDealsNotifier>(create: (context) => TodaysDealsNotifier()),
  ChangeNotifierProvider<CouponNotifier>(create: (context) => CouponNotifier()),
  ChangeNotifierProvider<MyRepairsNotifier>(create: (context) => MyRepairsNotifier()),
  ChangeNotifierProvider<BrandsNotifier>(create: (context) => BrandsNotifier()),
  ChangeNotifierProvider<HotProductsNotifier>(create: (context) => HotProductsNotifier()),
  ChangeNotifierProvider<RelatedProductsNotifier>(create: (context) => RelatedProductsNotifier()),
  ChangeNotifierProvider<WishListNotifier>(create: (context) => WishListNotifier()),
  ChangeNotifierProvider<NewProductsNotifier>(create: (context) => NewProductsNotifier()),
  ChangeNotifierProvider<TogetherProductsNotifier>(create: (context) => TogetherProductsNotifier()),
  ChangeNotifierProvider<EnquireProductNotifier>(create: (context) => EnquireProductNotifier()),
  ChangeNotifierProvider<ExchangeProductNotifier>(create: (context) => ExchangeProductNotifier()),
  ChangeNotifierProvider<FirmwareNotifier>(create: (context) => FirmwareNotifier()),
  ChangeNotifierProvider<FirmwareSearchNotifier>(create: (context) => FirmwareSearchNotifier()),
  ChangeNotifierProvider<EquipmentSearchNotifier>(create: (context) => EquipmentSearchNotifier()),
  ChangeNotifierProvider<RemoveWishListNotifier>(create: (context) => RemoveWishListNotifier()),
  ChangeNotifierProvider<WishListItemShowingNotifier>(create: (context) => WishListItemShowingNotifier()),
  ChangeNotifierProvider<EnquireProductDetailsNotifier>(create: (context) => EnquireProductDetailsNotifier()),
  ChangeNotifierProvider<ExchangeProductDetailsNotifier>(create: (context) => ExchangeProductDetailsNotifier()),
  ChangeNotifierProvider<SpecificationsNotifier>(create: (context) => SpecificationsNotifier()),
  ChangeNotifierProvider<TrackingStatusNotifier>(create: (context) => TrackingStatusNotifier()),
  ChangeNotifierProvider<RentalShopSearchNotifier>(create: (context) => RentalShopSearchNotifier()),
  ChangeNotifierProvider<HelpNotifier>(create: (context) => HelpNotifier()),
  ChangeNotifierProvider<AddReviewNotifier>(create: (context) => AddReviewNotifier()),
  ChangeNotifierProvider<SupportQuestionsNotifier>(create: (context) => SupportQuestionsNotifier()),
  ChangeNotifierProvider<ImageProviderModel>(create: (context) => ImageProviderModel(),),
  // ChangeNotifierProvider<OrderInvoiceProvider>(create: (context) => OrderInvoiceProvider(),)
  ChangeNotifierProvider<LanguageProvider>(create: (context) => LanguageProvider(),),
  ChangeNotifierProvider<ReturnPolicyNotifier>(create: (context) => ReturnPolicyNotifier(),),
  ChangeNotifierProvider<PrivecyNotifier>(create: (context) => PrivecyNotifier(),),
  ChangeNotifierProvider<DateProvider>(create: (context) => DateProvider(),)


];
