# veriBLAS

This project implements a 32‑bit sequential ALU with sixteen opcodes in Verilog (iVerilog), designed to support and accelerate linear algebra computations such as matrix multiplication, vector operations, dot products, scaling, accumulation, and reduction. <br> 

The system accepts two 32‑bit operands (A and B), a 4‑bit opcode (supporting 16 operations), and clock/control signals. The ALU produces a 32‑bit result along with status flags (Zero, Carry, Overflow, Negative, and Error). The design includes an internal 32‑bit accumulator register that enables feedback-based iterative operations required in matrix and vector computations.
