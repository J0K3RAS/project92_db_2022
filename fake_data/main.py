#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat May 28 16:46:53 2022

@author: charalampos
"""

import mariadb
import sys

global cursor
# Connect to MariaDB Platform
try:
    conn = mariadb.connect(
        user="root",
        password="",
        host="localhost",
        port=3306,
        database="project92"
	)
	
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    sys.exit(1)

# Get Cursor
cursor = conn.cursor()

import stelexos
stelexos.init(cursor)
conn.commit()
import researcher
researcher.init(cursor)
conn.commit()
import fields
fields.init(cursor)
conn.commit()

cursor.execute("INSERT INTO Company (Budget) VALUES (?)", 
    (10000,))
cursor.execute("INSERT INTO Research_Center (Ministry_Budget,Private_Budget) VALUES (?, ?)", 
    (10000,100))
cursor.execute("INSERT INTO University (Budget) VALUES (?)", 
    (10000,))
cursor.execute("INSERT INTO Programma (Name,Address) VALUES (?, ?)", 
    ("TestName","TestAddress"))
conn.commit() 

import organismoi
organismoi.init(cursor)
conn.commit()
import erga
erga.init(cursor)
conn.commit()
import relations
relations.init(cursor)
conn.commit()

conn.close()