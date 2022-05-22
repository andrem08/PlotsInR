library(plotly)
library(ggplot2)
library(tidyr)
library(plyr)
library(openxlsx)
library(dplyr)

renderInputTable <- function (data){
  fig <- plot_ly(type = 'table',
                 header = list(
                   values = c('Índice: ',names(data)),
                   align = c('left', rep('center', ncol(mtcars))),
                   fill = list(color = 'rgb(173, 216, 230)')
                 ),

                 cells = list(
                   values = rbind(
                     rownames(data),
                     t(as.matrix(unname(data)))
                   ),
                   line = list(color = "black", width = 1),
                   fill = list(color = c('rgb(173, 216, 230)', 'rgb(244, 245, 255)')),
                   font = list(family = "Arial", size = 12, color = "black")
                 )
  )
  return(fig)
}

construct_different_plots <- function (data, mode){
  fig <- switch(
    mode,
    'Gráfico de Barras' = plot_ly(x = data[[1]], y = data[[2]], type = 'bar'),
    'Gráfico de Espalhamento' = plot_ly(x = data[[1]], y = data[[2]], type = 'scatter', mode = 'markers'),
    'Gráfico de Linhas' = plot_ly(x = data[[1]], y = data[[2]], type = 'scatter', mode = 'lines+markers'),
  )
  title <- paste0("<b> Gráfico de comparando o \"",colnames(data)[1], "\" pelo \"",colnames(data)[2], "\" </b>")
  fig <- fig %>% layout(title = list(text = title, font = fontTit),
           font = globalFont,
           plot_bgcolor='#e5ecf6',

           xaxis = list(
             title = colnames(data)[1],
             zerolinecolor = '#ffff',
             zerolinewidth = 2,
             gridcolor = 'ffff'
           ),

           yaxis = list(
             title = colnames(data)[2],
             zerolinecolor = '#ffff',
             zerolinewidth = 2,
             gridcolor = 'ffff'),
           margin = margin,
           showlegend = FALSE
    )
  return(fig)
}

construct_comparable_plot <- function (data, data2, comparing){
  fig <- plot_ly(x = data[[1]], y = data[[2]], type = 'scatter', mode = 'lines+markers', name = 'Seu gráfico')
  if('Linear' %in% comparing){
    linear <- data[[1]]
    fig <- fig %>% add_trace(y = linear, name = 'Linear')
  }
  if('Quadrático' %in% comparing){
    quad <- as.numeric(lapply(data[[1]], FUN = function (x)(x^2)))
    fig <- fig %>% add_trace(y = quad, name = 'Quadrático')
  }
  if('Raiz quadrada' %in% comparing){
    log <- as.numeric(lapply(data[[1]],sqrt))
    fig <- fig %>% add_trace(y = log, name = 'Raiz quadrada')
  }
  if('Log base 10' %in% comparing){
    log10 <- as.numeric(lapply(data[[1]],FUN = function (x)(log10(x))))
    fig <- fig %>% add_trace(y = log10, name = 'Log base 10')
  }
  if('Log base 2' %in% comparing){
    log2 <- as.numeric(lapply(data[[1]],FUN = function (x)(log2(x))))
    fig <- fig %>% add_trace(y = log2, name = 'Log base 2')
  }
  if (('Segundo gráfico' %in% comparing) & !is.null(data2)){
    fig <- fig %>% add_trace(x = data2[[1]], y = data2[[2]], name = 'Segundo gráfico')
  }
  return(fig)
}

construct_probability_plot <- function (data, chosen, plot_type){
  if(plot_type == 'Gráfico de Distribuição ( Histograma )'){
    fig <- plot_ly(x = as.numeric(data[[chosen]]), type = "histogram") %>%
      layout(
        barmode="overlay",
        bargap=0.1)
  }
  if(plot_type == 'Gráfico de Pizza'){
    title <- paste0("<b> Gráfico de pizza a respeito do(a) ",chosen," </b>")
    fig <- plot_ly(labels = names(table(data[chosen])), values = as.numeric(table(data[chosen])), type = 'pie')%>%
      layout(
        title = list(text = title, font = fontTit),
        margin = margin,
        legend = list(
          title=list(text='<b> Legenda </b>'),
          font = list(
            size = 12,
            color = "#000"),
          bgcolor = "#BEC3C6"
     )
      )
  }
  return(fig)
}