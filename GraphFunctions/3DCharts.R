library(plotly)
library(ggplot2)
library(tidyr)
library(plyr)

line_3D_graph <- function (){
  count <- 3000

  x <- c()
  y <- c()
  z <- c()
  c <- c()

  for (i in 1:count) {
    r <- i * (count - i)
    x <- c(x, r * cos(i / 30))
    y <- c(y, r * sin(i / 30))
    z <- c(z, i)
    c <- c(c, i)
  }

  data <- data.frame(x, y, z, c)

  fig <- plot_ly(data, x = ~x, y = ~y, z = ~z, type = 'scatter3d', mode = 'lines',
          line = list(width = 4, color = ~c, colorscale = list(c(0,'#BA52ED'), c(1,'#FCB040')))) %>% layout(
      title = list(text = '<b> Gráfico de erro com dois dados </b>', font = fontTit),
      margin = margin
  )

  return(fig)
}

surface_3D_graph <- function (){
  fig <- plot_ly(z = ~volcano) %>% add_surface(
    contours = list(
      z = list(
        show=TRUE,
        usecolormap=TRUE,
        highlightcolor="#ff0000",
        project=list(z=TRUE)
      )
    )
  )
  fig <- fig %>% layout(
    scene = list(
      camera=list(
        eye = list(x=1.87, y=0.88, z=-0.64)
        )
      )
  )
  fig <- fig  %>% layout(
      title = list(text = '<b> Gráfico de erro com dois dados </b>', font = fontTit),
      margin = margin
  )
  return(fig)
}