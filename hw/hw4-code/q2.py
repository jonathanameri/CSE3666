from myhdl import block, always_comb, always_seq, Signal, intbv, instances

@block 
def Register(dout, din, clock, reset):
    """ 
    A register that always saves din to dout on positive edges
    """

    @always_seq(clock.posedge, reset=reset)
    def seq_reg():
        dout.next = din

    return seq_reg

# HW4Q5
@block
def Detect3x(z, b, clock, reset):
    """ 
    Input:  b
    Output: z

    b is the input bit
    z is 1 if and only if the current state is 0
    """
    # 2 bits are enough to encode 3 states
    # initial state is 0
    state = Signal(intbv(0)[2:])
    next_state = Signal(intbv(0)[2:])

    # TODO
    # instantiate a register here.
    # next_state is the input and stat is the output

    # generate next_state, based on state and b
    @always_comb
    def next_state_logic():
        # TODO
        # We can use if-elif-else statements in Python
        # next_state.next = ... 
        pass

    # generate output
    @always_comb
    def z_logic():
        # TODO
        # generate z from state
        pass

    # return all logic  
    return instances()

if __name__ == "__main__":
    from myhdl import delay, instance, ResetSignal, always, StopSimulation
    import argparse, re

    # testbench itself is a block
    @block
    def test_comb(args):

        # reset signal level
        ACTIVE_LOW, INACTIVE_HIGH = 0, 1
        # create reset signal
        reset = ResetSignal(0, active=ACTIVE_LOW, isasync=True)

        HALF_PERIOD = delay(10)
        # create clock signal
        clock  = Signal(bool(1))

        # driving the clock
        @always(HALF_PERIOD)
        def clockGen():
            clock.next = not clock

        # create signals
        b, z = [Signal(bool(0)) for i in range(2)]

        # instantiating a block and connect to signals
        tut = Detect3x(z, b, clock, reset)

        @instance
        def stimulus():
            # release reset after a short delay
            yield delay(1)
            reset.next = INACTIVE_HIGH
            yield clock.negedge

            # v is only for debugging
            v = 0
            print("b | z v")
            for s in args.bits:
                # set b's value, after the negative edge
                b.next = s == '1'
                v = (v << 1) | (s == '1')
                # wait a little bit
                # here we wait for clock's negative edge
                yield clock.negedge
                print("{} | {} {}".format(int(b), int(z), v))

            raise StopSimulation()

        return tut, clockGen, stimulus

    parser = argparse.ArgumentParser(description='A state machine detecting 3x')
    parser.add_argument('bits', nargs='?', default="1001", help='bits to be shifted in')
    parser.add_argument('--trace', action='store_true', help='generate trace file')

    args = parser.parse_args()

    if not re.match(r"[01]+$", args.bits):
        print("Error: bits can only be 0 or 1")
        exit(1)

    tb = test_comb(args)
    tb.config_sim(trace=args.trace)
    tb.run_sim()
