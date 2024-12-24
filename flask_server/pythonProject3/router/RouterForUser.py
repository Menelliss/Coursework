from flask import Blueprint, request, jsonify
from tables.User import User
from database.database import db
import bcrypt

user_router = Blueprint('user', __name__)


@user_router.route('/check_user_login', methods=['POST'])
def check_user_login():
    data = request.get_json()

    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({"message": "Email and password are required"}), 400

    try:
        user = db.session.query(User).filter(User.email == email).first()

        if user and bcrypt.checkpw(password.encode('utf-8'), user.password.encode('utf-8')):
            return jsonify({"message": "Login successful"}), 200
        else:
            return jsonify({"message": "Invalid email or password"}), 401
    except Exception as e:
        return jsonify({"message": str(e)}), 500


@user_router.route('/get_user_info', methods=['GET'])
def get_user_info():
    email = request.args.get('email')

    if not email:
        return jsonify({"message": "Email is required"}), 400

    try:
        user = db.session.query(User).filter(User.email == email).first()
        if user:
            return jsonify({
                "id": user.id,
                "username": user.username,
                "number": user.number,
                "avatar": user.avatar
            }), 200
        else:
            return jsonify({"message": "User  not found"}), 404
    except Exception as e:
        return jsonify({"message": str(e)}), 500


@user_router.route('/register', methods=['POST'])
def register():
    data = request.get_json()

    email = data.get('email')
    password = data.get('password')
    username = data.get('username')
    number = data.get('number')

    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

    try:
        new_user = User(email=email, password=hashed_password, username=username, number=number)
        db.session.add(new_user)
        db.session.commit()
        return jsonify({"message": "User  registered successfully"}), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": str(e)}), 500


@user_router.route('/check_email', methods=['GET'])
def check_email():
    email = request.args.get('email')

    if not email:
        return jsonify({"message": "Email is required"}), 400

    try:
        exists = db.session.query(User).filter(User.email == email).count() > 0
        return jsonify(exists), 200
    except Exception as e:
        return jsonify({"message": str(e)}), 500


@user_router.route('/recover_password', methods=['POST'])
def recover_password():
    data = request.get_json()
    email = data.get('email')
    new_password = data.get('new_password')

    user = db.session.query(User).filter(User.email == email).first()

    hashed_new_password = bcrypt.hashpw(new_password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

    try:
        user.password = hashed_new_password
        db.session.commit()
        return jsonify({"message": "Password recover successfully"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": str(e)}), 500


@user_router.route('/change_password', methods=['POST'])
def change_password():
    data = request.get_json()

    email = data.get('email')
    old_password = data.get('old_password')
    new_password = data.get('new_password')

    user = db.session.query(User).filter(User.email == email).first()

    if not user:
        return jsonify({"message": "User  not found"}), 404

    if not bcrypt.checkpw(old_password.encode('utf-8'), user.password.encode('utf-8')):
        return jsonify({"message": "Old password is incorrect"}), 400

    hashed_new_password = bcrypt.hashpw(new_password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

    try:
        user.password = hashed_new_password
        db.session.commit()
        return jsonify({"message": "Password changed successfully"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": str(e)}), 500


@user_router.route('/change_email', methods=['POST'])
def change_email():
    data = request.get_json()

    old_email = data.get('old_email')
    new_email = data.get('new_email')

    if db.session.query(User).filter(User.email == new_email).count() > 0:
        return jsonify({"message": "New email already exists"}), 400

    user = db.session.query(User).filter(User.email == old_email).first()

    if not user:
        return jsonify({"message": "User  not found"}), 404

    try:
        user.email = new_email
        db.session.commit()
        return jsonify({"message": "Email changed successfully"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": str(e)}), 500


@user_router.route('/change_avatar', methods=['POST'])
def change_avatar():
    data = request.get_json()

    email = data.get('email')
    avatar = data.get('avatar')

    if not email or avatar is None:
        return jsonify({"message": "Email and avatar are required"}), 400

    try:
        user = db.session.query(User).filter(User.email == email).first()
        if user:
            user.avatar = avatar
            db.session.commit()
            return jsonify({"message": "Avatar updated successfully"}), 200
        else:
            return jsonify({"message": "User  not found"}), 404
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": str(e)}), 500