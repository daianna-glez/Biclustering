## R code 

## Instal biclust package
install.packages("biclust")
library("biclust")
library(cluster)

## Get the input data
mat<-readRDS("input_data.RData")
## Hold expression values
mat<-as.matrix(mat)

## Biclustering using CC method
## Delta is the maximum of accepted score
## Get at most 5 biclusters
biclusters<-biclust(mat, method = BCCC(), delta = 1.0, number=5)

## View biclusters information
biclusters


## Set outer and inner margins and plot size for both heatmaps
par(omi = c(0.5, 0.5, 0.5, 0.5),      
    mai = c(1,1,1,1),                     
    fin = c(6, 7),                        
    mfrow=c(1,2) )                        
## See all biclusters 
heatmapBC(mat, biclusters,col = rev(colorspace::terrain_hcl(10)))
## All biclusters orderer by rows and columns
heatmapBC(mat, biclusters, number = 0, order = TRUE,
          outside = FALSE, col = rev(colorspace::terrain_hcl(10)))


## Plot the heatmaps of each bicluster obtained 
sapply(1:biclusters@Number, function(x){
  par(omi = c(0.5, 0.5, 0.5, 0.5),          # Set outer margin at .5 inches
      mai = c(1,1,1,1),                     # Set inner margin btwn figure & plot
      fin = c(6, 7),                        # Plot size
      mfrow=c(1,2) )  
  ## Bicluster in the whole heatmap 
  heatmapBC(mat, biclusters, number = x, local = FALSE, order = TRUE,
            outside = FALSE, col = rev(colorspace::terrain_hcl(10)))
  ## Local region of bicluster 
  heatmapBC(mat, biclusters, number = x, local = TRUE, order = TRUE,
            outside = FALSE, col = rev(colorspace::terrain_hcl(10))) })


## View all genes expression in all conditions of each bicluster
sapply (1:biclusters@Number, function(x){  
  parallelCoordinates(mat,bicResult=biclusters,number=x, plotBoth=FALSE, plotcol=TRUE,
    compare=FALSE, info=TRUE, bothlab=c("Bicluster genes","Bicluster conditions"), cex.axis=0.35, 
    las = 2, col= rev(colorspace::rainbow_hcl(10)))
  })


## Hierarchical clustering of data
library("pheatmap")
pheatmap(
  mat,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  show_rownames = TRUE,
  fontsize_row = 5,
  show_colnames = TRUE,
  clustering_method = "complete",
  col= rev(colorspace::terrain_hcl(10))
  )

## Reproduce code in 120 chars
options(width = 120)
sessioninfo::session_info()
