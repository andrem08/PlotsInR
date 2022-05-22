library(shiny)
library(shinythemes)
library(shinyWidgets)

source('GraphFunctions/SimpleGraphs.R')

ui <<- fluidPage(
  theme = shinytheme('flatly'),
  setBackgroundColor(
  ),

  navbarPage((''),
             tabPanel('Gráficos Simples',
                      tabsetPanel(type = 'tabs', id = 'simple_tabset',
                                   tabPanel(title = 'Gráfico de espalhamento' ,
                                            plotlyOutput('scatter_plotly'),
                                            wellPanel(
                                              p('Neste gráfico eu modifiquei o nome dos eixos e seus títulos, angulações, coloração dos pontos
                                              de acordo com o número de carburadores, junto com um rótulo, modifiquei o tamanho, as cores e as fontes
                                              dos textos, defini uma margem e defini cores para os eixos e para o plano de fundo.'),
                                            )
                                   ),
                                  tabPanel(title = 'Gráfico de Linhas',
                                           plotlyOutput('line_plotly'),
                                            wellPanel(
                                              br(),br(),
                                              p('Neste gráfico foi criado dois subgráficos de linha no qual, eu criei os rótulos interativos dependendo da localização/
                                              tamanho, com cada subgráfico com seu próprio título. configurei os eixos, o tamanho do gráfico, a cor de fundo,
                                               e as cores dos rútulos com seus nomes e painel personalizado.')
                                            )
                                  ),
                                  tabPanel(title = 'Gráfico de Barras',
                                           plotlyOutput('bar_plotly'),
                                            wellPanel(
                                              br(),br(),
                                              p('Neste gráfico eu utilizei um gráfico de barras, com uma palheta de cores específica, comparando diferentes categorias, todas
                                              com um diferente valor no eixo Y dependendo do eixo X. Também é comparado com a média geral, com diferentes visualizações em um
                                              mesmo gráfico')
                                            )
                                  ),
                                  tabPanel(title = 'Gráfico de espalhamento ggplot2' ,
                                            plotlyOutput('scatter_plotly_ggplot2'),
                                            wellPanel(
                                              p('Mesmo gráfico de espalhamento, porém utilizando o ggplot2'),
                                            )
                                   ),
                      )

             ),
             tabPanel('Gráficos Estatística',
                      tabsetPanel(type = 'tabs', id = 'statistic_tabset',
                                  tabPanel(title = 'BoxPlot' ,
                                            plotlyOutput('boxplot_plotly')
                                  ),
                                  tabPanel(title = 'Histograma' ,
                                            plotlyOutput('histogram_plotly')
                                  ),
                                  tabPanel(title = 'Gráfico de Erros' ,
                                            plotlyOutput('error_bar_plotly')
                                  ),
                      )
             ),
             tabPanel('Gráficos 3D',
                      tabsetPanel(type = 'tabs', id = '3D_tabset',
                                  tabPanel(title = '3D Line Plot' ,
                                           plotlyOutput('Line3DPlotly')
                                  ),
                                  tabPanel(title = '3D Surface Plot' ,
                                           plotlyOutput('Surface3DPlotly')
                                  ),
                      )
             ),
             tabPanel(title = 'Gráficos Interativos',
                      tabsetPanel(type = 'tabs', id = 'interactive_plots',
                                  tabPanel(title = 'Baixe o seu gráfico',
                                           column(3,wellPanel(

                                            strong('Coloque os seus dados para o cálculo:'),
                                            fileInput('file_input', 'Insira o arquivo'),
                                            actionButton('load_file', 'Carregue o arquivo')
                                           )),
                                           column(9,
                                                  plotlyOutput('file_table')
                                           )
                                  ),
                                  tabPanel(title = 'Mostrando os tipos de gráfico',
                                          column(3,wellPanel(
                                            strong('Escolha um dos tipos de gráfico para construir:'),
                                            selectInput('select_scatter', '',
                                                        choices = c('Gráfico de Espalhamento', 'Gráfico de Linhas', 'Gráfico de Barras')),
                                            actionButton('button_scatter', 'Construa o gráfico!')
                                          )),
                                          column(9,
                                                 plotlyOutput('scatter_user_plot')
                                          )
                                  ),
                                  tabPanel(title = 'Compare gráficos',
                                           column(3, wellPanel(
                                             strong('Insita um segundo arquivo para o cálculo: (opcional)'),
                                             fileInput('compare_second_file', ''),
                                             actionButton('upload_second_file', 'Carregue o segundo arquivo.'),
                                             checkboxGroupInput('select_compare', 'Escolha outros gráficos para comparar:',
                                                                c('Linear', 'Quadrático', 'Raiz quadrada', 'Log base 10', 'Log base 2', 'Segundo gráfico')),
                                             actionButton('button_compare_file', 'Construa o gráfico!'),
                                           )),
                                          column(9,
                                                 plotlyOutput('compare_plots')
                                          )
                                  ),
                                  tabPanel(title = 'Probabilidades e porcentagens',
                                           column(3, wellPanel(
                                             strong('Coloque os seus dados para o cálculo:'),
                                             fileInput('file_input_prob', 'Insira o arquivo'),
                                             actionButton('load_file_prob', 'Carregue o arquivo'),
                                             br(),
                                             uiOutput('probability_ui')
                                           )),
                                           column(9,
                                                  tabsetPanel(type = 'tabs', id = 'probability_plots',
                                                              tabPanel('Tabela',plotlyOutput('prob_plot_table')),
                                                              tabPanel('Gráfico',plotlyOutput('prob_plot'))
                                                  ),

                                           )
                                  )
                      )

             )

          )
)