class AppSettings {
  final String appVersion;
  final String showFunctionIOS;
  final String idnewsOpenWebview;
  final String openNewsInWebview;
  final String isLogoNewYear;
  final String isOpenAdmobInApp;
  final String showDailyNewspaper;

  AppSettings({
    required this.appVersion,
    required this.showFunctionIOS,
    required this.idnewsOpenWebview,
    required this.openNewsInWebview,
    required this.isLogoNewYear,
    required this.isOpenAdmobInApp,
    required this.showDailyNewspaper,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      appVersion: json['app_version'],
      showFunctionIOS: json['show_function_ios'],
      idnewsOpenWebview: json['idnews_open_webview'],
      openNewsInWebview: json['open_news_in_webview'],
      isLogoNewYear: json['is_logo_new_year'],
      isOpenAdmobInApp: json['is_open_admob_in_app'],
      showDailyNewspaper: json['show_daily_newspaper'],
    );
  }
}
class IPInfo {
  final String ip;
  final String city;
  final String region;
  final String country;
  final String loc;
  final String org;
  final String postal;
  final String timezone;
  final String readme;

  IPInfo({
    required this.ip,
    required this.city,
    required this.region,
    required this.country,
    required this.loc,
    required this.org,
    required this.postal,
    required this.timezone,
    required this.readme,
  });

  factory IPInfo.fromJson(Map<String, dynamic> json) {
    return IPInfo(
      ip: json['ip'],
      city: json['city'],
      region: json['region'],
      country: json['country'],
      loc: json['loc'],
      org: json['org'],
      postal: json['postal'],
      timezone: json['timezone'],
      readme: json['readme'],
    );
  }
}