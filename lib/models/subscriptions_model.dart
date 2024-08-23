class Subscription {
  int? id;
  int? clientId;
  int? amount;
  int? duration;
  String? dateCreated;
  String? type;

  Subscription(
      {this.id,
      this.clientId,
      this.amount,
      this.dateCreated,
      this.duration,
      this.type});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    amount = json['amount'];
    duration = json['duration'];
    dateCreated = json['date_created'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['amount'] = amount;
    data['date_created'] = dateCreated;
    data['duration'] = duration;
    data['type'] = type;
    return data;
  }
}
