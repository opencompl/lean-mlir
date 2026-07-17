import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas
import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Register.Lemmas
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.HandshakeToHW.HWForkSampling
import SSA.Projects.CIRCT.HandshakeToHW.HWFork
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
  Handshake program after buffers' insertion and materialization:

  module {
    handshake.func @add(%arg0: index, %arg1: index, %arg2: none, ...) -> (index, none) attributes {argNames = ["arg0", "arg1", "arg2"], resNames = ["out0", "out1"]} {
      %0:2 = fork [2] %arg0 : index
      %1 = buffer [2] seq %arg2 : none
      %2 = arith.addi %0#0, %0#1 : index
      %3 = buffer [2] seq %2 : index
      %4 = arith.addi %3, %arg1 : index
      %5 = buffer [2] seq %4 : index
      return %5, %1 : index, none
    }
  }

  We define it based on a synchroniing wrapper, that first synchronizes the input streams and
  then applies the operation.

  We ignore the semantics of buffers.
-/
def add_handshake (a b : Stream' (Option (BitVec 64))) :=
  let ⟨fork_0, fork_1⟩ := HandshakeOp.fork a
  let addi_1 := syncMap₂ BitVec.add fork_0 fork_1
  let addi_2 := syncMap₂ BitVec.add addi_1 b
  addi_2

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

  This fork is the same as the basic fork module.
-/
def handshake_fork_in_ui64_out_ui64_ui64 (ready ready_1 valid : Stream' (BitVec 1)) (in0 : Stream' (BitVec 64)) :=
  HWComponents.TRY3.hw_fork ready ready_1 valid in0

/--
  Second RTL module:

  hw.module @arith_addi_in_ui64_ui64_out_ui64(in %in0 : i64, in %in0_valid : i1, in %in1 : i64, in %in1_valid : i1, in %out0_ready : i1, out in0_ready : i1, out in1_ready : i1, out out0 : i64, out out0_valid : i1) {
    %0 = comb.and %in0_valid, %in1_valid : i1
    %1 = comb.and %out0_ready, %0 : i1
    %2 = comb.add %in0, %in1 : i64
    hw.output %1, %1, %2, %0 : i1, i1, i64, i1
  }

  This circuit is purely combinational.

-/
def arith_addi_in_ui64_ui64_out_ui64 (in0_valid in1_valid out0_ready: Stream' (BitVec 1)) (in0 in1 : Stream' (BitVec 64)) :
    Stream' (
      BitVec 1 -- in0_ready
      × BitVec 1 -- in1_ready
      × BitVec 64 -- out0
      × BitVec 1 -- out0_valid
    ) :=
  Stream'.corec' (α := Nat) (fun i =>
    let out0_valid := HWComponents.comb_and (in0_valid i) (in1_valid i)
    let in0_ready := HWComponents.comb_and (out0_ready i) out0_valid
    let out1_ready := HWComponents.comb_and (out0_ready i) out0_valid
    let out0 := HWComponents.comb_add (in0 i) (in1 i)
    ((in0_ready, out1_ready, out0, out0_valid), (i + 1))
  ) 0

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

  The composed `@add` module: we need to inline
  the two adders' ready/valid equations into the fork's; the only registers are the fork's `emitted_0`/`emitted_1`.

  We also treat the `i0` type as `i1`, since the `BitVec 0` type in lean is degenerate.

