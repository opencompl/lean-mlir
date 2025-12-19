import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas
import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Register.Lemmas

namespace HandshakeStream

/-!
  # Add

  We add a circuit that given two inputs `a` and `b` performs two additions: `(a + a) + b`.

  We insert buffers in the handshake program and lower it to rtl level, considering all the
  buffer configurations CIRCT inserts.

  The hardware (lowered) module is a function over the `Stream'` type,
  which does not contain `Option` values, because at this level
  of abstractions the content of streams has been concretized.

  See: https://github.com/opencompl/DC-semantics-simulation-evaluation/commit/bf86f7247a767d97516a05a29e313634e5172398

-/

/--
  Handshake program after buffers' insertion::

  handshake.func @add(%arg0: index, %arg1: index, %arg2: none, ...) -> (index, none) attributes {argNames = ["arg0", "arg1", "arg2"], resNames = ["out0", "out1"]} {
    %0 = buffer [2] seq %arg2 : none
    %1 = arith.addi %arg0, %arg0 : index
    %2 = buffer [2] seq %1 : index
    %3 = arith.addi %2, %arg1 : index
    %4 = buffer [2] seq %3 : index
    return %4, %0 : index, none
  }

-/
def add_handshake (a b : Stream (BitVec 64)) :=
  corec (a, b) fun
    (x, y) =>
    match x 0, y 0 with
    | some x0, some y0 => (some (x0 + y0), x.tail, y.tail)
    | some _, none => (none, x, y.tail)
    | none, some _ => (none, x.tail, y)
    | none, none => (none, x.tail, y.tail)

/-
  RTL program, config. 1:

module {
  hw.module @add(in %a : i32, in %a_valid : i1, in %b : i32, in %b_valid : i1, in %clk : !seq.clock, in %rst : i1, in %out0_ready : i1, out a_ready : i1, out b_ready : i1, out out0 : i32, out out0_valid : i1) {
    %false = hw.constant false
    %c0_i0 = hw.constant 0 : i0
    %c0_i0_0 = hw.constant 0 : i0
    %c0_i0_1 = hw.constant 0 : i0
    %false_2 = hw.constant false
    %true = hw.constant true
    %0 = comb.xor %12, %true : i1
    %1 = comb.and %5, %0 : i1
    %emitted_0 = seq.compreg sym @emitted_0 %1, %clk reset %rst, %false_2 : i1
    %2 = comb.xor %emitted_0, %true : i1
    %3 = comb.and %2, %a_valid : i1
    %4 = comb.and %16, %3 : i1
    %5 = comb.or %4, %emitted_0 {sv.namehint = "done0"} : i1
    %6 = comb.xor %12, %true : i1
    %7 = comb.and %11, %6 : i1
    %emitted_1 = seq.compreg sym @emitted_1 %7, %clk reset %rst, %false_2 : i1
    %8 = comb.xor %emitted_1, %true : i1
    %9 = comb.and %8, %a_valid : i1
    %10 = comb.and %16, %9 : i1
    %11 = comb.or %10, %emitted_1 {sv.namehint = "done1"} : i1
    %12 = comb.and %5, %11 {sv.namehint = "allDone"} : i1
    %13 = comb.extract %a from 0 : (i32) -> i31
    %14 = comb.concat %13, %false : i31, i1
    %c0_i0_3 = hw.constant 0 : i0
    %c0_i0_4 = hw.constant 0 : i0
    %15 = comb.and %b_valid, %9, %3 : i1
    %16 = comb.and %out0_ready, %15 : i1
    %17 = comb.add %14, %b : i32
    hw.output %12, %16, %17, %15 : i1, i1, i32, i1
  }
}

  `add` performs two additions given inputs `a` and `b`: (a + a) + b

  The hardware (lowered) module is a function over the `Stream'` type,
  which does not contain `Option` values, because at this level
  of abstractions the content of streams has been concretized.
-/
def add
  (xst : Stream' (wiresStruc 2 3)) :
    Stream' (wiresStruc 1 3) :=
  register_wrapper_generalized
              (inputs := xst)
              (init_regs := {result := #v[], signals := #v[0#1, 0#1]})
              (outops := 1)
              (outsigs := 3)
              (update_fun :=
                        fun (inp, regs) =>
                            let v2 := BitVec.xor regs.signals[0] 1#1
                            let v8 := BitVec.xor regs.signals[1] 1#1
                            let v3 := BitVec.and v2 inp.signals[0] -- inp a_valid
                            let v9 := BitVec.and v8 inp.signals[0] -- inp a_valid
                            let v15 := BitVec.and inp.signals[1] (BitVec.and v9 v3) -- inp b_valid
                            let v16 := BitVec.and inp.signals[2] v15 --inp out_ready
                            let v10 := BitVec.and v16 v9
                            let v4 := BitVec.and v16 v3
                            let v11 := BitVec.or v10 regs.signals[1] -- emitted_1
                            let v5 := BitVec.or v4 regs.signals[0] -- emitted_0
                            let v12 := BitVec.and v5 v11
                            let v0 := BitVec.xor v12 1#1
                            let v1 := BitVec.and v5 v0
                            let v6 := BitVec.xor v12 1#1
                            let v7 := BitVec.and v11 v6
                            let v13 := BitVec.extractLsb' 0 31 inp.result[0] -- a
                            let v14 := BitVec.concat v13 false
                            let v17 : BitVec 32 := BitVec.add v14 inp.result[1] -- b
                            let updated_reg0 := v1
                            let updated_reg1 := v7
                           ⟨{result := #v[v17], signals := #v[v12, v16, v15]},
                            {result := #v[], signals := #v[updated_reg0, updated_reg1]}⟩
                )
