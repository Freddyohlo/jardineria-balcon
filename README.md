# Balcón Verde — sitio estático multipágina

Sitio de guías prácticas de jardinería urbana en balcones pequeños.
HTML semántico, sin frameworks, sin proceso de build.

## Estructura

```
jardineria-balcon/
├── plantilla.html            Plantilla base reutilizable (marcadores {{...}})
├── url-map.md                Mapa de las 10 URLs + páginas de apoyo
├── DEPLOY.md                 Notas de despliegue (Netlify / Cloudflare / Vercel)
├── verificar.sh              Comprobación de enlaces, metadatos y 400+ palabras
└── public/                   ← raíz publicada (output dir)
    ├── index.html            Home
    ├── sobre.html            Sobre el proyecto
    ├── contacto.html         Contacto (formulario)
    ├── 404.html              No encontrada (noindex)
    ├── gracias.html          Confirmación de envío (noindex)
    ├── aviso-legal.html      Aviso legal (noindex)
    ├── privacidad.html       Privacidad (noindex)
    ├── robots.txt
    ├── sitemap.xml
    ├── guias/
    │   ├── index.html
    │   ├── riego-en-balcones-pequenos/index.html
    │   ├── sustratos-y-macetas/index.html
    │   ├── huerto-vertical/index.html
    │   ├── luz-en-balcones-con-sombra/index.html
    │   ├── plantas-aromaticas/index.html
    │   └── plagas-y-enfermedades/index.html
    ├── servicios/
    │   ├── index.html
    │   ├── diseno-de-balcones/index.html
    │   ├── asesoria-personalizada/index.html
    │   └── kit-inicial/index.html
    └── assets/
        ├── css/estilos.css
        ├── js/main.js
        ├── js/consent.js
        └── img/
            ├── favicon.svg
            ├── hero-*.svg        Ilustraciones del cuerpo (vectoriales)
            └── *.jpg             Versiones 1200x630 para Open Graph
```

## Imágenes

Las ilustraciones son SVG propios (sin bancos de imágenes ni licencias de
terceros), ligeros y nítidos en cualquier pantalla. Cada página de contenido
muestra una figura con `figcaption`, y los listados usan miniaturas en las
tarjetas.

Para las etiquetas Open Graph se genera además un JPG de 1200x630 por página,
porque las redes sociales no renderizan SVG. Los JPG se obtienen rasterizando
los SVG; si cambias un SVG, vuelve a generar su JPG correspondiente.

## Desarrollo local

```bash
cd public
python3 -m http.server 8080
# abrir http://localhost:8080
```

## Verificación

```bash
./verificar.sh
```

## Despliegue

Ver `DEPLOY.md`. En resumen: sube `public/` como output directory en
Cloudflare Pages, Netlify o Vercel, y apunta el dominio con los registros DNS
que indique el panel.
