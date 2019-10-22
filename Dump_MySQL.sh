#!/bin/bash

#mysqldump -h 127.0.0.1 -u root -p bd_estudo>bd_estudo.sql

echo "########################################"
echo "         EXPORTAR BANCO DE DADOS        "
echo "                  MYSQL                 "
echo "########################################"
echo ""

echo "1. Digite o nome do Banco que desejas exportar: " 
read nome_bd
echo ""

echo "2. Digite o nome do Arquivo de exportação que deseja criar: "
read nome_arquivo
echo ""

echo "3. Digite sua senha de root do MySQL: "
mysqldump -h 127.0.0.1 -u root -p $nome_bd>$nome_arquivo

echo ""
echo "Exportação Concluída com Sucesso!"


sleep 2
exit
