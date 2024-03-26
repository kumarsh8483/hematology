#!/bin/bash

# Process the (temporary bandaid solution) for q-generated output on the rxds server
# See https://dev.azure.com/Syneos-IEP-IT-3595/IEP%20Data%20Team/_git/e2e-q-rxds

conda activate kdbenv

echo "Step 1: Processing the dataset uploads"
python3 -m e2e.q.1_process_cli
echo "-> Feature tables have been written as registered data assets"

echo "Step 2: Running data profiling scripts"
python3 -m e2e.q.2_data_profiling
echo "-> See output in ~/figures"

echo "~~~ End of pipeline_q.sh ~~~"