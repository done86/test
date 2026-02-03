DART-TOURNAMENT-MANAGER – Render Fix Paket

WICHTIG (häufigster Fehler):
Auf GitHub musst du beim Upload den INHALT dieses Ordners hochladen, NICHT den Ordner selbst.
Sonst landet alles in einem Unterordner und Render findet das Modul nicht.

1) ZIP entpacken
2) GitHub Repo öffnen → Add file → Upload files
3) Öffne den entpackten Ordner im Explorer
4) Markiere ALLES im Ordner (Strg+A) und ziehe es in die Upload-Seite:
   - wsgi.py
   - requirements.txt
   - dart_tournament_manager/   (dieser Ordner muss im Repo-Hauptordner liegen!)
   - data/
   - Server_Start.bat (optional)
   - usw.
5) Unten „Commit changes“ klicken

6) Render → Service → Settings
   Build Command: pip install -r requirements.txt
   Start Command: gunicorn --bind 0.0.0.0:$PORT wsgi:app

7) Render → Manual Deploy → Deploy latest commit

Wenn es noch nicht geht:
Render → Logs öffnen und die letzten 20 Zeilen hier kopieren.
