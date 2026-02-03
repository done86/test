import sqlite3
from pathlib import Path
from typing import Optional

from flask import current_app, g, Flask

def _ensure_dirs() -> None:
    db_path: Path = current_app.config["DATABASE"]
    db_path.parent.mkdir(parents=True, exist_ok=True)

def get_db() -> sqlite3.Connection:
    if "db" not in g:
        _ensure_dirs()
        db_path: Path = current_app.config["DATABASE"]
        conn = sqlite3.connect(db_path)
        conn.row_factory = sqlite3.Row
        g.db = conn
    return g.db

def close_db(e: Optional[BaseException] = None) -> None:
    db = g.pop("db", None)
    if db is not None:
        db.close()

def init_schema() -> None:
    db = get_db()
    # Minimal placeholder schema (extend later)
    db.execute(
        """
        CREATE TABLE IF NOT EXISTS meta (
            key TEXT PRIMARY KEY,
            value TEXT
        )
        """
    )
    db.execute(
        """
        INSERT OR IGNORE INTO meta(key, value) VALUES ('app', 'Dart-Tournament-Manager')
        """
    )
    db.commit()

def init_db(app: Flask) -> None:
    app.teardown_appcontext(close_db)
    with app.app_context():
        init_schema()
