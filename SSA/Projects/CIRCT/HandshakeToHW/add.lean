import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas
import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Register.Lemmas

namespace HandshakeStream

/-!
  # Add

  We add a circuit that given two inputs `a` and `b` performs two additions: `(a + a) + b`.

  The hardware (lowered) module is a function over the `Stream'` type,
  which does not contain `Option` values, because at this level
  of abstractions the content of streams has been concretized.
  We ignore buffers.

  See: https://github.com/opencompl/DC-semantics-simulation-evaluation/commit/bf86f7247a767d97516a05a29e313634e5172398

-/

/--
  Handshake program after buffers' insertion::

  handshake.func @add(%arg0: index, %arg1: index, %arg2: none, ...) -> (index, none) {
      %0 = arith.addi %arg0, %arg0 : index
      %1 = arith.addi %0, %arg1 : index
      handshake.return %1, %arg2 : index, none
  }

  We define it based on a synchroniing wrapper, that first synchronizes the input streams and
  then applies the operation.
-/
def add_handshake (a b : Stream' (Option (BitVec 64))) := syncMap₂ BitVec.add a b

/--
  First RTL module:

  hw.module @handshake_fork_in_ui64_out_ui64_ui64(in %in0 : i64, in %in0_valid : i1, in %clock : !seq.clock, in %reset : i1, in %out0_ready : i1, in %out1_ready : i1, out in0_ready : i1, out out0 : i64, out out0_valid : i1, out out1 : i64, out out1_valid : i1) {
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
    hw.output %12, %in0, %3, %in0, %9 : i1, i64, i1, i64, i1
  }
-/
def handshake_fork_in_ui64_out_ui64_ui64
    (inp : wiresStruc 1 3 64)
    (regs : wiresStruc 0 2 64) :
     (wiresStruc 2 5 64)  :=
      let v2 := regs.signals[0] ^^^ 1#1 -- emitted_0
      let v3 := v2 &&& inp.signals[0] -- in0_valid
      let v4 := inp.signals[1] &&& v3 -- out0_ready
      let v5 := v4 ||| regs.signals[0]
      let v8 := regs.signals[1] ^^^ 1#1 -- emitted_1
      let v9 := v8 &&& inp.signals[0] -- in0_valid
      let v10 := inp.signals[2] &&& v9 -- out1_ready
      let v11 := v10 ||| regs.signals[1]
      let v12 := v5 &&& v11
      let v0 := v12 ^^^ 1#1
      let v1 := v5 &&& v0
      let v6 := v12 ^^^ 1#1
      let v7 := v11 &&& v6
      let updated_reg0 := v1
      let updated_reg1 := v7
      {result := #v[inp.result[0], inp.result[0]], signals := #v[v12, v3, v9, updated_reg0, updated_reg1]}

/--
  Second RTL module:

  hw.module @arith_addi_in_ui64_ui64_out_ui64(in %in0 : i64, in %in0_valid : i1, in %in1 : i64, in %in1_valid : i1, in %out0_ready : i1, out in0_ready : i1, out in1_ready : i1, out out0 : i64, out out0_valid : i1) {
    %0 = comb.and %in0_valid, %in1_valid : i1
    %1 = comb.and %out0_ready, %0 : i1
    %2 = comb.add %in0, %in1 : i64
    hw.output %1, %1, %2, %0 : i1, i1, i64, i1
  }

-/
def arith_addi_in_ui64_ui64_out_ui64
  (inp : (wiresStruc 2 3 64)) : (wiresStruc 1 3 64) :=
    let v0 := inp.signals[0] &&& inp.signals[1] -- in0_valid &&& in1_valid
    let v1 := inp.signals[2] &&& v0 -- out0_ready
    let v2 := inp.result[0] + inp.result[1]
    {result := #v[v2], signals := #v[v1, v1, v0]}

/--
  Third RTL module:

    hw.module @add(in %arg0 : i64, in %arg0_valid : i1, in %arg1 : i64, in %arg1_valid : i1, in %arg2 : i0, in %arg2_valid : i1, in %clock : !seq.clock, in %reset : i1, in %out0_ready : i1, in %out1_ready : i1, out arg0_ready : i1, out arg1_ready : i1, out arg2_ready : i1, out out0 : i64, out out0_valid : i1, out out1 : i0, out out1_valid : i1) {

      %handshake_fork0.in0_ready, %handshake_fork0.out0, %handshake_fork0.out0_valid, %handshake_fork0.out1, %handshake_fork0.out1_valid =
          hw.instance "handshake_fork0" @handshake_fork_in_ui64_out_ui64_ui64
              (in0: %arg0: i64, in0_valid: %arg0_valid: i1, clock: %clock: !seq.clock, reset: %reset: i1, out0_ready: %arith_addi0.in0_ready: i1, out1_ready: %arith_addi0.in1_ready: i1) ->
              (in0_ready: i1, out0: i64, out0_valid: i1, out1: i64, out1_valid: i1)

      %arith_addi0.in0_ready, %arith_addi0.in1_ready, %arith_addi0.out0, %arith_addi0.out0_valid =
          hw.instance "arith_addi0" @arith_addi_in_ui64_ui64_out_ui64
            (in0: %handshake_fork0.out0: i64, in0_valid: %handshake_fork0.out0_valid: i1, in1: %handshake_fork0.out1: i64, in1_valid: %handshake_fork0.out1_valid: i1, out0_ready: %arith_addi1.in0_ready: i1) ->
            (in0_ready: i1, in1_ready: i1, out0: i64, out0_valid: i1)

      %arith_addi1.in0_ready, %arith_addi1.in1_ready, %arith_addi1.out0, %arith_addi1.out0_valid =
          hw.instance "arith_addi1" @arith_addi_in_ui64_ui64_out_ui64
            (in0: %arith_addi0.out0: i64, in0_valid: %arith_addi0.out0_valid: i1, in1: %arg1: i64, in1_valid: %arg1_valid: i1, out0_ready: %out0_ready: i1) ->
            (in0_ready: i1, in1_ready: i1, out0: i64, out0_valid: i1)

      hw.output %handshake_fork0.in0_ready, %arith_addi1.in1_ready, %out1_ready, %arith_addi1.out0, %arith_addi1.out0_valid, %arg2, %arg2_valid : i1, i1, i1, i64, i1, i0, i1
    }
-/
def add_rtl
  /-
    xst.result[0] = arg0
    xst.result[1] = arg1
    xst.signals[0] = arg0_valid
    xst.signals[1] = arg1_valid
    xst.signals[2] = arg2
    xst.signals[3] = arg2_valid
    xst.signals[4] = out0_ready
    xst.signals[5] = out1_ready
  -/
  (inp : Stream' (wiresStruc 2 6 64)) : Stream' (wiresStruc 1 6 64) :=
    register_wrapper_generalized
      (inputs := inp)
      (init_regs := {result := #v[], signals := #v[0#1, 0#1, 0#1, 0#1]})
      (outops := 1)
      (outsigs := 6)
      (update_fun :=
        fun (inp, regs) =>
          let addi0_in0_ready := regs.signals[2]
          let addi0_in1_ready := regs.signals[3]
          let arg0 := inp.result[0]
          let arg1 := inp.result[1]
          let arg0_valid := inp.signals[0]
          let arg1_valid := inp.signals[1]
          let arg2 := inp.signals[2]
          let arg2_valid := inp.signals[3]
          let out0_ready := inp.signals[4]
          let out1_ready := inp.signals[5]
          -- fork
          let fork_inp :=
            {result := #v[arg0],
              signals := #v[arg0_valid, addi0_in0_ready, addi0_in1_ready]}
          let fork_regs :=
            {result := #v[],
              signals := #v[regs.signals[0], regs.signals[1]]}
          -- fork
          let fork_out := handshake_fork_in_ui64_out_ui64_ui64 fork_inp fork_regs
          let fork_in0_ready := fork_out.signals[0]
          let fork_out0_valid := fork_out.signals[1]
          let fork_out1_valid := fork_out.signals[2]
          let fork_out0 := fork_out.result[0]
          let fork_out1 := fork_out.result[1]
          let updated_reg0 := fork_out.signals[3]
          let updated_reg1 := fork_out.signals[4]
          -- addi0
          let addi0_inp :=
            {result := #v[fork_out0, fork_out1],
              signals := #v[fork_out0_valid, fork_out1_valid, fork_in0_ready]}
          let addi0_out := arith_addi_in_ui64_ui64_out_ui64 addi0_inp
          let addi0_in0_ready := addi0_out.signals[0]
          let addi0_in1_ready := addi0_out.signals[1]
          let addi0_out0_valid := addi0_out.signals[2]
          let addi0_out0 := addi0_out.result[0]
          -- addi1
          let addi1_inp : wiresStruc 2 3 64 :=
            {result := #v[addi0_out0, inp.result[1]],
              signals := #v[addi0_out0_valid, inp.signals[1], inp.signals[4]]}
          let addi1_out := arith_addi_in_ui64_ui64_out_ui64 addi1_inp
          let addi1_in0_ready := addi1_out.signals[0]
          let addi1_in1_ready := addi1_out.signals[1]
          let addi1_out0_valid := addi1_out.signals[2]
          let addi1_out0 := addi1_out.result[0]
          ⟨{result := #v[addi1_out0],
            signals := #v[fork_in0_ready, addi1_in1_ready, out1_ready, addi1_out0_valid, arg2, arg2_valid]},
            {result := #v[], signals := #v[updated_reg0, updated_reg1, addi0_in0_ready, addi0_in1_ready]}⟩
      )

theorem lowering_correctness
  (a b : Stream (BitVec 64)) -- handshake level
  (a_readyvalid b_readyvalid : wiresStructStream 1 2 64) -- rtl level
  (sig_readyValid : Vector (Stream' (BitVec 1)) 3) -- extra input signal
  (hsig : ReadyValid sig_readyValid sig)
  (hsig_a : ReadyValidStruc a_readyvalid a) (hsig_b : ReadyValidStruc b_readyvalid b) :
    let inp : wiresStructStream 2 6 64 := {
      result := #v[a_readyvalid.result[0], b_readyvalid.result[0]]
      signals := #v[a_readyvalid.signals[1], b_readyvalid.signals[1],
                    sig_readyValid[0], sig_readyValid[2],
                    a_readyvalid.signals[0], b_readyvalid.signals[0]]}
    let inp' := streams_to_wires inp
    let rtl' := add_rtl inp'
    let rtl := wires_to_streams rtl'
    (add_handshake a b) ~ rtl.result[0] := by sorry
