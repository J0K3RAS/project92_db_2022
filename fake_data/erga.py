#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed May 25 01:09:47 2022

@author: charalampos
"""

import pandas as pd
from faker import Faker
import numpy as np
fake = Faker('el_GR')

def init(cursor):
    dat = pd.read_csv("erga.csv")
    
    #cursor = conn.cursor()
    cursor.execute("SELECT ID FROM Researcher" )
    res_ids = [d[0] for d in cursor]
    cursor.execute("SELECT ID FROM Stelexos" )
    stel_ids = [d[0] for d in cursor]
    cursor.execute("SELECT ID FROM Organization" )
    org_ids = [d[0] for d in cursor]
    cursor.execute("SELECT ID FROM Programma" )
    prog_ids = [d[0] for d in cursor]
    
    erga = np.random.choice(dat["Amigos"],size=160,replace=False)
    for ergo in erga:
        title = ergo
        flag = True
        while flag:
            d1 = fake.date_between(start_date='-2y', end_date='+2y')
            d2 = fake.date_between(start_date='-3y', end_date='+2y')
            diff = abs((d2-d1).days)
            if diff>=370 and diff<=1410:
                sdate = str(min(d1,d2))
                edate = str(max(d1,d2))
                flag = False
        brief = fake.catch_phrase()
        master_stelexos = int(np.random.choice(stel_ids))
        budget = int(np.random.randint(10000,10000000))
        master_organization = int(np.random.choice(org_ids))
        #copy = res_ids
        #copy.remove(master_researcher)
        upeuthinos = int(np.random.choice(res_ids))
        programma = int(np.random.choice(prog_ids))
        
        cursor.execute("INSERT INTO Ergo (Title,Brief,StartDate,EndDate,Budget,Programma,MasterStelexos,MasterOrganization,Responsible) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", 
            (title,brief,sdate,edate,budget,programma,master_stelexos,master_organization,upeuthinos))
    
#    conn.commit()