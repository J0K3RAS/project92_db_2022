#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed May 25 14:58:17 2022

@author: charalampos
"""

import pandas as pd
from faker import Faker
import numpy as np
fake = Faker('el_GR')

dat = pd.read_csv("organismoi.csv")
def init(cursor):
    alphabet = [s for s in "ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩ"]
    numb = [s for s in "0123456789"]
    
    organizations = np.random.choice(dat['Aberystwyth University'], size=30 ,replace="False")
    org_id=0
    for org in organizations:
        name = org
        abbr = ''.join(np.random.choice(alphabet,5))
        city = fake.city()
        number = fake.building_number()
        #postcode  = fake.postcode()
        postcode  = ''.join(np.random.choice(numb,size=5))
        street_name = fake.street_name()
        foreas = np.random.choice(["UnivID","CompID","ResID"])
        query= "INSERT INTO Organization (Name,Abbreviation,Street,StreetNo,City,PostalCode,{}) VALUES (?, ?, ?, ?, ?, ?, ?)".format(foreas)
        
        cursor.execute(query,  (name,abbr,street_name,number,city,postcode,1))
        
        ################
        ## Telephones ##
        ################
        org_id += 1
        #).replace(" ","")[-10:]
        prob = 1
        while np.random.choice([True,False],p=[prob,1-prob]):
            tel = ( fake.phone_number() ).replace(" ","")[-10:]
            query= "INSERT INTO Telephone (Number,Organization) VALUES (?, ?)"
            cursor.execute(query, (tel,org_id))
            prob += -0.25
            
#conn.commit()

