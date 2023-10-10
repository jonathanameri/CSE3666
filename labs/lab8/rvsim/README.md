# RISC-V Simulator

## Files

The files under the root directory of the projects are the following.

```
rvsim.py	The main file. We start the simulator with this file.

utilities.py	Help functions.

sc_signals.py	A class that has all signals in the single-cycle processor.

sc_core.py	The processor core. To be completed.

maincontro.py	The main control.

immgen.py	The ImmGen module.

alucontrol.py	The ALU Control module.

README.md	This file.

LICENSE.txt	License information. 
```

The files in `hardware` directory are hardware modules, including basic
gates, MUX, adder, ALU, register, register file, and memory. 

We can use pydoc module to read the docstrings in Python files. For example, 

```
py -m pydoc hardware/gates.py
py -m pydoc hardware/alu.py
py -m pydoc sc_signals.py

```

If pydoc does not work for some files, read the comments in a text editor.

## Running the simulator

The simulator starts with `rvsim.py`. It accepts a few arguments from the
command line. 

* `-h`: display the help message.

* `<program>`: specify the program to run on the simulator. For example, 

   ```
   py rvsim.py input\fib.txt

   or 

   python rvsim.py input/fib.txt
   ```

* `-a <num>`: set the argument registers before the simulation starts. For
  example, `-a 100` sets register `a0` to 10. `-a 100 200` sets `a0` to 100
  and `a1` to 200.

* `-n <num>`: specify the number of cycles to simulate. Without the option, 
  the simulator runs until PC is larger than the largest address in the
  instruction memory. 

*   `-s <start>` and `-e <end>`. These two options specify in which cycle the
    simulator starts to print signal values and in which cycle printing stops.
    By default, printing starts in cycle 0. 

    These two options help us focus on signal values in particular cycles. We can
    also suppress printing to make the simulator run faster on large programs.  For
    example, with `-e 0`, the simulator does not print signal values because
    printing stops at cycle 0.

## Test programs

A few test programs are in input directory. The expected output are in output directory.
The description of test programs are in [testprog.md](testprog.md).

### Initial values in registers

Except for x2 (sp) and x3 (gp), all other registers are initialized to their
register number. For example, 1 in x1, 4 in x4, and so on. x2 (sp) is the
address of the word at the top of the stack. x3 (gp) is the starting address of
global data section.

Argument registers, a0, a1, and so on, can be set from the command line
arguments using the `-a` option.

### Creating your own test program

The simulator accepts dump files from RARS. For example, the following command
assembles the source code `prog.s` and saves the machine code and matching
lines in the source code to `prog.txt`. The simulator can extract the machine
code from `prog.txt`. Note that not all the instructions are supported by the
simulator.  

```
java -jar rars.jar a dump .text SegmentWindow prog.txt prog.s
```

Note that RARS may have a different filename on your computer and the program
is not `prog.s`.  

## Features and limitations

ImmGen supports I, S, and SB types. It can be (easily) extended to support U
and UJ types.

I-type instructions that have opcode 0b0010011(0x13) are similar to many R-type
instructions. Let us call them ALU I-type instructions. 

The main control does not support ALU I-type instructions. It can be extended
to support these instructions, ALUOp for these instructions should be set
to 0b11. 

ALU Control can generate proper ALU operation for most of R-type, ALU I-type,
load, store, and branch instructions. 

ALU, in hardware folder, supports shift operations required for SLL, SRL, and
SRA although the operations are performed in a separate functional unit in real
designs.  If ADD, SUB, AND, and OR are supported, the processor should be able
to execute SLL, SRL, and SRA instructions. Those with an immediate operand need
support from the main control.  

The line endings in the files are `\r\n`, the one on Windows systems.

## Why copyright notice?

We have spent a lot of time to prepare the lab and plan to use it in many
semesters to come. We restrict the dissemination of the code to give students
who take the course in the future opportunities to solve the problems
themselves.

It happened in the past that some assignments and solutions were posted in
public servers, by mistake or on purpose. It was hard to get them removed. 
A copyright infringement notice may make it easier.

