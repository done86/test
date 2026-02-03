# Dart-Tournament-Manager (Python Webapp)

## Start (Windows)
Doppelklick auf `Server_Start.bat`.

- Beim ersten Start wird `.venv` erstellt und `requirements.txt` installiert.
- Danach startet die App auf: http://127.0.0.1:5000
- Der Browser öffnet automatisch.

## Struktur
- `dart_tournament_manager/` enthält die App (Flask).
- `data/` enthält später die SQLite DB (wird beim Start angelegt).
- `logs/` enthält Start-Logs.

## Nächste Schritte (wenn du willst)
- Turnier anlegen/auflisten
- Spielerverwaltung
- Matchplan & Ergebnisse
- SQLite-Tabellen sauber modellieren

## Version anzeigen
Die Versionsanzeige unten rechts kommt aus `dart_tournament_manager/config.py` (`APP_VERSION`).
