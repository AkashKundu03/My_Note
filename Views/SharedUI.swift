import SwiftUI

// MARK: - Section header used across tabs
struct SectionHeader: View {
    let title: String
    var trailing: AnyView? = nil

    var body: some View {
        HStack {
            Text(title).font(.title3.weight(.semibold))
            Spacer()
            if let trailing { trailing }   // <- safe optional trailing view
        }
        .padding(.horizontal, 20)
        .padding(.top, 18)
        .padding(.bottom, 8)
    }
}

// MARK: - Blue text with rounded light-blue capsule background
struct PillButton: View {
    let title: String
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
        .foregroundStyle(Color.accentColor)
        .background(
            Capsule(style: .continuous)
                .fill(Color.accentColor.opacity(0.12))
        )
    }
}

// MARK: - App row with icon + title/subtitle + pill
struct AppRowWithPill: View {
    let iconBG: Color
    let iconName: String
    let title: String
    let subtitle: String
    var pillTitle: String = "Try it"
    var action: () -> Void = {}

    // Figma color #F7F9F9
    private let cardBG = Color(red: 247/255, green: 249/255, blue: 249/255)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(cardBG)

            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous).fill(iconBG)
                    Image(systemName: iconName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .frame(width: 36, height: 36)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.body.weight(.semibold))
                        .lineLimit(1)
                        .truncationMode(.tail)

                    Text(subtitle)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                        .padding(.trailing, 6)
                }
                .layoutPriority(1)

                PillButton(title: pillTitle, action: action)
                    .fixedSize()
            }
            .padding(14)
        }
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

// MARK: - Priority chip used in Tasks
struct PriorityChip: View {
    enum Level { case high, low }
    let level: Level

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "calendar")
            Text(level == .high ? "High" : "Low")
        }
        .font(.caption.weight(.semibold))
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule(style: .continuous)
                .fill(level == .high ? Color(.systemRed).opacity(0.14) : Color(.systemGray5))
        )
        .foregroundStyle(level == .high ? Color(.systemRed) : .secondary)
    }
}

// MARK: - Shared bullet row (used by all sheets)
struct BulletRow: View {
    let icon: String
    let title: String
    private let detail: String   // <- store internally as 'detail'

    // Keep the same external label 'body' so you don't have to change call sites
    init(icon: String, title: String, body: String) {
        self.icon = icon
        self.title = title
        self.detail = body
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .frame(width: 28, height: 28)

            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.headline)
                Text(detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
