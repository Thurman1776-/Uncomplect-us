func dispatchAsyncOnGlobal(with qualityOfService: DispatchQoS.QoSClass = .userInitiated, work: @escaping () -> Void) {
    DispatchQueue.global(qos: qualityOfService).async { work() }
}
