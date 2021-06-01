class AppMessages {
  static String greeting(String name) => 'Hi, $name';
  static String buyNow(String value) => 'Buy now $value';
  static String purchaseSuccessDescription({
    required String name,
    required String price,
  }) =>
      'You bought: $name for $price';
  static const String success = 'Success';
  static const String error = 'Error';
  static const String moreButton = 'More';
  static const String serverError = 'Something went wrong, try again, later.';
  static const String backToHome = 'Back to Home';
  static const String offerPageAppBarTitle = 'Offer Details';
  static const String totalBalance = 'Total Balance';
  static const String offersLabel = 'Offers';
  static const String okButton = 'OK';
  static const String somethingWrong = 'Something Wrong Happened';
  static const String tryAgain = 'Try again';
}
