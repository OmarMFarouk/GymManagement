class Client {
  int? id;
  int? duration;
  String? clientName;
  int? clientPhone;
  String? clientType;
  String? dateJoined;
  String? lastRenewal;
  String? image;

  Client(
      {this.id,
      this.clientName,
      this.clientPhone,
      this.clientType,
      this.dateJoined,
      this.duration,
      this.image,
      this.lastRenewal});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['name'];
    clientPhone = json['phone'];
    clientType = json['type'];
    duration = json['current_duration'];
    dateJoined = json['date_created'];
    lastRenewal = json['last_renewal'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = clientName;
    data['phone'] = clientPhone;
    data['type'] = clientType;
    data['current_duration'] = duration;
    data['date_created'] = dateJoined;
    data['last_renewal'] = lastRenewal;
    data['image'] = image;
    return data;
  }
}

class ClientsModel {
  bool? success;
  String? message;
  List<Client?>? clients;

  ClientsModel({this.success, this.message, this.clients});

  ClientsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['clients'] != null) {
      clients = <Client>[];
      json['clients'].forEach((v) {
        clients!.add(Client.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['clients'] =
        clients != null ? clients!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
