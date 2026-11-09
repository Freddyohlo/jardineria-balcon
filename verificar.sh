#!/usr/bin/env bash
# Verificación del sitio estático y de la integración de AdSense.
#   1) enlaces internos resuelven a un archivo existente
#   2) cada página tiene title, description, canonical y h1
#   3) los artículos superan las 400 palabras de texto visible
#   4) sitemap.xml y robots.txt son coherentes con los archivos
#   5) ads.txt tiene formato válido y declara a Google
#   6) páginas de contenido incluyen banner de consentimiento y unidades de anuncio

set -u
cd "$(dirname "$0")/public" || exit 1

fallos=0

echo "== 1. Enlaces internos =="
grep -rhoE 'href="(/[^"#?]*)' . --include='*.html' \
  | sed 's/href="//' | sort -u | while read -r ruta; do
    caso="${ruta%/}"
    if [ -f ".${ruta}" ] || [ -f ".${caso}/index.html" ] || [ -f ".${ruta}index.html" ]; then
      :
    else
      echo "  ROTO: $ruta"
    fi
  done

echo "== 2. Metadatos por página =="
for f in $(find . -name '*.html' | sort); do
  t=$(grep -c '<title>' "$f")
  d=$(grep -c 'name="description"' "$f")
  c=$(grep -c 'rel="canonical"' "$f")
  h=$(grep -c '<h1' "$f")
  if [ "$t" -lt 1 ] || [ "$d" -lt 1 ] || [ "$c" -lt 1 ] || [ "$h" -lt 1 ]; then
    echo "  INCOMPLETO ($f): title=$t desc=$d canonical=$c h1=$h"
    fallos=$((fallos+1))
  fi
done
[ "$fallos" -eq 0 ] && echo "  OK: todas las páginas tienen title, description, canonical y h1"

echo "== 3. Longitud de artículos (>=400 palabras) =="
for f in guias/*/index.html; do
  palabras=$(sed -E 's/<[^>]+>/ /g' "$f" | tr -s '[:space:]' '\n' | grep -cE '[[:alpha:]]')
  estado="OK"
  [ "$palabras" -lt 400 ] && estado="CORTO"
  printf "  %-45s %4d palabras  %s\n" "$f" "$palabras" "$estado"
done

echo "== 4. Coherencia sitemap / robots =="
grep -q "Sitemap:" robots.txt && echo "  OK: robots.txt declara el sitemap" || echo "  FALTA: Sitemap en robots.txt"
grep -q "balconverde.example" sitemap.xml && echo "  OK: sitemap.xml usa el dominio canónico" || echo "  FALTA: dominio en sitemap.xml"

echo "== 5. ads.txt =="
if [ -f ads.txt ]; then
  if grep -qE '^google\.com, pub-[0-9A-Za-z]+, DIRECT, f08c47fec0942fa0' ads.txt; then
    echo "  OK: línea de Google con formato válido"
  else
    echo "  REVISAR: no se encontró una línea válida de Google"
    fallos=$((fallos+1))
  fi
  grep -q 'pub-0000000000000000' ads.txt && \
    echo "  PENDIENTE: publisher ID sigue siendo el placeholder"
else
  echo "  FALTA: ads.txt"
  fallos=$((fallos+1))
fi

echo "== 6. Consentimiento y unidades de anuncio =="
for f in $(find . -name '*.html' | grep -vE '404.html|gracias.html' | sort); do
  banner=$(grep -c 'id="consent-banner"' "$f")
  script=$(grep -c 'consent.js' "$f")
  unidades=$(grep -c 'class="adsbygoogle"' "$f")
  # Artículos: 3 unidades (superior + intercalado + lateral). Resto: 2 (sin intercalado).
  if echo "$f" | grep -qE '^\./guias/[^/]+/index\.html$'; then
    minimo=3
  else
    minimo=2
  fi
  if [ "$banner" -lt 1 ] || [ "$script" -lt 1 ] || [ "$unidades" -lt "$minimo" ]; then
    echo "  INCOMPLETO ($f): banner=$banner script=$script unidades=$unidades (min $minimo)"
    fallos=$((fallos+1))
  fi
done
[ "$fallos" -eq 0 ] && echo "  OK: banner, script y unidades mínimas por tipo de página"

echo "== Fin (fallos acumulados en fases 2/5/6: $fallos) =="
