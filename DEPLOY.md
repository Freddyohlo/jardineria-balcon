# Configuración de hosting estático — Balcón Verde
# Publica la carpeta /public tal cual (sitio estático multipágina, sin build).

## Netlify
# netlify.toml
[build]
  publish = "public"

[[redirects]]
  from = "/*"
  to = "/404.html"
  status = 404

## Cloudflare Pages
# No requiere configuración: sube /public como output directory.
# Comando de deploy:
#   wrangler pages deploy public --project-name=balcon-verde

## Vercel
# vercel.json
# { "cleanUrls": true, "trailingSlash": true, "outputDirectory": "public" }
