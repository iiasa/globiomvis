#' GLOBIOM output combinations
#'
#' Creates data frame with all existing combinations of VAR_ID, VAR_UNIT and ITEM_AG in GLOBIOM output file.
#'
#' @param df_gl dataframe with globiom output.
#' @return A data.frame with existing VAR_ID, VAR_UNIT, ITEM_AG combinations in df_gl
#'
#' @examples
#' \dontrun{
#' all_output_comb(globiom)
#' }
#'
#' @export

all_output_comb <- function(df_gl){
  output_comb <- df_gl %>%
    dplyr::select(VAR_ID, VAR_UNIT, ITEM_AG) %>%
    tidyr::complete(nesting(VAR_ID, VAR_UNIT, ITEM_AG)) %>%
    dplyr::distinct()
  return(output_comb)
}
