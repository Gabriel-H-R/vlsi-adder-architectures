#!/bin/bash

# ============================================================================
# Script de execução rápida para Xcelium (xrun)
# Uso: ./run_sim.sh [nome_do_teste] [seed] [gui]
# ============================================================================

# Valores Padrão
TESTNAME="adder_test"
SEED="random"
GUI_MODE=""

# Processamento de Argumentos Básicos
if [ "$1" != "" ]; then
    TESTNAME=$1
fi

if [ "$2" != "" ]; then
    SEED=$2
fi

if [ "$3" == "gui" ]; then
    GUI_MODE="-gui"
fi

echo "=========================================================="
echo " Iniciando Simulação UVM"
echo " Teste: $TESTNAME"
echo " Seed:  $SEED"
echo "=========================================================="

# Comando Xcelium
xrun \
    -sv \
    -uvmhome CDNS-1.2 \
    -access +rwc \
    -cov_cg -coverage all \
    -incdir ../tb/uvm_components \
    -incdir ../tb/tests \
    ../rtl/*.v \
    ../tb/uvm_components/adder_pkg.sv \
    ../tb/uvm_components/adder_if.sv \
    ../tb/tests/tb_top.sv \
    +UVM_TESTNAME=$TESTNAME \
    -svseed $SEED \
    $GUI_MODE

# Verifica se a simulação passou ou falhou e retorna o status
if [ $? -eq 0 ]; then
    echo -e "\n[\033[0;32mSUCESSO\033[0m] Simulação finalizada sem erros críticos de compilação."
else
    echo -e "\n[\033[0;31mFALHA\033[0m] A simulação foi abortada devido a erros."
fi