all:

all: analysis/covariate_goodness.txt
analysis/covariate_goodness.txt: results/model_scores/cox_covariate_model_scores.rds results/model_scores/svm_covariate_model_scores.rds
	Rscript melt_covariates.R $^ > $@

all: analysis/model_goodness.txt
analysis/model_goodness.txt: results/model_scores/cnet_model_scores.rds results/model_scores/rfe_model_scores.rds
	Rscript melt_covariates.R $^ > $@


all: analysis/compared_runs.txt
analysis/compared_runs.txt: analysis/model_goodness.txt analysis/covariate_goodness.txt
	Rscript compare_runs.R $^ > $@


all: analysis/goodness_hits.txt
analysis/goodness_hits.txt: analysis/compared_runs.txt
	Rscript choose_hits.R $^ > $@

all: analysis/microbial_features.txt
analysis/microbial_features.txt: analysis/goodness_hits.txt
	Rscript pull_coefficients.R $$( Rscript kraken_hits_to_paths.R $^ ) > $@

all: analysis/microbial_feature_stats.txt
analysis/microbial_feature_stats.txt: analysis/microbial_features.txt
	Rscript feature_stats.R $^ > $@

all: figures/barplots/barplots.marker
figures/barplots/barplots.marker: analysis/goodness_hits.txt
	Rscript generate_barplots.R $^ figures/barplots && touch $@

all: figures/microbiome_density_plots/microbiome_density.marker
figures/microbiome_density_plots/microbiome_density.marker: analysis/goodness_hits.txt analysis/model_goodness.txt analysis/covariate_goodness.txt
	Rscript microbiome_density.R $^ figures/microbiome_density_plots && touch $@


clean:
	-rm -f analysis/microbial_feature_stats.txt analysis/microbial_features.txt analysis/goodness_hits.txt analysis/compared_runs.txt analysis/model_goodness.txt analysis/covariate_goodness.txt figures/barplots/barplots.marker

.DELETE_ON_ERROR:
