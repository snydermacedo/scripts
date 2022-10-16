#!/bin/bash

 DATAINICIAL=$(date +%d/%m/%Y)
 HORAINICIAL=$(date +%T)
 LOG=/var/log/backup_servder-`date +%Y-%m-%d_`-log

 SRC="CAMINHO DO DIRETORIO DE ORIGEM"
 DEST="CAMINHO DO DIRETORIO DE DESTINO"

 echo " " >> $LOG
 echo " " >> $LOG
 echo "| ------ ------ ------ ------ ------ ------ -----------"  >> $LOG
 echo "  Sincronizacao iniciada em $DATAINICIAL - $HORAINICIAL" >> $LOG
 echo "  Origem:  $SRC" >> $LOG
 echo "  Destino: $DEST" >> $LOG
 echo " " >> $LOG
 echo " " >> $LOG

 rsync -abvh $SRC $DEST >> $LOG

 MD5SRC=$(find $SRC -type f -exec md5sum {} + | LC_ALL=C sort | md5sum)
 # MD5DEST=$(find $DEST -type f -exec md5sum {} + | LC_ALL=C sort | md5sum)
 DATAFINAL=$(date +%d/%m/%Y)
 HORAFINAL=$(date +%T)

 echo " " >> $LOG
 echo " " >> $LOG
 echo "  Sincronização Feita com Sucesso!!!"  >> $LOG

 echo " " >> $LOG
 HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
 HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
 TEMPO=$(date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S")
 echo "  Tempo gasto para execução do script $TEMPO"  >> $LOG

 echo " " >> $LOG
 echo "  Checksum da pasta de Origem: $MD5SRC" >> $LOG
 # echo "  Checksum da pasta de Destino: $MD5DEST" >> $LOG

 echo " " >> $LOG
 echo "  Sincronizacao Finalizada em $DATAFINAL - $HORAFINAL" >> $LOG
 echo "| ------ ------ ------ ------ ------ ------ -----------"  >> $LOG
 echo " " >> $LOG
