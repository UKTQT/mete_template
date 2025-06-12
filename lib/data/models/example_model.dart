import 'package:com_nectrom_metetemplate/core/base/base_model.dart';

class ExampleModel extends BaseModel {
  int? exampleVariable;

  ExampleModel({
    super.id,
    super.dateCreated,
    super.dateUpdated,
    super.createdBy,
    super.updatedBy,
    super.deletedDate,
    this.exampleVariable,
  });

  ExampleModel.fromJson(Map<String, dynamic> json) {
    super.id = json['id'];
    super.dateCreated = json['dateCreated'];
    super.dateUpdated = json['dateUpdated'];
    super.createdBy = json['createdBy'];
    super.updatedBy = json['updatedBy'];
    super.deletedDate = json['deletedDate'];
    exampleVariable = json['exampleVariable'];
  }

  @override
  Map<String, dynamic> toJson({bool? isSuperToJson = true}) {
    final Map<String, dynamic> data;
    data = isSuperToJson != true ? {} : super.toJson();
    data['exampleVariable'] = exampleVariable;
    return data;
  }
}
