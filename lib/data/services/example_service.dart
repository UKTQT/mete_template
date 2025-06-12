import 'package:com_nectrom_metetemplate/core/base/base_response_model.dart';
import 'package:com_nectrom_metetemplate/core/base/base_service.dart';
import 'package:com_nectrom_metetemplate/data/models/example_model.dart';
import 'package:dio/dio.dart';

class ExampleService {
  /// Sunucudan ExampleModel listesini çeker.
  Future<BaseResponseModel<List<ExampleModel>>?> getList() async {
    return await BaseService.instance.get<BaseResponseModel<List<ExampleModel>>>(
      path: "/example/getList",
      fromJson: (json) => BaseResponseModel<List<ExampleModel>>.fromJson(
        json,
        (body) => (body as List).map((e) => ExampleModel.fromJson(e)).toList(),
      ),
    );
  }

  /// Sunucudan tek bir ExampleModel nesnesi çeker.
  Future<BaseResponseModel<ExampleModel>?> getModel() async {
    return await BaseService.instance.get<BaseResponseModel<ExampleModel>>(
      path: "/example/getModel",
      fromJson: (json) => BaseResponseModel<ExampleModel>.fromJson(
        json,
        (body) => ExampleModel.fromJson(body),
      ),
    );
  }

  /// Bir ExampleModel nesnesini sunucuya POST isteğiyle gönderir.
  Future<BaseResponseModel<ExampleModel>?> post({required ExampleModel? exampleModel}) async {
    return await BaseService.instance.post<BaseResponseModel<ExampleModel>>(
      path: "/example/post",
      data: exampleModel!.toJson(),
      fromJson: (json) => BaseResponseModel<ExampleModel>.fromJson(
        json,
        (body) => ExampleModel.fromJson(body),
      ),
    );
  }

  /// Dosya yüklemek için sunucuya multipart/form-data formatında veri gönderir.
  Future<void> uploadFile({Object? data}) async {
    return await BaseService.instance.post(
      path: "/example/uploadFile/",
      data: data,
      options: Options(
        contentType: "multipart/form-data",
        headers: {
          "Accept": "*/*",
          "accept-encoding": "gzip,deflate,br",
        },
      ),
      fromJson: (json) {},
    );
  }
}
