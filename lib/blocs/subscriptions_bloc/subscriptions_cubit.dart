import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmanagement/models/subscriptions_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../src/app_db.dart';
import 'subscriptions_states.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsStates> {
  SubscriptionsCubit() : super(SubscriptionsInitial());
  static SubscriptionsCubit get(context) => BlocProvider.of(context);

  Database? dbInstance = AppDB.database;
  List<Subscription> subscriptionsList = [];

  fetchSubscriptions() async {
    if (subscriptionsList.isNotEmpty) {
      subscriptionsList.clear();
    }
    emit(SubscriptionsLoading());
    var queryList = (await dbInstance!
            .rawQuery('SELECT * FROM subscriptions ORDER BY id DESC '))
        .toList() as List<Map<String, dynamic>>;
    for (var i = 0; i < queryList.length; i++) {
      subscriptionsList.add(Subscription.fromJson(queryList[i]));
    }

    emit(SubscriptionsInitial());
  }
}
