class ApiConfig {
  static const String baseUrl = "https://vloo.6lgx.com/api/";

  // Authentications
  static const String loginURL = "${baseUrl}login";
  static const String logoutURL = "${baseUrl}profile/logout";
  static const String registerURL = "${baseUrl}register";

  static const String getProfileURL = "${baseUrl}profile/get";
  static const String profileUpdateURL = "${baseUrl}profile/update";
  static const String languageUpdateURL = "${baseUrl}profile/change-language";
  static const String passwordResetLinkURL = "${baseUrl}password/reset-link";
  static const String passwordResetURL = "${baseUrl}password/reset";
  static const String deleteAccountURL = "${baseUrl}profile/permanent-delete";
  static const String softDeleteAccountURL = "${baseUrl}profile/delete";

  // Templates
  static const String getTemplateListingURL = "${baseUrl}template/get";
  static const String getSavedTemplateListingURL =
      "${baseUrl}template/get-saved-template";
  static const String createTemplateURL = "${baseUrl}template/add";
  static const String createCanvaTemplateURL = "${baseUrl}template/save";
  static const String countTemplateURL = "${baseUrl}template/counts";
  static const String updateTemplateFeatureImageURL =
      "${baseUrl}template/save-snapshot";
  static const String updateTemplateTitleURL =
      "${baseUrl}template/update-title";
  static const String uploadTemplateMediaURL =
      "${baseUrl}template/upload-media";

  // Elements
  static const String addElementURL = "${baseUrl}element/add";

  // Add plans
  static const String addPlanURL = "${baseUrl}add-plan";
  static const String addOrderURL = "${baseUrl}order/make-Order";
  static const String getOrderURL = "${baseUrl}order/get-orders";

  // My screens
  static const String screensListingURL = "${baseUrl}screen/lisitng";
  static const String screensListingCountURL = "${baseUrl}screen/lisitng/count";
  static const String screenDetailsURL = "${baseUrl}screen/details";
  static const String updateScreenOrientationURL =
      "${baseUrl}screen/change-orientation";
  static const String updateScreenTitleURL = "${baseUrl}screen/edit-title";
  static const String deleteScreenURL = "${baseUrl}screen/delete";
}
