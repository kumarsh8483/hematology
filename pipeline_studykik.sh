#!/bin/bash

# Pipeline which generates the StudyKIK sites and then makes a (fuzzy) match to the Syneos internal sites

conda activate kdbenv

echo "Step 1: Get the geolocations for export"
python3 -m e2e.studykik.1_geolocate_export_sk
# Returns ~/data/studykik/studykik_geo.csv
# This output needs to be through https://geocodingapp.bcg.com/

echo "Step 2: "
# Takes as input an uploaded ~/data/studykik/studykik_geocoding.xlsx file which is the export from the geocoding app
python3 -m e2e.studykik.2_fuzzy_match_sk
# Returns ~/data/studykik/studykik_fuzzymap.csv
