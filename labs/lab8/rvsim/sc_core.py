# Copyright 2021-2022 Zhijie Shi. All rights reserved. See LICENSE.txt.
import opcode
from myhdl import * 

from hardware.register import RegisterE
from hardware.memory import Ram, Rom
from hardware.mux import Mux2
from hardware.gates import And2
from hardware.alu import ALU
from hardware.adder import Adder
from hardware.registerfile import RegisterFile

from sc_signals import RISCVSignals
from immgen import ImmGen 
from maincontrol import MainControl
from alucontrol import ALUControl

@block
def     RISCVCore(imem, dmem, rf, clock, reset, env):
    """
    All signals are input

    imem:   instruction memory. A dictionary
    dmem:   data memory. A dictionary
    rf:     register file. A list of 32 integers
    clock:  clock 
    reset:  reset
    env:    additonal info, mainly for controlling print

    env.done:   asserted when simulation is done
    """

    max_pc = max(imem.keys()) 
    init_pc = min(imem.keys()) 

    # signals
    sig = RISCVSignals(init_pc)

    # TODO
    # instantiate hardware modules 
    # check the diagram, make sure nothing is missing
    # and signals are connected correctly
    # 

    # for example, PC register is instantiated with the following line
    regPC = RegisterE(sig.PC, sig.NextPC, sig.signal1, clock, reset)

    IM = Rom(sig.instruction, sig.PC, imem)
    maincontrol = MainControl(sig.opcode, sig.ALUOp, sig.ALUSrc, sig.Branch, sig.MemRead, sig.MemWrite, sig.MemtoReg, sig.RegWrite)
    regf = RegisterFile(sig.ReadData1, sig.ReadData2, sig.rs1, sig.rs2, sig.rd, sig.WriteData, sig.RegWrite, rf, clock)
    immgen = ImmGen(sig.immediate, sig.instruction)
    aluctrl = ALUControl(sig.ALUOp, sig.instr30, sig.funct3, sig.ALUOperation)
    mux1 = Mux2(sig.ALUInput2, sig.ReadData2, sig.immediate, sig.ALUSrc)
    alu = ALU(sig.ALUResult, sig.Zero, sig.ReadData1, sig.ALUInput2, sig.ALUOperation)
    datamem = Ram(sig.MemReadData ,sig.ReadData2, sig.ALUResult, sig.MemRead, sig.MemWrite, dmem, clock)
    mux2 = Mux2(sig.WriteData, sig.ALUResult, sig.MemReadData, sig.MemtoReg)
    adder1 = Adder(sig.PC4, sig.PC, sig.Const4)
    adder2 = Adder(sig.BranchTarget, sig.PC, sig.immediate)
    pcsrc = And2(sig.PCSrc, sig.Branch, sig.Zero)
    mux3 = Mux2(sig.NextPC, sig.PC4, sig.BranchTarget, sig.PCSrc)


    





    ##### No need to change the following logics
    @always_comb
    def set_done():
        env.done.next = sig.PC > max_pc  

    # print at the negative edge. for simulation only 
    @always(clock.negedge)
    def print_logic():
        if env.print_enable:
            sig.print(env.cycle_number, env.print_option)

    return instances()

if __name__ == "__main__" :
    print("Error: Please start the simulation with rvsim.py")
    exit(1)
