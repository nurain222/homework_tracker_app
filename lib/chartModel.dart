class ChartModel {
  int? id;
  String? subName;
  String? subDetails;
  String? subStatus;
  String? createdAt;
  String? updatedAt;
  String? userId;

  ChartModel(
      {this.id,
        this.subName,
        this.subDetails,
        this.subStatus,
        this.createdAt,
        this.updatedAt,
        this.userId});

  ChartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = json['sub_name'];
    subDetails = json['sub_details'];
    subStatus = json['sub_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_name'] = this.subName;
    data['sub_details'] = this.subDetails;
    data['sub_status'] = this.subStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    return data;
  }
}
