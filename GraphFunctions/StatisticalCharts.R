    library(plotly)
library(ggplot2)
library(tidyr)
library(plyr)


boxplot_graph <- function (){

  fig <- plot_ly() %>%
    add_trace(data = Orange, y = ~circumference, color = ~Tree, colors = "Paired", type = "box") %>%
    layout(
      title = list(text = '<b> Boxplot de diversos tipos de arvore sobre seu raio </b>', font = fontTit),
      font = globalFont,
      margin = margin,
      xaxis = list(
        title = 'Tipos de Arvore',
        ticktext = list('Arvore 1', 'Arvore 2', 'Arvore 3', 'Arvore 4', 'Arvore 5'),
        tickvals = list('1', '2', '3', '4', '5'),
        tickmode = "array"
      ),
      yaxis = list(
        title = 'Diâmetro da circunferência da arvore'
      )
    )

  return(fig)
}

histogram_graph <- function (){
  fig <- plot_ly(alpha = 0.6) %>%
    add_histogram(x = ~rnorm(500)) %>%
    add_histogram(x = ~rnorm(500) + 1) %>%
    layout(
      barmode = "overlay",
      title = list(text = '<b> Gráfico com dois histogramas </b>', font = fontTit),
      font = globalFont,
      margin = margin
    )

  return(fig)
}

error_bar_graph <- function (){
  data_mean <- ddply(ToothGrowth, c("supp", "dose"), summarise, length = mean(len))
  data_sd <- ddply(ToothGrowth, c("supp", "dose"), summarise, length = sd(len))
  data <- data.frame(data_mean, data_sd$length)
  data <- rename(data, c("sd" = "data_sd.length"))
  data$dose <- as.factor(data$dose)

  fig <- plot_ly(data = data[which(data$supp == 'OJ'),], x = ~dose, y = ~length, type = 'scatter', mode = 'markers',
          name = 'OJ',
          error_y = ~list(array = sd,
                          color = '#000000'))
  fig <- fig %>% add_trace(data = data[which(data$supp == 'VC'),], name = 'VC') %>% layout(
      title = list(text = '<b> Gráfico de erro com dois dados </b>', font = fontTit),
      font = globalFont,
      margin = margin
  )

  return(fig)

}