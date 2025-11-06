# 🧠 CPU Architecture Overview

This document describes the **datapath** and **control flow** of the single-cycle RISC-V CPU.

---

## 🧩 Core Design Philosophy
The CPU implements the **RISC-V RV32I** base instruction set.  
All instructions complete in **one clock cycle**. The design follows a **Harvard architecture** (separate instruction and data memory).

---

## ⚙️ Main Components
| Module | Function |
|---------|-----------|
| `pc_counter` | Holds the current program counter (PC) value. Updates on each rising clock edge. |
| `imem` | 1 KB instruction memory, read-only. Loads program from `imem_data.hex`. |
| `control_unit` | Decodes opcode and generates control signals for datapath. |
| `ALU_Control` | Determines the ALU operation using `funct3`, `funct7`, and `ALU_Op`. |
| `regfile` | 32 × 32-bit registers. x0 hardwired to zero. |
| `imm_gen` | Generates sign-extended immediate values. |
| `ALU` | Executes arithmetic, logic, shift, and comparison operations. |
| `dmem` | 1 KB data memory. Supports LW and SW. |
| `pc_next` | Calculates the next PC based on instruction type (PC+4, branch, JAL, JALR). |

---

## 🧠 Datapath Overview
The CPU executes the five classic stages **in a single clock**:
1. **Instruction Fetch (IF)** → from IMEM using PC  
2. **Instruction Decode (ID)** → Control unit & register file  
3. **Execute (EX)** → ALU performs operation  
4. **Memory Access (MEM)** → DMEM read/write (LW/SW)  
5. **Writeback (WB)** → Result written back to register file

Each stage is combinational, and all updates are latched on the clock edge.

---

## 🔗 Next Step
This design forms the foundation for a **pipelined RISC-V processor**, where each stage operates concurrently with pipeline registers.

