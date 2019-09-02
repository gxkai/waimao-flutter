class Api{
  static const String BASE_URL = 'https://api.waimao86.com';
//  static const String BASE_URL = 'https://flutter-go.pub/api/';

  static const String DO_LOGIN = BASE_URL+'/client/login';//登陆

  static const String CHECK_LOGIN = BASE_URL+'checkLogin';//验证登陆
  
  static const String LOGOUT = BASE_URL+'logout'; //退出登陆

  static const String VisitByHour = BASE_URL + '/client/visitByHour';

  static const String VisitByDay = BASE_URL + '/client/visitByDay';

  static const String VisitByCountry = BASE_URL + '/client/country';

  static const String VisitByOs = BASE_URL + '/client/os';

  static const String MyProduct = BASE_URL + '/client/my';

  static const String Message = BASE_URL + '/client/message';

  static const String VisitByKeyword = BASE_URL + '/client/keyword';
}
