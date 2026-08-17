# Dark Matter

A true-black [Omarchy](https://omarchy.org/) theme for OLED panels, plus a tool
that measures whether your desktop actually deserves one.

Most "OLED themes" are dark themes with the background pushed a bit further
down. This one is built around three rules, and every number below was
measured rather than asserted.

## The three rules

**1 · The background is `#000000`.**

On an OLED that is not a very dark grey — it is the pixel switched off. No
light, no power, no ageing. `#0b0b0b` looks nearly identical and is a
fundamentally different thing to the panel.

**2 · Nothing is pure white.**

`#ffffff` drives all three emitters flat out, and body text is the largest
continuously-lit area on a desktop. It buys contrast nobody needs:

| foreground | contrast on black | emitted light |
|---|---|---|
| `#ffffff` | 21.0:1 | 100% |
| **`#c2c2c2`** (Dark Matter) | **11.8:1** | **54%** |

WCAG AAA asks for 7:1. Dark Matter clears it by a wide margin while emitting
**46% less light** for every character on screen.

**3 · Colour is spent, not scattered.**

One hue — amber `#d9822b` — carries meaning. Everything else is neutral, and
differentiation comes from lightness, which reads on any panel. Blue is the
shortest-lived emitter in an OLED stack, so no large surface is allowed to
depend on it.

This reaches further than the terminal. Applications that colour themselves
through the ANSI palette rather than truecolor inherit it — which is why
`yellow` here is `#7a7a7a` rather than something bright: it is the slot several
tools land their status chrome in, and status chrome does not move.

The honest trade-off: **syntax highlighting reads as a greyscale with one
accent.** If you want a conventional rainbow in your editor, point
`neovim.lua` at a different colorscheme — the desktop chrome stays Dark Matter.

## What else it fixes

**Window borders.** Omarchy's theme template leaves `hyprland_active_border`
inheriting `accent`. On a bright-accented theme that makes the border the
brightest continuously-lit thing on screen after the bar — thin, but long, and
on a tiling layout it holds still for as long as the layout does. Dark Matter
sets it explicitly to a neutral `#5a5a5a`: unmistakable as a focus cue against
true black, at roughly a tenth of white's emission.

Measured on a two-window tiling layout, borders turn out to be the *largest*
static emitter on screen — ahead of the status bar, which is mostly black with
sparse glyphs while a border is a solid line with every pixel lit. So the
inactive border is set fully transparent: only the focused window needs one, and
focus stays unambiguous because exactly one window has a border at all.

**The wallpaper.** Ships a true `#000000` background as the default. This is
not a detail — the stock Vantablack default (`0-dot-hands.jpg`) is **1.5%
near-white pixels**, about 78,000 of them at near-full drive in permanently
fixed positions.

## Install

```bash
omarchy theme install https://github.com/rawritude/omarchy-dark-matter-theme.git
omarchy theme set dark-matter
```

## Companion settings

None of these belong in a theme — they change application behaviour rather than
colour, and a theme should not quietly do that. They are listed here because
Dark Matter is what makes them worth having.

**Hyprland** — `~/.config/hypr/looknfeel.lua`:

```lua
-- Border emission is perimeter x thickness. Halving the thickness halves the
-- light while leaving the focus cue legible. Measured: border pixels drop from
-- ~29,900 to ~18,400. On a tiling layout borders are the largest static
-- emitter on screen, ahead of the status bar.
hl.config({ general = { border_size = 1 } })

-- Dims unfocused window *content* (not borders). Measured at 14.7% less total
-- screen emission on a two-window layout.
hl.config({ decoration = { dim_inactive = true, dim_strength = 0.30 } })
```

**herdr** (terminal multiplexer) — `~/.config/herdr/config.toml`:

```toml
[theme]
name = "terminal"          # inherit this palette instead of herdr's own

[theme.custom]
panel_bg    = "black"
sidebar_bg  = "#000000"    # the sidebar is a tall column held all session
surface_dim = "#0b0b0b"
accent      = "#7a7a7a"    # the active tab is a filled block; neutral and dim

[ui]
hide_tab_bar_when_single_tab = true
pane_outer_borders = false   # no outer frame, same argument as border_size
pane_scrollbars    = false   # reclaims a permanently-lit column
```

Two herdr caveats found the hard way: `panel_bg` is the entire tab-bar
background rather than just the active tab's text, so it must stay black — which
is why the accent has to stay light enough for black text to read on it. And
`fg`/`dim` on `tab_bar_right` entries are accepted by `herdr config check` but
ignored by the renderer, so the hostname there cannot be darkened, only removed.

**Claude Code** — `~/.claude/settings.json`:

```json
{ "theme": "dark-ansi" }
```

`dark-ansi` routes Claude Code's own chrome through the terminal's ANSI palette
instead of hardcoded truecolor, which is the only thing that brings it under a
theme's control. Its status line sits in a fixed row at the bottom of a pane for
an entire session — measured at 1,218 units of emission, roughly 28x a
bar that OLED Guard is attenuating. Expect its UI to read as greyscale
afterwards, which is the same bargain this theme already makes for syntax.

## `oled-audit`

The theme ships a tool that measures a live Omarchy desktop and reports what is
costing panel life. It changes nothing.

```bash
bin/oled-audit          # human-readable
bin/oled-audit --json   # for scripting
```

```
OLED audit  what is costing panel life on this desktop

  theme      dark-matter  background #000000
  wallpaper  00-pure-black.png  mean 0.0%  near-white 0.0%
  borders    active #5a5a5a (0.10)  size 1px
  bar        1440x26 at 0,0

  + Wallpaper 00-pure-black.png is dark (0.0% mean, 0.0% near-white).
  + Background is #000000 — those pixels are off.
  + Foreground #c2c2c2 at 11.8:1 on black — readable without running the
    emitters flat out.
  + Active border #5a5a5a is subdued (0.10).
  + Bar strip 1440x26 is being attenuated 85% by OLED Guard.
```

It checks four things, because those are the four a desktop actually controls:

| probe | what it measures | why |
|---|---|---|
| wallpaper | mean luminance **and** near-white share | mean alone is misleading — diffuse light spreads wear, concentrated static peaks accumulate it in fixed pixels |
| theme | background, foreground contrast and luminance | catches pure-white foregrounds and near-black-but-not-black backgrounds |
| borders | colour, alpha, effective luminance | composited against black, so alpha counts |
| bar | geometry, and whether anything is attenuating it | the one surface pinned to the same pixels all session |

Run it against a stock theme and it will tell you what it finds. Pointed at
Vantablack it flags the pure-`#ffffff` foreground, which is the specific thing
this theme exists to fix.

Luminance is computed through the sRGB gamma curve, not linearly — `#808080`
looks half-bright but emits about a fifth of white, and guessing linearly would
overstate every mid-grey in the report.

Requires `python3` (3.11+ for `tomllib`) and ImageMagick for the wallpaper probe.

## Pairs with

[OLED Guard](https://github.com/rawritude/omarchy-oled-guard) — a shell plugin
that attenuates the status bar strip, the one surface a theme cannot help with,
because its cost is not the colour but the fact that it never moves.

## Keeping it in proportion

Lower your brightness and set a short display-off timeout first. Both beat
everything here on effort-to-benefit. A
[3000-hour burn-in test](https://www.notebookcheck.net/3000-hour-LG-OLED-monitor-burn-in-test-reveals-minor-defects-with-Overwatch-2-a-culprit.1221804.0.html)
found modern panels hold up well, with damage concentrated in high-contrast
static elements. This theme is insurance against exactly that shape — not an
emergency.

## Licence

MIT
