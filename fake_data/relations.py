#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed May 25 16:45:40 2022

@author: charalampos
"""

from faker import Faker
import numpy as np
import pandas as pd
fake = Faker('el_GR')
dat = pd.read_csv("paradotea.csv")
paradotea = dat["Dead Beta"]

#cursor = conn.cursor()
def init(cursor):
    cursor.execute("SELECT ID FROM Researcher" )
    res_ids = [d[0] for d in cursor]
    cursor.execute("SELECT ID,Responsible,StartDate,EndDate,MasterOrganization FROM Ergo" )
    erga = [d for d in cursor]
    erg_ids =  [d[0] for d in erga]
    resp_ids = [d[1] for d in erga]
    sdates = [d[2] for d in erga]
    edates = [d[3] for d in erga]
    master_org = [d[4] for d in erga]
    cursor.execute("SELECT * FROM Pedio" )
    pedia_names =  [d[0] for d in cursor]
    
    ###################################
    ### WORKS FOR ORGANIZATION      ###
    ###################################
    
    cursor.execute("SELECT ID FROM Organization" )
    org_ids = [d[0] for d in cursor]
    #cursor.execute("SELECT e.MasterOrganization, r.Researcher FROM Review r INNER JOIN Ergo e ON r.Ergo=e.ID" )
    #result = [d for d in cursor]
    #master_org = [d[0] for d in result]
    uvw = {}
    for j in range(len(res_ids)):
        researcher = res_ids[j]
        org_id = np.random.choice(org_ids)
        uvw[researcher] = org_id
        date = str(fake.date_between(start_date='-4y', end_date='-1y'))
        cursor.execute("INSERT INTO WorksForOrganization (Organization,Researcher,SINCE) VALUES (?,?,?)",
                   (int(org_id), researcher, date ))
    
    for i in range(len(erg_ids)):
        pedia=pedia_names
        ergo = erg_ids[i]
        ######################
        ### WRITE A REVIEW ##
        #####################
        master = master_org[i]
        grade = int(np.random.randint(40,101) )
        sdate = str(sdates[i])
        resp = resp_ids[i]
        flag = True
        while flag:
            reviewer = int(np.random.choice(res_ids))
            if resp != reviewer and master!=uvw[reviewer]:
                flag=False  
        
                
        cursor.execute("INSERT INTO Review (Researcher,Ergo,Grade,Date) VALUES (?,?,?,?)",
                       (reviewer,ergo,grade,sdate) )
              
        ######################
        ### PEDIA RELATION ##
        #####################
        prob = 1
        count = 0
        while np.random.choice([True,False],p=[prob,1-prob]):
            count += 1
            prob -= .25
        pedio = np.random.choice(pedia,replace=False,size=count)
        for p in pedio:
            cursor.execute("INSERT INTO PedioRelation (Pedio,Ergo) VALUES (?,?)",
                           (str(p),ergo ))
        
        ###############################
        ### WORKS FOR ERGO RELATION ###
        ###############################
        count = np.random.randint(0,10)
        ereunites = list(np.random.choice(res_ids,size=count,replace=False))
        if resp_ids[i] in ereunites:
            ereunites.remove(resp_ids[i])
        if reviewer in ereunites:
            ereunites.remove(reviewer)
        for e in ereunites:
            cursor.execute("INSERT INTO WorksForErgo (Ergo,Researcher) VALUES (?,?)",
                           (ergo, int(e) ))
        
        ######################
        ###   PARADOTEO   ###
        #####################
        count = 0
        if np.random.choice([True,False],p=[0.6,0.4]):
            prob = 1
            while np.random.choice([True,False],p=[prob,1-prob]):
                count += 1 
                prob *= 0.7
            title = np.random.choice(paradotea,size=count,replace=False)
            for t in title:
                summary = fake.catch_phrase()
                deadline = str(fake.date_between_dates(date_start=sdates[i], date_end=edates[i]))
                cursor.execute("INSERT INTO Paradoteo (Title,Ergo,Summary,Deadline) VALUES (?,?,?,?)",
                           (t, ergo, summary, deadline ))
    
#conn.commit()