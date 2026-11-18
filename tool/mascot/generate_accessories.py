"""Genera los accesorios cosméticos de Aqua como capas SVG.

Uso:  python tool/mascot/generate_accessories.py
Salida: assets/images/accessories/<id>.svg

Cada capa usa el mismo viewBox (512x512) que las etapas de Aqua, de modo que
se superpone directamente sobre la mascota. Los fondos (`bg_*`) se dibujan
detrás; el resto, delante.
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "assets" / "images" / "accessories"


def svg(content: str, defs: str = "") -> str:
    d = f"\n  <defs>{defs}\n  </defs>" if defs else ""
    return (
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="512" height="512">'
        + d + content + "\n</svg>\n"
    )


# ---------- Sombreros (sobre la punta de la gota) ----------
def hat_cap() -> str:
    return svg("""
  <path d="M296 170 Q 380 158 418 182 Q 388 198 300 188 Z" fill="#176A9A"/>
  <path d="M174 178 Q 176 98 256 92 Q 336 98 338 178 Q 256 190 174 178 Z" fill="url(#cap)"/>
  <path d="M256 94 L 256 176" stroke="#176A9A" stroke-width="3" stroke-opacity="0.5"/>
  <path d="M176 172 Q 256 186 336 172" stroke="#FFFFFF" stroke-width="6" fill="none" stroke-opacity="0.7"/>
  <circle cx="256" cy="94" r="9" fill="#176A9A"/>
  <ellipse cx="214" cy="126" rx="16" ry="8" fill="#FFFFFF" fill-opacity="0.35" transform="rotate(-30 214 126)"/>""",
               """
    <linearGradient id="cap" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#4FB8E8"/><stop offset="1" stop-color="#269DD4"/>
    </linearGradient>""")


def hat_flower() -> str:
    petals = "".join(
        f'\n  <ellipse cx="256" cy="66" rx="16" ry="34" fill="{c}" transform="rotate({a} 256 100)"/>'
        for a, c in [(-60, "#FFB3C7"), (60, "#FFB3C7"), (-30, "#FF8FAE"), (30, "#FF8FAE"), (0, "#FF7A9E")]
    )
    return svg(petals + """
  <path d="M200 112 Q 256 92 312 112 Q 256 126 200 112 Z" fill="#59B88A"/>
  <circle cx="256" cy="100" r="13" fill="#F2BD55"/>
  <circle cx="252" cy="96" r="4" fill="#FFFFFF" fill-opacity="0.8"/>""")


def hat_beanie() -> str:
    stripes = "".join(
        f'\n  <path d="M{x} 104 Q {x + 2} 140 {x} 172" stroke="#C8432C" stroke-width="5" fill="none" stroke-opacity="0.6"/>'
        for x in (206, 232, 258, 284, 310)
    )
    return svg("""
  <path d="M172 180 Q 172 96 256 90 Q 340 96 340 180 Z" fill="#E4573D"/>""" + stripes + """
  <rect x="164" y="166" width="184" height="32" rx="16" fill="#C8432C"/>
  <circle cx="256" cy="82" r="24" fill="#FFFFFF"/>
  <circle cx="248" cy="74" r="7" fill="#FFFFFF" stroke="#EEE" stroke-width="2"/>""")


def hat_party() -> str:
    return svg("""
  <path d="M206 178 L 256 34 L 306 178 Z" fill="url(#party)"/>
  <path d="M222 132 L 290 132 M 236 92 L 276 92" stroke="#FFFFFF" stroke-width="10" stroke-opacity="0.8"/>
  <circle cx="232" cy="156" r="6" fill="#F2BD55"/><circle cx="276" cy="112" r="5" fill="#59B88A"/>
  <circle cx="256" cy="34" r="16" fill="#F2BD55"/>
  <path d="M206 178 Q 256 192 306 178" stroke="#8B6CF0" stroke-width="6" fill="none"/>""",
               """
    <linearGradient id="party" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#B98CFF"/><stop offset="1" stop-color="#8B6CF0"/>
    </linearGradient>""")


# ---------- Gafas (sobre los ojos: 208,312 y 304,312) ----------
def _arms(color: str) -> str:
    return f"""
  <path d="M168 304 L 126 292" stroke="{color}" stroke-width="7" stroke-linecap="round"/>
  <path d="M344 304 L 386 292" stroke="{color}" stroke-width="7" stroke-linecap="round"/>"""


def glasses_round() -> str:
    return svg(_arms("#3B2A1E") + """
  <circle cx="208" cy="312" r="40" fill="#FFFFFF" fill-opacity="0.18" stroke="#3B2A1E" stroke-width="8"/>
  <circle cx="304" cy="312" r="40" fill="#FFFFFF" fill-opacity="0.18" stroke="#3B2A1E" stroke-width="8"/>
  <path d="M246 306 Q 256 296 266 306" stroke="#3B2A1E" stroke-width="7" fill="none" stroke-linecap="round"/>""")


def glasses_sun() -> str:
    return svg(_arms("#1A2540") + """
  <rect x="162" y="282" width="88" height="62" rx="22" fill="#1A2540" fill-opacity="0.9"/>
  <rect x="262" y="282" width="88" height="62" rx="22" fill="#1A2540" fill-opacity="0.9"/>
  <path d="M250 300 L 262 300" stroke="#1A2540" stroke-width="8"/>
  <path d="M178 296 L 204 296" stroke="#FFFFFF" stroke-width="6" stroke-linecap="round" stroke-opacity="0.6"/>
  <path d="M278 296 L 304 296" stroke="#FFFFFF" stroke-width="6" stroke-linecap="round" stroke-opacity="0.6"/>""")


def _star(cx: float, cy: float, r: float) -> str:
    import math
    pts = []
    for i in range(10):
        rad = r if i % 2 == 0 else r * 0.5
        a = -math.pi / 2 + i * math.pi / 5
        pts.append(f"{cx + rad * math.cos(a):.1f},{cy + rad * math.sin(a):.1f}")
    return " ".join(pts)


def glasses_star() -> str:
    return svg(_arms("#E0A43A") + f"""
  <polygon points="{_star(208, 314, 50)}" fill="#FF8FAE" fill-opacity="0.75" stroke="#E0A43A" stroke-width="6" stroke-linejoin="round"/>
  <polygon points="{_star(304, 314, 50)}" fill="#FF8FAE" fill-opacity="0.75" stroke="#E0A43A" stroke-width="6" stroke-linejoin="round"/>
  <path d="M248 304 L 264 304" stroke="#E0A43A" stroke-width="7"/>""")


# ---------- Cuello (zona inferior del cuerpo) ----------
def neck_bow() -> str:
    return svg("""
  <path d="M256 404 L 200 376 Q 188 404 200 432 Z" fill="#FF7A9E"/>
  <path d="M256 404 L 312 376 Q 324 404 312 432 Z" fill="#FF7A9E"/>
  <path d="M256 404 L 212 388 Q 206 404 212 420 Z" fill="#FF5A86" fill-opacity="0.6"/>
  <path d="M256 404 L 300 388 Q 306 404 300 420 Z" fill="#FF5A86" fill-opacity="0.6"/>
  <rect x="242" y="390" width="28" height="28" rx="10" fill="#E04A74"/>""")


def neck_scarf() -> str:
    return svg("""
  <path d="M140 378 Q 256 420 372 378 L 380 410 Q 256 456 132 410 Z" fill="#59B88A"/>
  <path d="M150 392 Q 256 430 362 392" stroke="#FFFFFF" stroke-width="5" fill="none" stroke-opacity="0.6" stroke-dasharray="14 10"/>
  <path d="M300 418 L 330 484 L 356 474 L 332 410 Z" fill="#3E8F68"/>
  <path d="M316 470 L 352 462" stroke="#FFFFFF" stroke-width="4" stroke-opacity="0.6"/>""")


# ---------- Fondos (detrás de Aqua) ----------
def bg_ocean() -> str:
    return svg("""
  <rect width="512" height="512" rx="64" fill="url(#sea)"/>
  <path d="M0 360 Q 64 340 128 360 T 256 360 T 384 360 T 512 360 L 512 512 L 0 512 Z" fill="#7FD0F2" fill-opacity="0.6"/>
  <path d="M0 410 Q 64 390 128 410 T 256 410 T 384 410 T 512 410 L 512 512 L 0 512 Z" fill="#F5E2B8"/>
  <circle cx="420" cy="90" r="40" fill="#FFE29A"/>
  <path d="M60 120 q 20 -14 40 0 q 20 -14 40 0" stroke="#FFFFFF" stroke-width="6" fill="none" stroke-linecap="round"/>""",
               """
    <linearGradient id="sea" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#BDE9FB"/><stop offset="1" stop-color="#4FB8E8"/>
    </linearGradient>""")


def bg_rain() -> str:
    drops = "".join(
        f'\n  <path d="M{x} {y} q 4 10 0 16 q -4 -6 0 -16 Z" fill="#7FB6D9"/>'
        for x, y in [(70, 200), (130, 280), (420, 220), (460, 320), (60, 360), (400, 400), (110, 440), (470, 150)]
    )
    return svg("""
  <rect width="512" height="512" rx="64" fill="url(#rain)"/>
  <g fill="#FFFFFF" fill-opacity="0.95">
    <circle cx="110" cy="96" r="34"/><circle cx="150" cy="80" r="42"/><circle cx="196" cy="100" r="30"/>
    <circle cx="360" cy="110" r="30"/><circle cx="400" cy="92" r="40"/><circle cx="440" cy="112" r="28"/>
  </g>""" + drops,
               """
    <linearGradient id="rain" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#DCE8F2"/><stop offset="1" stop-color="#A9C6DD"/>
    </linearGradient>""")


# ---------- Efectos (delante) ----------
def fx_bubbles() -> str:
    bubbles = "".join(
        f'\n  <circle cx="{x}" cy="{y}" r="{r}" fill="#FFFFFF" fill-opacity="0.25" stroke="#FFFFFF" stroke-width="3"/>'
        f'\n  <circle cx="{x - r * 0.35:.1f}" cy="{y - r * 0.35:.1f}" r="{r * 0.25:.1f}" fill="#FFFFFF"/>'
        for x, y, r in [(70, 180, 22), (440, 150, 16), (460, 300, 26), (60, 330, 14), (400, 440, 18), (110, 430, 24), (330, 60, 12), (170, 50, 10)]
    )
    return svg(bubbles)


ITEMS = {
    "hat_cap": hat_cap, "hat_flower": hat_flower, "hat_beanie": hat_beanie, "hat_party": hat_party,
    "glasses_round": glasses_round, "glasses_sun": glasses_sun, "glasses_star": glasses_star,
    "neck_bow": neck_bow, "neck_scarf": neck_scarf,
    "bg_ocean": bg_ocean, "bg_rain": bg_rain, "fx_bubbles": fx_bubbles,
}

if __name__ == "__main__":
    OUT.mkdir(parents=True, exist_ok=True)
    for name, fn in ITEMS.items():
        (OUT / f"{name}.svg").write_text(fn(), encoding="utf-8")
        print("ok", name)
