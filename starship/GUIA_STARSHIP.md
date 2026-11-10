# Guía Completa de Starship — Uso Diario y Personalización

> **Referencia:** Configuración basada en [Gentleman.Dots](https://github.com/Gentleman-Programming/Gentleman.Dots) y mejorada para proyectos en **Python (`pyenv` / `.venv`), Node.js (`fnm`), Git y sistemas en Español/Inglés**.

---

## 1. ¿Cómo leer la información que muestra tu Prompt?

Tu prompt está dividido en **dos renglones**:

```text
󰲋 mi-proyecto ->  main (!2 ?1 ⇡1 )                   3.12.7 (.venv)   v22.11.0  took  2s   21:45
❯ _
```

### Lado Izquierdo (Ubicación y Git)
- **Carpeta actual (`$directory`):** Muestra dónde estás y reemplaza nombres comunes (tanto en español como en inglés: `Proyectos`/`Projects`, `Descargas`/`Downloads`, `Documentos`/`Documents`, etc.) por su icono. Si la carpeta no tiene permisos de escritura, muestra un candado `󰌾`.
- **Rama de Git (`->  rama`):** Aparece automáticamente cuando entras a un repositorio Git.
- **Estado de Git (`$git_status`):** Te avisa qué pasa en tu repositorio sin que tengas que escribir `git status`:

| Símbolo | Significado en Git |
| :--- | :--- |
| **`!1`** | Tienes **1 archivo modificado** sin agregar a stage (`git add`). |
| **`?1`** | Tienes **1 archivo nuevo** sin seguimiento (*untracked*). |
| **`+1`** | Tienes **1 archivo en stage** listo para hacer `git commit`. |
| **`✘1`** | Tienes **1 archivo eliminado**. |
| **`⇡1`** | Tienes **1 commit local** pendiente de subir (`git push`). |
| **`⇣1`** | Hay **1 commit en el servidor** pendiente de bajar (`git pull`). |
| **`$1`** | Tienes **1 cambio guardado en el stash** (`git stash`). |

### Lado Derecho (Lenguajes, Tiempo y Reloj)
- **Python (` 3.12.7 (.venv)`):** Aparece cuando la carpeta tiene archivos `.py`, `pyproject.toml` o `requirements.txt`, o cuando tienes un entorno virtual activo. Muestra tanto la versión de `pyenv` como el nombre de tu entorno virtual `(venv)`.
- **Node.js (` v22.11.0`):** Aparece cuando hay un `package.json` o `node_modules`.
- **Otros lenguajes (`Rust `, `Go `, `Bun `, `PHP `, `Java `, `C `, `Zig `, `Docker `):** Solo aparecen si entras a un proyecto de ese lenguaje, manteniendo tu terminal limpia el resto del tiempo.
- **Duración (`took  2s`):** Solo aparece si el último comando tardó más de medio segundo (`500ms`).
- **Reloj (` 21:45`):** Hora actual en formato 24h.

---

## 2. Cómo Cambiar el Símbolo del Cursor (y cómo buscar Iconos en Internet)

Quitamos el icono del bigote (`󱗞`) y dejamos activo por defecto el símbolo de flecha limpia **`❯`** (verde si el comando anterior salió bien, rojo si dio error).

### Opción A: Usar uno de los iconos ya listos en `starship.toml`
Abre [`starship/starship.toml`](./starship.toml) en la **Sección 3 (`[character]`)**. Ahí ya tienes 6 opciones listas; solo comenta la actual con `#` y descomenta la que quieras:

```toml
# Opción 1: Flecha moderna limpia
# success_symbol = "[❯](bold fg:green)"
# error_symbol   = "[❯](bold fg:red)"

# Opción 2: Logo de Fedora Linux
success_symbol = "[ ](bold fg:green)"
error_symbol   = "[ ](bold fg:red)"
```
Apenas guardes el archivo y presiones **`Enter`** en la terminal, el icono cambia al instante.

### Opción B: Buscar cualquier icono en Internet (Más de 10,000 disponibles)
Como tienes instaladas las fuentes **Nerd Fonts** (`JetBrainsMono Nerd Font` / `FiraCode Nerd Font`), puedes usar cualquier icono del catálogo oficial siguiendo estos 3 pasos:

1. Entra a: **[https://www.nerdfonts.com/cheat-sheet](https://www.nerdfonts.com/cheat-sheet)**
2. Escribe en el buscador una palabra en inglés de lo que te guste, por ejemplo:
   - `fedora`, `linux`, `ubuntu`, `arch`, `debian` (logos de distros)
   - `terminal`, `code`, `console`, `vim` (iconos de programación)
   - `rocket`, `bolt`, `fire`, `star`, `dragon`, `ghost`, `coffee`, `sword`
3. Pasa el mouse sobre el icono que te guste, haz clic en el botón naranja **"Copy Icon"** y pégalo dentro de los corchetes en [`starship/starship.toml`](./starship.toml) dejando un espacio después del icono:
   ```toml
   success_symbol = "[AQUI_PEGAS_TU_ICONO ](bold fg:green)"
   error_symbol   = "[AQUI_PEGAS_TU_ICONO ](bold fg:red)"
   ```

---

## 3. Cómo Cambiar el Tema / Paleta de Colores de Starship

En la **Sección 2** de [`starship/starship.toml`](./starship.toml) encontrarás la línea:

```toml
palette = "gentleman"
```

Ya dejamos **5 paletas completas** preconfiguradas al final del archivo. Para cambiar todos los colores del prompt, solo cambia esa palabra por cualquiera de estas 5 y presiona `Enter`:

1. `palette = "gentleman"` *(Azul noche y tonos pastel — activo por defecto)*
2. `palette = "catppuccin_mocha"` *(Tonos suaves lavanda/durazno de Catppuccin)*
3. `palette = "tokyonight"` *(Tonos neón azul/morado de TokyoNight)*
4. `palette = "kanagawa"` *(Tonos cálidos japoneses de Kanagawa)*
5. `palette = "gruvbox_dark"` *(Tonos tierra retro de Gruvbox)*

---

## 4. Cómo Agregar o Quitar Elementos del Prompt

En la **Sección 1 (`format`)** de [`starship/starship.toml`](./starship.toml) ves la lista de piezas que arman el prompt:

```toml
format = """\
($directory)\
$os\
$git_branch\
$git_status\
$fill\
$python\
$nodejs\
...
$cmd_duration\
$time\
\n$character\
"""
```

- **Si no quieres ver el reloj a la derecha:** Borra la línea `$time\` (o cambia `disabled = false` a `disabled = true` en `[time]`).
- **Si quieres agregar otro módulo en el futuro** (por ejemplo, nivel de batería `$battery` o uso de memoria `$memory_usage`): Solo agrégalo en esa lista.

---

## 5. Comandos Útiles de Starship en Terminal

| Comando | Para qué sirve |
| :--- | :--- |
| `starship explain` | **El comando más útil:** Te explica pieza por pieza qué está mostrando el prompt en la carpeta actual y cuántos milisegundos tardó cada módulo. |
| `starship timings` | Muestra cuánto tiempo tarda cada parte del prompt (útil si algún día sientes lento el prompt en un repo gigante). |
| `starship preset --list` | Muestra plantillas oficiales integradas en Starship. |
