abstract class SubscriptionsStates {}

class SubscriptionsLoading extends SubscriptionsStates {}

class SubscriptionsInitial extends SubscriptionsStates {}

class SubscriptionsFailure extends SubscriptionsStates {
  String msg = '';
  SubscriptionsFailure({required this.msg});
}

class SubscriptionsSuccess extends SubscriptionsStates {}
