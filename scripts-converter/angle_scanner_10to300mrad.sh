#! /bin/bash
# Copyright 2010, 2011, 2012, 2013, 2014 Stefano Sinigardi
# The program is distributed under the terms of the GNU General Public License 
# This file is part of "Propaga_converter".
# Propaga_converter is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# Propaga_converter is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with Propaga_converter.  If not, see <http://www.gnu.org/licenses/>.
######################################################
# Per evitare che la parte finale (dove avvengono degli rm) crei
# confusioni spiacevoli, e' opportuno definire gli angoli sempre
# con TRE CIFRE, quindi invece di 0 mrad scrivere 000 e invece di
# 27 scrivere 027. A causa di cio', non e' possibile usare angoli
# superiori ai 999 mrad
######################################################
FILE=Prpout10_switchXZ_READY.ascii
FILE_BASENAME=Prpout10
GNUPLOT_SCRIPT_ENERGY=gnuplot_energy_logscale_publication.plt
GNUPLOT_SCRIPT_ANGLE=gnuplot_angle_logscale_publication.plt
CONVERTER_EXEC=/sto2/stefano/converter/converter
declare -a APERTURE_DA_CANCELLARE
declare -a ANGOLI_DA_CANCELLARE
ANGOLI_MINIMI_DA_CANCELLARE=(100)
ANGOLI_MASSIMI_DA_CANCELLARE=(200 300 500)
CANCELLA_ANCHE_DOTENERGY_E_DOTANGLE=1
NUMBER_OF_PROTONS_PER_MACROPARTICLE=6977
######################################################
#DO NOT TOUCH FROM HERE
######################################################
touch ${FILE_BASENAME}_ANGLE_STATS.ppg
FILE_STATS=${FILE_BASENAME}_ANGLE_STATS.ppg
C_VALUE=29979245800
MODE_AUTO=1
MODE_SELECT_IN_ENERGY=5
MODE_SELECT_IN_ANGLE=20
MODE_CONVERT_BETA_TO_ENERGY=11
MODE_CONVERT_BETA_TO_ANGLE=18
MODE_BIN_4COLS=21
BINNED_COLUMN=4
NUMBER_OF_BINS=100
######################################################
ANGOLO_MINIMO=000
ANGOLO_MASSIMO=010
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_SELECT_IN_ANGLE} $FILE $ANGOLO_MINIMO $ANGOLO_MASSIMO
mv conv.$FILE      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ANGLE} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS} ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ANGLE}
mv da_plottare.ppg             ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.ppg
mv distribuzione_angolare.eps  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.eps
#
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ENERGY} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS}  ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ENERGY}
mv da_plottare.ppg  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.ppg
mv spettro.eps      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.eps
#
echo -e "Nella porzione di cono tra $ANGOLO_MINIMO mrad e $ANGOLO_MASSIMO mrad il numero di particelle e':" >> ${FILE_STATS}
wc -l ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg >> ${FILE_STATS}
echo -e "\n" >> ${FILE_STATS}
######################################################
ANGOLO_MINIMO=000
ANGOLO_MASSIMO=020
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_SELECT_IN_ANGLE} $FILE $ANGOLO_MINIMO $ANGOLO_MASSIMO
mv conv.$FILE      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ANGLE} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS} ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ANGLE}
mv da_plottare.ppg             ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.ppg
mv distribuzione_angolare.eps  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.eps
#
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ENERGY} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS}  ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ENERGY}
mv da_plottare.ppg  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.ppg
mv spettro.eps      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.eps
#
echo -e "Nella porzione di cono tra $ANGOLO_MINIMO mrad e $ANGOLO_MASSIMO mrad il numero di particelle e':" >> ${FILE_STATS}
wc -l ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg >> ${FILE_STATS}
echo -e "\n" >> ${FILE_STATS}
######################################################
ANGOLO_MINIMO=000
ANGOLO_MASSIMO=050
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_SELECT_IN_ANGLE} $FILE $ANGOLO_MINIMO $ANGOLO_MASSIMO
mv conv.$FILE      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ANGLE} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS} ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ANGLE}
mv da_plottare.ppg             ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.ppg
mv distribuzione_angolare.eps  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.eps
#
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ENERGY} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS}  ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ENERGY}
mv da_plottare.ppg  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.ppg
mv spettro.eps      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.eps
#
echo -e "Nella porzione di cono tra $ANGOLO_MINIMO mrad e $ANGOLO_MASSIMO mrad il numero di particelle e':" >> ${FILE_STATS}
wc -l ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg >> ${FILE_STATS}
echo -e "\n" >> ${FILE_STATS}
######################################################
ANGOLO_MINIMO=000
ANGOLO_MASSIMO=100
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_SELECT_IN_ANGLE} $FILE $ANGOLO_MINIMO $ANGOLO_MASSIMO
mv conv.$FILE      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ANGLE} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS} ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ANGLE}
mv da_plottare.ppg             ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.ppg
mv distribuzione_angolare.eps  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.eps
#
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ENERGY} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS}  ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ENERGY}
mv da_plottare.ppg  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.ppg
mv spettro.eps      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.eps
#
echo -e "Nella porzione di cono tra $ANGOLO_MINIMO mrad e $ANGOLO_MASSIMO mrad il numero di particelle e':" >> ${FILE_STATS}
wc -l ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg >> ${FILE_STATS}
echo -e "\n" >> ${FILE_STATS}
######################################################
ANGOLO_MINIMO=000
ANGOLO_MASSIMO=200
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_SELECT_IN_ANGLE} $FILE $ANGOLO_MINIMO $ANGOLO_MASSIMO
mv conv.$FILE      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ANGLE} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS} ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ANGLE}
mv da_plottare.ppg             ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.ppg
mv distribuzione_angolare.eps  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.eps
#
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ENERGY} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS}  ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ENERGY}
mv da_plottare.ppg  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.ppg
mv spettro.eps      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.eps
#
echo -e "Nella porzione di cono tra $ANGOLO_MINIMO mrad e $ANGOLO_MASSIMO mrad il numero di particelle e':" >> ${FILE_STATS}
wc -l ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg >> ${FILE_STATS}
echo -e "\n" >> ${FILE_STATS}
######################################################
ANGOLO_MINIMO=000
ANGOLO_MASSIMO=300
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_SELECT_IN_ANGLE} $FILE $ANGOLO_MINIMO $ANGOLO_MASSIMO
mv conv.$FILE      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ANGLE} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS} ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ANGLE}
mv da_plottare.ppg             ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.ppg
mv distribuzione_angolare.eps  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.eps
#
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ENERGY} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS}  ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ENERGY}
mv da_plottare.ppg  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.ppg
mv spettro.eps      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.eps
#
echo -e "Nella porzione di cono tra $ANGOLO_MINIMO mrad e $ANGOLO_MASSIMO mrad il numero di particelle e':" >> ${FILE_STATS}
wc -l ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg >> ${FILE_STATS}
echo -e "\n" >> ${FILE_STATS}
######################################################
ANGOLO_MINIMO=100
ANGOLO_MASSIMO=150
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_SELECT_IN_ANGLE} $FILE $ANGOLO_MINIMO $ANGOLO_MASSIMO
mv conv.$FILE      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ANGLE} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS} ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ANGLE}
mv da_plottare.ppg             ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.ppg
mv distribuzione_angolare.eps  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.eps
#
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ENERGY} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS}  ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ENERGY}
mv da_plottare.ppg  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.ppg
mv spettro.eps      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.eps
#
echo -e "Nella porzione di cono tra $ANGOLO_MINIMO mrad e $ANGOLO_MASSIMO mrad il numero di particelle e':" >> ${FILE_STATS}
wc -l ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg >> ${FILE_STATS}
echo -e "\n" >> ${FILE_STATS}
######################################################
ANGOLO_MINIMO=100
ANGOLO_MASSIMO=200
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_SELECT_IN_ANGLE} $FILE $ANGOLO_MINIMO $ANGOLO_MASSIMO
mv conv.$FILE      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ANGLE} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS} ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ANGLE}
mv da_plottare.ppg             ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.ppg
mv distribuzione_angolare.eps  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.eps
#
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ENERGY} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS}  ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ENERGY}
mv da_plottare.ppg  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.ppg
mv spettro.eps      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.eps
#
echo -e "Nella porzione di cono tra $ANGOLO_MINIMO mrad e $ANGOLO_MASSIMO mrad il numero di particelle e':" >> ${FILE_STATS}
wc -l ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg >> ${FILE_STATS}
echo -e "\n" >> ${FILE_STATS}
######################################################
ANGOLO_MINIMO=100
ANGOLO_MASSIMO=300
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_SELECT_IN_ANGLE} $FILE $ANGOLO_MINIMO $ANGOLO_MASSIMO
mv conv.$FILE      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ANGLE} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS} ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ANGLE}
mv da_plottare.ppg             ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.ppg
mv distribuzione_angolare.eps  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ANGLE.binned.eps
#
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_CONVERT_BETA_TO_ENERGY} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg
${CONVERTER_EXEC} ${MODE_AUTO} ${C_VALUE} ${MODE_BIN_4COLS} ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg ${BINNED_COLUMN} ${NUMBER_OF_BINS}  ${NUMBER_OF_PROTONS_PER_MACROPARTICLE}
mv conv.${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.ppg da_plottare.ppg
gnuplot ${GNUPLOT_SCRIPT_ENERGY}
mv da_plottare.ppg  ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.ppg
mv spettro.eps      ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ENERGY.binned.eps
#
echo -e "Nella porzione di cono tra $ANGOLO_MINIMO mrad e $ANGOLO_MASSIMO mrad il numero di particelle e':" >> ${FILE_STATS}
wc -l ${FILE_BASENAME}_ANGLESEL_${ANGOLO_MINIMO}mrad_${ANGOLO_MASSIMO}mrad.ppg >> ${FILE_STATS}
echo -e "\n" >> ${FILE_STATS}
#######################################################
#Rimozione tagli angolo minimo non da conservare
#######################################################
for (( $((i=0)) ; $((i<${#ANGOLI_MINIMI_DA_CANCELLARE[*]})) ; $((i=i+1)) )) ; do rm ${FILE_BASENAME}_ANGLESEL_${ANGOLI_MINIMI_DA_CANCELLARE[i]}mrad_???mrad.ppg ; done
if (($CANCELLA_ANCHE_DOTENERGY_E_DOTANGLE==1)) ; then for (( $((i=0)) ; $((i<${#ANGOLI_MINIMI_DA_CANCELLARE[*]})) ; $((i=i+1)) )) ; do rm ${FILE_BASENAME}_ANGLESEL_${ANGOLI_MINIMI_DA_CANCELLARE[i]}mrad_???mrad.*.ppg ; done; fi
#######################################################
#Rimozione tagli angolo massimo non da conservare
#######################################################
for (( $((i=0)) ; $((i<${#ANGOLI_MASSIMI_DA_CANCELLARE[*]})) ; $((i=i+1)) )) ; do rm ${FILE_BASENAME}_ANGLESEL_???mrad_${ANGOLI_MASSIMI_DA_CANCELLARE[i]}mrad.ppg ; done
if (($CANCELLA_ANCHE_DOTENERGY_E_DOTANGLE==1)) ; then for (( $((i=0)) ; $((i<${#ANGOLI_MASSIMI_DA_CANCELLARE[*]})) ; $((i=i+1)) )) ; do rm ${FILE_BASENAME}_ANGLESEL_???mrad_${ANGOLI_MASSIMI_DA_CANCELLARE[i]}mrad.*.ppg ; done; fi
#######################################################