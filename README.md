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

**The wallpaper.** Ships a true `#000000` background as the default. This is
not a detail — the stock Vantablack default (`0-dot-hands.jpg`) is **1.5%
near-white pixels**, about 78,000 of them at near-full drive in permanently
fixed positions.

## Install

```bash
omarchy theme install https://github.com/rawritude/omarchy-dark-matter-theme.git
omarchy theme set dark-matter
```

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
  borders    active #5a5a5a (0.10)  size 2px
  bar        1440x26 at 0,0

  + Wallpaper 00-pure-black.png is dark (0.0% mean, 0.0% near-white).
  + Background is #000000 — those pixels are off.
  + Foreground #c2c2c2 at 11.8:1 on black — readable without running the
    emitters flat out.
  + Active border #5a5a5a is subdued (0.10).
  + Bar strip 1440x26 is being attenuated 25% by OLED Guard.
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
