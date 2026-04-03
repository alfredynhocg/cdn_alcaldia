# CLAUDE.md — cdn_alcaldia

## Proposito

Fuente de verdad de design tokens (colores, tipografia) para los proyectos de la Alcaldia.
Los cambios en este repositorio se propagan a `admin_alcaldia` y `frontend_alcaldia` via `make build`.

## Estructura

```
cdn_alcaldia/
├── src/
│   └── tokens.css        ← EDITAR AQUI al cambiar de gestion
├── dist/
│   └── tokens.css        ← archivo publicado en el CDN (generado)
├── Makefile
└── README.md
```

## URL del CDN

```text
https://alfredynhocg.github.io/cdn_alcaldia/dist/tokens.css
```

Se actualiza automaticamente con cada push a `main` via GitHub Actions.

## Comandos

```bash
make build     # valida colores, copia src/ → dist/ y sincroniza a admin + frontend
make sync      # solo copia dist/ a admin + frontend (sin recompilar)
make watch     # sincroniza automaticamente cada vez que se guarda tokens.css
make check     # verifica que dist/ esta sincronizado con src/
make validate  # verifica formato hex de los colores en src/
```

## Proyectos consumidores

| Proyecto | Destino |
|---|---|
| `admin_alcaldia` | `src/assets/css/tokens.css` |
| `frontend_alcaldia` | `src/assets/tokens.css` |

## Reglas importantes

- **Solo editar `src/tokens.css`**, nunca `dist/tokens.css` directamente — se sobreescribe con `make build`.
- La seccion `MARCA` es la unica que cambia entre gestiones (colores de marca).
- Las secciones `SEMANTICOS`, `NEUTRALES`, `TIPOGRAFIA` y `ALIASES` son estables y no deben modificarse salvo necesidad tecnica justificada.
- `make build` tambien actualiza el SVG de hexagonos en `admin_alcaldia` extrayendo el valor de `--color-brand-accent`.

## Como cambiar la paleta para una nueva gestion

1. Editar `src/tokens.css` — solo la seccion `MARCA` (primeras ~10 variables).
2. Ejecutar `make build`.
3. Verificar en admin y frontend que los colores se aplicaron correctamente.
4. Commit + push — el CDN se actualiza automaticamente via GitHub Pages.

## Tokens de marca actuales (gestion 2025)

```css
--color-brand-primary:       #8B1A1A   /* rojo oscuro */
--color-brand-primary-light: #B22222   /* rojo medio */
--color-brand-primary-dark:  #5C0F0F   /* rojo muy oscuro */
--color-brand-accent:        #E8A020   /* amarillo dorado */
--color-brand-accent-light:  #F5C55A   /* dorado claro */
--color-brand-accent-dark:   #B87A10   /* dorado oscuro */
--color-brand-secondary:     #7B3A1A   /* marron */
```
