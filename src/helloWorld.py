import os

from flask import Flask

app = Flask(__name__)


@app.route('/index')
def index():
    return "Hello,World!"


if __name__ == "__main__":
    # app.route(os.getenv("host", '127.0.0.1'))
    app.run(
        host=os.getenv("hostname", "0.0.0.0"),
        port=os.getenv("port", 8888),
        debug=True
    )
