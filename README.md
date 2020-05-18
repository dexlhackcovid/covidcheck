---
title: "CovidCheck"
author: "DexlLab"
date: "17 de maio de 2020"
output:
  pdf_document: default
  html_document:
    df_print: paged
---



##Aplicação HACKCOVID


Este Repositório tem como objetivo apresentar o projeto desenvolvido para o Hackcovid19. Para o desafio, foi desenvolvida uma aplicação para auxiliar pacientes com suspeita de Covid-19. Durante a utilização, o paciente acessa o aplicativo e informa os sintomas apresentados. Em seguida a aplicação executa um algoritmo de inteligência artificial que indica uma classificação de risco baseada nos sintomas informados, sugerindo unidades de atendimento mais indicadas com base na distância e no tempo de espera estimado de acordo com o risco.

##Desafio Escolhido


O desafio ao qual nos propomos a trabalhar é o D007 - PATH TO EMERGENCE CARE (PATH TO EMERGENCE CARE)
Link para o desafio:

http://www.cbpf.br/hackcovid19/Hackcovid_Desafios_Todas.html.
 


Para o desafio a aplicação foi desenvolvida em duas frentes, a primeira já completamente funcional é um Progressive Web App (PWA), a segunda como uma aplicação nativa android que está na fase de protótipo, a primeira pode ser acessada tanto pelo desktop utilizando seu navegador de preferência quanto através de um celular ou tablet, a aplicação reconhece então o tipo de sistema que está acessando e adapta sua interface de acordo.
 
Nossa aplicação tem como objetivo receber de seu usuário dados clínicos de interesse (Condições pré-existentes, sintomas atuais) , além da idade, os atributos completos requeridos são as patologias existentes com hipertensão, diabetes, asma e/ou câncer. Além de sintomas como tosse, coriza, falta de ar e dor de cabeça e sinais como a temperatura e frequência cardíaca. Informações importantes que descrevem comorbidades que compõe o grupo de risco do COVID-19, assim como sintomas relacionados à doença e sinais vitais que possam ser avaliados pelo usuário da aplicação.


Após alimentado estes atributos o usuário envia estes dados a nosso servidor, onde estes são processados por um modelo de aprendizado de máquina em árvore de decisão. Esta retorna a probabilidade de que o usuário esteja em cada uma das faixas determinadas pelo Protocolo de Manchester. Através dos dados fornecidos, é possível classificar cada usuário em cores - azul, verde, amarelo, laranja e vermelho - determinando a urgência da consulta e tempo de espera para bom funcionamento do serviço de atendimentos de saúde.
Tendo esta informação e a localização do usuário, informação obtida requerendo permissão de localização do usuário já implementada, Apresentamos então a lista de todas as upas da região com o tempo de espera na categoria (s) que o usuário foi alocado, e este pode então demarcar quais que ele teria interesse de se deslocar, retornamos um mapa então na quarta aba que permite o usuário ver sua localização e de todas as upas que ele estaria disposto a se deslocar, dado que já sabe o tempo de espera para ser atendido ao ir nestas. 
 
A seguir vemos algumas imagens da aplicação funcionando no celular. Esta é responsiva e se adapta a tablets e computadores também.


##Interface Mobile

![](https://imgur.com/bNMxH3q.jpg)

![](https://imgur.com/W0FRfu7.jpg)


##Arvore de Decisão


![](https://imgur.com/XHz8Qc7.jpg)


## Interface Mobile (Prototipo)

A seguir alguns exemplos da versão nativa da aplicação

![](https://imgur.com/MyI0RwQ.jpg)

![](https://imgur.com/EJ9ey4s.jpg)




 