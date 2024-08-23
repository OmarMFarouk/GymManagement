class Treasury {
  int? id;
  String? createdby;
  int? amount;
  String? type;
  String? comment;
  String? datecreated;

  Treasury(
      {this.id,
      this.createdby,
      this.amount,
      this.type,
      this.comment,
      this.datecreated});

  Treasury.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdby = json['created_by'];
    amount = json['amount'];
    type = json['type'];
    comment = json['comment'];
    datecreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_by'] = createdby;
    data['amount'] = amount;
    data['comment'] = comment;
    data['type'] = type;
    data['date_created'] = datecreated;
    return data;
  }
}
