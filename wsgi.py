"""WSGI entrypoint for production (Render/Gunicorn).

Render Start Command:
    gunicorn --bind 0.0.0.0:$PORT wsgi:app
"""

import importlib
import os

def _candidate_packages() -> list[str]:
    # Common names (falls you renamed the folder at some point)
    candidates = [
        "dart_tournament_manager",
        "dart_tournament_manager",
        "dart_tournament_manager",
        "dart_tournament_manager",
    ]

    # Auto-detect: any top-level package folder that looks like our app
    here = os.path.dirname(__file__)
    for name in os.listdir(here):
        p = os.path.join(here, name)
        if os.path.isdir(p) and os.path.isfile(os.path.join(p, "__init__.py")) and os.path.isfile(os.path.join(p, "app.py")):
            candidates.append(name)

    # Unique, preserve order
    seen = set()
    out = []
    for c in candidates:
        if c not in seen:
            out.append(c)
            seen.add(c)
    return out

def _load_create_app():
    last_err = None
    for pkg in _candidate_packages():
        try:
            mod = importlib.import_module(f"{pkg}.app")
            return mod.create_app
        except Exception as e:
            last_err = e
    raise last_err

create_app = _load_create_app()
app = create_app()
