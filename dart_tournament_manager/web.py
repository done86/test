from flask import Blueprint, render_template, current_app

bp = Blueprint("web", __name__)

@bp.get("/")
def welcome():
    return render_template("welcome.html", app_version=current_app.config.get("APP_VERSION", ""))
