from flask import Blueprint, request, jsonify
from tables.FindThings import FindThings
from database.database import db
from datetime import datetime, timedelta

find_router = Blueprint('find', __name__)


@find_router.route('/find_things', methods=['GET'])
def get_find_things():
    find_things = FindThings.query.filter_by(status=False).order_by(FindThings.id.desc()).all()
    result = [item.to_dict() for item in find_things]
    return jsonify(result), 200


@find_router.route('/find_things/search', methods=['GET'])
def search_find_things():
    word = request.args.get('word', '')
    if not word:
        return jsonify({"message": "No search term provided"}), 400

    find_things = FindThings.query.filter(FindThings.title.ilike(f'%{word}%')).all()

    result = [item.to_dict() for item in find_things]

    return jsonify(result), 200


@find_router.route('/find_things/user/<int:user_id>', methods=['GET'])
def get_user_find_things(user_id):
    find_things = FindThings.query.filter_by(user_id=user_id).order_by(FindThings.id.desc()).all()

    result = [item.to_dict() for item in find_things]

    return jsonify(result), 200


@find_router.route('/find_things_add', methods=['POST'])
def add_find_thing():
    data = request.json

    user_id = int(data.get('user_id'))
    title = data.get('title')
    find_date_str = data.get('find_date')
    time_1_str = data.get('time_1')
    time_2_str = data.get('time_2')
    description = data.get('description')
    address = data.get('address')
    number = data.get('number')
    image = data.get('image', '')
    status = data.get('status')

    try:
        find_date = datetime.strptime(find_date_str, '%Y-%m-%d').date()
    except ValueError:
        return jsonify({"message": "Invalid date format. Use YYYY-MM-DD."}), 400

    try:
        time_1_parts = list(map(int, time_1_str.split(':')))
        time_2_parts = list(map(int, time_2_str.split(':')))
        time_1 = timedelta(hours=time_1_parts[0], minutes=time_1_parts[1])
        time_2 = timedelta(hours=time_2_parts[0], minutes=time_2_parts[1])
    except Exception:
        return jsonify({"message": "Invalid time format."}), 401

    if not all([user_id, title, find_date, time_1, time_2, description, address, number]):
        return jsonify({"message": "Missing required fields"}), 400

    new_find_thing = FindThings(
        user_id=user_id,
        title=title,
        find_date=find_date,
        time_1=time_1,
        time_2=time_2,
        description=description,
        address=address,
        number=number,
        image=image,
        status=status
    )

    try:
        db.session.add(new_find_thing)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": "Failed to add find thing", "error": str(e)}), 500

    return jsonify({"message": "Find thing added successfully"}), 201