import SwiftUI

struct PreScanSurveyHeightInputView: View {
    @ObservedObject private var viewModel: HeightInputViewModel
    private let isMetricSystem = false

    var body: some View {
        HStack {
            Menu(
                content: primaryPickerContentView,
                label: primaryPickerLabelView
            )
            if !viewModel.locale.isMetricSystem {
                Menu(
                    content: secondaryPickerContentView,
                    label: secondaryPickerLabelView
                )
            }
        }
        .buttonStyle(.plain)
        .padding(24)
        .overlay(borderView)
    }

    init(viewModel: HeightInputViewModel) {
        self.viewModel = viewModel
    }

    private var borderView: some View {
        RoundedRectangle(cornerRadius: 16)
            .inset(by: 2)
            .stroke(Color.blue, lineWidth: 4)
    }

    private var pickerRange: ClosedRange<Int> {
        viewModel.locale.isMetricSystem ? 61...269 : 2...8
    }

    private func primaryPickerLabelView() -> some View {
        Text(viewModel.displayedHeightPrimary)
            .font(.system(size: 46, weight: .semibold))
    }

    private func primaryPickerContentView() -> some View {
        ForEach(pickerRange, id: \.self) { value in
            Button("\(value) \(viewModel.heightPrimaryUnit)") {
                viewModel.heightPrimary = "\(value)"
            }
        }
    }

    private func secondaryPickerLabelView() -> some View {
        Text(viewModel.displayedHeightSecondary)
            .font(.system(size: 46, weight: .semibold))
    }

    private func secondaryPickerContentView() -> some View {
        ForEach(0...11, id: \.self) { value in
            Button("\(value) ″") {
                viewModel.heightSecondary = "\(value)"
            }
        }
    }
}

#if DEBUG
public struct PreScanSurveyHeightInputView_Previews: PreviewProvider {
    public static var previews: some View {
        VStack {
            PreScanSurveyHeightInputView(
                viewModel: .init(locale: Locale(identifier: "en_US"))
            )
            PreScanSurveyHeightInputView(
                viewModel: .init(locale: Locale(identifier: "en_AU"))
            )
        }
    }
}
#endif
