class ChartModel {
  String x;
  double y;
  ChartModel({required this.x, required this.y});

  static dynamic getColumnsData(List<Map> data) {
    List<ChartModel> columnData = <ChartModel>[];
    for (var i = 0; i < data.length; i++) {
      columnData.add(ChartModel(x: data[i]['date'], y: data[i]['value']));
    }

    return columnData;
  }
}
