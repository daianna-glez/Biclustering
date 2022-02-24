## Instal biclust package
install.packages("biclust")
library("biclust")

## Get the input data
mat<-readRDS("input_data.RData")
## Hold expression values
mat<-as.matrix(mat)

## Biclustering using CC method
## Delta is the maximum of accepted score
## Get only 5 biclusters
biclusters<-biclust(mat, method = BCCC(), delta = 1.0, number=5)

## View biclusters information
biclusters

## Plot heatmap of all biclusters
heatmapBC(mat, biclusters, number = 0, local = TRUE, order = TRUE,
          outside = FALSE)
## Plot each bicluster
heatmapBC(mat, biclusters, number = 1, local = TRUE, order = TRUE,
          outside = FALSE)
heatmapBC(mat, biclusters, number = 2, local = TRUE, order = TRUE,
          outside = FALSE)
heatmapBC(mat, biclusters, number = 3, local = TRUE, order = TRUE,
          outside = FALSE)
heatmapBC(mat, biclusters, number = 4, local = TRUE, order = TRUE,
          outside = FALSE)
heatmapBC(mat, biclusters, number = 5, local = TRUE, order = TRUE,
          outside = FALSE)

## View all genes behavior in all conditions of each bicluster
parallelCoordinates(x=mat,bicResult=biclusters,number=5, plotBoth=FALSE, plotcol=TRUE,
                compare=FALSE, info=TRUE, bothlab=c("Genes Bicluster","Conditions Bicluster"))




## Hierarchical clustering 


