# Tour Companion - Design System

Bright modern mobile travel app for a branded multi-city sporting tour. Light, airy,
immersive, discovery-forward. No dark theme. No em dash anywhere.

## Frame
- 393x852 (iPhone 16/17). Top status/notch inset ~59px, bottom home-indicator inset ~34px.
- Never place tappable content under the status bar or home indicator.
- Screen edge padding 20px.

## Color (use these EXACT hexes - do NOT use generic violet #6366F1 or flat grey #6B7280)
- background (tinted near-white): `#F1F8FA`
- surface (card/sheet): `#FFFFFF`
- surfaceAlt (grouped rows): `#E9F3F6`
- accent (lagoon blue, primary actions/active): `#0EA5C4`
- accentTint (fills/badges/selected): `#D6EEF4`
- accentPressed: `#0C8BA6`
- support (sunset warm, secondary data / illustration only, never a primary button): `#FF9E5E`
- text primary (near-ink, tinted): `#0E2126`
- text secondary: `#41595F`
- text tertiary (hint/placeholder): `#7C9299`
- border (hairline): `#D4E4E8`
- success `#16A34A`, warning `#D97706`, danger `#DC2626`

Neutrals are cool-tinted toward the lagoon accent. Background is never pure white.

## Typography - font family: Sora (Google Font), used across ALL screens
- display: 32 / 700 / -0.02em - hero titles, countdowns, "What's next"
- title: 20 / 600 - section headers, card titles
- body: 16 / 400 - default text
- label: 14 / 500 - buttons, tabs, chips
- caption: 13 / 500 - times, metadata (secondary color)

## Radius / spacing / elevation
- radius: card 20, control 14, input 12, pill 999
- spacing: 8pt scale (4,8,12,16,24,32); generous vertical rhythm
- elevation: soft only - card = 0 1px 2px rgba(0,0,0,.04) + 0 8px 24px rgba(0,0,0,.06). No hard/black shadows.

## Icons
- ONE set only: rounded outline (Lucide style), 24px, ~1.75 stroke. Never mix outline + filled.

## Controls (one spec, reused everywhere)
- Primary button: pill, accent `#0EA5C4` fill, white label; pressed = `#0C8BA6`; disabled = accentTint fill + tertiary label.
- Secondary button: pill, white fill, accent border + accent label.
- Text input: 12px radius, white fill, border `#D4E4E8`; focus = accent ring; error = danger ring.
- Card: 20px radius, white surface, soft shadow.
- Chip: pill; selected = accentTint fill + accent label; unselected = surfaceAlt + secondary label.
- Segmented control: pill track surfaceAlt, selected segment white with soft shadow.

## Gradient + focal rules
- Soft accent -> support gradient (`#0EA5C4` -> `#FF9E5E`, low contrast, 2 stops) ONLY on:
  the tour-code hero, the welcome screen, and the home "What's next" hero card. Tab bar stays flat.
- Duotone (accent + support) on hero imagery (MCG photo, activity hero).
- ONE bold focal element per screen: the code input, the welcome check, the "What's next"
  hero card, the map, the pinned update. Everything else stays quiet.
- Banned: rainbow gradients, gradient on body text, gradient soup.

## Shared components (consistency mandatory - reuse verbatim)
### Bottom tab bar (EXACTLY 5 tabs, this order, on every nav screen)
1. Home - house icon
2. Itinerary - calendar-days icon
3. Map - map-pin icon
4. Updates - bell icon
5. Profile - user icon

Active tab: accent `#0EA5C4` icon + label. Inactive: tertiary grey `#7C9299`. Flat white bar,
hairline top border, no gradient. Never rename, reorder, add, or remove tabs. Full-screen /
onboarding / detail / modal screens render NO bottom tab bar.

### Top app bar
- Tour name + group chip (e.g. "Group C - Ashes Tour AU").
- Slim "Offline ready" pill (accentTint) when the itinerary is cached.

## Realistic mock data
Ashes Tour Australia 2026, six tour groups, cities Melbourne / Sydney / Adelaide, venues MCG /
SCG, hotels Crown Melbourne, delegate Alex Morgan, tour code ASH-42K. Never lorem ipsum.

## a11y
- accent darkened for small text/icons where needed to pass >=4.5:1 on white.
- all tap targets >=44x44pt.
