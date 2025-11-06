# 🧾 RISC-V Instruction Format Reference

Each 32-bit instruction is broken into standard RISC-V fields:

| Type | [31:25] | [24:20] | [19:15] | [14:12] | [11:7] | [6:0] | Description |
|------|----------|----------|----------|----------|----------|----------|
| **R-Type** | funct7 | rs2 | rs1 | funct3 | rd | opcode | Register arithmetic instructions |
| **I-Type** | imm[11:0] | — | rs1 | funct3 | rd | opcode | Immediate arithmetic and load |
| **S-Type** | imm[11:5] | rs2 | rs1 | funct3 | imm[4:0] | opcode | Store instructions |
| **B-Type** | imm[12|10:5] | rs2 | rs1 | funct3 | imm[4:1|11] | opcode | Branch instructions |
| **U-Type** | imm[31:12] | — | — | — | rd | opcode | LUI, AUIPC |
| **J-Type** | imm[20|10:1|11|19:12] | — | — | — | rd | opcode | JAL jump instruction |

---

### Example Encodings
```text
ADD   x3, x1, x2   → funct7=0000000, funct3=000, opcode=0110011
ADDI  x1, x0, 5    → imm=000000000101, opcode=0010011
SW    x1, 0(x2)    → funct3=010, opcode=0100011
BEQ   x1, x2, 8    → funct3=000, opcode=1100011
JAL   x1, 32       → opcode=1101111
