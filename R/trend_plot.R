#' This function allows you to plot historical trends and globiom results
#' @param love Do you love cats? Defaults to TRUE.
#' @keywords cats
#' @export
#' @examples
#' cat_function()

trend_plot <- function(var_sel, item_sel, unit_sel, reg_sel, df_gl = globiom, df_hs = hist,
                       display = T, output = T,...) {
  df_gl <- filter(df_gl, item %in% item_sel, variable %in% var_sel, unit %in% unit_sel, region %in% reg_sel)
  df_hs <- filter(df_hs, item %in% item_sel, variable %in% var_sel, unit %in% unit_sel, region %in% reg_sel)
  y_unit <- paste(unique(df_gl$unit))
  print(unique(df_gl$item))
  tit <- paste(var_sel, item_sel, unit_sel, sep = "_")
  p = ggplot(data = df_gl, aes(x = year, y = value, colour = scenario_id), size = 1) +
    geom_line() +
    geom_line(data = df_hs, aes(x = year, y = value), colour = "black", size = 1) +
    geom_vline(aes(xintercept = 2000), linetype = "dashed") +
    labs(title = tit, x = "", y = y_unit) +
    theme_bw() +
    theme(legend.position = "bottom") +
    facet_wrap(~region)

  if(display) {print(p)}
  if(output) {return(p)}
}

