import SwiftUI

@main
struct HeightPickerDropdownTestApp: App {
    var body: some Scene {
        WindowGroup {
            HStack {
                PreScanSurveyHeightInputView(viewModel: .init(locale: Locale(identifier: "en_US")))
                PreScanSurveyHeightInputView(viewModel: .init(locale: Locale(identifier: "en_AU")))
            }
        }
    }
}
