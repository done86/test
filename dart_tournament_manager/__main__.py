from .app import create_app

def main() -> None:
    app = create_app()
    # debug/reloader aus, damit Windows-BAT stabil bleibt
    app.run(host="127.0.0.1", port=5000, debug=False, use_reloader=False)

if __name__ == "__main__":
    main()
