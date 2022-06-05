#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May 23 22:43:38 2022

@author: charalampos
"""
fields =  [ "Acoustics","Aeronautics","Agronomy","Anatomy","Anthropology","Archaeology","Astronomy","Astrophysics","Bacteriology","Biochemistry",
    "Biology","Botany","Cardiology","Cartography","Chemistry","Cosmology","Crystallography","Ecology","Embryology","Endocrinology","Entomology",
    "Enzymology","Forestry","Gelotology","Genetics","Geochemistry","Geodesy","Geography","Geology","Geophysics","Hematology","Histology","Horology",
    "Hydrology","Ichthyology","Immunology","Linguistics","Mechanics","Medicine","Meteorology","Metrology","Microbiology","Mineralogy","Mycology",
    "Neurology","Nucleonics","Nutrition","Oceanography","Oncology","Optics","Paleontology","Pathology","Petrology","Pharmacology","Physics",
    "Physiology","Psychology","Radiology","Robotics","Seismology","Spectroscopy","Systematics","Thermodynamics","Toxicology","Virology","Volcanology","Zoology", ]

#cursor = conn.connect()

def init(cursor):
    for field in fields:
        cursor.execute("INSERT INTO Pedio (Name) VALUES (?)",(field,))

# conn.commit()
