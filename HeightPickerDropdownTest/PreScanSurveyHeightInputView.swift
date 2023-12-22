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
        viewModel.locale.isMetricSystem ? 6...26 : 2...8
    }

    private func primaryPickerLabelView() -> some View {
        Text(viewModel.displayedHeightPrimary)
            .font(.system(size: 46, weight: .semibold))
    }

    @ViewBuilder
    private func primaryPickerContentView() -> some View {
        if viewModel.locale.isMetricSystem {
            ForEach(pickerRange, id: \.self) { decimeter in
                Menu("\(decimeter)0 см - \(decimeter)9 см") {
                    ForEach(0...9, id: \.self) { centimeter in
                        let centimeters = decimeter * 10 + centimeter
                        Button("\(centimeters) cm") {
                            viewModel.heightPrimary = "\(centimeters)"
                        }
                    }
                }
            }
        } else {
            ForEach(pickerRange, id: \.self) { value in
                Button("\(value) ′") {
                    viewModel.heightPrimary = "\(value)"
                }
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
