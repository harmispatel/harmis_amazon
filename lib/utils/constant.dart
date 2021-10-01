const kLocalKey = {
  "userInfo": "userInfo",
  "shippingAddress": "shippingAddress",
  "recentSearches": "recentSearches",
  "wishlist": "wishlist",
  "home": "home"
};

class AppConstants {
  static final String APP_NAME = "Bigmart";
  static final String DEVICE_ACCESS_ANDROID = "1";
  static final String DEVICE_ACCESS_IOS = "2";
  static final String DEVICE_ACCESS_WEB = "3";
  static final String FONT_FAMILY = "Sans";
  static final String FONT_FAMILY_GOTIK = "Gotik";
  static final String LOGIN_DETAILS = "LOGIN_DETAILS";
  static final String METHOD_POST = 'POST';
  static final String ADDRESS_ADDED = 'ADDRESS_ADDED';
  static final String SETTINGS_SCREEN = 'SETTINGS_SCREEN';
  static final String CART_SCREEN = 'CART_SCREEN';

  /*--------Language Codes-------------------*/
  static const String LANGUAGE_ENGLISH = 'en';
  static const String LANGUAGE_ARABIC = 'ar';

  static const String USER_TYPE = "2";
  static const String USER_TYPE_ADMIN = "3";
  static const String GENDER_TYPE_MR = "1";
  static const String GENDER_TYPE_MRS = "2";
  static const String GENDER_TYPE_MS = "3";

  /*Firebase tables name*/
  static final String USERS = "users_master";
  static final String MESSAGES = "messages_master";

  /*Firebase Users table columns*/
  static final String UID = "id";
  static final String NICKNAME = "nickname";
  static final String PHOTO_URL = "photoUrl";
  static final String CREATED_AT = "createdAt";
  static final String CHATTING_WITH = "chattingWith";
  static final String PUSH_TOKEN = "pushToken";
  static final String USER_ID = "userId";
  static final String FRIENDS_IDS = "friendsIDs";
  static final String FIREBASE_USER_TYPE = "userType";

  /*Firebase Messages table columns*/
  static final String CONTENT = "content";
  static final String ID_FROM = "idFrom";
  static final String ID_TO = "idTo";
  static final String TIMESTAMP = "timestamp";
  static final String TYPE = "type";
  static final String IS_READ = "isRead";

  /* order status */
  static final String ORDER_NEW = "New";
  static final String ORDER_IN_PROGRESS = "In Progress";
  static final String ORDER_PAID = "Paid";
  static final String ORDER_COMPLETED = "Completed";
  static final String ORDER_CANCELLED = "Cancelled";
  static final String IS_REFRESH = "IS_REFRESH";
  static final String ORDER_ACCEPTED = "Accepted";

  static final String googleApiKey = 'AIzaSyA6Kj4DQTaSxjO05x-Cjpg5k944mJL58k0';

  static var phoneLength = 1000;
  static var dummyImage = "https://picsum.photos/200/300";

  static var dummyText =
      "Lorem Ipsum is simply dummy text of the printing and " +
          "typesetting industry. Lorem Ipsum has been the industry’s" +
          "standard dummy text ever since the 1500s, when an" +
          "unknown printer took a galley of type and scrambled it to" +
          "make a type specimen book";

  static var phoneCode = "+964";

  static var USER_TYPE_CUSTOMER = "customer";

  static String USER_TYPE_BUSINESS = "business";
  static String BUSINESS_ID = "1";
  static String FILTERS = "FILTERS";

  // order status
  static String ORDER_STATUS_PENDING = "1";
  static String ORDER_STATUS_COMPLETED = "2";
  static String ORDER_STATUS_CANCEL = "3";
  static String ORDER_STATUS_RETURN = "4";
}
