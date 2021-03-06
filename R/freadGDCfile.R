#' Read GDC segmentation datafile for low-pass sequencing data.
#'
#' Reads a GDC segmetnation file and extract the segmetnation data.
#' @keywords read file
#' @import magrittr
#' @importFrom data.table fread
#' @importFrom reshape2 colsplit
#' @importFrom dplyr bind_cols
#' @param file GDC file to be read
#' @param fread_skip The number of metadata lines to be skipped(typically 14)..
#' @return input_tsv_with_sample_info A data frame containing the sample information extracted
#'  from the filename, including sample name & comparison type.
#' @examples 
#' freadGDCfile(file =
#' system.file("extdata","somaticCnvSegmentsDiploidBeta_TARGET-30-PANRVJ_NormalVsPrimary.tsv",
#' package = "HiCNV"))
#' @export
freadGDCfile<-function(file,fread_skip=14) {input_tsv<-data.table::fread(file,skip=fread_skip)
sample_info_colsplit<-reshape2::colsplit(basename(file),"_|-|\\.",c("pre","project","num","sample","comparison","fn_ext"))
input_tsv_with_sample_info<-dplyr::bind_cols(input_tsv,sample_info_colsplit[rep(1,nrow(input_tsv)),])
if(length(na.omit(unlist(sample_info_colsplit)))!=6){return(NULL)}
return(input_tsv_with_sample_info)
}
