import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas
import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Register.Lemmas

namespace HandshakeStream

abbrev option_bitvec (n : Nat) : Type := Option (BitVec n)

abbrev stream_option (n : Nat) : Type := Stream' (option_bitvec n)

def convertVecToStream {l : List Nat} (xv : HVector stream_option l) : Stream' (HVector option_bitvec l) :=
  fun (i : Nat) =>
    xv.map (fun {n : Nat} (s : stream_option n) => s i)

def convertStreamToVec {l : List Nat} (xv : Stream' (HVector option_bitvec l)) : HVector stream_option l :=
  HVector.ofFn stream_option l (fun (k : Fin l.length) => fun (i : Nat) => (xv i).get k)

/-
Handshake program (https://github.com/opencompl/DC-semantics-simulation-evaluation/blob/main/benchmarks/add_naive/handshake.mlir) :

handshake.func @add(%a : i32, %b : i32) -> i32{
    %add1 = comb.add %a, %a : i32
    %add2 = comb.add %add1, %b : i32
    return %add2: i32
}
-/
def add_handshake (a b : stream_option 64) :=
  let ⟨fork_0, fork_1⟩ := HandshakeOp.fork a
  let addi_1 := syncMap₂ BitVec.add fork_0 fork_1
  let addi_2 := syncMap₂ BitVec.add addi_1 b
  addi_2

/-
  Lowered program (https://github.com/opencompl/DC-semantics-simulation-evaluation/blob/main/benchmarks/add_naive/HW-hw.mlir):
-/

/--
  hw.module @handshake_fork_in_ui64_out_ui64_ui64(in %in0 : !esi.channel<i64>, in %clock : !seq.clock, in %reset : i1, out out0 : !esi.channel<i64>, out out1 : !esi.channel<i64>) {
    %true = hw.constant true
    %false = hw.constant false
    %rawOutput, %valid = esi.unwrap.vr %in0, %12 : i64
    %chanOutput, %ready = esi.wrap.vr %rawOutput, %3 : i64
    %chanOutput_0, %ready_1 = esi.wrap.vr %rawOutput, %9 : i64
    %0 = comb.xor %12, %true : i1
    %1 = comb.and %5, %0 : i1
    %emitted_0 = seq.compreg sym @emitted_0 %1, %clock reset %reset, %false : i1
    %2 = comb.xor %emitted_0, %true : i1
    %3 = comb.and %2, %valid : i1
    %4 = comb.and %ready, %3 : i1
    %5 = comb.or %4, %emitted_0 {sv.namehint = "done0"} : i1
    %6 = comb.xor %12, %true : i1
    %7 = comb.and %11, %6 : i1
    %emitted_1 = seq.compreg sym @emitted_1 %7, %clock reset %reset, %false : i1
    %8 = comb.xor %emitted_1, %true : i1
    %9 = comb.and %8, %valid : i1
    %10 = comb.and %ready_1, %9 : i1
    %11 = comb.or %10, %emitted_1 {sv.namehint = "done1"} : i1
    %12 = comb.and %5, %11 {sv.namehint = "allDone"} : i1
    hw.output %chanOutput, %chanOutput_0 : !esi.channel<i64>, !esi.channel<i64>
  }
-/
def handshake_fork_in_ui64_out_ui64_ui64
    (inputs : Stream' (HVector option_bitvec [64, 64])) :
    Stream' (HVector option_bitvec [64, 64])  :=
  het_register_wrapper
    (inputs := inputs)
    (ls := [64, 64]) (lout := [64, 64])
    (init_regs := HVector.cons (some 0#64) <| HVector.cons (some 0#64) <| HVector.nil)
    (update_fun :=
      fun (inp, regs) =>
        let regs_0 := let e := (regs.get ⟨0, by simp⟩)
        let regs_1 := let e := (regs.get ⟨1, by simp⟩)
        let out0_valid := (emitted_0 ^^^ 1#1) &&& in0_valid

        let valid :=
        let v2 := regs_0 ^^^ 1#1 -- emitted_0
        let v3 := v2 &&& inp.signals[0] -- in0_valid
        let v4 := inp.signals[1] &&& v3 -- out0_ready
        let v5 := v4 ||| regs_0
        let v8 := regs_1 ^^^ 1#1 -- emitted_1
        let v9 := v8 &&& inp.signals[0] -- in0_valid
        let v10 := inp.signals[2] &&& v9 -- out1_ready
        let v11 := v10 ||| regs_1
        let v12 := v5 &&& v11
        let v0 := v12 ^^^ 1#1
        let v1 := v5 &&& v0
        let v6 := v12 ^^^ 1#1
        let v7 := v11 &&& v6
        let updated_reg0 := v1
        let updated_reg1 := v7
      )


/--
  hw.module @arith_addi_in_ui64_ui64_out_ui64(in %in0 : !esi.channel<i64>, in %in1 : !esi.channel<i64>, out out0 : !esi.channel<i64>) {
    %rawOutput, %valid = esi.unwrap.vr %in0, %1 : i64
    %rawOutput_0, %valid_1 = esi.unwrap.vr %in1, %1 : i64
    %chanOutput, %ready = esi.wrap.vr %2, %0 : i64
    %0 = comb.and %valid, %valid_1 : i1
    %1 = comb.and %ready, %0 : i1
    %2 = comb.add %rawOutput, %rawOutput_0 : i64
    hw.output %chanOutput : !esi.channel<i64>
  }
-/
def arith_addi_in_ui64_ui64_out_ui64
  (xst : Stream' (wiresStruc 2 3 64)) :
    Stream' (wiresStruc 1 3 64) :=
  fun i =>
    let xst_tovecs := streams_to_vec'
    let valid := xs



/--
hw.module @add(in %arg0 : !esi.channel<i64>, in %arg1 : !esi.channel<i64>, in %arg2 : !esi.channel<i0>, in %clock : !seq.clock, in %reset : i1, out out0 : !esi.channel<i64>, out out1 : !esi.channel<i0>) {
    %handshake_fork0.out0, %handshake_fork0.out1 = hw.instance "handshake_fork0" @handshake_fork_in_ui64_out_ui64_ui64(in0: %arg0: !esi.channel<i64>, clock: %clock: !seq.clock, reset: %reset: i1) -> (out0: !esi.channel<i64>, out1: !esi.channel<i64>)
    %arith_addi0.out0 = hw.instance "arith_addi0" @arith_addi_in_ui64_ui64_out_ui64(in0: %handshake_fork0.out0: !esi.channel<i64>, in1: %handshake_fork0.out1: !esi.channel<i64>) -> (out0: !esi.channel<i64>)
    %arith_addi1.out0 = hw.instance "arith_addi1" @arith_addi_in_ui64_ui64_out_ui64(in0: %arith_addi0.out0: !esi.channel<i64>, in1: %arg1: !esi.channel<i64>) -> (out0: !esi.channel<i64>)
    hw.output %arith_addi1.out0, %arg2 : !esi.channel<i64>, !esi.channel<i0>
  }
-/

-/

/--
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