-/
def add_rtl (arg0_valid arg1_valid arg2 arg2_valid out0_ready out1_ready : Stream' (BitVec 1)) (arg0 arg1 : Stream' (BitVec 64)) :
      Stream' (
        BitVec 1 -- arg0_ready
        × BitVec 1 -- arg1_ready
        × BitVec 1 -- arg2_ready
        × BitVec 64 -- out0
        × BitVec 1 -- out0_valid
        × BitVec 1 --out1
        × BitVec 1 --out1_valid
      ) :=

  Stream'.corec' (α := Nat × BitVec 1 × BitVec 1) (fun (i, _emitted_0, _emitted_1) =>
    /-
    %handshake_fork0.in0_ready, %handshake_fork0.out0, %handshake_fork0.out0_valid, %handshake_fork0.out1, %handshake_fork0.out1_valid =
          hw.instance "handshake_fork0" @handshake_fork_in_ui64_out_ui64_ui64
              (in0: %arg0: i64, in0_valid: %arg0_valid: i1, clock: %clock: !seq.clock, reset: %reset: i1, out0_ready: %arith_addi0.in0_ready: i1, out1_ready: %arith_addi0.in1_ready: i1) ->
              (in0_ready: i1, out0: i64, out0_valid: i1, out1: i64, out1_valid: i1)
    -/
    let _true := HWComponents.hw_constant true
    let _false := HWComponents.hw_constant false
    let _2 := HWComponents.comb_xor _emitted_0 _true
    let fork_valid0 := HWComponents.comb_and _2 (arg0_valid i)
    let _8 := HWComponents.comb_xor _emitted_1 _true
    let fork_valid1 := HWComponents.comb_and _8 (arg0_valid i)
    let fork_rawOutput := arg0 i
    /-
        %arith_addi0.in0_ready, %arith_addi0.in1_ready, %arith_addi0.out0, %arith_addi0.out0_valid =
      hw.instance "arith_addi0" @arith_addi_in_ui64_ui64_out_ui64
        (in0: %handshake_fork0.out0: i64, in0_valid: %handshake_fork0.out0_valid: i1, in1: %handshake_fork0.out1: i64, in1_valid: %handshake_fork0.out1_valid: i1, out0_ready: %arith_addi1.in0_ready: i1) ->
        (in0_ready: i1, in1_ready: i1, out0: i64, out0_valid: i1)
    -/
    let add0_out0_valid := HWComponents.comb_and fork_valid0 fork_valid1
    let add0_out0 := HWComponents.comb_add fork_rawOutput fork_rawOutput
    /-
        %arith_addi1.in0_ready, %arith_addi1.in1_ready, %arith_addi1.out0, %arith_addi1.out0_valid =
      hw.instance "arith_addi1" @arith_addi_in_ui64_ui64_out_ui64
        (in0: %arith_addi0.out0: i64, in0_valid: %arith_addi0.out0_valid: i1, in1: %arg1: i64, in1_valid: %arg1_valid: i1, out0_ready: %out0_ready: i1) ->
        (in0_ready: i1, in1_ready: i1, out0: i64, out0_valid: i1)

    -/
    let add1_out0_valid := HWComponents.comb_and add0_out0_valid (arg1_valid i)
    let add1_in0_ready := HWComponents.comb_and (out0_ready i) add1_out0_valid
    let add1_in1_ready := HWComponents.comb_and (out0_ready i) add1_out0_valid
    let add0_in0_ready := HWComponents.comb_and add1_in0_ready add0_out0_valid
    let _4 := HWComponents.comb_and add0_in0_ready fork_valid0
    let _5 := HWComponents.comb_or _4 _emitted_0   -- done0
    let add0_in1_ready := HWComponents.comb_and add1_in0_ready add0_out0_valid
    let _10 := HWComponents.comb_and add0_in1_ready fork_valid1
    let _11 := HWComponents.comb_or _10 _emitted_1 -- done1
    let fork_ready := HWComponents.comb_and _5 _11       -- allDone
    let _0 := HWComponents.comb_xor fork_ready _true
    let _6 := HWComponents.comb_xor fork_ready _true
    let _7 := HWComponents.comb_and _11 _6
    let _1 := HWComponents.comb_and _5 _0
    let add1_out0 := HWComponents.comb_add add0_out0 (arg1 i)
    ((fork_ready, add1_in1_ready, (out1_ready i), add1_out0, add1_out0_valid, (arg2 i), (arg2_valid i)), (i + 1, _1, _7))
  ) (0, 0#1, 0#1)

/-- The update function of `add_rtl`, extracted verbatim (the analogue of
`fork_corec` for the fork): one combinational cycle of the composed module as
a function of the corec state `(i, emitted_0, emitted_1)`. -/
def add_rtl_corec (arg0_valid arg1_valid arg2 arg2_valid out0_ready out1_ready :
    Stream' (BitVec 1)) (arg0 arg1 : Stream' (BitVec 64)) :=
  fun ((i, _emitted_0, _emitted_1) : Nat × BitVec 1 × BitVec 1) =>
    let _true := HWComponents.hw_constant true
    let _false := HWComponents.hw_constant false
    let _2 := HWComponents.comb_xor _emitted_0 _true
    let fork_valid0 := HWComponents.comb_and _2 (arg0_valid i)
    let _8 := HWComponents.comb_xor _emitted_1 _true
    let fork_valid1 := HWComponents.comb_and _8 (arg0_valid i)
    let fork_rawOutput := arg0 i
    let add0_out0_valid := HWComponents.comb_and fork_valid0 fork_valid1
    let add0_out0 := HWComponents.comb_add fork_rawOutput fork_rawOutput
    let add1_out0_valid := HWComponents.comb_and add0_out0_valid (arg1_valid i)
    let add1_in0_ready := HWComponents.comb_and (out0_ready i) add1_out0_valid
    let add1_in1_ready := HWComponents.comb_and (out0_ready i) add1_out0_valid
    let add0_in0_ready := HWComponents.comb_and add1_in0_ready add0_out0_valid
    let _4 := HWComponents.comb_and add0_in0_ready fork_valid0
    let _5 := HWComponents.comb_or _4 _emitted_0   -- done0
    let add0_in1_ready := HWComponents.comb_and add1_in0_ready add0_out0_valid
    let _10 := HWComponents.comb_and add0_in1_ready fork_valid1
    let _11 := HWComponents.comb_or _10 _emitted_1 -- done1
    let fork_ready := HWComponents.comb_and _5 _11       -- allDone
    let _0 := HWComponents.comb_xor fork_ready _true
    let _6 := HWComponents.comb_xor fork_ready _true
    let _7 := HWComponents.comb_and _11 _6
    let _1 := HWComponents.comb_and _5 _0
    let add1_out0 := HWComponents.comb_add add0_out0 (arg1 i)
    ((fork_ready, add1_in1_ready, (out1_ready i), add1_out0, add1_out0_valid, (arg2 i), (arg2_valid i)), (i + 1, _1, _7))

/-- `add_rtl`, re-expressed through the named update function (the analogue of
`hw_fork'`). -/
def add_rtl' (arg0_valid arg1_valid arg2 arg2_valid out0_ready out1_ready :
    Stream' (BitVec 1)) (arg0 arg1 : Stream' (BitVec 64)) :
      Stream' (
        BitVec 1 -- arg0_ready
        × BitVec 1 -- arg1_ready
        × BitVec 1 -- arg2_ready
        × BitVec 64 -- out0
        × BitVec 1 -- out0_valid
        × BitVec 1 --out1
        × BitVec 1 --out1_valid
      ) :=
  Stream'.corec' (α := Nat × BitVec 1 × BitVec 1)
    (add_rtl_corec arg0_valid arg1_valid arg2 arg2_valid out0_ready out1_ready
      arg0 arg1)
    (0, 0#1, 0#1)

/-- The transcription and its named-update form agree (the analogue of
`hw_fork_eq`). -/
theorem add_rtl_eq
    {arg0_valid arg1_valid arg2 arg2_valid out0_ready out1_ready :
      Stream' (BitVec 1)} {arg0 arg1 : Stream' (BitVec 64)} :
    add_rtl arg0_valid arg1_valid arg2 arg2_valid out0_ready out1_ready arg0 arg1
      = add_rtl' arg0_valid arg1_valid arg2 arg2_valid out0_ready out1_ready
          arg0 arg1 := by
  unfold add_rtl add_rtl' add_rtl_corec
  congr 1

/-!
  ## Reasoning layer

  The composed circuit in the style of `HWForkSampling.lean`: every signal a
  pure function of the cycle index, the fork's `emitted` pair as the only
  state, and the `Fork` library reused through instantiation.
-/
namespace Add

open HWComponents

variable (arg0Vld arg1Vld out0Rdy : Stream' (BitVec 1))

/-- The ready signal presented to *each* fork output by the adder chain, as a
pure function of the fork's register state `e` and the current inputs: the
external `out0_ready`, gated backward through `addi1`'s and `addi0`'s joins.
Both fork outputs receive this same signal. -/
def readyThroughAdders (a0v a1v or0 : BitVec 1) (e : BitVec 1 × BitVec 1) :
    BitVec 1 :=
  let f0v := comb_and (comb_xor e.1 (hw_constant true)) a0v  -- fork.out0_valid
  let f1v := comb_and (comb_xor e.2 (hw_constant true)) a0v  -- fork.out1_valid
  let j0 := comb_and f0v f1v      -- addi0.out0_valid
  let j1 := comb_and j0 a1v       -- addi1.out0_valid
  comb_and (comb_and or0 j1) j0

/-- Trajectory of the composed module's only registers — the fork's `emitted`
pair — under the readies computed by the adder chain. -/
def regs : Nat → BitVec 1 × BitVec 1
  | 0 => (0#1, 0#1)
  | n + 1 =>
    let rd := readyThroughAdders (arg0Vld n) (arg1Vld n) (out0Rdy n) (regs n)
    Fork.stepRegs rd rd (arg0Vld n) (regs n)

@[simp] theorem regs_zero : regs arg0Vld arg1Vld out0Rdy 0 = (0#1, 0#1) := by rfl

/-- The ready signal seen by both fork outputs, as a stream. -/
def forkRdy (n : Nat) : BitVec 1 :=
  readyThroughAdders (arg0Vld n) (arg1Vld n) (out0Rdy n)
    (regs arg0Vld arg1Vld out0Rdy n)

theorem regs_succ (n : Nat) :
    regs arg0Vld arg1Vld out0Rdy (n + 1)
      = Fork.stepRegs (forkRdy arg0Vld arg1Vld out0Rdy n)
          (forkRdy arg0Vld arg1Vld out0Rdy n) (arg0Vld n)
          (regs arg0Vld arg1Vld out0Rdy n) := by rfl

/-- **Instantiation lemma**: the composed module's registers are exactly the
abstract fork's registers run against the environment `forkRdy` — the
fork-in-context is the abstract fork of `HWForkSampling.lean` applied to the
(self-consistent) readies computed by the adders, so the whole `Fork` library
applies to it. (Induction on `n`; both recursions step by `Fork.stepRegs` from
`(0#1, 0#1)`, and `forkRdy n` depends only on `regs n`, so the induction
hypothesis closes the loop.) -/
theorem regs_eq_emitted (n : Nat) :
    regs arg0Vld arg1Vld out0Rdy n
      = Fork.emitted (forkRdy arg0Vld arg1Vld out0Rdy)
          (forkRdy arg0Vld arg1Vld out0Rdy) arg0Vld n := by
  induction n
  · simp [Fork.emitted]
  · case _ m ihm =>
    simp [regs_succ, ihm, Fork.emitted]


/-! Named signals of the composed module, defined through the `Fork`
instantiation so that the `Fork` library applies definitionally. -/

/-- Fork `out0_valid` inside the composition. -/
@[bv_normalize]
def fork0Vld (n : Nat) : BitVec 1 :=
  Fork.vldOut1 (forkRdy arg0Vld arg1Vld out0Rdy)
    (forkRdy arg0Vld arg1Vld out0Rdy) arg0Vld n

/-- Fork `out1_valid` inside the composition. -/
@[bv_normalize]
def fork1Vld (n : Nat) : BitVec 1 :=
  Fork.vldOut2 (forkRdy arg0Vld arg1Vld out0Rdy)
    (forkRdy arg0Vld arg1Vld out0Rdy) arg0Vld n

/-- Ready returned to the `arg0` producer (the fork's `in0_ready = allDone`). -/
@[bv_normalize]
def arg0Rdy (n : Nat) : BitVec 1 :=
  Fork.allDone (forkRdy arg0Vld arg1Vld out0Rdy)
    (forkRdy arg0Vld arg1Vld out0Rdy) arg0Vld n

/-- `arith_addi0.out0_valid`: the join of the two fork outputs. -/
@[bv_normalize]
def join0Vld (n : Nat) : BitVec 1 :=
  comb_and (fork0Vld arg0Vld arg1Vld out0Rdy n)
    (fork1Vld arg0Vld arg1Vld out0Rdy n)

/-- `arith_addi1.out0_valid = out0_valid` of the composed module. -/
@[bv_normalize]
def out0Vld (n : Nat) : BitVec 1 :=
  comb_and (join0Vld arg0Vld arg1Vld out0Rdy n) (arg1Vld n)


/-- Ready returned to the `arg1` producer (`arith_addi1.in1_ready`). -/
@[bv_normalize]
def arg1Rdy (n : Nat) : BitVec 1 :=
  comb_and (out0Rdy n) (out0Vld arg0Vld arg1Vld out0Rdy n)

variable (arg0 arg1 : Stream' (BitVec 64))

/-- Data path of the composed module: combinational, `out0 = (arg0 + arg0) + arg1`. -/
@[bv_normalize]
def out0Data (n : Nat) : BitVec 64 := (arg0 n + arg0 n) + arg1 n

/-! ### The transcription computes the named signals -/

/-- `add_rtl`'s corec state is `(n, regs n)` — the analogue of
`iterate_eq_emitted`. (Induction on `n`; the register updates of
`add_rtl_corec` are, after zeta-reduction, exactly
`Fork.stepRegs (readyThroughAdders …) (readyThroughAdders …) (arg0Vld n)`.) -/
theorem add_rtl_iterate {arg2 arg2Vld out1Rdy : Stream' (BitVec 1)} (n : Nat) :
    Stream'.iterate
        (Prod.snd ∘ add_rtl_corec arg0Vld arg1Vld arg2 arg2Vld out0Rdy out1Rdy
          arg0 arg1)
        (0, 0#1, 0#1) n
      = (n, regs arg0Vld arg1Vld out0Rdy n) := by
  induction n
  · simp [Stream'.iterate]
  · case _ m ihm =>
    simp [Stream'.iterate, ihm]
    unfold add_rtl_corec
    simp
    simp [regs_succ, Fork.stepRegs]
    exact Prod.mk_inj.mp _root_.rfl


/-! ### Composition facts -/

/-- **The fork never stalls inside this composition**: both fork outputs see
the same ready (`forkRdy`), and from clear registers both outputs are valid
together, so both receivers always accept in the same cycle — `allDone` fires
in the same cycle as the accepts and the registers never latch. (Induction on
`n`; the step is pointwise: `regs_succ`, `Fork.stepRegs`, `bv_decide`.) -/
theorem regs_eq_zero (n : Nat) :
    regs arg0Vld arg1Vld out0Rdy n = (0#1, 0#1) := by
  induction n
  · simp
  · case _ m ihm =>
    simp [regs_succ, ihm, Fork.stepRegs]
    bv_decide

/-- With the registers identically clear the fork is transparent: `out0_valid`
is the conjunction of the input valids. (Pointwise from `regs_eq_zero`.) -/
theorem out0Vld_eq (n : Nat) :
    out0Vld arg0Vld arg1Vld out0Rdy n
      = comb_and (arg0Vld n) (arg1Vld n) := by
  have hreg : Fork.emitted (forkRdy arg0Vld arg1Vld out0Rdy)
      (forkRdy arg0Vld arg1Vld out0Rdy) arg0Vld n = (0#1, 0#1) :=
    (regs_eq_emitted arg0Vld arg1Vld out0Rdy n).symm.trans
      (regs_eq_zero arg0Vld arg1Vld out0Rdy n)
  simp [out0Vld, join0Vld, fork0Vld, fork1Vld,
      Fork.vldOut1_def, Fork.vldOut2_def, Fork.e0, Fork.e1, hreg]
  bv_decide

/-- With the registers identically clear, the ready returned to `arg0` is the
external ready gated by both valids: the composed module behaves as one
combinational join. (Pointwise from `regs_eq_zero`.) -/
theorem arg0Rdy_eq (n : Nat) :
    arg0Rdy arg0Vld arg1Vld out0Rdy n
      = comb_and (out0Rdy n) (comb_and (arg0Vld n) (arg1Vld n)) := by
  have hreg : Fork.emitted (forkRdy arg0Vld arg1Vld out0Rdy)
      (forkRdy arg0Vld arg1Vld out0Rdy) arg0Vld n = (0#1, 0#1) :=
    (regs_eq_emitted arg0Vld arg1Vld out0Rdy n).symm.trans
      (regs_eq_zero arg0Vld arg1Vld out0Rdy n)
  simp [arg0Rdy, Fork.allDone_def, Fork.done0_def, Fork.fire1_def, Fork.vldOut1_def, Fork.e0,
    Fork.done1, Fork.vldOut2_def, Fork.fire2, Fork.e1, hreg, comb_and, comb_or, comb_xor, hw_constant,
    forkRdy, readyThroughAdders, regs_eq_zero]
  bv_decide

/-- Pointwise characterization of the composed module — the analogue of
`hw_fork'_get`. With `regs_eq_zero`, the corec state is the literal `(0, 0)`
pair, the transcription's body fully reduces, and the named signals collapse
through `out0Vld_eq`/`arg0Rdy_eq`; every component is then `rfl` or a width-1
boolean fact. -/
theorem add_rtl'_get {arg2 arg2Vld out1Rdy : Stream' (BitVec 1)} (n : Nat) :
    add_rtl' arg0Vld arg1Vld arg2 arg2Vld out0Rdy out1Rdy arg0 arg1 n
      = (arg0Rdy arg0Vld arg1Vld out0Rdy n,
         arg1Rdy arg0Vld arg1Vld out0Rdy n,
         out1Rdy n,
         out0Data arg0 arg1 n,
         out0Vld arg0Vld arg1Vld out0Rdy n,
         arg2 n, arg2Vld n) := by
  unfold add_rtl' Stream'.corec' Stream'.corec Stream'.map Stream'.get
  simp only [Function.comp_apply]
  rw [add_rtl_iterate, regs_eq_zero]
  simp only [add_rtl_corec]
  simp only [arg1Rdy, out0Vld_eq, arg0Rdy_eq, out0Data]
  simp only [HWComponents.comb_and, HWComponents.comb_or, HWComponents.comb_xor,
             HWComponents.hw_constant, HWComponents.comb_add, comb_and,
             reduceIte, Prod.mk.injEq]
  and_intros <;> first | rfl | bv_decide

/-! ### Correctness -/

/-- Split a stream of `add_rtl`-shaped 7-tuples into its component streams
(mirrors `TRY3.split_stream2` for the fork's 5-tuples). -/
def split_stream7 {a b c d e f g : Type} :
    Stream' (a × b × c × d × e × f × g) →
      Stream' a × Stream' b × Stream' c × Stream' d × Stream' e × Stream' f
        × Stream' g := fun s =>
  (fun i => (s i).1, fun i => (s i).2.1, fun i => (s i).2.2.1,
   fun i => (s i).2.2.2.1, fun i => (s i).2.2.2.2.1,
   fun i => (s i).2.2.2.2.2.1, fun i => (s i).2.2.2.2.2.2)

/-- The components produced by `add_rtl` are exactly the named signals of this
section — the analogue of `hw_fork_components`. (Route: an
`iterate_eq_emitted`-style lemma identifying `add_rtl`'s corec state with
`(n, regs n)`, then read off each output component pointwise.) -/
theorem add_rtl_components
    {arg2 arg2Vld out1Rdy : Stream' (BitVec 1)}
    {arg0Rdy' arg1Rdy' arg2Rdy' out0Vld' out1' out1Vld' : Stream' (BitVec 1)}
    {out0' : Stream' (BitVec 64)}
    (hadd : (arg0Rdy', arg1Rdy', arg2Rdy', out0', out0Vld', out1', out1Vld')
      = split_stream7 (add_rtl arg0Vld arg1Vld arg2 arg2Vld out0Rdy out1Rdy
          arg0 arg1)) :
    arg0Rdy' = arg0Rdy arg0Vld arg1Vld out0Rdy
      ∧ arg1Rdy' = arg1Rdy arg0Vld arg1Vld out0Rdy
      ∧ arg2Rdy' = out1Rdy
      ∧ out0' = out0Data arg0 arg1
      ∧ out0Vld' = out0Vld arg0Vld arg1Vld out0Rdy
      ∧ out1' = arg2 ∧ out1Vld' = arg2Vld := by
  simp [add_rtl_eq, split_stream7, Prod.mk.injEq] at hadd
  obtain ⟨h1, h2, h3, h4, h5, h6, h7⟩ := hadd
  and_intros
  · simp [h1, add_rtl'_get]
  · simp [h2, add_rtl'_get]
  · simp [h3, add_rtl'_get]
  · simp [h4, add_rtl'_get]
  · simp [h5, add_rtl'_get]
  · simp [h6, add_rtl'_get]
  · simp [h7, add_rtl'_get]


/-- **Lowering correctness for the composed `add` module**: given the RTL
circuit `add_rtl` (via its output streams, bound by `hadd` — the analogue of
the fork equation in `hw_fork_refines_out1`), the handshake-level program
applied to the token streams of the two inputs is bisimilar to the token
stream of the RTL output.

Proof plan: `add_rtl_components` + `subst` reduce the goal to the named
signals; by `regs_eq_zero` and its corollaries the RTL side is a single
combinational join (`out0Vld_eq`, `arg0Rdy_eq`, data path `out0Data`); the
fork contributes no further proof obligations. What remains is the handshake
side: `HandshakeOp.fork x = (x, x)` and a `syncMap₂_aligned` lemma (when the
two argument streams carry their `some`s at identical positions, `syncMap₂ f`
is the pointwise zip). Both token inputs here fire at the same instants
(`arg0Rdy ∧ arg0Vld` and `arg1Rdy ∧ arg1Vld` both reduce to
`out0Rdy ∧ arg0Vld ∧ arg1Vld`), so the two sides are pointwise *equal* and
`~` follows by reflexivity — the handshake contract hypotheses are not needed:
with the registers identically clear the composed module is memoryless, and
the contracts only existed to tame register skew. -/
theorem add_lowering_correctness
    {arg2 arg2Vld out1Rdy : Stream' (BitVec 1)}
    {arg0Rdy' arg1Rdy' arg2Rdy' out0Vld' out1' out1Vld' : Stream' (BitVec 1)}
    {out0' : Stream' (BitVec 64)}
    (hadd : (arg0Rdy', arg1Rdy', arg2Rdy', out0', out0Vld', out1', out1Vld')
      = split_stream7 (add_rtl arg0Vld arg1Vld arg2 arg2Vld out0Rdy out1Rdy
          arg0 arg1)) :
    add_handshake
        (toStream arg0Rdy' arg0Vld arg0)
        (toStream arg1Rdy' arg1Vld arg1)
      ~ toStream out0Rdy out0Vld' out0' := by
  obtain ⟨h1, h2, -, h4, h5, -, -⟩ :=
    add_rtl_components arg0Vld arg1Vld out0Rdy arg0 arg1 hadd
  subst h1 h2 h4 h5
  have hcase : ∀ b : BitVec 1, b = 0#1 ∨ b = 1#1 := by
    intro b
    by_cases hb : b = 1#1
    · exact Or.inr hb
    · exact Or.inl (HWComponents.false_of_width_one _ hb)
  have hbisim_of_eq : ∀ {a b : Stream (BitVec 64)}, a = b → a ~ b := by
    intro a b heq
    rw [heq]
    exact HandshakeStream.rfl
  unfold add_handshake
  rw [HandshakeOp.fork_eq]
  dsimp only []
  rw [syncMap₂_aligned (fun _ => Iff.rfl)]
  have hal : ∀ n,
      ((alignedZip BitVec.add
          (toStream (arg0Rdy arg0Vld arg1Vld out0Rdy) arg0Vld arg0)
          (toStream (arg0Rdy arg0Vld arg1Vld out0Rdy) arg0Vld arg0)) n).isSome
        ↔ (toStream (arg1Rdy arg0Vld arg1Vld out0Rdy) arg1Vld arg1 n).isSome := by
    intro n
    rcases hcase (arg0Vld n) with h0 | h0 <;>
      rcases hcase (arg1Vld n) with ha | ha <;>
        rcases hcase (out0Rdy n) with hr | hr <;>
          simp [alignedZip, toStream, arg1Rdy, out0Vld_eq, arg0Rdy_eq, h0, ha, hr,
                HWComponents.comb_and]
  rw [syncMap₂_aligned hal]
  apply hbisim_of_eq
  funext n
  rcases hcase (arg0Vld n) with h0 | h0 <;>
    rcases hcase (arg1Vld n) with ha | ha <;>
      rcases hcase (out0Rdy n) with hr | hr <;>
        simp [alignedZip, toStream, arg1Rdy, out0Vld_eq, arg0Rdy_eq, out0Data,
              h0, ha, hr, HWComponents.comb_and, BitVec.add_eq]

end Add
end HandshakeStream
