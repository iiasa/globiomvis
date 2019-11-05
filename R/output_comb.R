#' Create plots for GLOBIOM scenarios
#'
#' Creates scenario plots by region for selected items
#'
#' This is additional  information
#'
#' @param df_gl dataframe with globiom output
#' @export
#' @Return A data.frame with all unique and existing VAR_ID, VAR_UNIT, ITEM_AG combinations in df_gl
#' @examples

all_output <- function(df_gl){
  output_comb <- df_gl %>%
    dplyr::select(VAR_ID, VAR_UNIT, ITEM_AG) %>%
    tidyr::complete(nesting(VAR_ID, VAR_UNIT, ITEM_AG)) %>%
    dplyr::distinct()
  return(output_comb)
}
