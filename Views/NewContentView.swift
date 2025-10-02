import SwiftUI

struct NewContentView: View {
    @Environment(\.dismiss) private var dismiss
    let kind: MNContentKind
    /// When editing an existing row we pass it in; Generate will keep its id.
    var editingItem: MNContentItem? = nil
    var onGenerate: (MNContentItem) -> Void

    // top pills
    private let channels = ["Twitter", "Instagram", "LinkedIn", "YouTube"]
    @State private var selectedIndex: Int = 1 // Instagram default

    // content editor text
    @State private var text: String = """
And what's, what has been implemented and what we want. Uh, this looks good, definitely. No worries on that. Uh, the thing is that, uh, here, what do you want is, uh, the moment, uh, someone who goes into the home screen, right?
"""

    // chips (equal size, horizontal scroll)
    private let chipData: [(String,String)] = [
        ("Falling dreams","Fear of losing control"),
        ("Being chased","Avoiding problems or pressure"),
        ("Missed flight","Deadline anxiety")
    ]

    init(kind: MNContentKind,
         editingItem: MNContentItem? = nil,
         onGenerate: @escaping (MNContentItem) -> Void) {
        self.kind = kind
        self.editingItem = editingItem
        self.onGenerate = onGenerate
        // _text / _selectedIndex are @State; we hydrate them in .onAppear to avoid SwiftUI complaints
    }

    var body: some View {
        VStack(spacing: 0) {
            // Centered title row
            HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.primary)
                                .frame(width: 36, height: 36)
                                .background(.ultraThinMaterial, in: Circle())
                        }

                        Spacer()
                        Text("New Content").font(.title2.bold())
                        Spacer()

                        // spacer to balance the leading button
                        Color.clear.frame(width: 36, height: 36)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

            // Top pills
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(channels.indices, id: \.self) { i in
                        Button {
                            selectedIndex = i
                        } label: {
                            Text(channels[i])
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(selectedIndex == i ? .white : .primary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule(style: .continuous)
                                        .fill(selectedIndex == i ? Color.primary : Color(.systemGray6))
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
            }

            // Content box
            VStack(alignment: .leading, spacing: 8) {
                Text("CONTENT")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)

                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .padding(8)
                        .frame(minHeight: 220, maxHeight: 240)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(Color(.systemGray6))
                        )
                        .scrollContentBackground(.hidden)

                    if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text("Type or paste your content…")
                            .foregroundStyle(.secondary)
                            .padding(.top, 16).padding(.leading, 16)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)

            // Equal chips (horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {                       // <- exact gap between chips
                    ForEach(0..<chipData.count, id: \.self) { i in
                        Chip(title: chipData[i].0, subtitle: chipData[i].1)
                    }
                }
                .padding(.leading, 20)                     // align with your other content (change to 0 if you want)
                .padding(.trailing, 20)
                .padding(.top, 14)
            }




            Spacer(minLength: 0)

            // Generate -> create/overwrite item, send back
            Button {
                let ch = channels[selectedIndex]
                let (title, sub) = suggestedMeta(from: text)
                let idToKeep = editingItem?.id ?? UUID()
                let item = MNContentItem(id: idToKeep,
                                         kind: kind,
                                         channel: ch,
                                         title: title,
                                         subtitle: sub,
                                         body: text)
                onGenerate(item)
            } label: {
                Text("Generate")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 14).fill(Color.accentColor))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
            }
        }
        .toolbar(.hidden, for: .navigationBar)   // ⬅️ hide system bar so only your header shows
                .onAppear {
                    if let e = editingItem {
                        text = e.body
                        if let idx = channels.firstIndex(of: e.channel) { selectedIndex = idx }
                    }
                }
            }
    // Helpers
    private func suggestedMeta(from text: String) -> (String,String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return ("New Content", "Draft generated") }
        let firstSentence = trimmed.split(separator: ".").first.map(String.init) ?? trimmed
        return (firstSentence, trimmed)
    }

    // equal-sized info chip
    struct Chip: View {
        let title: String
        let subtitle: String

        var body: some View {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.subheadline.weight(.semibold))
                Text(subtitle).font(.caption).foregroundStyle(.secondary)
            }
            .padding(.horizontal, 12)        // inner text padding
            .padding(.vertical, 10)
            .frame(width: 220, height: 64)   // <- Frame BEFORE background so tile fills full width
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            )
            // no outer padding here
        }
    }




}
