import 'package:com_nectrom_metetemplate/core/constants/routes_constants.dart';
import 'package:com_nectrom_metetemplate/core/enums/notification_style_type.dart';
import 'package:com_nectrom_metetemplate/core/managers/notification_manager.dart';
import 'package:com_nectrom_metetemplate/routing/routes.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class GeneralInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.headers.containsKey('Content-Type')) {
      options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    }

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _handleError(err);

    super.onError(err, handler);
  }

  void _handleError(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionError:
        NotificationManager.instance.showInAppSnackbar(notificationStyleType: NotificationStyleType.error, text: 'response.connectionError'.tr());
        break;
      case DioExceptionType.receiveTimeout:
        NotificationManager.instance.showInAppSnackbar(notificationStyleType: NotificationStyleType.error, text: 'response.receiveTimeout'.tr());
        break;
      case DioExceptionType.sendTimeout:
        NotificationManager.instance.showInAppSnackbar(notificationStyleType: NotificationStyleType.error, text: 'response.sendTimeout'.tr());
        break;
      case DioExceptionType.connectionTimeout:
        NotificationManager.instance.showInAppSnackbar(notificationStyleType: NotificationStyleType.error, text: 'response.connectionTimeout'.tr());
        break;
      case DioExceptionType.unknown:
        NotificationManager.instance.showInAppSnackbar(notificationStyleType: NotificationStyleType.error, text: 'response.unknownError'.tr());
        break;
      case DioExceptionType.badCertificate:
        NotificationManager.instance.showInAppSnackbar(notificationStyleType: NotificationStyleType.error, text: 'response.badCertificateError'.tr());
        break;
      default:
        break;
    }

    // Handle HTTP response status codes
    if (err.response != null) {
      switch (err.response!.statusCode) {
        case 401: // Unauthorized
          NotificationManager.instance.showInAppSnackbar(notificationStyleType: NotificationStyleType.error, text: 'response.authError'.tr());

          Routes.instance.clearStackAndNavigate(RoutesConstants.leaveScreen);
          break;
        case 498: // Invalid Token
          break;
        case 408: // Request Timeout
          break;
        case 400: // Bad Request
          break;
        default:
          break;
      }
    }
  }
}
