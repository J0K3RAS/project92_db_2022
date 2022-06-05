# -*- coding: utf-8 -*-
"""
Created on Fri May 13 19:06:23 2022

@author: chara
"""
from numpy import random
from faker import Faker
fake = Faker('el_GR')
global cursor


def init(cursor):
    for _ in range(100):
        gender = random.choice(["Male","Female"],p=[0.5,0.5])
        if gender == "Male":
            name = fake.name_male()
        else: 
            name = fake.name_female()
        name = name.split(" ")
        fname = name[0]
        lname = name[1]
        bdate = str(fake.date_between(start_date='-60y', end_date='-18y'))
        cursor.execute("INSERT INTO Stelexos (FirstName,LastName,Gender,DoBirth) VALUES (?, ?, ?, ?)", 
            (fname,lname,gender,bdate))
        

# conn.commit() 
#conn.close()
#cursor.execute(''' INSERT INTO researcher VALUES(v1,v2...) ''')
#mysql.connection.commit()
#cursor.close()
