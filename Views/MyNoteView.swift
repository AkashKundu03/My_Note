import SwiftUI

// Tabs
enum MyNoteTab: String, CaseIterable, Identifiable {
    case summary = "Summary"
    case tasks = "Tasks"
    case transcript = "Transcript"
    var id: String { rawValue }
}

struct MyNoteView: View {
    @State private var tab: MyNoteTab = .summary

    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemBackground).ignoresSafeArea()

            VStack(spacing: 0) {
                // Top glass buttons
                HStack {
                    GlassIconButton(systemName: "chevron.left") { /* back */ }
                    Spacer()
                    HStack(spacing: 12) {
                        GlassIconButton(systemName: "square.and.arrow.up") { /* share */ }
                        GlassIconButton(systemName: "ellipsis") { /* menu */ }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 6)

                // Title (left aligned)
                VStack(alignment: .leading, spacing: 6) {
                    Text("My Note")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.primary)

                    Text("Meeting with Subham — Sep 16")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 6)

                // Segmented control (white selected pill, black labels)
                CustomSegmented(tab: $tab)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 8)

                // Body (no extra bottom whitespace)
                Group {
                    switch tab {
                    case .summary: SummaryView()
                    case .tasks: TasksView()
                    case .transcript: TranscriptView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

// MARK: Glass morphism circular icon button (pops on white too)
private struct GlassIconButton: View {
    let systemName: String
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.primary)      // black in light mode
                .frame(width: 36, height: 36)
        }
        .buttonStyle(.plain)
        .background(.ultraThinMaterial, in: Circle())
        .overlay( // bright rim
            Circle().stroke(Color.white.opacity(0.55), lineWidth: 0.8)
        )
        .overlay( // subtle inner highlight to sell the glass
            Circle()
                .fill(LinearGradient(
                    colors: [Color.white.opacity(0.35), .clear],
                    startPoint: .top, endPoint: .bottom
                ))
                .padding(8)
        )
        .compositingGroup()
        .shadow(color: .black.opacity(0.14), radius: 12, x: 0, y: 8) // drop shadow
        .shadow(color: .white.opacity(0.35), radius: 1,  x: 0, y: 0) // lift
    }
}

// MARK: Custom segmented control (extra-rounded ends)
private struct CustomSegmented: View {
    @Binding var tab: MyNoteTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(MyNoteTab.allCases) { t in
                Button { tab = t } label: {
                    Text(t.rawValue)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary) // always black per design
                        .frame(maxWidth: .infinity, minHeight: 34)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(tab == t ? Color.white : .clear) // white pill when selected
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}

#Preview { MyNoteView() }
