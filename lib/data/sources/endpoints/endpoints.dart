class AppEndpoints {
  AppEndpoints._();
  // static const String baseUrl = "https://7rm.ae/api/";
  static const String baseUrl = "https://main.7rm.ae/api/";
  static const auth = "mobile/auth";
  static const order = "mobile/order";
  static const stables = "mobile/stable";
  static const category = "mobile/category";
  static const auction = "mobile/auction";
  static const profile = "mobile/auth/me";
  static const updateProfile = "mobile/user/update";
  static const favorite = "mobile/auction/getFavoriteHorseData";
  static const addFavorite = "mobile/auction/createFavorite";
  static const removeFavorite = "mobile/auction/removeFavorite";
  static const package = "mobile/package";
  static const search = "mobile/stable/search-by-name";
  static const filter = "mobile/auction/horse-filter";
  static const trainers = "mobile/trainers/";
  static const showTrainers = "mobile/user/trainer";

  // receiveTimeout
  static const int receiveTimeout = 15000;
  // connectTimeout
  static const int connectionTimeout = 30000;
// to do

  /// AUTH API
  static String signupUrl = "$auth/signup";
  static String loginUrl = "$auth/login";
  static String logoutUrl = "$auth/logout";
  static String resetPassword = "$auth/resetPassword";
  static String sendVerificationCode = "$auth/sendVerificationCode";
  static String validateMobileNumber = "$auth/validateMobileNumber";
  static String verifyPassword = "$auth/generate-token";

  ///Service API
  static String servicesUrl = "/mobile/service";

  ///Auctions
  static String detailHorseUrl = "$auction/show/horse";
  static String isHorseInFavorite = "$auction/is_the_horse_in_favourate";
  static String auctionsHorses = "$auction/horses";
  static String auctionsCalendar = "$auction/comming";
  static String checkedPayment = "$auction/check/payment";
  static String pay = "$auction/accept_the_payment";
  static String sendPusher = "$auction/sendpusher";
  static String authPusher = "$auction/pusher/auth";
  static String allAuctionsRandomly = "$auction/getHorsesForUpcomingAuctions";
  static String allAuctionsByPrice =
      "$auction/getHorsesForUpcomingAuctionsSortedByPrice"; //Error
  static String auctionToday = "$auction/getHorsesForTodaysAuctions";
  static String myAuctions = "$auction/AllUserAuction";

  /// Stables Api

  static String allStables = stables;
  static String bestStables = "$stables/popularstables";
  static String nearbyStables = "$stables/nearbystables";
  static String stableTrainers = "$stables/stabletrainers";
  static String stableInformation = '$stables/search';
  static String stableLocationsUrl = 'mobile/nearbystables';

  /// Categories

  static String allCategories = category;
  static String servicesStablePackages =
      '$category/getServicesInCategory/stables';

  ///
  static String bookingAvailableTime = "$order/booking/times";
  static String bookingUserInStable = "$order/booking/by_stable";
  static String getAllBookingWithPackages = "$order/booking/getUserBookingDetails_with_packages";
  static String addOrder = "$order/booking/create";
  static String allBooking = "$order/booking/getUserBookingDetails_with_packages";
}
