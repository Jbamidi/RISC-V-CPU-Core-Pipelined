# 🧠 RISC-V CPU Core (RV32I) — Single-Cycle + 5-Stage Pipeline

This repository contains a **32-bit RISC-V CPU** written in **SystemVerilog**, including:

- A **single-cycle RV32I core**
- A fully working **5-stage pipelined RV32I core**  
  (with forwarding, hazard detection, and branch/JAL/JALR flushing)

The full design is modular, easy to understand, and ready for FPGA extension.

---

## ⚙️ Overview

| Feature | Description |
|--------|-------------|
| **ISA** | RISC-V RV32I |
| **Architectures** | Single-cycle + Pipelined |
| **Pipeline Stages** | IF → ID → EX → MEM → WB |
| **Hazards** | Forwarding, load-use stall, branch flush |
| **Language** | SystemVerilog |
| **Simulation** | EDA Playground or any SV simulator |
| **Memories** | 1 KB IMEM + 1 KB DMEM |
| **Registers** | 32 × 32-bit, x0 hardwired to 0 |

---

## 🧩 Module Breakdown

### Core & Datapath

| Module | Purpose |
|--------|---------|
| `cpu_top_singlecycle.sv` | Single-cycle CPU |
| `cpu_top_pipeline.sv` | 5-stage pipelined CPU |
| `pc_counter.sv` | Program Counter w/ enable |
| `pc_next.sv` | Sequential, branch, JAL, JALR PC logic |
| `imem.sv` | Instruction memory |
| `dmem.sv` | Data memory |
| `regfile.sv` | 32-register file |
| `ALU.sv` | Arithmetic/logic |
| `ALU_Control.sv` | Selects ALU operation |
| `control_unit.sv` | Datapath control signals |
| `imm_gen.sv` | Immediate generator |

### Pipeline Registers

| Module | Purpose |
|--------|---------|
| `if_id_reg.sv` | IF/ID register |
| `id_ex_reg.sv` | ID/EX register |
| `ex_mem_reg.sv` | EX/MEM register |
| `mem_wb_reg.sv` | MEM/WB register |

### Hazard Logic

| Module | Purpose |
|--------|---------|
| `hazard_detection.sv` | Detects load-use hazard, stalls IF/ID, flushes ID/EX |
| `forwarding_unit.sv` | EX forwarding from MEM/WB |

---

## 🧾 Example Program (`imem_data.hex`)

```text
00500093   // addi x1, x0, 5
00A00113   // addi x2, x0, 10
002081B3   // add  x3, x1, x2
```
## 🧠 Supported Instructions

| Category   | Example                                           | Description                     |
|------------|---------------------------------------------------|---------------------------------|
| **R-Type** | ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU | Register arithmetic             |
| **I-Type** | ADDI, ANDI, ORI, XORI, SLTI, SLTIU, SLLI, SRLI, SRAI | Immediate arithmetic        |
| **Load/Store** | LW, SW                                       | Memory access                   |
| **Branch** | BEQ, BNE, BLT, BGE, BLTU, BGEU                    | Conditional branches            |
| **Jump**   | JAL, JALR                                         | Jump + link                     |
| **U-Type** | LUI, AUIPC                                        | Upper immediates                |

## 🛠️ Simulation & Synthesis Setup (Vivado)

1. **Create a New Vivado Project**
   - Open **Vivado**
   - Select **Create New Project**
   - Choose **RTL Project**
   - Check **“Do not specify sources at this time”**
   - Select your FPGA board or target device  
     *(e.g., xc7a35t-1cpg236 for Arty A7)*

2. **Add All Source Files**
   - Add every `*.sv` file:
     - `cpu_top_singlecycle.sv`
     - `cpu_top_pipeline.sv`
     - All datapath, control, memory, hazard, and pipeline register modules
   - Add `imem_data.hex` to the project as a memory initialization file

3. **Enable SystemVerilog Support**
   - In **Project Settings → Simulation**
   - Set **xsim.xelab.more_options** to:
     ```
     -sv
     ```

4. **Set the Top Module**
   Choose one:
   - `cpu_top_singlecycle`  
     **or**
   - `cpu_top_pipeline`

5. **Create a Testbench**
   - Add a new file `tb.sv`
   - Example template:
     ```systemverilog
     module tb;
       logic clk = 0;
       logic reset = 1;

       cpu_top_pipeline dut (
         .clk(clk),
         .reset(reset),
         .pc(),
         .op_instr(),
         .ALU_res(),
         .reg_write_data(),
         .reg_write_addr(),
         .reg_debug()
       );

       always #5 clk = ~clk;

       initial begin
         #10 reset = 0;
         #1000 $finish;
       end
     endmodule
     ```

6. **Run Simulation**
   - Go to **Flow → Run Simulation → Run Behavioral Simulation**
   - View waveforms:
     - `pc`
     - `instr_out`
     - `ALU_res`
     - `reg_write_data`
     - `branch_taken`, `forwardA`, `forwardB`, etc.

7. **(Optional) Synthesize for FPGA**
   - Go to **Flow → Run Synthesis**
   - Fix timing or LUT usage as needed
   - Run **Implementation**
   - Generate **bitstream**
   - Program board using **Hardware Manager**

8. **(Optional) Load Custom Programs**
   - Modify `imem_data.hex`
   - Right-click → **Reload Source**
   - Re-run simulation or synthesis


## 🎨 Design Highlights

- Forwarding for ALU RAW hazards  
- Load-use hazard stall detection  
- Branch + JAL/JALR flush support  
- Modular and clean datapath  
- Harvard architecture (IMEM + DMEM)  
- No combinational loops or unintended latches  
- Separate pipeline registers for each stage  

## 🧭 Future Extensions

- ✔️ RV32I Single-cycle implementation  
- ✔️ 5-stage pipelined implementation  
- ✔️ Full forwarding + hazard detection  
- ✔️ Branch/JAL/JALR flush  
- ⬜ CSR + ECALL  
- ⬜ Simple instruction/data cache  
- ⬜ Static or dynamic branch predictor  
- ⬜ Memory-mapped UART/GPIO  
- ⬜ FPGA synthesis & timing closure  
- ⬜ Comprehensive instruction tests  
- ⬜ Block diagrams & documentation  
