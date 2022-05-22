library(plotly)
library(ggplot2)
library(tidyr)
library(plyr)

#Scatter plot utilizado junto com o ggplot2
scatter_graph_ggplot2 <- function (){
    p <- ggplot(mtcars) +
    #Define o eixo x e o eixo y respectivamente
    geom_point(aes(mpg, disp, color = carb)) +
    labs(title = "Gráfico de pontos comparando mpg pelo deslocamento ", color = 'Carburadores') +
    #Define o nome do eixo Y, cada tick do eixo y e modifica os nomes dos ticks do gráfico
    scale_x_continuous(name = 'Milhas por galao',
                       breaks = c(12.5, 25, 35),
                       labels = c('12,5 mpg', '25,0 mpg', '35,0 mpg'),
                       ) +
    scale_y_continuous(name = 'Deslocamento') +
    #Define o ângulo dos titulos dos eixos
    theme(
      axis.text.x = element_text(angle = 30),
      axis.title.y = element_text(size = 15, color = 'red', angle = 0, face = "bold"),
      axis.title.x = element_text(size = 15, color = 'orange', angle = 0, face = "bold"),
      plot.title = element_text(size = 18, face = "italic", hjust = 0.5)
    )

  return (p)
}

scatter_graph <- function (){

  fig <- plot_ly(data = mtcars, x =~mpg, y = ~disp, color = ~carb, type = "scatter", mode = "markers") %>%
    layout(title = list(text = "<b> Gráfico de pontos comparando mpg pelo deslocamento </b>", font = fontTit),
           font = globalFont,
           plot_bgcolor='#e5ecf6',

           xaxis = list(
             title = "Milhas por galão",
             zerolinecolor = '#ffff',
             zerolinewidth = 2,
             gridcolor = 'ffff',
             ticktext = list('12,5 mpg', '25,0 mpg', '35,0 mpg'),
             tickvals = list(12.5, 25, 35),
             tickmode = "array",
             tickangle = 30),

           yaxis = list(
             title = "Deslocamento",
             zerolinecolor = '#ffff',
             zerolinewidth = 2,
             gridcolor = 'ffff'),
           margin = margin,
           showlegend = FALSE
    )
  return(fig)

}

line_graoh <- function (){

  construction$Month <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)

  fig1 <- plot_ly(construction, x = ~Month, y = ~Northeast, type = 'scatter', mode = 'lines+markers', name = 'Northeast', height = '150%') %>%
    add_trace(y = ~Midwest, name = 'Midwest') %>%
    add_trace(y = ~South, name = 'South') %>%
    add_trace(y = ~West, name = 'West')

  fig2 <- plot_ly(construction, x = ~Month, y = ~`1 unit`, type = 'scatter', mode = 'lines+markers', name = '1 andar', height = '150%') %>%
    add_trace(y = ~`5 units or more`, name = '5 andares ou mais') %>%
    layout(xaxis = list(
      title=list(text='Mês', font = list(size = 20), standoff = 25),
      ticktext = list('Janeiro', 'Fevereiro','Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro'),
      tickvals = list(1, 2, 3, 4, 5, 6, 7, 8, 9),
      tickmode = "array"))

  fig <- subplot(fig1, fig2) %>%
    layout(
      plot_bgcolor='#e5ecf6',
      xaxis = list(
        ticktext = list('Janeiro', 'Fevereiro','Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro'),
        tickvals = list(1, 2, 3, 4, 5, 6, 7, 8, 9),
        tickmode = "array"),

      yaxis = list(
        title=list(text='Número de construções', standoff = 25)
      ),
      font = globalFont
    )
  annotations <- list(
    list(
      x = 0.23,
      y = 1.0,
      text = "<b> Número de construções por mes em cada localização </b>",
      xref = "paper",
      yref = "paper",
      xanchor = "center",
      yanchor = "bottom",
      showarrow = FALSE
    ),
    list(
      x = 0.76,
      y = 1,
      text = "<b> Número de construções por mes dependendo de seu tamanho </b>",
      xref = "paper",
      yref = "paper",
      xanchor = "center",
      yanchor = "bottom",
      showarrow = FALSE
    )
  )

  fig <- fig %>%layout(annotations = annotations,
                       legend = list(
                         title=list(text='<b> Legenda </b>'),
                         font = list(
                           family = "sans-serif",
                           size = 12,
                           color = "#000"),
                         bgcolor = "#E2E2E2",
                         bordercolor = "#FFFFFF",
                         borderwidth = 2)
  )

  return(fig)
}

bar_graph <- function (){
  dados <- as.data.frame(VADeaths)
  dados$Age <- rownames(VADeaths)
  dados2 <- data.frame(Age = rownames(VADeaths), Mean = rowMeans(VADeaths))

  fig <- plot_ly(dados, x = ~Age, y = ~`Rural Male`, type = 'bar', name = 'Homem - Rural', height = '150%') %>%
    add_trace(y = ~`Rural Female`, name = 'Mulher - Rural') %>%
    add_trace(y = ~`Urban Male`, name = 'Homem - Urbano') %>%
    add_trace(y = ~`Urban Female`, name = 'Mulher - Urbano') %>%
    add_trace(dados2, x = ~Age, y = dados2[['Mean']], type = 'scatter',  mode = 'lines+markers', name = 'Média') %>%

    layout(
      title = list(text = "<b> Gráfico de barras comparando o numero de mortes por idades </b>", font = fontTit),
      colorway = c('#e7a4b6', '#cd7eaf', '#a262a9', '#6f4d96', '#000000'),
      yaxis = list(
        title = 'Número de Mortes'
      ),
      xaxis = list(
        title = 'Períodos de Idade'
      ),
      margin = margin,
     legend = list(
       title=list(text='<b> Legenda </b>'),
       font = list(
         size = 12,
         color = "#000"),
       bgcolor = "#BEC3C6"
     )
    )

  return(fig)
}
