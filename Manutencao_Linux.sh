#!/bin/bash


echo "#########################################"
echo "             MANUTENÇÃO LINUX            "
echo "#########################################"

echo ""
echo "1. REMOVENDO PACOTES NÃO NECESSÁRIOS!"
sudo apt-get autoremove -s

echo ""
echo "2. REMOVENDO PACOTES OBSOLETOS!"
sudo apt-get autoclean -s

echo ""
echo "3. REMOVENDO KERNELS ANTIGOS!"
sudo apt-get autoremove --purge -s

echo ""
echo "4. ATUALIZANDO LISTA DE PACOTES!"
sudo apt-get update -s

echo ""
echo "5. ATUALIZANDO SISTEMA!"
sudo apt-get upgrade -s

echo ""
echo "Tarefa Concluida com Sucesso!"
sleep 2
exit

