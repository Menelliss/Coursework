from database.database import db


class User(db.Model):
    __tablename__ = 'User_reg'
    id = db.Column(db.BigInteger, primary_key=True)
    email = db.Column(db.Text, unique=True, nullable=False)
    username = db.Column(db.Text, nullable=False)
    password = db.Column(db.Text, nullable=False)
    number = db.Column(db.Text, unique=True, nullable=False)
    avatar = db.Column(db.Integer, nullable=False, default=1)

    def __repr__(self):
        return f'<Username: {self.username}, email: {self.email}>'