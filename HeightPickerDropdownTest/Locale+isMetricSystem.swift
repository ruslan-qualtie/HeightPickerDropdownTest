import Foundation

extension Locale {
    public var isMetricSystem: Bool {
        #if os(macOS)
        usesMetricSystem
        #elseif os(iOS)
        measurementSystem != .us
        #endif
    }
}
