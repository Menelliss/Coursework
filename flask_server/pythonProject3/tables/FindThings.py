from database.database import db


class FindThings(db.Model):
    __tablename__ = 'Find_things'
    id = db.Column(db.BigInteger, primary_key=True)
    user_id = db.Column(db.BigInteger, nullable=False)
    title = db.Column(db.Text, nullable=False)
    find_date = db.Column(db.Date, nullable=False)
    time_1 = db.Column(db.Interval, nullable=False)
    time_2 = db.Column(db.Interval, nullable=False)
    description = db.Column(db.Text, nullable=False)
    address = db.Column(db.Text, nullable=False)
    number = db.Column(db.Text, nullable=False)
    image = db.Column(db.Text, nullable=False)
    status = db.Column(db.Boolean, nullable=False)

    def __repr__(self):
        return (f'<FindThing:  user_id:{self.user_id}, title:{self.title}, '
                f'find_date:{self.find_date}, status:{self.status}>')

    def to_dict(self):
        return {
            'title': self.title,
            'find_date': self.find_date,
            'time_1': str(self.time_1),
            'time_2': str(self.time_2),
            'description': self.description,
            'address': self.address,
            'number': self.number,
        }
