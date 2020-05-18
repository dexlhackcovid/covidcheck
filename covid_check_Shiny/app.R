library(shiny)
library(shinyMobile)
library(leaflet)
  ui = f7Page(
    #includeCSS("www/custom.css"),
    title = "CovidCheck",
    skin='auto',
    
    init = f7Init(theme = "light"),
    tags$head(
      tags$script(src="ObterIP.js")
    ),
    tags$head(tags$style(HTML("#table1 tr.selected, #Espera tr.selected {background-color:red}"))),
    f7TabLayout(
      navbar = f7Navbar(
        title = "CovidCheck",
        left_panel = FALSE,
        right_panel = FALSE,
        shadow=TRUE
      ),
      f7Tabs(
        animated = TRUE,
        id = "tabs",
        f7Tab(
          tabName = "Informações",
          icon = f7Icon("checkmark"),
          active = TRUE,
          # Tab 1 content
          h4('Prencha suas informações, após clicar no botão enviar direcione se a aba Diagnostico'),
          uiOutput('ObterLatitude'),
          br(),
          br(),
          uiOutput('ObterLongitude'),
          br(),
          br(),
          numericInput('Age','Qual sua idade?',value=20,min=5,max=120),
          br(),
          br(),
          numericInput('Temp','Informe aqui sua temperatura medida por um termometro',value=36.5,min=30,max=45),
          br(),
          br(),
          numericInput('Pul','Informe aqui sua pulsação cardiaca',value=60,min=30,max=320),
          br(),
          br(),
          f7checkBoxGroup('Preexistentes',label='Marque caso possua alguma das condições a seguir',choices=c('Hipertensao','diabetes','asma','oncologia')),
          f7checkBoxGroup('Sintomas',label='Marque nas caixas a seguir quais dos sintomas voce possui',choices = c('Tosse','Falta de ar','Dor de cabeca','coriza')),
          f7Button(inputId = 'Arvore',label='Enviar')
          
        ),
        f7Tab(
          tabName = "Diagnostico",
          icon = f7Icon("play"),
          active = FALSE,
          h4('Aqui observamos  a probabilidade que voce esteja em cada faixa'),
          plotOutput('MostrarPrevisaoPie')
        ),
        f7Tab(
          tabName = "Ver Upas",
          icon = f7Icon("placemark"),
          active = FALSE,
          h4('Aqui temos o tempo de espera atual para cada UPA na região em minutos'),
          h4('Clique em uma UPA de interesse para a localizarmos no mapa'),
          DT::dataTableOutput("Espera")
        ),
        f7Tab(tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
          tabName = "Mapa",
          icon = f7Icon("map"),
          active = FALSE,
          # Tab 1 content
          leafletOutput('Mapa')
          
        )

      )
    )
  )
  
  server <- function(input, output) {
    
   
    
    
    # A seguinte função é um objetivo reativo que pega as informações do usuario e organiza para passar para a arvore de decisão
    OrganizarDataset<-reactive({
      idade=input$Age
      febre=input$Temp
      pulsação=input$Pul
      hipertensão=as.numeric('Hipertensao' %in% input$Preexistentes)
      diabetes=as.numeric('diabetes' %in% input$Preexistentes)
      asma=as.numeric('asma' %in% input$Preexistentes)
      oncologia=as.numeric('oncologia' %in% input$Preexistentes)
      tosse=as.numeric('Tosse' %in% input$Sintomas)
      falta.de.ar=as.numeric('Falta de ar' %in% input$Sintomas)
      dor.de.cabeça=as.numeric('Dor de cabeca' %in% input$Sintomas)
      coriza=as.numeric('coriza' %in% input$Sintomas)
      df=data.frame(idade,hipertensão,diabetes,asma,oncologia,tosse,coriza,falta.de.ar,febre,dor.de.cabeça,pulsação)
      return(df)
    })
    
    output$ObterLatitude<-renderUI({
      Latitude=IP()$Latitude
      numericInput('Lat','Latitude',Latitude,-90,90 )
    })
    
    output$ObterLongitude<-renderUI({
      Longitude=IP()$Longitude
      numericInput('Lon','Longitude',Longitude,-90,90)
    })
    

    
    IP1 <- reactive({ input$long })
    
    observe({
      cat(capture.output(str(IP1()), split=TRUE))
    })
        
    IP <- reactive({
      if(!is.null(input$lat)){
        Latitude=input$lat
        Longitude=input$long
      }else{
        Latitude=-22.5
        Longitude=-43.1823 #Caso tenha problema com o ip
      }
      return(list(Latitude=Latitude,Longitude=Longitude))
    } )
    
    
    #A seguinte função gera o mapa
    output$Mapa<-renderLeaflet({
      Upas<-ExtrairUpasSelecionadas()
      
      p=leaflet(data = Upas) %>% addTiles() %>%addCircleMarkers(lat=input$Lat,lng = input$Lon,popup = 'Sua Localização',color = 'black',fillColor = 'black') #Inicializa o mapa e seta a posição do usuario
      if(nrow(Upas)>0)
        p=p %>%addMarkers(popup = ~as.character(UPA), label = ~as.character(UPA)) #Adiciona as upas
      
      p
    })
    #A seguinte função  verificara quais upas foram selecionadas e retornar seus nomes,latitude e longitude
    ExtrairUpasSelecionadas<-reactive({
      Arquivo=GerarUpas()
      Arquivo=Arquivo[input$Espera_rows_selected,]
      Locais=read.csv('Localizacao.csv')
      Locais=Locais[Locais[,1] %in% Arquivo[,6],]
      return(Locais)
    })
    #Função para mapear as cores
    scale_fill_fixed <- function(...){
      ggplot2:::manual_scale(
        'fill', 
        values = setNames(c('green', 'blue', 'red', 'orange','yellow'), c('verde','azul','vermelho','laranja','amarelo')  ), 
        ...
      )
    }
    
    #A Função a seguir ira aplicar a arvore de decisão sobre os dados do usuario
    ServirModelo<-eventReactive(input$Arvore,{
     load('ArvoreDecisao.Rdata')
      Dados=OrganizarDataset()
      Previsao=predict(l[[1]]$finalModel,newdata=Dados)
      return(Previsao)
      
    })
    

    #Esta função retorna a previsao do modelo como probabilidade
    output$MostrarPrevisao<-renderTable({
      Previsao<-ServirModelo()
      Previsao
    })
    #Foi decidido que é melhor retornar a previsao acima como um grafico de pizza, esta função faz isto
    output$MostrarPrevisaoPie<-renderPlot({
      showModal(modalDialog(title="Consultando o servidor","Ao final clique na aba Provavel Diagnostico", footer=NULL))
      Previsao<-ServirModelo()
      removeModal()
      require(ggplot2)
      Previsao=data.frame(Previsao[1,],names(Previsao[1,]))
      ggplot(Previsao) + geom_bar(aes(x="",y=Previsao[,1],fill=Previsao[,2]),stat='identity' ) +coord_polar("y",start=0) + labs(y='',fill='Classificação para o atendimento') + scale_fill_fixed()
    })
    
    #Ordenação  para retornar as upas ao usuario
    GerarUpas<-reactive({
      Previsao<-ServirModelo()
      Arquivo=read.csv('Upas.csv')
      Ordenacao=which(Previsao[1,]==max(Previsao[1,]) )
      Arquivo=Arquivo[order(Arquivo[,Ordenacao]),]
      return(Arquivo)
    })
    #Impressão das upas com filtragem de tempos que não são relevantes
    output$Espera<-DT::renderDataTable(options = list(lengthChange = FALSE),{
      Arquivo=GerarUpas()
      Arquivo=GerarUpas()
      Previsao=ServirModelo()
      Ind=which(Previsao[1,]>0)
      Ind=c(Ind,6)
      Arquivo=Arquivo[,Ind]
      print(Arquivo)
    })
  } 
  
  
  shinyApp(ui, server)