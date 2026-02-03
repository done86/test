from flask import Flask
from .config import Config
from .db import init_db
from .web import bp as web_bp

def create_app() -> Flask:
    app = Flask(__name__)
    app.config.from_object(Config())

    # DB init (creates sqlite file + basic table)
    init_db(app)

    # Routes
    app.register_blueprint(web_bp)

    return app
