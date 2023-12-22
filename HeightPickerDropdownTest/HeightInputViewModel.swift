import Combine
import Foundation

public class HeightInputViewModel {
    @Published public var heightPrimary: String = ""
    @Published public var heightSecondary: String = ""
    public var locale: Locale
    
    public init(locale: Locale) {
        self.locale = locale
    }
    
    private var heightPrimaryUnit: String {
        locale.isMetricSystem ? "cm" : "′"
    }

    public var displayedHeightPrimary: String {
        heightPrimary.isEmpty ? placeholderText : "\(heightPrimary) \(heightPrimaryUnit)"
    }
    
    public var displayedHeightSecondary: String {
        heightSecondary.isEmpty ? "–– ″" : "\(heightSecondary) ″"
    }
    
    private var placeholderText: String {
        locale.isMetricSystem ? "––– cm" : "– ′"
    }
}

extension HeightInputViewModel: ObservableObject {}
