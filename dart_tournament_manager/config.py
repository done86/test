from dataclasses import dataclass
from pathlib import Path

@dataclass
class Config:
    # Change this in production
    SECRET_KEY: str = "dev-secret-key-change-me"

    # App version shown in UI
    APP_VERSION: str = "1.0"

    # SQLite database file location
    BASE_DIR: Path = Path(__file__).resolve().parents[1]
    DATA_DIR: Path = BASE_DIR / "data"
    DATABASE: Path = DATA_DIR / "dtm.sqlite"
