# DESIGN

<!-- Optional: only for projects with a visual side (website, app, game, device screen). -->
<!-- Written in the kickoff after PLAN, from the approved mood board. Delete sections that don't apply. -->
<!-- Read by Claude Code before any UI work. -->

## Type
- Website / app / game / device screen

## Mood
- Keywords (3–5):
- References: link — what to take from it
- Not like: what to avoid

## Colours
| Role | Hex | Used for |
|------|-----|----------|
| background | | |
| surface | | cards, panels |
| text | | |
| text-muted | | |
| primary | | main actions |
| accent | | highlights |
| success / warning / error | | states |

## Typography
- Headings: font, weight
- Body: font, size
- Numbers / code: font
- Source and licence:

## Motion
- Feel: calm / snappy / playful
- Durations: fast ~150 ms, normal ~300 ms
- Reduced motion: what turns off

## Accessibility
- Text contrast at least 4.5:1
- Visible focus states, usable without a mouse where it makes sense
- Respect "reduce motion" settings

## Do / Don't
- Do:
- Don't:

## Website / app
- Layout: max width, grid, spacing scale
- Components: buttons, cards, nav, forms — one line each
- Effects: glass, glow, gradients, noise — where and how strong
- Theme modes: dark / light / both
- Mobile: what changes on small screens

## Game
- Art style: pixel / low-poly / hand-drawn / vector
- Scale: base resolution, pixel scale, sprite and tile sizes
- Characters and objects: silhouettes, outlines yes/no
- HUD and menus: what is on screen and where
- Camera:
- Sound style:

## Device screen
- Display: size, resolution, colour depth
- States: colour per state (idle, active, warning, error)
- Readability: minimum text size, viewing distance
- LEDs and physical indicators:

## Theme file
- Location: set in Stage 1, e.g. `src/styles/theme.css` or `src/theme.ts`
- Rule: every colour, font and duration comes from this file; no hard-coded values elsewhere
