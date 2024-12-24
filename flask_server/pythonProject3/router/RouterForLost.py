from flask import Blueprint, request, jsonify
from tables.LostThings import LostThings
from database.database import db
from datetime import datetime, timedelta

lost_router = Blueprint('lost', __name__)

@lost_router.route('/lost_things', methods=['GET'])
def get_lost_things():
    lost_things = LostThings.query.filter_by(status=False).order_by(LostThings.id.desc()).all()
    result = [item.to_dict() for item in lost_things]
    return jsonify(result), 200


@lost_router.route('/lost_things/search', methods=['GET'])
def search_lost_things():
    word = request.args.get('word', '')
    if not word:
        return jsonify({"message": "No search term provided"}), 400

    lost_things = LostThings.query.filter(LostThings.title.ilike(f'%{word}%')).all()

    result = [item.to_dict() for item in lost_things]

    return jsonify(result), 200


@lost_router.route('/lost_things/user/<int:user_id>', methods=['GET'])
def get_user_lost_things(user_id):
    lost_things = LostThings.query.filter_by(user_id=user_id).order_by(LostThings.id.desc()).all()

    result = [item.to_dict() for item in lost_things]

    return jsonify(result), 200


@lost_router.route('/lost_things_add', methods=['POST'])
def add_lost_thing():
    data = request.json

    user_id = int(data.get('user_id', 0))
    title = data.get('title')
    lost_date_str = data.get('lost_date')
    time_1_str = data.get('time_1')
    time_2_str = data.get('time_2')
    description = data.get('description')
    address = data.get('address')
    number = data.get('number')
    image = data.get('image', '')
    status = data.get('status')

    try:
        lost_date = datetime.strptime(lost_date_str, '%Y-%m-%d').date()
    except ValueError:
        return jsonify({"message": "Invalid date format. Use YYYY-MM-DD."}), 400

    try:
        time_1_parts = list(map(int, time_1_str.split(':')))
        time_2_parts = list(map(int, time_2_str.split(':')))
        time_1 = timedelta(hours=time_1_parts[0], minutes=time_1_parts[1])
        time_2 = timedelta(hours=time_2_parts[0], minutes=time_2_parts[1])
    except Exception:
        return jsonify({"message": "Invalid time format."}), 401

    if not all([user_id, title, lost_date, time_1, time_2, description, address, number]):
        return jsonify({"message": "Missing required fields"}), 400

    new_lost_thing = LostThings(
        user_id=user_id,
        title=title,
        lost_date=lost_date,
        time_1=time_1,
        time_2=time_2,
        description=description,
        address=address,
        number=number,
        image=image,
        status=status
    )

    try:
        db.session.add(new_lost_thing)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": "Failed to add lost thing", "error": str(e)}), 500

    return jsonify({"message": "Lost thing added successfully"}), 201