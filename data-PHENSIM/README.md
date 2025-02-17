Folder that contains PHENSIM data that will be used to run the program and see if the results are better or worse than the ones used in the original article.

PHENSIM data are the Endpoint perturbation of pathways taken from the output of PHENSIM, in particular the data used is the Average node perturbation for the pathways.

The raw endpoint perturbation, which they replace the raw counts on the expression set input, are reported on the file "matrix_perturbation_". 

The data is seen as a **kraken** input since the kraken inputs are not normalized and the pipeline is a straightforward model.

To run on these input, the scripts are the same as the ones used for the kraken inputs, an example is the following:
```bash
./run_model.sh --model-type rfe --dataset data-PHENSIM/tcga_blca_resp_gemcitabine_kraken_eset_virtualEndPert.rds
```

The last part of the file name means that it is not a kraken expression set but the endpoint perturbation of the PHENSIM output. This name was used to mantain the code used in the original project.
