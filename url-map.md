# Mapa de URLs — Balcón Verde

Dominio canónico: `https://balconverde.example`
Estructura: rutas "limpias" con carpeta + `index.html` (compatible con Cloudflare Pages, Netlify y Vercel sin configuración extra).

| # | URL | Tipo | Título | Plantilla | Prioridad |
|---|-----|------|--------|-----------|-----------|
| 1 | `/` | Home | Jardinería urbana en balcones pequeños | `plantilla.html` (sin bloque Article) | 1.0 |
| 2 | `/guias/riego-en-balcones-pequenos/` | Artículo | Riego en balcones pequeños: cuánta agua y cuándo | `plantilla.html` + Article | 0.9 |
| 3 | `/guias/sustratos-y-macetas/` | Artículo | Sustratos y macetas para espacios reducidos | `plantilla.html` + Article | 0.9 |
| 4 | `/guias/huerto-vertical/` | Artículo | Montar un huerto vertical que aguante el verano | `plantilla.html` + Article | 0.9 |
| 5 | `/guias/luz-en-balcones-con-sombra/` | Artículo | Qué plantar cuando el balcón recibe poca luz | `plantilla.html` + Article | 0.9 |
| 6 | `/guias/plantas-aromaticas/` | Artículo | Aromáticas para macetas: del huerto a la cocina | `plantilla.html` + Article | 0.9 |
| 7 | `/guias/plagas-y-enfermedades/` | Artículo | Plagas y enfermedades: detectarlas a tiempo | `plantilla.html` + Article | 0.9 |
| 8 | `/servicios/diseno-de-balcones/` | Servicio | Diseño de balcones | `plantilla.html` + Service | 0.8 |
| 9 | `/servicios/asesoria-personalizada/` | Servicio | Asesoría personalizada | `plantilla.html` + Service | 0.8 |
| 10 | `/servicios/kit-inicial/` | Servicio | Kit inicial de balcón | `plantilla.html` + Service | 0.8 |

## Páginas de apoyo (no indexables o secundarias)

| URL | Uso | `robots` |
|-----|-----|----------|
| `/guias/` | Índice de artículos (listado) | index, follow |
| `/servicios/` | Índice de servicios | index, follow |
| `/sobre.html` | Sobre el proyecto | index, follow |
| `/contacto.html` | Contacto | index, follow |
| `/404.html` | Página no encontrada | noindex |
| `/aviso-legal.html` | Aviso legal | noindex |
| `/privacidad.html` | Privacidad | noindex |

## Enlazado interno recomendado

- Home enlaza a los 6 artículos y a los 3 servicios.
- Cada artículo enlaza a 2-3 artículos relacionados (contextual, en el cuerpo) y al servicio que mejor encaje.
- Cada servicio enlaza al artículo que resuelve la duda previa a la compra.
- `aside` repetido en todas las páginas: últimos artículos + CTA de servicio.
