# =============================================
# Makefile — tokens_alcaldia
# =============================================
# Uso:
#   make sync      → copia tokens a admin y frontend
#   make build     → valida, copia src/ → dist/ y luego sync
#   make watch     → re-sincroniza cada vez que guardas tokens.css
#   make check     → verifica que dist/ esta sincronizado con src/
#   make validate  → verifica que los colores tienen formato hex valido

TOKENS_SRC  := src/tokens.css
TOKENS_DIST := dist/tokens.css

ADMIN_DEST    := ../admin_alcaldia/src/assets/css/tokens.css
FRONTEND_DEST := ../frontend_alcaldia/src/assets/tokens.css
ADMIN_SVG     := ../admin_alcaldia/src/assets/images/modern.svg

# --------------------------------------------------
.PHONY: sync build watch check validate help

# --------------------------------------------------
help:
	@echo ""
	@echo "  make build     → valida, actualiza dist/ y sincroniza a proyectos"
	@echo "  make sync      → copia dist/ a admin y frontend (sin recompilar)"
	@echo "  make watch     → sincroniza automaticamente al guardar"
	@echo "  make check     → verifica que dist/ esta sincronizado con src/"
	@echo "  make validate  → verifica formato hex de los colores en src/"
	@echo ""

# --------------------------------------------------
validate:
	@echo "[tokens] Validando colores en $(TOKENS_SRC)..."
	@INVALID=$$(grep -E '^\s+--color-[^:]+:' $(TOKENS_SRC) \
		| grep -v 'var(--\|"' \
		| grep -v '#[0-9A-Fa-f]\{6\}\b\|#[0-9A-Fa-f]\{3\}\b' \
		| grep '#'); \
	if [ -n "$$INVALID" ]; then \
		echo "[tokens] ERROR: colores con formato invalido:"; \
		echo "$$INVALID"; \
		exit 1; \
	fi
	@echo "[tokens] OK: todos los colores son validos."

# --------------------------------------------------
check:
	@if diff -q $(TOKENS_SRC) $(TOKENS_DIST) > /dev/null 2>&1; then \
		echo "[tokens] OK: dist/ esta sincronizado con src/"; \
	else \
		echo "[tokens] ADVERTENCIA: dist/ no esta sincronizado."; \
		echo "         Ejecuta: make build"; \
		exit 1; \
	fi

# --------------------------------------------------
sync:
	@echo "[tokens] Copiando a admin_alcaldia..."
	@cp $(TOKENS_DIST) $(ADMIN_DEST)
	@echo "[tokens] Copiando a frontend_alcaldia..."
	@cp $(TOKENS_DIST) $(FRONTEND_DEST)
	@echo "[tokens] Sync completo."

# --------------------------------------------------
build: validate
	@echo "[tokens] Compilando src/ → dist/..."
	@cp $(TOKENS_SRC) $(TOKENS_DIST)
	@$(MAKE) _patch-svg --no-print-directory
	@echo "[tokens] Build completo."
	@$(MAKE) sync

# Extrae --color-brand-accent del tokens.css y lo aplica al SVG de hexagonos
_patch-svg:
	@ACCENT=$$(grep '\-\-color-brand-accent:' $(TOKENS_SRC) | grep -o '#[0-9A-Fa-f]\{6\}' | head -1); \
	if [ -n "$$ACCENT" ]; then \
		R=$$(printf "%d" 0x$$(echo $$ACCENT | cut -c2-3)); \
		G=$$(printf "%d" 0x$$(echo $$ACCENT | cut -c4-5)); \
		B=$$(printf "%d" 0x$$(echo $$ACCENT | cut -c6-7)); \
		sed -i "s/stroke='rgba([^)]*)'/stroke='rgba($$R, $$G, $$B, 0.5)'/g" $(ADMIN_SVG); \
		echo "[tokens] SVG hexagonos -> rgba($$R, $$G, $$B, 0.5)"; \
	fi

# --------------------------------------------------
watch:
	@echo "[tokens] Watching src/tokens.css... (Ctrl+C para detener)"
	@while true; do \
		$(MAKE) build --no-print-directory; \
		inotifywait -q -e close_write $(TOKENS_SRC) 2>/dev/null \
		|| sleep 2; \
	done
