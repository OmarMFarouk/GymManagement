abstract class AnalyticsStates {}

class AnalyticsInitial extends AnalyticsStates {}

class AnalyticsLoading extends AnalyticsStates {}

class AnalyticsLoaded extends AnalyticsStates {}

class AnalyticsSuccess extends AnalyticsStates {
  String msg = '';
  AnalyticsSuccess({required this.msg});
}

class AnalyticsFailure extends AnalyticsStates {
  String msg = '';
  AnalyticsFailure({required this.msg});
}
