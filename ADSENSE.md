# Monetización con Google AdSense — Balcón Verde

Guía operativa para completar el alta una vez el sitio está publicado en el dominio final.

## 0. Antes de solicitar (requisitos de contenido)

- Contenido original y sustancial: 6 artículos de 400-850 palabras + home + servicios. Cumple.
- Páginas legales: `aviso-legal.html`, `privacidad.html` (con sección de cookies) y contacto. Cumple.
- Navegación funcional y sin enlaces rotos. Cumple (`./verificar.sh`).
- Aviso de consentimiento de cookies operativo (`assets/js/consent.js`). Cumple.
- El sitio debe estar **en línea en el dominio final** antes de solicitar.

## 1. Solicitar el alta

1. Entra en `https://www.google.com/adsense/start/` con tu cuenta de Google.
2. Introduce la URL del dominio (no la del subdominio de hosting).
3. Indica país y moneda. Solo se pueden cambiar después con soporte.
4. Acepta las condiciones y envía la solicitud.
5. Copia tu **publisher ID** (formato `pub-XXXXXXXXXXXXXXXX`, 16 dígitos).

## 2. Reemplazar los placeholders

Busca y sustituye `0000000000000000` en estos sitios:

```bash
cd public
# 1) ads.txt
grep -rl 'pub-0000000000000000' . --include='ads.txt'
# 2) client ID en consent.js
grep -rl 'ca-pub-0000000000000000' assets/js/consent.js
# 3) data-ad-client en el HTML
grep -rl 'ca-pub-0000000000000000' . --include='*.html'

# Sustitución en bloque (usa tu ID real):
#   ads.txt  ->  google.com, pub-TUID, DIRECT, f08c47fec0942fa0
#   resto    ->  ca-pub-TUID
```

## 3. Verificar ads.txt

```bash
# Estado y Content-Type
curl -sI https://tu-dominio.example/ads.txt | grep -iE "HTTP/|content-type"

# Contenido exacto
curl -s https://tu-dominio.example/ads.txt

# Línea válida: google.com, pub-<16 dígitos>, DIRECT, f08c47fec0942fa0
curl -s https://tu-dominio.example/ads.txt \
  | grep -E "^google\.com, pub-[0-9]{16}, DIRECT, f08c47fec0942fa0$"
```

Después, en el panel: `AdSense → Sitios → ads.txt → Comprobar`. Debe pasar a "Autorizado".

## 4. Unidades de anuncio

El sitio ya incluye tres contenedores por página de contenido:

| Clase CSS | Ubicación | Slot placeholder |
|-----------|-----------|------------------|
| `anuncio--superior` | Bajo el `<h1>` | `1111111111` |
| `anuncio--intercalado` | Antes del 2.º `<h2>` (solo artículos) | `2222222222` |
| `anuncio--lateral` | Dentro de `<aside>` | `3333333333` |

Sustituye cada `data-ad-slot` por los slots reales que cree AdSense (`Anuncios → Por unidad de anuncio`).

## 5. Consentimiento

`assets/js/consent.js` bloquea la carga de AdSense hasta que el usuario acepta.
Para cumplir el RGPD en la UE, además configura un **CMP certificado** por Google:

1. En AdSense: `Privacidad y mensajes → Mensajes para el RGPD`.
2. Publica un mensaje de consentimiento (o integra un CMP de terceros).
3. Google exige un CMP certificado desde 2024 para servir anuncios a usuarios del EEE/Reino Unido.

## 6. Qué NO hacer

- No comprar tráfico ni usar bots para inflar visitas. Google detecta tráfico inválido, desactiva la cuenta y retiene los ingresos.
- No pedir clics a los usuarios ni colocarlos junto a elementos clicables.
- No superar las 3 unidades por página en un sitio de este tamaño.
