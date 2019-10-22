#!/bin/bash

#Declaração da Função do Menu!
function menuEscolha {

echo '####################################'
echo '                                    '
echo '       Inicializador do Xampp!      '
echo '                                    '
echo '####################################'
echo ''

echo 'Desejas abrir o Dashboard?'
echo '1. Sim'
echo '2. Não'
read option

xamppStart #Chamada Da Função!

}


#Declaração da Função que irá Iniciar o Xampp!
function xamppStart {

if   [ $option -eq 1 ]
then
    echo ''
    sudo /opt/lampp/manager-linux-x64.run
    sleep 1
    exit

elif [ $option -eq 2 ]
then
    echo ''
    sudo /opt/lampp/lampp start -f
    sleep 2
    exit

elif [ $option -ne 1 ]
then
    echo ''
    echo 'Opção Inválida!'
    sleep 1
    clear
    
    menuEscolha

fi
}

menuEscolha #Chamada Da Função abaixo!
