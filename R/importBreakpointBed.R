#' Import a breakpoint BED file.
#'
#' Imports a BED file with breakpoints or other interactions, in a dual position format.
#'
#' @keywords bed
#' @import GenomicInteractions
#' @param breakpoint_fn the filename of the breakpoint bed file
#' @return a Genomic Interactions Object
#' @export

  importBreakpointBed<-function(breakpoint_fn)
  {
    imported_bed<-rtracklayer::import.bed(breakpoint_fn)
    colsplit_locations<-colsplit(string = mcols(imported_bed)$name,pattern = "_R_",names=c("otherdata","pos"))[,2]
    colsplit_locations_gr<-GRanges(colsplit_locations)
    colsplit_id<-colsplit(string=colsplit(string = mcols(imported_bed)$name,pattern = "Id:",names=c("otherdata","id_containing"))[,2],pattern="_",names=c("id","other"))[,1]
    gint<-GenomicInteractions(imported_bed,colsplit_locations_gr,... = colsplit_id)
    colsplit_bed<-colsplit(string = mcols(imported_bed)$name,pattern = "_",names=c("otherdata","id_containing"))[,1]
    mcols(gint)$id<-colsplit_id
    mcols(gint)$bed<-colsplit_bed
    return(gint)
  }