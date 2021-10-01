class ApiUrl {
  /* Production server */
  static String BASE_URL = "https://ecommercemobileapplication.com/dev/api/";
  static String NOTIFICATION_LOGO_URL = "http://onlinebigmartauc.com/resources/assets/images/site_logo/logo1.png";
  static String MAIN_SITE_URL = "http://onlinebigmartauc.com/index.php/";

  /* Testing server */
  // static String BASE_URL = "http://basratimes-shops.com/api/";
  // static String NOTIFICATION_LOGO_URL ="http://basratimes-shops.com/resources/assets/images/site_logo/logo1.png";
  // static String MAIN_SITE_URL = "http://basratimes-shops.com/";

  /*
    http://basratimes-shops.com/terms
    http://basratimes-shops.com/privacyPolicy
    http://basratimes-shops.com/aboutUs
    http://basratimes-shops.com/contactUs
  * */

  static String USER_DETAILS = BASE_URL + "userdetail";
  static String LOGIN = BASE_URL + "login";
  static String REGISTER = BASE_URL + "registeruser";
  static String COUNTRIES = BASE_URL + "countries";
  static String VERIFY_ACCOUNT = BASE_URL + "verificationcode";
  static String FORGOT_PASSWORD = BASE_URL + "forgotpassword";
  static String BANNER_LIST = BASE_URL + "bannerlist";
  static String POPULAR_PRODUCTS = BASE_URL + "popularproducts";
  static String TOP_SALLER_PRODUCTS = BASE_URL + "topselledproduct";
  static String PRODUCT_LIST = BASE_URL + "productlist";
  static String CATEGORY_LIST = BASE_URL + "getcategorylist";
  static String SUB_CATEGORY_LIST = BASE_URL + "subcategorylist";
  static String BRAND_LIST = BASE_URL + "brandlist";
  static String OFFER_LIST = BASE_URL + "offerproduct";
  static String ADD_REMOVE_WHISHLIST = BASE_URL + "addtofavouritelist";
  static String GET_FAVOURITE_LIST = BASE_URL + "favouritelist";
  static String PRODUCT_DETAILS = BASE_URL + "productdetail";
  static String CART_LIST = BASE_URL + "cartlist";
  static String ADD_TO_CART = BASE_URL + "addtocart";
  static String ADD_REMOVE_QUANTITY = BASE_URL + "increamnetdecreamentquantity";
  static String SEARCH_PRODUCT = BASE_URL + "searchproduct";
  static String DEALS_LIST = BASE_URL + "productdealslist";
  static String ADD_REVIEW = BASE_URL + "addreview";
  static String EDIT_PROFILE = BASE_URL + "editprofile";
  static String ADDRESS_LIST = BASE_URL + "addresslist";
  static String ADD_ADDRESS = BASE_URL + "addaddress";
  static String DELETE_ADDRESS = BASE_URL + "deleteaddress";
  static String PLACE_ORDER = BASE_URL + "addorder";
  static String ORDER_LIST = BASE_URL + "orderlist";
  static String ORDER_DETAILS = BASE_URL + "orderdetail";
  static String INVOICE_DETAIS = BASE_URL + "invoicesummary";
  static String BUY_AGAIN = BASE_URL + "buyagain";
  static String SIMILAR_PRODUCTS = BASE_URL + "getsimilarproduct";
  static String SOCIAL_LOGIN = BASE_URL + "sociallogin";
  static var GET_ORDER_PRODUCT = BASE_URL + "getorderproductlist";
  static var GET_TRACK_ORDER = BASE_URL + "orderstatuslist";
  static var SEND_INVOICE = BASE_URL + "sendinvoice";
  static var SET_LANGUAGE_TO_BACKEND_NOTIFICATION = BASE_URL + "changeLanguage";

  // English Urls
  static String CONTACT_US = MAIN_SITE_URL + "contactUs";
  static String ABOUT_US = MAIN_SITE_URL + "aboutUs";
  static String TERMS_AND_CONDITION = MAIN_SITE_URL + "terms";
  static String PRIVACY_POLICY = MAIN_SITE_URL + "privacyPolicy";

  // Arabic Urls
  static String CONTACT_US_AR = MAIN_SITE_URL + "contactUs";
  static String ABOUT_US_AR = MAIN_SITE_URL + "aboutUs_ar";
  static String TERMS_AND_CONDITION_AR = MAIN_SITE_URL + "terms_ar";
  static String PRIVACY_POLICY_AR = MAIN_SITE_URL + "privacyPolicy_ar";
}
