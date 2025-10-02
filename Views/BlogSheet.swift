import SwiftUI

struct BlogSheet: View {
    var onContinue: () -> Void

    private let tileW: CGFloat = 96
    private let tileH: CGFloat = 78
    private let overlapFraction: CGFloat = 0.20

    var body: some View {
        VStack(spacing: 18) {
            // (Grabber removed; system drag indicator is provided by the .sheet modifier)

            // Zig-zag: Book / List / Sparkles
            HStack(spacing: -(tileW * overlapFraction)) {
                tile {
                    Image(systemName: "text.book.closed.fill")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.orange)
                }
                .rotationEffect(.degrees(8))
                .zIndex(1)

                tile {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.pink)
                }
                .rotationEffect(.degrees(-8))
                .zIndex(2)

                tile {
                    Image(systemName: "sparkles")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.yellow)
                }
                .rotationEffect(.degrees(8))
                .zIndex(3)
            }
            .frame(height: tileH)
            .padding(.top, 34)

            Text("Blog").font(.title.bold())

            Text("Turn summaries into formatted blog posts and outlines.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)

            VStack(alignment: .leading, spacing: 18) {
                BulletRow(icon: "list.bullet.rectangle.portrait.fill", title: "Outline from notes",
                          body: "Convert a note into a clean, organized outline.")
                BulletRow(icon: "sparkles", title: "Catchy titles",
                          body: "Get multiple headline options instantly.")
                BulletRow(icon: "chart.bar.doc.horizontal.fill", title: "SEO hints",
                          body: "Add keywords and meta description suggestions.")
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

    @ViewBuilder
    private func tile<Glyph: View>(@ViewBuilder _ glyph: () -> Glyph) -> some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .fill(.white)
            .frame(width: tileW, height: tileH)
            .shadow(color: .black.opacity(0.12), radius: 8, y: 5)
            .overlay(glyph())
    }
}
