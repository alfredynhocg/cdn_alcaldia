# tokens_alcaldia — CDN de Design Tokens

Fuente de verdad de design tokens (colores, tipografia) para todos los proyectos de la Alcaldia.
Cualquier cambio en este repositorio se propaga automaticamente a `admin_alcaldia` y `frontend_alcaldia`.

---

## Tabla de contenido

1. [Como funciona](#como-funciona)
2. [URL del CDN](#url-del-cdn)
3. [Integracion en proyectos existentes](#integracion-en-proyectos-existentes)
   - [admin_alcaldia (Angular + TailwindCSS)](#admin_alcaldia-angular--tailwindcss)
   - [frontend_alcaldia (Angular)](#frontend_alcaldia-angular)
4. [Integrar en un proyecto nuevo](#integrar-en-un-proyecto-nuevo)
5. [Referencia completa de tokens](#referencia-completa-de-tokens)
6. [Como usar los tokens en tus estilos](#como-usar-los-tokens-en-tus-estilos)
7. [Como cambiar la paleta para una nueva gestion](#como-cambiar-la-paleta-para-una-nueva-gestion)
8. [Comandos](#comandos)
9. [Estructura del repositorio](#estructura-del-repositorio)

---

## Como funciona

Este repositorio tiene dos roles:

1. **Fuente local:** el archivo `dist/tokens.css` se copia directamente a cada proyecto con `make build`. Es el metodo que se usa durante el desarrollo diario.
2. **CDN publico:** cuando se hace `git push`, GitHub Pages publica `dist/tokens.css` en una URL publica. Los proyectos pueden importar ese archivo sin necesidad de tener este repositorio clonado.

```text
src/tokens.css   ← editas aqui
       │
    make build
       │
dist/tokens.css  ← se copia a admin y frontend (local)
       │
   git push
       │
GitHub Pages → URL publica del CDN
```

---

## URL del CDN

```text
https://alfredynhocg.github.io/cdn_alcaldia/dist/tokens.css
```

Esta URL esta activa y siempre apunta a la version mas reciente del archivo publicado en `main`.

### Nota sobre cache del navegador

GitHub Pages puede cachear el archivo varios minutos. Si hiciste push y los cambios no se ven, fuerza la recarga:

- **Navegador:** `Ctrl + Shift + R` (Windows/Linux) o `Cmd + Shift + R` (Mac)
- **En codigo:** agrega un parametro de version a la URL para forzar descarga nueva:

```html
<link rel="stylesheet" href="https://alfredynhocg.github.io/cdn_alcaldia/dist/tokens.css?v=2025-04-03">
```

```css
@import url('https://alfredynhocg.github.io/cdn_alcaldia/dist/tokens.css?v=2025-04-03');
```

Cambia el valor de `?v=` cada vez que publiques una nueva paleta.

---

## Integracion en proyectos existentes

### admin_alcaldia (Angular + TailwindCSS)

El admin usa Angular 20 con TailwindCSS. Los tokens se importan como primer archivo CSS antes de Tailwind, para que las variables CSS queden disponibles en todo el proyecto.

**Archivo:** `src/styles.css`

```css
/* Google Fonts (deben estar antes que los tokens) */
@import url('https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,100..900;1,100..900&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Tourney:ital,wght@0,100..900;1,100..900&display=swap');

/* Design Tokens — fuente de verdad de colores */
/* Para actualizar: ejecutar `make build` en tokens_alcaldia/ */
@import "./assets/css/tokens.css";

/* Tailwind CSS */
@import "tailwindcss";
```

**Ruta del archivo en disco:** `src/assets/css/tokens.css`

El archivo llega ahi automaticamente cuando ejecutas `make build` o `make sync` en este repositorio.

**Alternativa via CDN** (sin clonar este repo):

Reemplaza el `@import` local por la URL del CDN en `styles.css`:

```css
@import url('https://alfredynhocg.github.io/cdn_alcaldia/dist/tokens.css');
```

> Nota: si usas la URL del CDN, los tokens se actualizan solos con cada push. Si usas el archivo local, debes ejecutar `make sync` cada vez que haya cambios en este repositorio.

---

### frontend_alcaldia (Angular)

El frontend es una aplicacion Angular. Los tokens se cargan como hoja de estilos en el `<head>` del HTML raiz, antes de cualquier otro estilo.

**Archivo:** `src/index.html`

```html
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <title>Alcaldia</title>
  <base href="/">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Design Tokens CDN — fuente de verdad de colores -->
  <!-- Opcion A: archivo local (requiere make sync) -->
  <link rel="stylesheet" href="assets/tokens.css">

  <!-- Opcion B: CDN publico (actualiza automatico con cada push) -->
  <!-- <link rel="stylesheet" href="https://alfredynhocg.github.io/cdn_alcaldia/dist/tokens.css"> -->
</head>
<body>
  <app-root></app-root>
</body>
</html>
```

**Ruta del archivo en disco:** `src/assets/tokens.css`

El archivo llega ahi automaticamente cuando ejecutas `make build` o `make sync` en este repositorio.

---

## Integrar en un proyecto nuevo

Si necesitas que otro proyecto consuma estos tokens, sigue estos pasos:

### Paso 1: Actualiza el Makefile de este repositorio

Abre el `Makefile` de este repositorio y agrega la ruta destino del nuevo proyecto:

```makefile
NUEVO_DEST := ../nuevo_proyecto/ruta/a/tokens.css
```

Luego agrega la copia en el target `sync`:

```makefile
sync:
    @cp $(TOKENS_DIST) $(ADMIN_DEST)
    @cp $(TOKENS_DIST) $(FRONTEND_DEST)
    @cp $(TOKENS_DIST) $(NUEVO_DEST)   # ← nueva linea
```

Ejecuta `make sync` para verificar que la copia funciona correctamente.

### Paso 2: Importa los tokens en el proyecto

Elige el metodo segun el tipo de proyecto:

**Opcion A — Archivo local** (recomendado para desarrollo):

```css
/* En tu archivo CSS principal */
@import "./ruta/al/tokens.css";
```

```html
<!-- O en el HTML raiz -->
<link rel="stylesheet" href="ruta/al/tokens.css">
```

**Opcion B — CDN publico** (recomendado para produccion):

```html
<link rel="stylesheet" href="https://alfredynhocg.github.io/cdn_alcaldia/dist/tokens.css">
```

```css
@import url('https://alfredynhocg.github.io/cdn_alcaldia/dist/tokens.css');
```

### Paso 3: Verifica que los tokens estan disponibles

Abre las DevTools del navegador → Inspector → selecciona cualquier elemento → en la pestana "Computed" busca `--color-brand-primary`. Si aparece, los tokens estan activos.

---

## Referencia completa de tokens

Todos los tokens se definen como variables CSS en `:root`, disponibles en cualquier elemento del DOM.

### Colores de marca

Estos son los unicos que cambian entre gestiones.

| Token | Valor actual | Uso |
| ----- | ------------ | --- |
| `--color-brand-primary` | `#8B1A1A` | Fondo principal, botones primarios |
| `--color-brand-primary-light` | `#B22222` | Hover de botones, variantes claras |
| `--color-brand-primary-dark` | `#5C0F0F` | Estados activos, pressed |
| `--color-brand-accent` | `#E8A020` | Sol del logo, elementos destacados |
| `--color-brand-accent-light` | `#F5C55A` | Hover del color accent |
| `--color-brand-accent-dark` | `#B87A10` | Texto sobre fondo accent |
| `--color-brand-secondary` | `#7B3A1A` | Interior del sol, elementos secundarios |

### Colores semanticos

Estables entre gestiones. Representan estados del sistema.

| Token | Valor | Uso |
| ----- | ----- | --- |
| `--color-success` | `#22C55E` | Exito, confirmacion |
| `--color-success-light` | `#DCFCE7` | Fondo de alertas de exito |
| `--color-warning` | `#F59E0B` | Advertencia |
| `--color-warning-light` | `#FEF3C7` | Fondo de alertas de advertencia |
| `--color-danger` | `#DC2626` | Error, peligro |
| `--color-danger-light` | `#FEE2E2` | Fondo de alertas de error |
| `--color-info` | `#0EA5E9` | Informacion |
| `--color-info-light` | `#E0F2FE` | Fondo de alertas informativas |

### Colores neutrales

Estables entre gestiones. Para texto, fondos y bordes.

| Token | Valor | Uso |
| ----- | ----- | --- |
| `--color-dark` | `#1A1A1A` | Texto principal |
| `--color-muted` | `#6B7280` | Texto secundario, placeholders |
| `--color-light` | `#F5F5F5` | Fondo claro de pagina |
| `--color-white` | `#FFFFFF` | Blanco puro |
| `--color-black` | `#000000` | Negro puro |
| `--color-border` | `#E5E7EB` | Bordes de tarjetas, inputs |
| `--color-border-dark` | `#D1D5DB` | Bordes con mas contraste |

### Tipografia

| Token | Valor | Uso |
| ----- | ----- | --- |
| `--font-primary` | `"DM Sans", sans-serif` | Texto general, parrafos, UI |
| `--font-display` | `"Tourney", sans-serif` | Titulos principales, headings |

> Las fuentes se cargan desde Google Fonts. Asegurate de importarlas antes de usar estos tokens:
> ```html
> <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&family=Tourney:wght@700&display=swap" rel="stylesheet">
> ```

### Aliases de compatibilidad

Estos tokens son atajos para nombres ya usados en `admin_alcaldia` y `frontend_alcaldia`. No los uses en proyectos nuevos; prefiere los tokens de marca directamente.

| Alias | Apunta a |
| ----- | -------- |
| `--color-primary` | `--color-brand-primary` |
| `--color-secondary` | `--color-brand-secondary` |
| `--color-primary-light` | `--color-brand-primary-light` |
| `--color-accent` | `--color-brand-accent` |

---

## Como usar los tokens en tus estilos

Una vez importado el archivo, los tokens estan disponibles como variables CSS nativas en cualquier selector.

### CSS puro

```css
.boton-primario {
  background-color: var(--color-brand-primary);
  color: var(--color-white);
  font-family: var(--font-primary);
}

.boton-primario:hover {
  background-color: var(--color-brand-primary-light);
}

.boton-primario:active {
  background-color: var(--color-brand-primary-dark);
}

.alerta-exito {
  background-color: var(--color-success-light);
  border-color: var(--color-success);
  color: var(--color-dark);
}

.texto-secundario {
  color: var(--color-muted);
  font-family: var(--font-primary);
}

.titulo-principal {
  font-family: var(--font-display);
  color: var(--color-brand-primary);
}
```

### SCSS

Las variables CSS nativas funcionan igual en SCSS. No necesitas ninguna configuracion adicional.

```scss
.card {
  border: 1px solid var(--color-border);
  background: var(--color-white);

  &__header {
    background: var(--color-brand-primary);
    color: var(--color-white);
    font-family: var(--font-display);
  }

  &__badge--success {
    background: var(--color-success-light);
    color: var(--color-success);
  }
}
```

### TailwindCSS (admin_alcaldia)

En el admin, Tailwind esta configurado para reconocer las variables CSS como colores. Puedes usarlas con clases utilitarias:

```html
<!-- Fondo con color de marca -->
<div class="bg-[var(--color-brand-primary)] text-white">
  Contenido
</div>

<!-- Borde con color de tokens -->
<input class="border border-[var(--color-border)] focus:border-[var(--color-brand-primary)]">

<!-- Texto con colores semanticos -->
<span class="text-[var(--color-success)]">Operacion exitosa</span>
<span class="text-[var(--color-danger)]">Error al procesar</span>
```

### Angular (interpolacion en estilos de componente)

```typescript
// En el componente
@Component({
  styles: [`
    :host {
      --btn-color: var(--color-brand-primary);
    }
    .btn {
      background: var(--btn-color);
    }
  `]
})
```

```scss
// En un archivo .scss de componente
.header {
  background-color: var(--color-brand-primary);
  font-family: var(--font-display);
}
```

---

## Como cambiar la paleta para una nueva gestion

Cuando hay cambio de gobierno, solo se edita la seccion `MARCA` del archivo fuente. El resto del sistema (semanticos, neutrales, tipografia, aliases) no cambia.

### Paso 1: Editar `src/tokens.css`

Abre `src/tokens.css` y modifica los valores de la seccion `MARCA`:

```css
/* ANTES (gestion 2025 - Alianza) */
--color-brand-primary:        #8B1A1A;   /* rojo oscuro */
--color-brand-accent:         #E8A020;   /* amarillo dorado */

/* DESPUES (gestion 2026 - nueva administracion) */
--color-brand-primary:        #1A4A8B;   /* azul marino */
--color-brand-accent:         #20E8A0;   /* verde esmeralda */
```

Tambien actualiza el comentario de cabecera con el nombre de la nueva gestion:

```css
/**
 * Design Tokens — Alcaldia
 * Gestion: [Nombre de la nueva gestion]
 * Version: [Año]
 */
```

### Paso 2: Compilar y sincronizar

```bash
make build
```

Este comando:
- Copia `src/tokens.css` → `dist/tokens.css`
- Actualiza el color del SVG de hexagonos en `admin_alcaldia` con el nuevo `--color-brand-accent`
- Copia `dist/tokens.css` a `admin_alcaldia` y `frontend_alcaldia`

### Paso 3: Verificar visualmente

Levanta `admin_alcaldia` y `frontend_alcaldia` y verifica que los colores se aplicaron correctamente en toda la interfaz.

### Paso 4: Publicar

```bash
git add dist/tokens.css src/tokens.css
git commit -m "tokens: cambio de paleta — gestion [nombre]"
git push
```

GitHub Pages publica el archivo automaticamente. Todos los proyectos que usen la URL del CDN reciben el cambio sin ninguna accion adicional.

---

## Comandos

```bash
make build   # Compila src/ → dist/ y sincroniza a admin + frontend
make sync    # Solo copia dist/ a admin + frontend (sin recompilar)
make watch   # Sincroniza automaticamente cada vez que guardas tokens.css
make help    # Muestra los comandos disponibles
```

**Cuando usar cada uno:**

| Comando | Cuando usarlo |
| ------- | ------------- |
| `make build` | Siempre que edites `src/tokens.css` |
| `make sync` | Cuando dist/ ya esta actualizado y solo necesitas copiar (ej: tras un `git pull`) |
| `make watch` | Durante sesiones de edicion activa — detecta cada guardado y sincroniza automaticamente |

> `make watch` requiere `inotifywait` (paquete `inotify-tools` en Linux).
> Instalacion: `sudo apt install inotify-tools`

---

## Estructura del repositorio

```
tokens_alcaldia/
├── src/
│   └── tokens.css        ← EDITAR AQUI al cambiar de gestion
├── dist/
│   └── tokens.css        ← archivo publicado en el CDN (no editar directamente)
├── Makefile              ← comandos de compilacion y sincronizacion
├── CLAUDE.md             ← guia para el asistente AI
└── README.md             ← esta documentacion
```

**Regla importante:** nunca edites `dist/tokens.css` directamente. Ese archivo se genera automaticamente desde `src/tokens.css` con `make build` y cualquier edicion manual se perdera en el siguiente build.

---

*Proyecto Alcaldia — Sistema de design tokens para la identidad visual de la gestion municipal.*
