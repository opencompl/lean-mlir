import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas
import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Register.Lemmas

namespace HandshakeStream

/-!
  Handshake program:

    handshake.func @test_fork(%arg0: none, %arg1: none, ...) -> (none, none, none) {
      %0:2 = fork [2] %arg0 : none
      return %0#0, %0#1, %arg1 : none, none, none
    }

  Lowered program (https://github.com/opencompl/DC-semantics-simulation-evaluation/commit/28ef888954a8726d4858bed925ad067729207655)

  module {
    hw.module @test_fork(in %arg0 : !esi.channel<i0>, in %arg1 : !esi.channel<i0>, in %clk : !seq.clock {dc.clock}, in %rst : i1 {dc.reset}, out out0 : !esi.channel<i0>, out out1 : !esi.channel<i0>, out out2 : !esi.channel<i0>) {
      %rawOutput, %valid = esi.unwrap.vr %arg0, %12 : i0
      %c0_i0 = hw.constant 0 : i0
      %chanOutput, %ready = esi.wrap.vr %c0_i0, %3 : i0
      %c0_i0_0 = hw.constant 0 : i0
      %chanOutput_1, %ready_2 = esi.wrap.vr %c0_i0_0, %9 : i0
      %false = hw.constant false
      %true = hw.constant true
      %0 = comb.xor %12, %true : i1
      %1 = comb.and %5, %0 : i1
      %emitted_0 = seq.compreg sym @emitted_0 %1, %clk reset %rst, %false : i1
      %2 = comb.xor %emitted_0, %true : i1
      %3 = comb.and %2, %valid : i1
      %4 = comb.and %ready, %3 : i1
      %5 = comb.or %4, %emitted_0 {sv.namehint = "done0"} : i1
      %6 = comb.xor %12, %true : i1
      %7 = comb.and %11, %6 : i1
      %emitted_1 = seq.compreg sym @emitted_1 %7, %clk reset %rst, %false : i1
      %8 = comb.xor %emitted_1, %true : i1
      %9 = comb.and %8, %valid : i1
      %10 = comb.and %ready_2, %9 : i1
      %11 = comb.or %10, %emitted_1 {sv.namehint = "done1"} : i1
      %12 = comb.and %5, %11 {sv.namehint = "allDone"} : i1
      hw.output %chanOutput, %chanOutput_1, %arg1 : !esi.channel<i0>, !esi.channel<i0>, !esi.channel<i0>
    }
  }
-/

/--
  `fork` replicates the content of an input stream and dispatches it to two channels.

  The hardware (lowered) module is a function over the `Stream'` type,
  which does not contain `Option` values, because at this level
  of abstractions the content of streams has been concretized.
-/
def fork
      (arg_0 : Stream' (BitVec 1))
      (arg_0_valid : Stream' (BitVec 1))
      (arg_1 : Stream' (BitVec 1))
      (arg_1_valid : Stream' (BitVec 1))
      (out0_ready : Stream' (BitVec 1))
      (out1_ready : Stream' (BitVec 1))
      (out2_ready : Stream' (BitVec 1))
  : Vector (Stream' (BitVec 1)) 8 :=
    let vec_streams := streams_to_vec'
                        (#v[arg_0, arg_0_valid, arg_1, arg_1_valid, out0_ready, out1_ready, out2_ready])
    vec_to_streams' <| register_wrapper
      (inputs := vec_streams)
      (init_regs := #v[0#1, 0#1])
      (update_fun := -- (Vector (BitVec 1) 7 × Vector (BitVec 1) 2) → (Vector α 9 × Vector α 2)
        fun (inp, regs) =>
          let v2 := BitVec.xor regs[0] 1#1
          let v3 := BitVec.and v2 inp[1]
          let v4 := BitVec.and inp[4] v3
          let v5 := BitVec.or v4 regs[0]
          let v8 := BitVec.xor regs[1] 1#1
          let v9 := BitVec.and v8 inp[1]
          let v10 := BitVec.and inp[5] v9
          let v11 := BitVec.or v10 regs[1]
          let v12 := BitVec.and v5 v11
          let v6 := BitVec.xor v12 1#1
          let v7 := BitVec.and v11 v6
          let v0 := BitVec.xor v12 1#1
          let v1 := BitVec.and v5 v0
          let updated_reg0 := v1
          let updated_reg1 := v7
          (#v[v12, inp[6], 0#1, v3, 0#1, v9, inp[2], inp[3]], #v[updated_reg0, updated_reg1])
      )

/-- We prove that the description at handshake level and the description at lower (RTL) level are bisimilar. -/
theorem fork_bisim
    (arg0_data arg0_valid arg1_data arg1_valid out0_ready out1_ready out2_ready : Stream' (BitVec 1))
    (arg0 arg1 out0 out1 out2 : Stream (BitVec 1)) :
    let := ReadyValid #v[arg0_data, arg0_valid, arg0_ready] arg0
    let := ReadyValid #v[arg1_data, arg1_valid, arg1_ready] arg1
    let := ReadyValid #v[out0_data, out0_valid, out0_ready] out0
    let := ReadyValid #v[out1_data, out1_valid, out1_ready] out1
    let := ReadyValid #v[out2_data, out2_valid, out2_ready] out2
    Bisim (iso_unary' ((fork arg0_data arg0_valid arg1_data arg1_valid out0_ready oue1_ready out2_ready).get 0))  (HandshakeOp.fork arg0).fst := by
  unfold iso_unary' HandshakeOp.fork
  unfold Bisim
  simp

  sorry
