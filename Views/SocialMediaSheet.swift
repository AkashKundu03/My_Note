import SwiftUI

struct SocialMediaSheet: View {
    var onContinue: () -> Void

    // Tile sizing + overlap (0.20 ≈ 4/5 visible)
    private let tileW: CGFloat = 96
    private let tileH: CGFloat = 78
    private let overlapFraction: CGFloat = 0.20

    var body: some View {
        VStack(spacing: 18) {
            // (Grabber removed; system drag indicator comes from SummaryView's .presentationDragIndicator)

            // Zig-zag: Instagram / X / YouTube
            HStack(spacing: -(tileW * overlapFraction)) {
                // 1) Instagram — right side DOWN
                tile { InstagramGlyph() }
                    .rotationEffect(.degrees(8))
                    .zIndex(1)

                // 2) X — left side DOWN (on top)
                tile {
                    Text("X")
                        .font(.system(size: 34, weight: .black))
                        .foregroundStyle(.black)
                }
                .rotationEffect(.degrees(-8))
                .zIndex(2)

                // 3) YouTube — right side DOWN
                tile {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                            .frame(width: 56, height: 38)
                        Image(systemName: "play.fill")
                            .font(.system(size: 20, weight: .black))
                            .foregroundStyle(.white)
                            .offset(x: 1)
                    }
                }
                .rotationEffect(.degrees(8))
                .zIndex(3)
            }
            .frame(height: tileH)
            .padding(.top,34)

            Text("Social Media").font(.title.bold())

            Text("Sync your calendar with Loominote to stay on top of your schedule.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)

            VStack(alignment: .leading, spacing: 18) {
                BulletRow(icon: "calendar", title: "Meeting Reminders",
                          body: "This allows you to record your voice, take notes hands-free.")
                BulletRow(icon: "calendar", title: "Meeting Reminders",
                          body: "This allows you to record your voice, take notes hands-free.")
                BulletRow(icon: "map", title: "Responses can be inaccurate",
                          body: "This helps us provide smarter suggestions, improve your notes.")
            }
            .padding(.horizontal, 24)

            Spacer(minLength: 0)

            Button(action: onContinue) {
                Text("Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 14).fill(Color.accentColor))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 16)
        }
    }

    // Base white rounded tile with shadow; overlays the passed glyph.
    @ViewBuilder
    private func tile<Glyph: View>(@ViewBuilder _ glyph: () -> Glyph) -> some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .fill(.white)
            .frame(width: tileW, height: tileH)
            .shadow(color: .black.opacity(0.12), radius: 8, y: 5)
            .overlay(glyph())
    }
}


// Minimal Instagram mark (pure SwiftUI; no assets)
private struct InstagramGlyph: View {
    var body: some View {
        let grad = AngularGradient(
            gradient: Gradient(colors: [
                Color(red: 0.99, green: 0.72, blue: 0.07),
                Color(red: 0.99, green: 0.23, blue: 0.18),
                Color(red: 0.76, green: 0.12, blue: 0.86),
                Color(red: 0.20, green: 0.58, blue: 0.97),
                Color(red: 0.99, green: 0.72, blue: 0.07)
            ]),
            center: .center
        )
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(grad, lineWidth: 5)
                .frame(width: 54, height: 54)
            Circle()
                .stroke(grad, lineWidth: 5)
                .frame(width: 26, height: 26)
            Circle()
                .fill(grad)
                .frame(width: 6, height: 6)
                .offset(x: 14, y: -14)
        }
    }
}
