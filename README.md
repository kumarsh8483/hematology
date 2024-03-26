# E2E pipelines

This repo contains the code used to i) process and store the feature tables as registered data asserts on Azure, and ii) run basic QC/data profiling. When calling the python scripts, ensure that execution occurs in this folder and that they are called like: `python3 -m e2e.{folder}.{file}`.

There are currently three modules found in the `e2e` folder which are described below. In addition to those, the `e2e` folder contains three utility script helpers that are called as internal modules by other scripts:

1. `utils.py`: A variety of basic utility functions that includes support for data processing (e.g. `clean_raw_upload`). 
2. `azure.py`: These are support functions for reading and writing datasets and registered data assets on Azure.
3. `qc.py`: Contains support functions for the QC/data profiling scripts.

## (1) q

Contains the scripts that process the q-generated feature tables. Because AzureML currently lacks the necessary kdb+ tables needed to create the feature tables, these scripts need to run on the rxds@z1deusrxds01 server. Another [git repo](https://dev.azure.com/Syneos-IEP-IT-3595/IEP%20Data%20Team/_git/e2e-q-rxds) contains the pipeline needed to update those files. This is a temporary feature and this pipeline will eventually be hosted in Azure once the kdb tables are ready. To run both scripts call `source pipeline_q.sh`.

1. `1_process_cli.py`: Loads the raw version of the feature tables that gets written to the `own_working_storage` datastore in Azure. After loading, the only feature transformations are to set the column types to the right data type (e.g. datetime or float), and dealing with missing/infinite values.
2. `2_data_profiling.py`: Carries out a basic analysis on i) the percent of fields that are missing or exactly zero, ii) the (log) distribution of continuous features, and iii) the frequency of categorical features. All output is saved to the `~/figures` folder.

## (2) StudyKIK

This pipeline generates a fuzzy matching between StudyKIK and Syneos sites (call `source pipeline_studykik.sh`). Note that the first time this is run, or for updated data, the output of the first script needs to be run through the [Geocoding](https://geocodingapp.bcg.com/) app and uploaded to the `~/data/studykik` folder. See the bash script for more details. 

This pipeline produces `studykik_fuzzymap.csv` which provides a mapping between the `project_code`+`int_site_id` index and the StudyKIK site_name and location. 

## (3) KOL

In the future will support any methods developed for calculating whether an investigator is a KOL. Currently, this was a simple POC script to show that a page-rank approach developed in Databracks could be run in this environment.


