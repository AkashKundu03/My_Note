
import SwiftUI

struct TranslateSheet: View {
    var onContinue: () -> Void
    
    // Match other sheets
    private let tileW: CGFloat = 96
    private let tileH: CGFloat = 78
    private let overlapFraction: CGFloat = 0.20   // ≈ 4/5 visible
    
    var body: some View {
        VStack(spacing: 18) {
            // (Grabber intentionally omitted – system drag indicator comes from .sheet)
            
            // ===== Zig-zag: Globe / Arrows / ABC =====
            HStack(spacing: -(tileW * overlapFraction)) {
                tile {
                    // Globe — languages palette
                    Image(systemName: "globe.asia.australia.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.blue)
                }
                .rotationEffect(.degrees(8))
                .zIndex(1)
                
                tile {
                    // Two-way arrows — translation direction
                    Image(systemName: "arrow.left.arrow.right")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.indigo)
                }
                .rotationEffect(.degrees(-8))
                .zIndex(2)
                
                tile {
                    // ABC — transliteration/normalization
                    Image(systemName: "textformat.abc.dottedunderline")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.teal)
                }
                .rotationEffect(.degrees(8))
                .zIndex(3)
            }
            .frame(height: tileH)
            .padding(.top, 34)
            
            Text("Translate").font(.title.bold())
            
            Text("Instantly translate your summaries and voice transcripts into any language. Enjoy wide language support with clear, natural results you can share anywhere.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)
            
            // Feature bullets (static copy; mirrors other sheets)
            VStack(alignment: .leading, spacing: 18) {
                BulletRow(icon: "character.bubble.fill",
                          title: "Many languages",
                          body: "Translate between major world languages with solid coverage.")
                BulletRow(icon: "text.alignleft",
                          title: "Preserve style",
                          body: "Keep your brand voice while adapting for locale.")
                BulletRow(icon: "mic.and.signal.meter.fill",
                          title: "Names stay intact",
                          body: "Protect proper nouns, product names, and hashtags.")
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
    
    // Base tile used in your other sheets
    @ViewBuilder
    private func tile<Glyph: View>(@ViewBuilder _ glyph: () -> Glyph) -> some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .fill(.white)
            .frame(width: tileW, height: tileH)
            .shadow(color: .black.opacity(0.12), radius: 8, y: 5)
            .overlay(glyph())
    }
}
