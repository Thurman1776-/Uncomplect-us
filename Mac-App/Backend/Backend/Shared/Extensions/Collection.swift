extension Collection where Element == String {
    func filterOcurrancesOf(_ string: String) -> [Element] {
        filter { $0 != string }
    }

    // MARK: - System symbols filtering

    func excludeSystemSymbols() -> [Element] {
        filter { systemSymbols.contains($0) == false }
    }

    func excludeSystemSymbolsPrefixes() -> [Element] {
        filter {
            $0.contains("NS") == false &&
                $0.contains("UI") == false &&
                $0.contains("CF") == false
        }
    }
}
