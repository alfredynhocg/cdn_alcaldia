# Changelog — tokens_alcaldia

Historial de paletas por gestion de gobierno.
Cada gestion tiene su propio tag de git para poder recuperar colores anteriores.

---

## Como etiquetar una nueva gestion

Antes de cambiar la paleta, crear un tag con la gestion actual:

```bash
git tag v2025-alianza
git push origin v2025-alianza
```

Para recuperar los tokens de una gestion anterior:

```bash
git show v2025-alianza:dist/tokens.css
# o para restaurar completamente:
git checkout v2025-alianza -- src/tokens.css dist/tokens.css
```

---

## [v2025] — Gestion: Alianza - Unidos por los Pueblos

**Fecha:** 2025  
**Tag git:** `v2025-alianza` *(pendiente crear)*

### Colores de marca

| Token | Valor | Descripcion |
| ----- | ----- | ----------- |
| `--color-brand-primary` | `#8B1A1A` | Rojo oscuro — fondo principal, botones primarios |
| `--color-brand-primary-light` | `#B22222` | Rojo medio — hover, variantes claras |
| `--color-brand-primary-dark` | `#5C0F0F` | Rojo muy oscuro — estados activos |
| `--color-brand-accent` | `#E8A020` | Amarillo dorado — sol del logo, destacados |
| `--color-brand-accent-light` | `#F5C55A` | Dorado claro — hover accent |
| `--color-brand-accent-dark` | `#B87A10` | Dorado oscuro — texto sobre accent |
| `--color-brand-secondary` | `#7B3A1A` | Marron — interior del sol, elementos secundarios |

### Tipografia

| Token | Valor |
| ----- | ----- |
| `--font-primary` | `"DM Sans", sans-serif` |
| `--font-display` | `"Tourney", sans-serif` |

---

*Para agregar una nueva gestion: editar `src/tokens.css`, ejecutar `make build`, crear el tag y hacer push.*
