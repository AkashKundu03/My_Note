import SwiftUI

struct ContentListView: View {
    @Environment(\.dismiss) private var dismiss
    let kind: MNContentKind

    @State private var items: [MNContentItem]
    @State private var showComposer = false

    init(kind: MNContentKind, newlyAdded: MNContentItem? = nil) {
        func seed(_ k: MNContentKind) -> [MNContentItem] {
            switch k {
            case .social:
                return Array(repeating:
                                MNContentItem(kind: .social, channel: "Instagram",
                                              title: "Marketing Review",
                                              subtitle: "Today’s discussion focused on simplifying the cycle.",
                                              body: "Today’s discussion focused on simplifying the cycle."),
                             count: 5)
            case .email:
                return Array(repeating:
                                MNContentItem(kind: .email, channel: "Email",
                                              title: "Welcome Email",
                                              subtitle: "Introduce the product and key value quickly.",
                                              body: "Introduce the product and key value quickly."),
                             count: 5)
            case .blog:
                return Array(repeating:
                                MNContentItem(kind: .blog, channel: "Blog",
                                              title: "Design Notes",
                                              subtitle: "Turning raw ideas into a clean outline.",
                                              body: "Turning raw ideas into a clean outline."),
                             count: 5)
            }
        }
        var base = seed(kind)
        if let n = newlyAdded { base.insert(n, at: 0) }
        _items = State(initialValue: base)
        self.kind = kind
    }

    var body: some View {
        NavigationStack {
            List {
                Section(header: header) {
                    ForEach(items.indices, id: \.self) { i in
                        NavigationLink {
                            NewContentView(
                                kind: kind,
                                editingItem: items[i]
                            ) { updated in
                                if let idx = items.firstIndex(where: { $0.id == updated.id }) {
                                    items[idx] = updated
                                }
                            }
                            .navigationBarBackButtonHidden(true)
                        } label: {
                            cell(items[i])
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Contents")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // iOS 16+ uses .topBarLeading; earlier iOS uses .navigationBarLeading
                if #available(iOS 16.0, *) {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                        }
                    }
                } else {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showComposer) {
            NewContentView(kind: kind) { item in
                items.insert(item, at: 0)
                showComposer = false
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
            // Comment this next line if you target iOS 16 or below
            .presentationCornerRadius(28)
        }
    }

    private var header: some View {
        HStack {
            Text("Contents").font(.headline)
            Spacer()
            Button("New Content") { showComposer = true }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.accentColor)
        }
    }

    @ViewBuilder
    private func cell(_ item: MNContentItem) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(item.title).font(.body.weight(.semibold))
                Spacer()
                Image(systemName: "ellipsis").foregroundStyle(.secondary)
            }
            Text(item.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Divider().padding(.top, 8)
        }
        .padding(.vertical, 6)
    }
}
