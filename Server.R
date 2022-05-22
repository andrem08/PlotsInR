source('GraphFunctions/SimpleGraphs.R')
source('GraphFunctions/SimpleGraphs.R')
source('GraphFunctions/StatisticalCharts.R')
source('GraphFunctions/3DCharts.R')
source('GraphFunctions/UserPlot.R')


server <- function (input, output, session){

  #Graficos simples
  output$scatter_plotly <- renderPlotly(scatter_graph())
  output$line_plotly <- renderPlotly(line_graoh())
  output$bar_plotly <- renderPlotly(bar_graph())
  output$scatter_plotly_ggplot2 <- renderPlotly(scatter_graph_ggplot2())

  #Graficos mais voltados a estatística
  output$boxplot_plotly <- renderPlotly(boxplot_graph())
  output$histogram_plotly <- renderPlotly(histogram_graph())
  output$error_bar_plotly <- renderPlotly(error_bar_graph())

  #Gráficos 3D
  output$Line3DPlotly <- renderPlotly(line_3D_graph())
  output$Surface3DPlotly <- renderPlotly(surface_3D_graph())
  data_input <<- NULL

   observeEvent(input$load_file, {
     data_input <<- data.frame(read.xlsx(input$file_input$datapath))
     output$file_table <- renderPlotly(renderInputTable(data_input))
   })

  observeEvent(input$button_scatter, {
    output$scatter_user_plot <- renderPlotly(construct_different_plots(data_input, input$select_scatter))
  })
  data2 <<- NULL
  observeEvent(input$upload_second_file, {
     data2 <<- data.frame(read.xlsx(input$compare_second_file$datapath))
   })
  observeEvent(input$button_compare_file,{
    output$compare_plots <- renderPlotly(construct_comparable_plot(data_input, data2, input$select_compare))
  })

  observeEvent(input$load_file_prob,{
    output$probability_ui <- renderUI(tagList(
      selectInput('prob_choice', 'Escolha a variavel para calcular', choices = colnames(data.frame(read.xlsx(input$file_input_prob$datapath)))),
      strong('Escolha um dos tipos de gráfico para construir:'),
      selectInput('probability_select', '',
                  choices = c('Gráfico de Distribuição ( Histograma )',  'Gráfico de Pizza')),
      actionButton('probability_button', 'Construa o gráfico!'),
      output$prob_plot_table <- renderPlotly(renderInputTable(data.frame(read.xlsx(input$file_input_prob$datapath))))
    ))
  })
  observeEvent(input$probability_button, {
        output$prob_plot <- renderPlotly(construct_probability_plot(data.frame(read.xlsx(input$file_input_prob$datapath)),
                                                                    input$prob_choice, input$probability_select))
  })
}