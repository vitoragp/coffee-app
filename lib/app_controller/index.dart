import 'bloc.dart' as bloc;
import 'state.dart' as states;
import 'events.dart' as events;

typedef AppBloc = bloc.AppBloc;
typedef AppState = states.AppState;
typedef AppEvent = events.AppEvent;
typedef AppEventSuccessAppCheck = events.AppEventSuccessAppCheck;
typedef AppEventThrowError = events.AppEventThrowError;
typedef AppEventLogin = events.AppEventLogin;
typedef AppEventLogout = events.AppEventLogout;
typedef AppEventSetConnectionState = events.AppEventSetConnectionState;
