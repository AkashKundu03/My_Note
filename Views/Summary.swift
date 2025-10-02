//import SwiftUI
//
//struct SummaryView: View {
//    var body: some View {
//        ScrollView {
//            SectionHeader(title: "Summary")
//
//            Text("""
//Today’s discussion focused on simplifying the onboarding flow and aligning it with the overall product vision. The user emphasized the importance of keeping the design clean, fast, and aligned with Apple’s ecosystem.
//""")
//            .font(.body)
//            .padding(.horizontal, 20)
//
//            SectionHeader(title: "Apps")
//
//
//            VStack(spacing: 12) {
//                AppRowWithPill(iconBG: Color(.systemIndigo), iconName: "pencil.circle.fill",
//                               title: "Social Media", subtitle: "Whether you play video games")
//
//                AppRowWithPill(iconBG: Color(.systemGreen), iconName: "tray.full.fill",
//                               title: "Email Template", subtitle: "Whether you play video games")
//
//                AppRowWithPill(iconBG: Color(.systemOrange), iconName: "pencil.tip.crop.circle.fill",
//                               title: "Blog", subtitle: "Whether you play video games")
//            }
//
//            .padding(.horizontal, 20)
//            .padding(.bottom, 24)
//
//            VStack(alignment: .leading, spacing: 4) {
//                // Top-left icon
//                Image(systemName: "person.2.fill")
//                    .font(.system(size: 14, weight: .semibold))
//                    .foregroundStyle(.secondary)
//
//                // Text sits below the icon, aligned left
//                Text("By tapping next, you are agreeing to Loominote Terms of Use & Privacy Policy. Your device serial number See how your data is managed..")
//                    .font(.caption2)
//                    .foregroundStyle(.secondary)
//                    .fixedSize(horizontal: false, vertical: true) // wrap text naturally
//            }
//            .padding(.horizontal, 20)
//            .padding(.bottom, 32)
//
//        }
//    }
//}


import SwiftUI

struct SummaryView: View {
    // App sheets you already have
    @State private var showSocial = false
    @State private var showEmail  = false
    @State private var showBlog   = false

    // Composer / List handoff
    @State private var showComposer = false
    @State private var showList     = false
    @State private var composerKind: MNContentKind = .social
    @State private var justMadeItem: MNContentItem?

    var body: some View {
        ScrollView {
            SectionHeader(title: "Summary")

            Text("""
Today’s discussion focused on simplifying the onboarding flow and aligning it with the overall product vision. The user emphasized the importance of keeping the design clean, fast, and aligned with Apple’s ecosystem.
""")
            .font(.body)
            .padding(.horizontal, 20)

            SectionHeader(title: "Apps")

            VStack(spacing: 12) {
                AppRowWithPill(
                    iconBG: Color(.systemIndigo), iconName: "pencil.circle.fill",
                    title: "Social Media", subtitle: "Whether you play video games",
                    pillTitle: "Try it"
                ) { showSocial = true }

                AppRowWithPill(
                    iconBG: Color(.systemGreen), iconName: "tray.full.fill",
                    title: "Email Template", subtitle: "Whether you play video games",
                    pillTitle: "Try it"
                ) { showEmail = true }

                AppRowWithPill(
                    iconBG: Color(.systemOrange), iconName: "pencil.tip.crop.circle.fill",
                    title: "Blog", subtitle: "Whether you play video games",
                    pillTitle: "Try it"
                ) { showBlog = true }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 24)

            VStack(alignment: .leading, spacing: 4) {
                Image(systemName: "person.2.fill")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.secondary)

                Text("By tapping next, you are agreeing to Loominote Terms of Use & Privacy Policy. Your device serial number See how your data is managed..")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        // ===== Sheets (unchanged look) =====
        .sheet(isPresented: $showSocial) {
            SocialMediaSheet {
                composerKind = .social
                showSocial = false
                showComposer = true
            }
            .presentationDetents([.fraction(0.78), .large])
            .presentationCornerRadius(28)
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showEmail) {
            EmailTemplateSheet {
                composerKind = .email
                showEmail = false
                showComposer = true
            }
            .presentationDetents([.fraction(0.78), .large])
            .presentationCornerRadius(28)
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showBlog) {
            BlogSheet {
                composerKind = .blog
                showBlog = false
                showComposer = true
            }
            .presentationDetents([.fraction(0.78), .large])
            .presentationCornerRadius(28)
            .presentationDragIndicator(.visible)
        }
        // New Content composer
        .sheet(isPresented: $showComposer) {
            NewContentView(kind: composerKind) { item in
                justMadeItem = item
                showComposer = false
                showList = true
            }
            .presentationDetents([.large])
            .presentationCornerRadius(28)
            .presentationDragIndicator(.visible)
        }
        // Contents list (shows the new item at top)
        .sheet(isPresented: $showList) {
            ContentListView(kind: composerKind, newlyAdded: justMadeItem)
                .presentationDetents([.large])
                .presentationCornerRadius(28)
                .presentationDragIndicator(.visible)
        }
    }
}

