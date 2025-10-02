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
    // App sheets
    @State private var showSocial = false
    @State private var showEmail  = false
    @State private var showBlog   = false

    // Content sheet after “Continue”
    @State private var showContent = false
    @State private var contentKind: ContentKind = .social

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
                    iconBG: Color(.systemIndigo),
                    iconName: "pencil.circle.fill",
                    title: "Social Media",
                    subtitle: "Whether you play video games",
                    pillTitle: "Try it",
                    action: { showSocial = true }
                )

                AppRowWithPill(
                    iconBG: Color(.systemGreen),
                    iconName: "tray.full.fill",
                    title: "Email Template",
                    subtitle: "Whether you play video games",
                    pillTitle: "Try it",
                    action: { showEmail = true }
                )

                AppRowWithPill(
                    iconBG: Color(.systemOrange),
                    iconName: "pencil.tip.crop.circle.fill",
                    title: "Blog",
                    subtitle: "Whether you play video games",
                    pillTitle: "Try it",
                    action: { showBlog = true }
                )
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
        // MARK: Sheets
        .sheet(isPresented: $showSocial) {
            SocialMediaSheet {
                // close -> then open Content
                contentKind = .social
                showSocial = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { showContent = true }
            }
            .presentationDetents([.fraction(0.78), .large])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showEmail) {
            EmailTemplateSheet {
                contentKind = .email
                showEmail = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { showContent = true }
            }
            .presentationDetents([.fraction(0.78), .large])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showBlog) {
            BlogSheet {
                contentKind = .blog
                showBlog = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { showContent = true }
            }
            .presentationDetents([.fraction(0.78), .large])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showContent) {
            ContentListView(kind: contentKind)   // static data inside
        }
    }
}
