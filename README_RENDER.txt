Render Quick Setup (Free Test)

1) In Render: New + -> Web Service
2) Connect your GitHub repo
3) Build Command: pip install -r requirements.txt
4) Start Command: gunicorn --bind 0.0.0.0:$PORT wsgi:app
5) Create Web Service

If the URL shows "Application loading" for a long time:
- Open the Render service -> Logs
- Ensure the Start Command matches step 4.
