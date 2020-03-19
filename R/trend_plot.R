#'Create plots for GLOBIOM scenarios
#'
#'Creates scenario plots by region for selected items.
#'
#'Note that the function uses standard GLOBIOM variable (VAR_ID), item
#'(ITEM_AG), unit (VAR_UNIT) and region (REGION_AG) nomenclature as input.
#'VAR_ID, ITEM_AG and VAR_UNIT have to be in upper case!
#'
#'@param var VAR_ID
#'@param item ITEM_AG
#'@param unit VAR_UNIT
#'@param reg REGION_AG
#'@param df_gl data frame with globiom output
#'@param df_hs data frame with historical data aggregated to GLOBIOM
#'  nomenclature
#'
#'@return A ggplot object
#'
#' @examples
#' \dontrun{
#' trend_plot(var = "AREA", item = "CORN", unit = 1000 HA", reg = "World", df_gl = globiom, df_hs = hist)
#'}
#'
#'@export
trend_plot <- function(var, item, unit, reg, df_gl, df_hs,
                       display = T, output = T,...) {
  df_gl_sel <- filter(df_gl, ITEM_AG %in% item, VAR_ID %in% var, VAR_UNIT %in% unit, REGION_AG %in% reg)
  df_hs_sel <- filter(df_hs, ITEM_AG %in% item, VAR_ID %in% var, VAR_UNIT %in% unit, REGION_AG %in% reg)
  if(dim(df_gl_sel)[1]==0) {stop("None of the provided output combinations are in the globiom output file")}
  tit <- paste(var, item, unit, sep = "_")
  message(tit)
  p = ggplot2::ggplot(data = df_gl_sel, aes(x = YEAR, y = OUTPUT_AG, colour = BioenScen,
                                            group = interaction(MacroScen, BioenScen, IEA_Scen)), size = 1) +
    ggplot2::geom_line() +
    ggplot2::geom_line(data = df_hs_sel, aes(x = YEAR, y = OUTPUT_AG), colour = "black", size = 1) +
    ggplot2::geom_vline(aes(xintercept = 2000), linetype = "dashed") +
    ggplot2::labs(title = tit, x = "", y = unit) +
    ggplot2::theme_bw(base_size = 10) +
    ggplot2::scale_y_continuous(labels = scales::comma) +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::facet_wrap(~REGION_AG, scales = "free", ncol = 3)

  if(display) {print(p)}
  if(output) {return(p)}
}

#' Creates pdf with plots for selected GLOBIOM output dimensions
#'
#' Creates a pdf file with plots for selected GLOBIOM VAR_ID, ITEM_AG and
#' VAR_UNIT combinations.
#'
#' Plots are produced for a standard set of key VAR_ID, ITEM_AG and VAR_UNIT
#' combinations stored in \code{output_comb_base} unless specified otherwise.
#' Plots are only produced for output combinations that exist in the data.
#'
#' @param df_gl dataframe with globiom output
#' @param df_hs data frame with historical data aggregated to GLOBIOM
#'   nomenclature
#' @param path path where the pdf file will be saved. Default is the working
#'   directory.
#' @param file_name name of the pdf file that is generated. Default is
#'   \code{globiom_trend_plots_YYYY-MM-DD.pdf}.
#' @param comb output combinations used for plotting. Default is
#'   main_output_comb
#'
#' @return None but a pdf file is saved in the working directory or a specified
#'   location.
#'
#' @examples
#' \dontrun{
#' trend_plot_all(df_gl = globiom, df_hs = hist, path = "c:/temp", file_name = "globiom_output",
#' output_se = df)
#' }
#'
#' @export
trend_plot_all <- function(df_gl = NULL, df_hs = NULL, path = NULL, file_name = NULL, comb = NULL) {
  df_gl_comb <- all_output_comb(df_gl)
  if(is.null(comb)){
    output_comb <- dplyr::inner_join(df_gl_comb, main_output_comb)
    all_region <- unique(df_gl$REGION_AG)
  } else {
    output_comb <- dplyr::inner_join(df_gl_comb, comb)
    if(dim(output_comb)[1]== 0) stop("None of the provided output combinations are in the globiom output file")
    all_region <- unique(df_gl$REGION_AG)
  }

  n_plot <- nrow(output_comb)
  message("Total number of plots: ", n_plot)

  file_name <- if(is.null(file_name)) {paste0("globiom_trend_plots_", Sys.Date(), ".pdf")
  } else {
    paste0(file_name, ".pdf")
  }
  if(is.null(path)) {getwd()}

  message(file_name, " will be saved in ", path)

  pdf(file = file.path(path, file_name))
  purrr::walk(1:n_plot, function(i){
    message("Adding plot ", i, " out of ", n_plot)
    trend_plot(var = output_comb$VAR_ID[i], item = output_comb$ITEM_AG[i],
               unit = output_comb$VAR_UNIT[i], reg = all_region, df_gl = df_gl, df_hs = df_hs)
  })
  dev.off()
}
