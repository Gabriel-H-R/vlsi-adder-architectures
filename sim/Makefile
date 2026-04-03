# ============================================================================
# Makefile para Verificação UVM de Somadores (Cadence Xcelium)
# ============================================================================

# --- Variáveis de Diretório ---
RTL_DIR  = ../rtl
TB_DIR   = ../tb/uvm_components
TEST_DIR = ../tb/tests
INC_DIRS = -incdir $(TB_DIR) -incdir $(TEST_DIR)

# --- Variáveis de Arquivos ---
RTL_FILES = $(RTL_DIR)/adder_32bit.v \
            $(RTL_DIR)/brent_kung_adder32.v \
            $(RTL_DIR)/carry_look_ahead32.v \
            $(RTL_DIR)/cla_cascade432.v \
            $(RTL_DIR)/kogge_stone_adder32.v

TB_FILES  = $(TB_DIR)/adder_pkg.sv \
            $(TB_DIR)/adder_if.sv \
            $(TEST_DIR)/tb_top.sv

# --- Variáveis do Simulador (Xcelium) ---
SIM_TOOL = xrun
UVM_VER  = -uvmhome CDNS-1.2 # Usa a biblioteca UVM 1.2 nativa da Cadence
SEED     = random            # Semente aleatória para CRV
TESTNAME = adder_test        # Teste padrão a ser executado

# --- Flags de Compilação e Simulação ---
# -sv: Habilita SystemVerilog
# -access +rwc: Permite leitura/escrita/conectividade para ver formas de onda
# -cov_cg -coverage all: Habilita coleta de cobertura funcional e de código
# -errormax 15: Para a simulação após 15 erros
COMPILE_FLAGS = -sv -access +rwc $(UVM_VER) $(INC_DIRS) -cov_cg -coverage all
SIM_FLAGS     = +UVM_TESTNAME=$(TESTNAME) -svseed $(SEED) -errormax 15

# ============================================================================
# Alvos (Targets)
# ============================================================================

.PHONY: all run gui clean view_waves cov

# Alvo padrão: Compila e roda em modo texto
all: run

# Roda a simulação em modo batch (texto)
run:
	@echo "Iniciando simulação em modo batch..."
	$(SIM_TOOL) $(COMPILE_FLAGS) $(RTL_FILES) $(TB_FILES) $(SIM_FLAGS)

# Roda a simulação abrindo a interface gráfica (SimVision)
gui:
	@echo "Iniciando simulação com SimVision (GUI)..."
	$(SIM_TOOL) $(COMPILE_FLAGS) $(RTL_FILES) $(TB_FILES) $(SIM_FLAGS) -gui

# Abre os relatórios de cobertura gerados (IMC - Integrated Metrics Center)
cov:
	@echo "Abrindo relatórios de cobertura..."
	imc -exe cgmem &

# Abre visualizador de formas de onda isoladamente, se existirem
view_waves:
	@echo "Abrindo SimVision para formas de onda antigas..."
	simvision waves.shm &

# Limpa todos os artefatos de simulação gerados pela Cadence
clean:
	@echo "Limpando diretório de simulação..."
	rm -rf xcelium.d/ xrun.history xrun.log waves.shm/ cov_work/ imc.log imc.key *.vcd *.dsn *.trn