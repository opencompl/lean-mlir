import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas
import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Register.Lemmas

namespace HandshakeStream

/-!
  # Fork

  `fork` replicates the content of an input stream and dispatches it to two channels.
  At the handshake level, `fork` operates on the `Stream' (Option α)` type (i.e., `Stream`).

  The hardware (lowered) module is a function over the `Stream'` type,
  which does not contain `Option` values, because at this level
  of abstractions the content of streams has been concretized.
  We ignore buffers.

  See: https://github.com/opencompl/DC-semantics-simulation-evaluation/commit/bf86f7247a767d97516a05a29e313634e5172398

-/

/--
  Handshake program:

  handshake.func @test_fork(%arg0: none, %arg1: none, ...) -> (none, none, none) {
    %0:2 = fork [2] %arg0 : none
    return %0#0, %0#1, %arg1 : none, none, none
  }
-/
def fork_handshake (arg : Stream (BitVec 1)) :=
  corec_prod arg
    fun x => Id.run <| do
      let x0 := x 0
      let x' := x.tail
      (x0, x0, x')

/--
  First RTL module:

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
  Second RTL module:

  hw.module @fork(in %arg0 : i0, in %arg0_valid : i1, in %arg1 : i0, in %arg1_valid : i1, in %clock : !seq.clock, in %reset : i1, in %out0_ready : i1, in %out1_ready : i1, in %out2_ready : i1, out arg0_ready : i1, out arg1_ready : i1, out out0 : i0, out out0_valid : i1, out out1 : i0, out out1_valid : i1, out out2 : i0, out out2_valid : i1) {
    %handshake_fork0.in0_ready, %handshake_fork0.out0, %handshake_fork0.out0_valid, %handshake_fork0.out1, %handshake_fork0.out1_valid = hw.instance "handshake_fork0" @handshake_fork_1ins_2outs_ctrl(in0: %arg0: i0, in0_valid: %arg0_valid: i1, clock: %clock: !seq.clock, reset: %reset: i1, out0_ready: %out0_ready: i1, out1_ready: %out1_ready: i1) -> (in0_ready: i1, out0: i0, out0_valid: i1, out1: i0, out1_valid: i1)
    hw.output %handshake_fork0.in0_ready, %out2_ready, %handshake_fork0.out0, %handshake_fork0.out0_valid, %handshake_fork0.out1, %handshake_fork0.out1_valid, %arg1, %arg1_valid : i1, i1, i0, i1, i0, i1, i0, i1
  }
-/
def fork_rtl
      (arg0 : Stream' (BitVec 1))
      (arg0_valid : Stream' (BitVec 1))
      (arg1 : Stream' (BitVec 1))
      (arg1_valid : Stream' (BitVec 1))
      (out0_ready : Stream' (BitVec 1))
      (out1_ready : Stream' (BitVec 1))
      (out2_ready : Stream' (BitVec 1))
  : Vector (Stream' (BitVec 1)) 8 :=
  let tmp := handshake_fork_1ins_2outs_ctrl arg0 arg0_valid out0_ready out1_ready
  let in0_ready := tmp[0]
  let out0 := tmp[1]
  let out0_valid := tmp[2]
  let out1 := tmp[3]
  let out1_valid := tmp[4]
  #v[in0_ready, out2_ready, out0, out0_valid, out1, out1_valid, arg1, arg1_valid]

theorem lowering_correctness
  (arg0 arg1 : Stream (BitVec 1))
  (arg0_readyvalid arg1_readyvalid : Vector (Stream' (BitVec 1)) 3)
  (harg0 : ReadyValid arg0_readyvalid arg0)
  (harg1 : ReadyValid arg1_readyvalid arg1)
  (arg2_ready : Stream' (BitVec 1)) :
    let fork_rtl' : Vector (Stream' (BitVec 1)) 8 :=
      fork_rtl arg0_readyvalid[0] arg0_readyvalid[2] arg1_readyvalid[0] arg1_readyvalid[2]
        arg0_readyvalid[1] arg1_readyvalid[1] sig
    Bisim' (fork_handshake arg0).fst fork_rtl'[2] := by sorry
