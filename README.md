# tokens_alcaldia

Fuente de verdad de design tokens (colores, tipografia) para los proyectos de la Alcaldia.

## Estructura

```text
tokens_alcaldia/
├── src/
│   └── tokens.css        ← EDITAR AQUI al cambiar de gestion
├── dist/
│   └── tokens.css        ← archivo publicado en el CDN
└── README.md
```

## Comandos

```bash
make build   # compila src/ → dist/ y copia a admin + frontend
make sync    # solo copia dist/ a admin + frontend (sin recompilar)
make watch   # sincroniza automaticamente cada vez que guardas tokens.css
```

## Como cambiar colores para una nueva gestion

1. Editar `src/tokens.css` — solo la seccion `MARCA`
2. Ejecutar `make build`
3. Levantar admin y frontend — los cambios ya estan aplicados
4. Cuando publiques: hacer commit + push y el CDN se actualiza

## Proyectos que consumen este CDN

| Proyecto | Archivo modificado |
| --- | --- |
| `admin_alcaldia` | `src/styles.css` |
| `frontend_alcaldia` | `src/index.html` |

## URL del CDN (pendiente configurar)

```text
https://[usuario].github.io/tokens_alcaldia/dist/tokens.css
```
