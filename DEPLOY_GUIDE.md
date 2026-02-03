# Dart Tournament Manager – Deployment Optionen (Kurz)

## Wichtig: Repo muss vollständig sein
Auf GitHub müssen der Ordner `dart_tournament_manager/` und die Unterordner `templates/` und `static/` vorhanden sein.
Wenn nur Root-Dateien hochgeladen wurden, kann kein Hosting-Anbieter die App starten.

---

## Option 1: Render (wie geplant)
- Service: Web Service
- Build: `pip install -r requirements.txt`
- Start: `gunicorn --bind 0.0.0.0:$PORT wsgi:app`

---

## Option 2: Railway
- New Project → Deploy from GitHub
- Start Command: `gunicorn --bind 0.0.0.0:$PORT wsgi:app`
- Railway setzt `PORT` automatisch.

---

## Option 3: Fly.io (Docker)
1) flyctl installieren
2) Im Projektordner:
   - `fly launch` (App anlegen)
   - `fly deploy`
Die App nutzt den `Dockerfile` im Repo.

---

## Option 4: PythonAnywhere (ohne Docker)
- Web → Add a new web app → Manual config → Python 3.x
- Code hochladen (Files)
- Virtualenv erstellen + requirements installieren
- WSGI file so anpassen, dass `wsgi:app` genutzt wird (oder direkt Flask app importieren)

---

## Option 5: Eigener Server (VPS) – Docker
- Docker installieren
- `docker build -t dtm .`
- `docker run -d -p 80:8080 --name dtm dtm`
Für HTTPS empfiehlt sich ein Reverse Proxy (Caddy/Nginx) + Let’s Encrypt.
