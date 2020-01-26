import ReSwift

public struct BackendAPI {
    private static let store: Store<AppState> = Store<AppState>(
        reducer: appReducer,
        state: AppState.initialState
    )

    public static var state: AppState { store.state }
    public static var dispatchFunction: ReSwift.DispatchFunction { store.dispatchFunction }

    public static func dispatch(_ action: Action) {
        BackendAPI.store.dispatch(action)
    }

    public static func subscribe<S>(_ subscriber: S)
        where AppState == S.StoreSubscriberStateType, S: ReSwift.StoreSubscriber {
        BackendAPI.store.subscribe(subscriber)
    }
}
