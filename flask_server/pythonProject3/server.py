from flask import Flask
from flask_cors import CORS
from database.database import db
from router.RouterForFind import find_router
from router.RouterForLost import lost_router
from router.RouterForUser import user_router

app = Flask(__name__)

CORS(app)

app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://cloud_user:FIO51qVLkqp%@quashigamjod.beget.app:5432/PoteryashkiDB?sslmode=disable'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

app.register_blueprint(find_router)
app.register_blueprint(lost_router)
app.register_blueprint(user_router)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)