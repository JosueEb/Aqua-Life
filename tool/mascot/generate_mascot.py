"""Genera las 5 etapas de Aqua como SVG con piezas compartidas.

Uso:  python tool/mascot/generate_mascot.py
Salida: assets/images/mascot/stage_N/aqua_stage_N.svg

La silueta, los ojos y las proporciones son comunes a todas las etapas para
que Aqua sea reconocible; cada etapa añade expresión y accesorios.
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "assets" / "images" / "mascot"

# Silueta base de la gota (viewBox 512x512, centro del cuerpo en 256,318).
DROP = (
    "M256 62 C 292 128, 404 214, 404 318 "
    "A 148 148 0 0 1 108 318 C 108 214, 220 128, 256 62 Z"
)


def defs(tint_mid: str, tint_edge: str, extra: str = "") -> str:
    return f"""
  <defs>
    <radialGradient id="body" cx="42%" cy="40%" r="70%">
      <stop offset="0" stop-color="#F4FBFF" stop-opacity="0.97"/>
      <stop offset="0.55" stop-color="{tint_mid}" stop-opacity="0.92"/>
      <stop offset="1" stop-color="{tint_edge}" stop-opacity="0.95"/>
    </radialGradient>
    <linearGradient id="rim" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#FFFFFF" stop-opacity="0.95"/>
      <stop offset="1" stop-color="#FFFFFF" stop-opacity="0.35"/>
    </linearGradient>
    <radialGradient id="eye" cx="45%" cy="40%" r="65%">
      <stop offset="0" stop-color="#2E4A7A"/>
      <stop offset="1" stop-color="#0E1A33"/>
    </radialGradient>
    <radialGradient id="blush" cx="50%" cy="50%" r="50%">
      <stop offset="0" stop-color="#FF7F9A" stop-opacity="0.85"/>
      <stop offset="1" stop-color="#FF7F9A" stop-opacity="0"/>
    </radialGradient>
    <radialGradient id="shadow" cx="50%" cy="50%" r="50%">
      <stop offset="0" stop-color="#0B4F75" stop-opacity="0.28"/>
      <stop offset="1" stop-color="#0B4F75" stop-opacity="0"/>
    </radialGradient>
    <linearGradient id="limb" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#D9F1FD"/>
      <stop offset="1" stop-color="{tint_edge}"/>
    </linearGradient>
    {extra}
  </defs>"""


def body() -> str:
    return f"""
  <ellipse cx="256" cy="472" rx="120" ry="16" fill="url(#shadow)"/>
  <path d="{DROP}" fill="url(#body)" stroke="url(#rim)" stroke-width="5"/>
  <path d="M176 200 C 196 160, 226 126, 244 104" stroke="#FFFFFF" stroke-opacity="0.85"
        stroke-width="16" stroke-linecap="round" fill="none"/>
  <ellipse cx="160" cy="262" rx="14" ry="30" fill="#FFFFFF" fill-opacity="0.55"
           transform="rotate(20 160 262)"/>
  <circle cx="352" cy="232" r="7" fill="#FFFFFF" fill-opacity="0.6"/>
  <circle cx="338" cy="404" r="9" fill="#FFFFFF" fill-opacity="0.45"/>
  <circle cx="176" cy="412" r="6" fill="#FFFFFF" fill-opacity="0.45"/>
  <circle cx="364" cy="372" r="4" fill="#FFFFFF" fill-opacity="0.5"/>"""


def eyes(happy_closed: bool = False) -> str:
    if happy_closed:
        return """
  <path d="M188 314 Q 210 290 232 314" stroke="#0E1A33" stroke-width="9" fill="none" stroke-linecap="round"/>
  <path d="M280 314 Q 302 290 324 314" stroke="#0E1A33" stroke-width="9" fill="none" stroke-linecap="round"/>"""
    return """
  <g>
    <ellipse cx="208" cy="312" rx="27" ry="30" fill="url(#eye)"/>
    <circle cx="217" cy="300" r="10" fill="#FFFFFF"/>
    <circle cx="199" cy="324" r="4.5" fill="#FFFFFF" fill-opacity="0.9"/>
  </g>
  <g>
    <ellipse cx="304" cy="312" rx="27" ry="30" fill="url(#eye)"/>
    <circle cx="313" cy="300" r="10" fill="#FFFFFF"/>
    <circle cx="295" cy="324" r="4.5" fill="#FFFFFF" fill-opacity="0.9"/>
  </g>"""


def blush() -> str:
    return """
  <ellipse cx="172" cy="356" rx="24" ry="13" fill="url(#blush)"/>
  <ellipse cx="340" cy="356" rx="24" ry="13" fill="url(#blush)"/>"""


def mouth(kind: str) -> str:
    if kind == "small":
        return '\n  <path d="M244 352 Q 256 364 268 352" stroke="#1A2540" stroke-width="6" fill="none" stroke-linecap="round"/>'
    if kind == "open":
        return """
  <path d="M234 348 Q 256 384 278 348 Z" fill="#7A2E3E" stroke="#1A2540" stroke-width="5" stroke-linejoin="round"/>
  <path d="M244 364 Q 256 356 268 364 Q 256 378 244 364 Z" fill="#FF8FA3"/>"""
    if kind == "grin":
        return '\n  <path d="M238 350 Q 256 372 274 350" stroke="#1A2540" stroke-width="7" fill="none" stroke-linecap="round"/>'
    return ""


def limbs(arms: str = "down") -> str:
    legs = """
  <rect x="210" y="446" width="30" height="30" rx="15" fill="url(#limb)" stroke="#FFFFFF" stroke-opacity="0.7" stroke-width="3"/>
  <rect x="272" y="446" width="30" height="30" rx="15" fill="url(#limb)" stroke="#FFFFFF" stroke-opacity="0.7" stroke-width="3"/>"""
    if arms == "up":
        a = """
  <rect x="88" y="236" width="28" height="70" rx="14" fill="url(#limb)" stroke="#FFFFFF" stroke-opacity="0.7" stroke-width="3" transform="rotate(-35 102 300)"/>
  <rect x="396" y="236" width="28" height="70" rx="14" fill="url(#limb)" stroke="#FFFFFF" stroke-opacity="0.7" stroke-width="3" transform="rotate(35 410 300)"/>"""
    elif arms == "wand":
        a = """
  <rect x="84" y="330" width="28" height="64" rx="14" fill="url(#limb)" stroke="#FFFFFF" stroke-opacity="0.7" stroke-width="3" transform="rotate(25 98 340)"/>
  <rect x="398" y="268" width="28" height="64" rx="14" fill="url(#limb)" stroke="#FFFFFF" stroke-opacity="0.7" stroke-width="3" transform="rotate(40 412 330)"/>"""
    else:
        a = """
  <rect x="84" y="330" width="28" height="64" rx="14" fill="url(#limb)" stroke="#FFFFFF" stroke-opacity="0.7" stroke-width="3" transform="rotate(25 98 340)"/>
  <rect x="400" y="330" width="28" height="64" rx="14" fill="url(#limb)" stroke="#FFFFFF" stroke-opacity="0.7" stroke-width="3" transform="rotate(-25 414 340)"/>"""
    return a + legs


def sparkle(x: float, y: float, s: float, color: str = "#FFFFFF", op: float = 0.95) -> str:
    return (
        f'\n  <path transform="translate({x} {y}) scale({s})" '
        f'd="M0 -20 C 3 -5, 5 -3, 20 0 C 5 3, 3 5, 0 20 C -3 5, -5 3, -20 0 C -5 -3, -3 -5, 0 -20 Z" '
        f'fill="{color}" fill-opacity="{op}"/>'
    )


def svg(content: str, bg: str = "") -> str:
    return (
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="512" height="512">'
        + content
        + "\n</svg>\n"
    )


# ---------- Etapa 1: Gotita bebé ----------
def stage_1() -> str:
    inner = body() + eyes() + blush() + mouth("small") + """
  <rect x="212" y="452" width="26" height="22" rx="11" fill="url(#limb)" stroke="#FFFFFF" stroke-opacity="0.7" stroke-width="3"/>
  <rect x="274" y="452" width="26" height="22" rx="11" fill="url(#limb)" stroke="#FFFFFF" stroke-opacity="0.7" stroke-width="3"/>
  <path d="M256 62 C 248 40, 268 30, 274 44" stroke="#9AD3F0" stroke-width="7" fill="none" stroke-linecap="round"/>"""
    # La bebé es más pequeña: se escala alrededor del centro inferior.
    return svg(defs("#BFE6FA", "#7CC4EA") + f'\n  <g transform="translate(256 476) scale(0.86) translate(-256 -476)">{inner}\n  </g>')


# ---------- Etapa 2: Gotita feliz ----------
def stage_2() -> str:
    c = defs("#B3E2FA", "#5DB6E6") + limbs("up") + body() + eyes() + blush() + mouth("open")
    c += sparkle(96, 150, 1.0, "#F2BD55") + sparkle(420, 130, 0.8, "#F2BD55") + sparkle(440, 230, 0.5, "#FFFFFF")
    c += sparkle(70, 250, 0.5, "#FFFFFF")
    return svg(c)


# ---------- Etapa 3: Gotita aventurera ----------
def stage_3(bare: bool = False) -> str:
    extra = """
    <linearGradient id="hat" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#E9C98F"/>
      <stop offset="1" stop-color="#C79A55"/>
    </linearGradient>"""
    c = defs("#B3E2FA", "#4FAEE0", extra) + limbs("down") + body()
    # Mochila (correas) y pañuelo
    c += """
  <path d="M150 300 Q 150 400 186 448" stroke="#8C5A2B" stroke-width="12" fill="none" stroke-linecap="round" stroke-opacity="0.9"/>
  <path d="M362 300 Q 362 400 326 448" stroke="#8C5A2B" stroke-width="12" fill="none" stroke-linecap="round" stroke-opacity="0.9"/>
  <path d="M196 398 Q 256 430 316 398 L 300 420 Q 256 446 212 420 Z" fill="#E4573D"/>
  <path d="M250 428 L 236 462 L 262 448 Z" fill="#C8432C"/>"""
    c += eyes() + blush() + mouth("grin")
    # Sombrero explorador (salacot)
    if not bare:
        c += """
  <ellipse cx="256" cy="196" rx="132" ry="24" fill="#B98A47"/>
  <path d="M168 192 Q 170 104 256 98 Q 342 104 344 192 Z" fill="url(#hat)"/>
  <path d="M170 176 Q 256 196 342 176 L 342 192 Q 256 210 170 192 Z" fill="#6B8E3D"/>
  <path d="M256 98 Q 260 84 256 74" stroke="#B98A47" stroke-width="8" stroke-linecap="round"/>
  <ellipse cx="214" cy="132" rx="18" ry="8" fill="#FFFFFF" fill-opacity="0.35" transform="rotate(-25 214 132)"/>"""
    # Hojita
    c += """
  <path d="M410 160 Q 450 120 470 150 Q 440 190 410 160 Z" fill="#59B88A"/>
  <path d="M412 160 Q 440 152 466 150" stroke="#3E8F68" stroke-width="3" fill="none"/>"""
    return svg(c)


# ---------- Etapa 4: Gotita mágica ----------
def stage_4(bare: bool = False) -> str:
    extra = """
    <linearGradient id="wizard" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#8B6CF0"/>
      <stop offset="1" stop-color="#4B3AA8"/>
    </linearGradient>
    <radialGradient id="aura" cx="50%" cy="55%" r="50%">
      <stop offset="0.6" stop-color="#B9A8FF" stop-opacity="0"/>
      <stop offset="0.85" stop-color="#B9A8FF" stop-opacity="0.35"/>
      <stop offset="1" stop-color="#B9A8FF" stop-opacity="0"/>
    </radialGradient>"""
    c = defs("#C9D8FB", "#6E8FE6", extra)
    c += '\n  <circle cx="256" cy="300" r="230" fill="url(#aura)"/>'
    c += limbs("wand") + body() + eyes() + blush() + mouth("grin")
    # Sombrero de mago
    if not bare:
        c += """
  <path d="M168 168 Q 256 186 344 168 L 352 184 Q 256 206 160 184 Z" fill="#3A2C8C"/>
  <path d="M186 172 Q 230 120 248 40 Q 262 30 280 52 Q 300 110 330 170 Q 256 186 186 172 Z" fill="url(#wizard)"/>
  <path d="M250 42 Q 300 30 316 70" stroke="url(#wizard)" stroke-width="18" fill="none" stroke-linecap="round"/>
  <path d="M196 160 Q 256 176 322 160" stroke="#F2BD55" stroke-width="8" fill="none"/>"""
    if not bare:
        c += sparkle(250, 120, 0.55, "#F2BD55") + sparkle(286, 90, 0.35, "#FFFFFF")
    # Varita
    c += """
  <path d="M432 262 L 470 160" stroke="#5A3E2B" stroke-width="10" stroke-linecap="round"/>"""
    c += sparkle(474, 148, 1.3, "#F2BD55", 1)
    c += sparkle(80, 170, 0.8, "#B9A8FF") + sparkle(110, 420, 0.6, "#F2BD55") + sparkle(440, 420, 0.7, "#B9A8FF")
    return svg(c)


# ---------- Etapa 5: Guardiana del agua ----------
def stage_5(bare: bool = False) -> str:
    extra = """
    <linearGradient id="gold" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#FFE29A"/>
      <stop offset="1" stop-color="#E0A43A"/>
    </linearGradient>
    <linearGradient id="cape" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#176A9A"/>
      <stop offset="1" stop-color="#0D4468"/>
    </linearGradient>
    <radialGradient id="halo" cx="50%" cy="55%" r="50%">
      <stop offset="0.55" stop-color="#FFE29A" stop-opacity="0"/>
      <stop offset="0.82" stop-color="#FFE29A" stop-opacity="0.45"/>
      <stop offset="1" stop-color="#FFE29A" stop-opacity="0"/>
    </radialGradient>"""
    c = defs("#A9DDF8", "#269DD4", extra)
    c += '\n  <circle cx="256" cy="300" r="236" fill="url(#halo)"/>'
    # Capa por detrás
    c += """
  <path d="M150 250 Q 70 380 96 470 Q 256 440 416 470 Q 442 380 362 250 Z" fill="url(#cape)"/>
  <path d="M96 470 Q 256 440 416 470" stroke="#F2BD55" stroke-width="6" fill="none"/>"""
    c += limbs("down") + body() + eyes() + blush() + mouth("grin")
    # Broche de la capa
    c += """
  <path d="M170 392 Q 256 420 342 392" stroke="#F2BD55" stroke-width="7" fill="none" stroke-linecap="round"/>
  <circle cx="256" cy="410" r="14" fill="url(#gold)" stroke="#B57F22" stroke-width="3"/>
  <path d="M256 400 C 260 406, 264 410, 264 414 A 8 8 0 0 1 248 414 C 248 410, 252 406, 256 400 Z" fill="#269DD4"/>"""
    # Corona
    if not bare:
        c += """
  <path d="M196 150 L 204 96 L 230 128 L 256 80 L 282 128 L 308 96 L 316 150 Q 256 162 196 150 Z"
        fill="url(#gold)" stroke="#B57F22" stroke-width="4" stroke-linejoin="round"/>
  <circle cx="256" cy="128" r="10" fill="#269DD4" stroke="#FFFFFF" stroke-width="3"/>
  <circle cx="221" cy="138" r="6" fill="#59B88A"/>
  <circle cx="291" cy="138" r="6" fill="#59B88A"/>"""
    # Escudo
    c += """
  <path d="M410 300 L 470 300 Q 472 372 440 398 Q 408 372 410 300 Z" fill="url(#gold)" stroke="#B57F22" stroke-width="4"/>
  <path d="M440 318 C 448 334, 456 344, 456 354 A 16 16 0 0 1 424 354 C 424 344, 432 334, 440 318 Z" fill="#269DD4"/>"""
    c += sparkle(86, 140, 1.0, "#F2BD55") + sparkle(432, 120, 0.8, "#F2BD55") + sparkle(60, 300, 0.5, "#FFFFFF")
    return svg(c)


STAGES = {1: stage_1, 2: stage_2, 3: stage_3, 4: stage_4, 5: stage_5}

if __name__ == "__main__":
    for n, fn in STAGES.items():
        d = OUT / f"stage_{n}"
        d.mkdir(parents=True, exist_ok=True)
        (d / f"aqua_stage_{n}.svg").write_text(fn(), encoding="utf-8")
        print("ok", d / f"aqua_stage_{n}.svg")
    # Variantes sin tocado propio, para cuando Aqua lleva un sombrero de la tienda.
    for n, fn in {3: stage_3, 4: stage_4, 5: stage_5}.items():
        (OUT / f"stage_{n}" / f"aqua_stage_{n}_bare.svg").write_text(fn(bare=True), encoding="utf-8")
        print("ok bare", n)
