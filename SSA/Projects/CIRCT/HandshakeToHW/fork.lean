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

  See: https://github.com/opencompl/DC-semantics-simulation-evaluation/commit/bef3960435bc638477cb7ece87879c3ba2703473

-/

/--
  Handshake program:

    handshake.func @test_fork(%arg0: none, %arg1: none, ...) -> (none, none, none) {
      %0:2 = fork [2] %arg0 : none
      return %0#0, %0#1, %arg1 : none, none, none
    }
-/
def fork_handshake (arg : Stream (BitVec 1)) :=
  corec_prod (β := Stream (BitVec 1)) arg
    fun x => Id.run <| do
      let x0 := x 0
      let x' := x.tail
      (x0, x0, x')

/--
  The first configuration of the rtl-lowered program

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
      (in0 : Stream' (BitVec 1))
      (in0_valid : Stream' (BitVec 1))
      (out0_ready : Stream' (BitVec 1))
      (out1_ready : Stream' (BitVec 1))
  : Vector (Stream' (BitVec 1)) 5 :=
    let vec_streams := streams_to_vec'
                        (#v[in0, in0_valid, out0_ready, out1_ready])
    vec_to_streams' <| register_wrapper
      (inputs := vec_streams)
      (init_regs := #v[0#1, 0#1])
      (update_fun :=
        fun (inp, regs) =>
          let v2 := BitVec.xor regs[0] 1#1
          let v3 := BitVec.and v2 inp[1]
          let v4 := BitVec.and inp[2] v3
          let v5 := BitVec.or regs[0] v4
          let v8 := BitVec.xor regs[1] 1#1
          let v9 := BitVec.and v8 inp[1]
          let v10 := BitVec.and inp[3] v9
          let v11 := BitVec.or v10 regs[1]
          let v12 := BitVec.and v5 v11
          let v0 := BitVec.xor v12 1#1
          let v1 := BitVec.and v5 v0
          let updated_reg0 := v1
          let v6 := BitVec.xor v12 1#1
          let v7 := BitVec.and v11 v6
          let updated_reg1 := v7
          (#v[v12, inp[0], v3, inp[0], v9], #v[updated_reg0, updated_reg1])
      )

/--
  The second configuration of the rtl-lowered program

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
    %ready0_reg = seq.compreg sym @ready0_reg %10, %clock reset %reset, %false : i1
    %4 = comb.mux %ready0_reg, %ready0_reg, %valid0_reg : i1
    %5 = comb.xor %ready0_reg, %true : i1
    %6 = comb.xor %15, %true : i1
    %7 = comb.and %6, %5 : i1
    %8 = comb.mux %7, %valid0_reg, %ready0_reg : i1
    %9 = comb.and %15, %ready0_reg : i1
    %10 = comb.mux %9, %false, %8 : i1
    %ctrl_data0_reg = seq.compreg sym @ctrl_data0_reg %13, %clock reset %reset, %c0_i0 : i0
    %11 = comb.mux %ready0_reg, %ctrl_data0_reg, %data0_reg : i0
    %12 = comb.mux %7, %data0_reg, %ctrl_data0_reg : i0
    %13 = comb.mux %9, %c0_i0, %12 : i0
    %valid1_reg = seq.compreg sym @valid1_reg %16, %clock reset %reset, %false : i1
    %14 = comb.xor %valid1_reg, %true : i1
    %15 = comb.or %14, %19 : i1
    %16 = comb.mux %15, %4, %valid1_reg : i1
    %17 = comb.mux %15, %11, %data1_reg : i0
    %data1_reg = seq.compreg sym @data1_reg %17, %clock reset %reset, %c0_i0 : i0
    %ready1_reg = seq.compreg sym @ready1_reg %24, %clock reset %reset, %false : i1
    %18 = comb.mux %ready1_reg, %ready1_reg, %valid1_reg : i1
    %19 = comb.xor %ready1_reg, %true : i1
    %20 = comb.xor %out0_ready, %true : i1
    %21 = comb.and %20, %19 : i1
    %22 = comb.mux %21, %valid1_reg, %ready1_reg : i1
    %23 = comb.and %out0_ready, %ready1_reg : i1
    %24 = comb.mux %23, %false, %22 : i1
    %ctrl_data1_reg = seq.compreg sym @ctrl_data1_reg %27, %clock reset %reset, %c0_i0 : i0
    %25 = comb.mux %ready1_reg, %ctrl_data1_reg, %data1_reg : i0
    %26 = comb.mux %21, %data1_reg, %ctrl_data1_reg : i0
    %27 = comb.mux %23, %c0_i0, %26 : i0
    hw.output %1, %25, %18 : i1, i0, i1
-/
def handshake_buffer_2slots_seq_1ins_1outs_ctrl
      (in0 : Stream' (BitVec 1))
      (in0_valid : Stream' (BitVec 1))
      (out0_ready : Stream' (BitVec 1))
  : Vector (Stream' (BitVec 1)) 3 :=
    let vec_streams := streams_to_vec'
                        (#v[in0, in0_valid, out0_ready])
    vec_to_streams' <| register_wrapper
      (inputs := vec_streams) (r := 3)
      (init_regs := #v[0#1, 0#1, 0#1, 0#1, 0#1, 0#1, 0#1, 0#1])
      (update_fun :=
        fun (inp, regs) =>
          /- order of registers:
            valid0, data0, ready0, ctrl_data0, valid1, data1, ready1, ctrl_data1 -/
          let v5 := BitVec.xor regs[2] 1#1
          let v14 := BitVec.xor regs[4] 1#1
          let v19 := BitVec.xor regs[6] 1#1
          let v15 := BitVec.or v14 v19
          let v20 := BitVec.xor inp[2] 1#1
          let v21 := BitVec.and v20 v19
          let v22 := if v21.msb then regs[4] else regs[6]
          let v23 := BitVec.and inp[2] regs[6]
          let v24 := if v23.msb then 0#1 else v22
          let v26 := if v21.msb then regs[5] else regs[7]
          let v27 := if v23.msb then 0#1 else v26
          let v0 := BitVec.xor regs[0] 1#1
          let v1 := BitVec.or v0 v5
          let v2 := if v1.msb then inp[1] else regs[0]
          let v3 := if v1.msb then inp[0] else regs[1]
          let v4 := if regs[2].msb then regs[2] else regs[0]
          let v6 := BitVec.xor v15 1#1
          let v7 := BitVec.and v5 v6
          let v8 := if v7.msb then regs[0] else regs[2]
          let v9 := BitVec.and v15 regs[2]
          let v10 := if v9.msb then 0#1 else v8
          let v11 := if regs[2].msb then regs[3] else regs[1]
          let v12 := if v7.msb then regs[2] else regs[3]
          let v13 := if v9.msb then 0#1 else v12
          let v16 := if v15.msb then v4 else regs[4]
          let v17 := if v15.msb then v11 else regs[5]
          let v18 := if regs[6].msb then regs[6] else regs[4]
          let v25 := if regs[6].msb then regs[7] else regs[5]
          let updated_valid0 := v2
          let updated_data0 := v3
          let updated_ready0 := v10
          let updated_ctrl_data0 := v13
          let updated_valid1 := v16
          let updated_data1 := v17
          let updated_ready1 := v24
          let updated_ctrl_data1 := v27
          ⟨#v[v1, v25, v18], #v[updated_valid0, updated_data0, updated_ready0, updated_ctrl_data0,
                                  updated_valid1, updated_data1, updated_ready1, updated_ctrl_data1]⟩
      )
