import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas
import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Register.Lemmas

namespace HandshakeStream

/-!
  # Fork

  `fork` replicates the content of an input stream and dispatches it to two channels.
  At the handshake level, `fork` operates on the `Stream' (Option α)` type (i.e., `Stream`).

  We insert buffers in the handshake program and lower it to rtl level, considering all the
  buffer configurations CIRCT inserts.

  The hardware (lowered) module is a function over the `Stream'` type,
  which does not contain `Option` values, because at this level
  of abstractions the content of streams has been concretized.

  See: https://github.com/opencompl/DC-semantics-simulation-evaluation/tree/bf86f7247a767d97516a05a29e313634e5172398/benchmarks/fork

-/

/--
  Handshake program after buffers' insertion:

  handshake.func @test_fork(%arg0: none, %arg1: none, ...) -> (none, none, none) attributes {argNames = ["arg0", "arg1"], resNames = ["out0", "out1", "out2"]} {
    %0 = buffer [2] seq %arg1 : none
    %1 = buffer [2] seq %arg0 : none
    %2:2 = fork [2] %1 : none
    %3 = buffer [2] seq %2#1 : none
    %4 = buffer [2] seq %2#0 : none
    return %4, %3, %0 : none, none, none
  }
-/
def fork_handshake (arg : Stream (BitVec 1)) :=
  corec_prod arg
    fun x => Id.run <| do
      let x0 := x 0
      let x' := x.tail
      (x0, x0, x')

/--
  First RTL Program

  hw.module @handshake_buffer_2slots_seq_1ins_1outs_ctrl(in %in0 : i0, in %in0_valid : i1, in %clock : !seq.clock, in %reset : i1, in %out0_ready : i1, out in0_ready : i1, out out0 : i0, out out0_valid : i1) {
    %true = hw.constant true
    %false = hw.constant false
    %c0_i0 = hw.constant 0 : i0
    %valid0_reg = seq.compreg sym @valid0_reg %2, %clock reset %reset, %false : i1
    %0 = comb.xor %valid0_reg, %true : i1
    %1 = comb.or %0, %5 : i1
    %2 = comb.mux %1, %in0_valid, %valid0_reg : i1
    %3 = comb.mux %1, %in0, %data0_reg : i0
    %data0_reg = seq.compreg sym @data0_reg %3, %clock reset %reset, %c0_i0 : i0
    %ready0_reg = seq.compreg sym @ready0_reg %11, %clock reset %reset, %false : i1
    %4 = comb.mux %ready0_reg, %ready0_reg, %valid0_reg : i1
    %5 = comb.xor %ready0_reg, %true : i1
    %6 = comb.xor %16, %true : i1
    %7 = comb.and %6, %5 : i1
    %8 = comb.mux %7, %valid0_reg, %ready0_reg : i1
    %9 = comb.and %16, %ready0_reg : i1
    %10 = comb.xor %9, %true : i1
    %11 = comb.and %10, %8 : i1
    %ctrl_data0_reg = seq.compreg sym @ctrl_data0_reg %14, %clock reset %reset, %c0_i0 : i0
    %12 = comb.mux %ready0_reg, %ctrl_data0_reg, %data0_reg : i0
    %13 = comb.mux %7, %data0_reg, %ctrl_data0_reg : i0
    %14 = comb.mux %9, %c0_i0, %13 : i0
    %valid1_reg = seq.compreg sym @valid1_reg %17, %clock reset %reset, %false : i1
    %15 = comb.xor %valid1_reg, %true : i1
    %16 = comb.or %15, %20 : i1
    %17 = comb.mux %16, %4, %valid1_reg : i1
    %18 = comb.mux %16, %12, %data1_reg : i0
    %data1_reg = seq.compreg sym @data1_reg %18, %clock reset %reset, %c0_i0 : i0
    %ready1_reg = seq.compreg sym @ready1_reg %26, %clock reset %reset, %false : i1
    %19 = comb.mux %ready1_reg, %ready1_reg, %valid1_reg : i1
    %20 = comb.xor %ready1_reg, %true : i1
    %21 = comb.xor %out0_ready, %true : i1
    %22 = comb.and %21, %20 : i1
    %23 = comb.mux %22, %valid1_reg, %ready1_reg : i1
    %24 = comb.and %out0_ready, %ready1_reg : i1
    %25 = comb.xor %24, %true : i1
    %26 = comb.and %25, %23 : i1
    %ctrl_data1_reg = seq.compreg sym @ctrl_data1_reg %29, %clock reset %reset, %c0_i0 : i0
    %27 = comb.mux %ready1_reg, %ctrl_data1_reg, %data1_reg : i0
    %28 = comb.mux %22, %data1_reg, %ctrl_data1_reg : i0
    %29 = comb.mux %24, %c0_i0, %28 : i0
    hw.output %1, %27, %19 : i1, i0, i1
-/
def handshake_buffer_2slots_seq_1ins_1outs_ctrl
      (inp : wiresStruc 1 2 1)
      (regs : wiresStruc 0 8 1)
  : wiresStruc 1 10 1 :=
    -- inputs
    let in0 := inp.result[0]
    let in0_valid := inp.signals[0]
    let out0_ready := inp.signals[1]
    -- registers
    let valid0_reg := regs.signals[0]
    let data0_reg := regs.signals[1]
    let ready0_reg := regs.signals[2]
    let ctrl_data0_reg := regs.signals[3]
    let valid1_reg := regs.signals[4]
    let data1_reg := regs.signals[5]
    let ready1_reg := regs.signals[6]
    let ctrl_data1_reg := regs.signals[7]
    -- circuit
    let v20 := ready1_reg ^^^ 1#1
    let v15 := valid1_reg ^^^ 1#1
    let v16 := v15 ||| v20
    let v5 := ready0_reg ^^^ 1#1
    let v0 := valid0_reg ^^^ 1#1
    let v1 := v0 ||| v5
    let v2 := if v1.msb then in0_valid else valid0_reg
    let v3 := if v1.msb then in0 else data0_reg
    let v4 := if ready0_reg.msb then ready0_reg else valid0_reg
    let v6 := v16 ^^^ 1#1
    let v7 := v6 &&& v5
    let v8 := if v7.msb then valid0_reg else ready0_reg
    let v9 := v16 &&& ready0_reg
    let v10 := v9 ^^^ 1#1
    let v11 := v10 &&& v8
    let v12 := if ready0_reg.msb then ctrl_data0_reg else data0_reg
    let v13 := if v7.msb then data0_reg else ctrl_data0_reg
    let v14 := if v9.msb then 0#1 else v13
    let v17 := if v16.msb then v4 else valid1_reg
    let v18 := if v16.msb then v12 else data1_reg
    let v19 := if ready1_reg.msb then ready1_reg else valid1_reg
    let v21 := out0_ready ^^^ 1#1
    let v22 := v21 &&& v20
    let v23 := if v22.msb then valid1_reg else ready1_reg
    let v24 := inp.signals[1] &&& regs.signals[6]
    let v25 := v24 ^^^ 1#1
    let v26 := v25 &&& v23
    let v27 := if ready1_reg.msb then ctrl_data1_reg else data1_reg
    let v28 := if v22.msb then data1_reg else ctrl_data1_reg
    let v29 := if v24.msb then 0#1 else v28
    let valid0_reg := v2
    let data0_reg := v3
    let ready0_reg := v11
    let ctrl_data0_reg := v14
    let valid1_reg := v17
    let data1_reg := v18
    let ready1_reg := v26
    let ctrl_data1_reg := v29
    {result := #v[v27], signals := #v[v1, v19,
                                  valid0_reg, data0_reg, ready0_reg, ctrl_data0_reg,
                                  valid1_reg, data1_reg, ready1_reg, ctrl_data1_reg]}

/--
  Second RTL Program

  hw.module @handshake_fork_1ins_2outs_ctrl(in %in0 : i0, in %in0_valid : i1, in %clock : !seq.clock, in %reset : i1, in %out0_ready : i1, in %out1_ready : i1, out in0_ready : i1, out out0 : i0, out out0_valid : i1, out out1 : i0, out out1_valid : i1) {
    %true = hw.constant true
    %false = hw.constant false
    %0 = comb.xor %12, %true : i1
    %1 = comb.and %5, %0 : i1
    %emitted_0 = seq.compreg sym @emitted_0 %1, %clock reset %reset, %false : i1
    %2 = comb.xor %emitted_0, %true : i1
    %3 = comb.and %2, %in0_valid : i1
    %4 = comb.and %out0_ready, %3 : i1
    %5 = comb.or %4, %emitted_0 {sv.namehint = "done0"} : i1
    %6 = comb.xor %12, %true : i1
    %7 = comb.and %11, %6 : i1
    %emitted_1 = seq.compreg sym @emitted_1 %7, %clock reset %reset, %false : i1
    %8 = comb.xor %emitted_1, %true : i1
    %9 = comb.and %8, %in0_valid : i1
    %10 = comb.and %out1_ready, %9 : i1
    %11 = comb.or %10, %emitted_1 {sv.namehint = "done1"} : i1
    %12 = comb.and %5, %11 {sv.namehint = "allDone"} : i1
    hw.output %12, %in0, %3, %in0, %9 : i1, i0, i1, i0, i1
  }
-/
def handshake_fork_1ins_2outs_ctrl
    (inp : wiresStruc 1 3 1)
    (regs : wiresStruc 0 2 1)
  : wiresStruc 2 5 1 :=
    -- inputs
    let in0 := inp.result[0]
    let in0_valid := inp.signals[0]
    let out0_ready := inp.signals[1]
    let out1_ready := inp.signals[2]
    -- regs
    let reg_0 := regs.signals[0]
    let reg_1 := regs.signals[1]
    -- circuit
    let v2 := BitVec.xor reg_0 1#1
    let v3 := BitVec.and v2 in0_valid
    let v4 := BitVec.and out0_ready v3
    let v5 := BitVec.or reg_0 v4
    let v8 := BitVec.xor reg_1 1#1
    let v9 := BitVec.and v8 in0_valid
    let v10 := BitVec.and out1_ready v9
    let v11 := BitVec.or v10 reg_1
    let v12 := BitVec.and v5 v11
    let v0 := BitVec.xor v12 1#1
    let v1 := BitVec.and v5 v0
    let v6 := BitVec.xor v12 1#1
    let v7 := BitVec.and v11 v6
    let reg0 := v1
    let reg1 := v7
    {result := #v[in0, in0], signals := #v[v12, v3, v9, reg_0, reg_1]}


set_option maxHeartbeats 0
/--
  Third RTL program:

  hw.module @test_fork(in %arg0 : i0, in %arg0_valid : i1, in %arg1 : i0, in %arg1_valid : i1, in %clock : !seq.clock, in %reset : i1, in %out0_ready : i1, in %out1_ready : i1, in %out2_ready : i1, out arg0_ready : i1, out arg1_ready : i1, out out0 : i0, out out0_valid : i1, out out1 : i0, out out1_valid : i1, out out2 : i0, out out2_valid : i1) {
    %handshake_buffer0.in0_ready, %handshake_buffer0.out0, %handshake_buffer0.out0_valid = hw.instance "handshake_buffer0" @handshake_buffer_2slots_seq_1ins_1outs_ctrl(in0: %arg1: i0, in0_valid: %arg1_valid: i1, clock: %clock: !seq.clock, reset: %reset: i1, out0_ready: %out2_ready: i1) -> (in0_ready: i1, out0: i0, out0_valid: i1)
    %handshake_buffer1.in0_ready, %handshake_buffer1.out0, %handshake_buffer1.out0_valid = hw.instance "handshake_buffer1" @handshake_buffer_2slots_seq_1ins_1outs_ctrl(in0: %arg0: i0, in0_valid: %arg0_valid: i1, clock: %clock: !seq.clock, reset: %reset: i1, out0_ready: %handshake_fork0.in0_ready: i1) -> (in0_ready: i1, out0: i0, out0_valid: i1)
    %handshake_fork0.in0_ready, %handshake_fork0.out0, %handshake_fork0.out0_valid, %handshake_fork0.out1, %handshake_fork0.out1_valid = hw.instance "handshake_fork0" @handshake_fork_1ins_2outs_ctrl(in0: %handshake_buffer1.out0: i0, in0_valid: %handshake_buffer1.out0_valid: i1, clock: %clock: !seq.clock, reset: %reset: i1, out0_ready: %handshake_buffer3.in0_ready: i1, out1_ready: %handshake_buffer2.in0_ready: i1) -> (in0_ready: i1, out0: i0, out0_valid: i1, out1: i0, out1_valid: i1)
    %handshake_buffer2.in0_ready, %handshake_buffer2.out0, %handshake_buffer2.out0_valid = hw.instance "handshake_buffer2" @handshake_buffer_2slots_seq_1ins_1outs_ctrl(in0: %handshake_fork0.out1: i0, in0_valid: %handshake_fork0.out1_valid: i1, clock: %clock: !seq.clock, reset: %reset: i1, out0_ready: %out1_ready: i1) -> (in0_ready: i1, out0: i0, out0_valid: i1)
    %handshake_buffer3.in0_ready, %handshake_buffer3.out0, %handshake_buffer3.out0_valid = hw.instance "handshake_buffer3" @handshake_buffer_2slots_seq_1ins_1outs_ctrl(in0: %handshake_fork0.out0: i0, in0_valid: %handshake_fork0.out0_valid: i1, clock: %clock: !seq.clock, reset: %reset: i1, out0_ready: %out0_ready: i1) -> (in0_ready: i1, out0: i0, out0_valid: i1)
    hw.output %handshake_buffer1.in0_ready, %handshake_buffer0.in0_ready, %handshake_buffer3.out0, %handshake_buffer3.out0_valid, %handshake_buffer2.out0, %handshake_buffer2.out0_valid, %handshake_buffer0.out0, %handshake_buffer0.out0_valid : i1, i1, i0, i1, i0, i1, i0, i1
  }
-/
def fork_buffer_rtl
  (inp : Stream' (wiresStruc 2 5 1)) :
    Stream' (wiresStruc 3 5 1) :=
  register_wrapper_generalized
      (inputs := inp)
      (init_regs := {result := #v[], signals := Vector.replicate 37 (0#1)})
      (outops := 3)
      (outsigs := 5)
      (update_fun :=
        fun (inp, regs) =>
          -- inputs
          let arg0 := inp.result[0]
          let arg1 := inp.result[1]
          let arg0_valid := inp.signals[0]
          let arg1_valid := inp.signals[1]
          let out0_ready := inp.signals[2]
          let out1_ready := inp.signals[3]
          let out2_ready := inp.signals[4]
          -- regs
          let fork0_in0_ready := regs.signals[0]
          let buffer2_in0_ready := regs.signals[1]
          let buffer3_in0_ready := regs.signals[2]
          let buffer0_reg_valid0 := regs.signals[3]
          let buffer0_reg_data0 := regs.signals[4]
          let buffer0_reg_ready0 := regs.signals[5]
          let buffer0_reg_ctrl_data0 := regs.signals[6]
          let buffer0_reg_valid1 := regs.signals[7]
          let buffer0_reg_data1 := regs.signals[8]
          let buffer0_reg_ready1 := regs.signals[9]
          let buffer0_reg_ctrl_data1 := regs.signals[10]
          let buffer1_reg_valid0 := regs.signals[11]
          let buffer1_reg_data0 := regs.signals[12]
          let buffer1_reg_ready0 := regs.signals[13]
          let buffer1_reg_ctrl_data0 := regs.signals[14]
          let buffer1_reg_valid1 := regs.signals[15]
          let buffer1_reg_data1 := regs.signals[16]
          let buffer1_reg_ready1 := regs.signals[17]
          let buffer1_reg_ctrl_data1 := regs.signals[18]
          let reg_0 := regs.signals[19]
          let reg_1 := regs.signals[20]
          let buffer2_reg_valid0 := regs.signals[21]
          let buffer2_reg_data0 := regs.signals[22]
          let buffer2_reg_ready0 := regs.signals[23]
          let buffer2_reg_ctrl_data0 := regs.signals[24]
          let buffer2_reg_valid1 := regs.signals[25]
          let buffer2_reg_data1 := regs.signals[26]
          let buffer2_reg_ready1 := regs.signals[27]
          let buffer2_reg_ctrl_data1 := regs.signals[28]
          let buffer3_reg_valid0 := regs.signals[29]
          let buffer3_reg_data0 := regs.signals[30]
          let buffer3_reg_ready0 := regs.signals[31]
          let buffer3_reg_ctrl_data0 := regs.signals[32]
          let buffer3_reg_valid1 := regs.signals[33]
          let buffer3_reg_data1 := regs.signals[34]
          let buffer3_reg_ready1 := regs.signals[35]
          let buffer3_reg_ctrl_data1 := regs.signals[36]
          -- circuit
          -- buffer0
          let inp_buffer0 : wiresStruc 1 2 1 := {result := #v[arg1], signals := #v[arg1_valid, out2_ready]}

          let regs_buffer0 := {result := #v[],
                                signals := #v[buffer0_reg_valid0, buffer0_reg_data0, buffer0_reg_ready0,
                                              buffer0_reg_ctrl_data0, buffer0_reg_valid1, buffer0_reg_data1,
                                              buffer0_reg_ready1, buffer0_reg_ctrl_data1]}
          let out_buffer0 := handshake_buffer_2slots_seq_1ins_1outs_ctrl inp_buffer0 regs_buffer0
          let buffer0_out0 := out_buffer0.result[0]
          let buffer0_in0_ready := out_buffer0.signals[0]
          let buffer0_out0_valid := out_buffer0.signals[1]
          let buffer0_reg_valid0 :=out_buffer0.signals[2]
          let buffer0_reg_data0 := out_buffer0.signals[3]
          let buffer0_reg_ready0 := out_buffer0.signals[4]
          let buffer0_reg_ctrl_data0 := out_buffer0.signals[5]
          let buffer0_reg_valid1 := out_buffer0.signals[6]
          let buffer0_reg_data1 := out_buffer0.signals[7]
          let buffer0_reg_ready1 := out_buffer0.signals[8]
          let buffer0_reg_ctrl_data1 := out_buffer0.signals[9]
          -- buffer1
          let inp_buffer1 : wiresStruc 1 2 1 := {result := #v[arg0], signals := #v[arg0_valid, fork0_in0_ready]}
          let regs_buffer1 := {result := #v[],
                                signals := #v[buffer1_reg_valid0, buffer1_reg_data0, buffer1_reg_ready0,
                                              buffer1_reg_ctrl_data0, buffer1_reg_valid1, buffer1_reg_data1,
                                              buffer1_reg_ready1, buffer1_reg_ctrl_data1]}
          let out_buffer1 := handshake_buffer_2slots_seq_1ins_1outs_ctrl inp_buffer1 regs_buffer1
          let buffer1_out0 := out_buffer1.result[0]
          let buffer1_in0_ready := out_buffer1.signals[0]
          let buffer1_out0_valid := out_buffer1.signals[1]
          let buffer1_reg_valid0 :=out_buffer1.signals[2]
          let buffer1_reg_data0 := out_buffer1.signals[3]
          let buffer1_reg_ready0 := out_buffer1.signals[4]
          let buffer1_reg_ctrl_data0 := out_buffer1.signals[5]
          let buffer1_reg_valid1 := out_buffer1.signals[6]
          let buffer1_reg_data1 := out_buffer1.signals[7]
          let buffer1_reg_ready1 := out_buffer1.signals[8]
          let buffer1_reg_ctrl_data1 := out_buffer1.signals[9]
          -- fork
          let fork0_inp : wiresStruc 1 3 1 := {result := #v[buffer1_out0], signals := #v[buffer1_out0_valid, buffer3_in0_ready, buffer2_in0_ready]}
          let fork0_regs : wiresStruc 0 2 1 := {result := #v[], signals := #v[reg_0, reg_1]}
          let fork_out := handshake_fork_1ins_2outs_ctrl fork0_inp fork0_regs
          let fork0_out0 := fork_out.result[0]
          let fork0_out1 := fork_out.result[1]
          let fork0_in0_ready := fork_out.signals[0]
          let fork0_out0_valid := fork_out.signals[1]
          let fork0_out1_valid := fork_out.signals[2]
          let updated_reg0 := fork_out.signals[3]
          let updated_reg1 := fork_out.signals[4]
          -- buffer2
          let inp_buffer2 : wiresStruc 1 2 1 := {result := #v[fork0_out1], signals := #v[fork0_out1_valid, out1_ready]}
          let regs_buffer2 := {result := #v[],
                                signals := #v[buffer2_reg_valid0, buffer2_reg_data0, buffer2_reg_ready0,
                                              buffer2_reg_ctrl_data0, buffer2_reg_valid1, buffer2_reg_data1,
                                              buffer2_reg_ready1, buffer2_reg_ctrl_data1]}
          let out_buffer2 := handshake_buffer_2slots_seq_1ins_1outs_ctrl inp_buffer2 regs_buffer2
          let buffer2_out0 := out_buffer2.result[0]
          let buffer2_in0_ready := out_buffer2.signals[0]
          let buffer2_out0_valid := out_buffer2.signals[1]
          let buffer2_reg_valid0 :=out_buffer2.signals[2]
          let buffer2_reg_data0 := out_buffer2.signals[3]
          let buffer2_reg_ready0 := out_buffer2.signals[4]
          let buffer2_reg_ctrl_data0 := out_buffer2.signals[5]
          let buffer2_reg_valid1 := out_buffer2.signals[6]
          let buffer2_reg_data1 := out_buffer2.signals[7]
          let buffer2_reg_ready1 := out_buffer2.signals[8]
          let buffer2_reg_ctrl_data1 := out_buffer2.signals[9]
          -- buffer3
          let inp_buffer3 : wiresStruc 1 2 1 := {result := #v[fork0_out0], signals := #v[fork0_out0_valid, out0_ready]}
          let regs_buffer3 := {result := #v[],
                                signals := #v[buffer3_reg_valid0, buffer3_reg_data0, buffer3_reg_ready0,
                                              buffer3_reg_ctrl_data0, buffer3_reg_valid1, buffer3_reg_data1,
                                              buffer3_reg_ready1, buffer3_reg_ctrl_data1]}
          let out_buffer3 := handshake_buffer_2slots_seq_1ins_1outs_ctrl inp_buffer3 regs_buffer3
          let buffer3_out0 := out_buffer3.result[0]
          let buffer3_in0_ready := out_buffer3.signals[0]
          let buffer3_out0_valid := out_buffer3.signals[1]
          let buffer3_reg_valid0 :=out_buffer3.signals[2]
          let buffer3_reg_data0 := out_buffer3.signals[3]
          let buffer3_reg_ready0 := out_buffer3.signals[4]
          let buffer3_reg_ctrl_data0 := out_buffer3.signals[5]
          let buffer3_reg_valid1 := out_buffer3.signals[6]
          let buffer3_reg_data1 := out_buffer3.signals[7]
          let buffer3_reg_ready1 := out_buffer3.signals[8]
          let buffer3_reg_ctrl_data1 := out_buffer3.signals[9]
          let out := {
            result := #v[buffer3_out0, buffer2_out0, buffer0_out0],
            signals := #v[buffer1_in0_ready, buffer0_in0_ready, buffer3_out0_valid, buffer2_out0_valid, buffer0_out0_valid]}
          let updatedregs := {
                                result := #v[],
                                signals := #v[fork0_in0_ready, buffer2_in0_ready, buffer3_in0_ready,
                                  buffer0_reg_valid0, buffer0_reg_data0,buffer0_reg_ready0, buffer0_reg_ctrl_data0,
                                  buffer0_reg_valid1, buffer0_reg_data1, buffer0_reg_ready1, buffer0_reg_ctrl_data1,
                                  buffer1_reg_valid0, buffer1_reg_data0, buffer1_reg_ready0, buffer1_reg_ctrl_data0,
                                  buffer1_reg_valid1, buffer1_reg_data1, buffer1_reg_ready1, buffer1_reg_ctrl_data1,
                                  reg_0, reg_1,
                                  buffer2_reg_valid0, buffer2_reg_data0, buffer2_reg_ready0, buffer2_reg_ctrl_data0,
                                  buffer2_reg_valid1, buffer2_reg_data1, buffer2_reg_ready1, buffer2_reg_ctrl_data1,
                                  buffer3_reg_valid0, buffer3_reg_data0, buffer3_reg_ready0, buffer3_reg_ctrl_data0,
                                  buffer3_reg_valid1, buffer3_reg_data1, buffer3_reg_ready1, buffer3_reg_ctrl_data1]
                              }
          ⟨out, updatedregs⟩
      )
