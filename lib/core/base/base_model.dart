class BaseModel {
  int? id;
  String? dateCreated;
  String? dateUpdated;
  String? createdBy;
  String? updatedBy;
  String? deletedDate;

  BaseModel({
    this.id,
    this.dateCreated,
    this.dateUpdated,
    this.createdBy,
    this.updatedBy,
    this.deletedDate,
  });

  BaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedDate = json['deletedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['deletedDate'] = deletedDate;
    return data;
  }
}
