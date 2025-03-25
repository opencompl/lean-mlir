import SSA.Projects.RISCV.RV64
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Util

open MLIR AST in

-- additional lemmas introduced for the proofs.

--@[simp] --> to do: fix it
theorem get_cons_succ0 {A : α → Type*} {a : α} {as : List α}
  (e : A a) (vec : HVector A as) (i : Fin as.length) :
  (e::ₕvec).get i.succ = vec.get i := by rfl -- extracting the i succ elem is like extracting the i elem from the remaining list

--@[simp]
--theorem get_cons_succ {A : α → Type*} {a : α} {as : List α}
  --(e : A a) (vec : HVector A as) (i : Fin (as.length)):
  --((e::ₕvec)).get ((i + 1)) = ((vec) : HVector A (as)).get (i : Fin (as.length))  := by rfl -- extracting the i succ elem is like extracting the i elem from the remaining list

--@[simp]
theorem get_cons_1 {A : α → Type*} {a b: α} {as : List α}
  (e : A a) (f : A b) (vec : HVector A as)  :
--((e::ₕ (f ::ₕ vec)) : HVector A (a :: b :: as)).get ⟨1, by simp⟩ = f := by rfl -- extracting the i succ elem is like extracting the i elem from the remaining list
  ((e::ₕ (f ::ₕ vec)) : HVector A (a :: b :: as)).get (1 : Fin (as.length + 2)) = f := by rfl -- extracting the i succ elem is like extracting the i elem from the remaining list


-- modelled the same rewrites done on the llvm ir level in assembly
--next goal:
  ---extract the llvm based on bitvectors

-- add rd rs1 rs1 <-> slli rd rs1 $1
theorem addTwice_eq_shiftLeftOnce :
  [RV64_com| {
  ^entry (%0: !i64 ):
  %1 = "RV64.add" (%0, %0) : (!i64, !i64) -> (!i64)
  "return" (%1) : (!i64) -> ()
  }].denote =
  [RV64_com| {
  ^entry (%0 : !i64 ):
    %1 = "RV64.slli" (%0) { shamt = 1 : !i64 } : ( !i64) -> (!i64)
    "return" (%1) : (!i64 ) -> ()
}].denote := by
  funext Γv
  simp_peephole at Γv -- simplifies a :: in the resolve what values variables map to --> directly TV v for some variable v which gives me the valuation of the varialbe of ty in cotext T
  simp
  unfold RV64.RTYPE_pure64_RISCV_ADD RV64.SHIFTIOP_pure64_RISCV_SLLI
  bv_decide


/-  add rd rs1 rs1
    add rd rd rd
    ==
    slli rd rs1 $2
-/

  theorem addFourth_eq_shiftLeftTwice :
    [RV64_com| {
    ^entry (%0: !i64 ):
    %1 = "RV64.add" (%0, %0) : (!i64, !i64) -> (!i64)
    %2 = "RV64.add" (%1, %1) : (!i64, !i64) -> (!i64)
    "return" (%2) : (!i64) -> ()
    }].denote =
    [RV64_com| {
    ^entry (%0 : !i64 ):
      %1 = "RV64.slli" (%0) { shamt = 2 : !i64 } : ( !i64) -> (!i64)
      "return" (%1) : ( !i64 ) -> ()
  }].denote := by
    funext Γv
    simp_peephole at Γv
    simp
    unfold RV64.RTYPE_pure64_RISCV_ADD RV64.SHIFTIOP_pure64_RISCV_SLLI
    simp [BitVec.add_eq, BitVec.toNat_ofNat, Nat.reducePow, Nat.reduceMod, BitVec.shiftLeft_eq]
    intro e
    show @Eq (BitVec _) (e + e + (e + e)) (e <<< 2) -- used to help Lean to discover the type of the operation
    --show (e + e + (e + e)) = (e <<< 2) also works
    bv_decide


/-  and rd rs1 $0
    ==
    $0
-/
  theorem andZero_eq_zero :
    [RV64_com| {
    ^entry (%0: !i64 ):
      %1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
      %2 = "RV64.and" (%0, %1) : ( !i64, !i64 ) -> (!i64)
      "return" (%2) : ( !i64) -> ()
  }].denote =
    [RV64_com| {
    ^entry (%0 : !i64 ):
      %1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
      "return" (%1) : ( !i64 ) -> ()
  }].denote := by
      funext Γv
      simp_peephole at Γv
      simp
      unfold RV64.RTYPE_pure64_RISCV_AND RV64.const_func
      bv_decide

/-  mul rd rs1 $1
    ==
    slli rd rs1 $0
-/
  theorem mulOne_eq_shiftZero :
    [RV64_com| {
    ^entry (%0: !i64 ):
      %1 = "RV64.const" () { val = 1 : !i64  } : (!i64) -> (!i64)
      %2 = "RV64.mulu" (%0, %1) : ( !i64, !i64 ) -> (!i64)
      "return" (%2) : ( !i64 ) -> ()
  }].denote =
    [RV64_com| {
    ^entry (%0 : !i64 ):
      %1 = "RV64.slli" (%0) { shamt = 0 : !i64 } : ( !i64) -> (!i64)
      "return" (%1) : ( !i64 ) -> ()
  }].denote := by
      funext Γv
      simp_peephole at Γv
      simp
      unfold RV64.MUL_pure64_fff RV64.SHIFTIOP_pure64_RISCV_SLLI RV64.const_func
      intro e
      show @Eq (BitVec _) _ _
      simp [get_cons_1]
      bv_decide

/-
    sub rd rs1 rs1
    xor rd rd rs2
    return rd
    ==
    return rs2
-/
  theorem xor_sub : -- taken from the peephole rewrite
    [RV64_com| {
      ^entry (%r1: !i64, %r2: !i64 ) :
        %0 = "RV64.sub" (%r1, %r1) : (!i64,!i64 ) -> (!i64)
        %1 = "RV64.xor" (%0,%r2) : (!i64,!i64 ) -> (!i64)
      "return" (%1) : (!i64 ) -> ()
    }].denote =
    [RV64_com| {
      ^entry (%r1: !i64, %r2: !i64 ) :
       "return" (%r2) : (!i64 ) -> ()
      }].denote := by
      funext Γv
      simp_peephole at Γv
      simp only [Fin.isValue, HVector.cons_get_zero]
      intros e s
      unfold RV64.RTYPE_pure64_RISCV_XOR RV64.RTYPE_pure64_RISCV_SUB
      show @Eq (BitVec 64) _ _
      --show @Eq (BitVec 64) ((s.sub s).xor e) e
      bv_decide


/-  xor rd x1 x1
    return rd
    ==
    return $0
-/
def RISCVEg1 := [RV64_com| {
  ^entry (%x1: !i64):
    %1 = "RV64.xor" (%x1, %x1) : (!i64, !i64) -> (!i64)
    "return" (%1) : (!i64) -> ()
}].denote

def RISCVZero := [RV64_com| {
  ^entry (%x1: !i64):
    %1 =  "RV64.const" () { val = 0 : !i64  } : (!i64) -> (!i64)
    "return" (%1) : (!i64) -> ()
}].denote

theorem xor_eq_zero :
  RISCVEg1 = RISCVZero := by
  unfold RISCVEg1 RISCVZero
  funext Γv
  simp_peephole at Γv
  intro e
  unfold RV64.RTYPE_pure64_RISCV_XOR RV64.const_func
  rw[HVector.cons_get_zero]
  show @Eq (BitVec 64) _ _
  bv_decide


/-
-/
def RISCVEg25 := [RV64_com| {
  ^entry (%0: !i64 ):
    %1 = "RV64.const" () { val = 2 : !i64  } : ( !i64 ) -> (!i64)
    %2 = "RV64.mulu" (%0, %1)  : ( !i64, !i64 ) -> (!i64)
    "return" (%2) : ( !i64, !i64 ) -> ()
}].denote

def RISCVEg26 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "RV64.mulu" (%0, %1)  : ( !i64, !i64 ) -> (!i64)
    "return" (%2) : ( !i64, !i64 ) -> ()
}].denote



-- section where I start to rewrite things from alive

/-  add rd rs1 rs1
    ==
    slli rd rs1 1
-/
def RISCVE_AddSub_src := [RV64_com| {
  ^entry (%0: !i64 ):
    %v1 = "RV64.add" (%0, %0) : ( !i64, !i64 ) -> (!i64)
    "return" (%v1) : ( !i64, !i64 ) -> ()
}].denote

def RISCVE_AddSub_opt := [RV64_com| {
  ^entry (%0: !i64 ):
    %v1 = "RV64.slli" (%0) { shamt = 1 : !i64 } : ( !i64) -> (!i64)
    "return" (%v1) : ( !i64, !i64 ) -> ()
}].denote

theorem RISCV64_AddSub : RISCVE_AddSub_src = RISCVE_AddSub_opt := by
  unfold RISCVE_AddSub_src RISCVE_AddSub_opt
  funext Γv
  simp_peephole at Γv
  intro e
  unfold RV64.RTYPE_pure64_RISCV_ADD RV64.SHIFTIOP_pure64_RISCV_SLLI
  rw [HVector.cons_get_zero, HVector.cons_get_zero]
  bv_decide


/-  sub rd1 v1 $0 -- -a
    add rd2 rd1 b -- (-a) + b
    return rd2 -- (-a) + b
    ==
    sub rd b v1
-/

def RISCVE_AddSub1164_src := [RV64_com| {
  ^entry (%a: !i64, %b: !i64 ):
    %v1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %v2 = "RV64.sub" (%a, %v1 ) : ( !i64, !i64 ) -> (!i64)
    %v3 = "RV64.add" (%v2 , %b ) : ( !i64, !i64 ) -> (!i64)
    "return" (%v3) : (!i64, !i64) -> ()
}].denote

def RISCVE_AddSub1164_opt := [RV64_com| {
  ^entry (%a: !i64, %b: !i64 ):
    %v1 = "RV64.sub" (%a, %b) : ( !i64, !i64 ) -> (!i64) -- b - a
    "return" (%v1) : (!i64, !i64) -> ()
}].denote

theorem RISCV64_AddSub1164 :
  RISCVE_AddSub1164_src = RISCVE_AddSub1164_opt := by
  unfold RISCVE_AddSub1164_opt RISCVE_AddSub1164_src
  funext Γv
  simp_peephole at Γv
  intro e1 e2
  unfold RV64.RTYPE_pure64_RISCV_ADD RV64.RTYPE_pure64_RISCV_SUB RV64.const_func
  simp [HVector.cons_get_zero]
  bv_decide

/-  sub rd1 v1 $0 -- -a
    add rd2 rd1 b -- (-a) + b
    return rd2 -- (-a) + b
    ==
    sub rd b v1
-/
def RISCVE_AddSub1164_src2 := [RV64_com| {
  ^entry (%a: !i64, %b: !i64 ):
    %v1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %v2 = "RV64.sub" (%a, %v1 ) : ( !i64, !i64 ) -> (!i64) -- 0-a
    %v3 = "RV64.add" (%b, %v2 ) : ( !i64, !i64 ) -> (!i64) -- b - a
    "return" (%v3) : (!i64, !i64) -> ()
}].denote


def RISCVE_AddSub1164_opt2 := [RV64_com| {
  ^entry (%a: !i64, %b: !i64 ):
    %v1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64) -- 0
    %v2 = "RV64.sub" (%a, %v1 ) : ( !i64, !i64 ) -> (!i64) -- 0 - a basically dead code
    %v3 = "RV64.sub" ( %a ,  %b ) : ( !i64, !i64 ) -> (!i64) -- b- a
    "return" (%v3) : (!i64, !i64) -> ()
}].denote

theorem RISCV64_AddSub1164_2 :
  RISCVE_AddSub1164_src2 = RISCVE_AddSub1164_opt2 := by
  unfold RISCVE_AddSub1164_opt2 RISCVE_AddSub1164_src2
  funext Γv
  simp_peephole at Γv
  intro e1 e2
  unfold RV64.RTYPE_pure64_RISCV_SUB RV64.const_func RV64.RTYPE_pure64_RISCV_ADD
  simp [HVector.cons_get_zero]
  show @Eq (BitVec 64) _ _
  bv_decide



def RV64_DivRemOfSelect_src := [RV64_com| {
  ^entry (%c: !i64, %y: !i64, %x: !i64):
    %c0 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64) -- 0
    %v1 = "RV64.czero.nez" ( %c0, %y ) : ( !i64, !i64 ) -> (!i64) -- if c0 is zero then y else 0 --> fixed to y
    %v2 = "RV64.divu" ( %v1, %x ) : ( !i64, !i64 ) -> (!i64) -- x / v1
    "return" (%v2) : (!i64, !i64,!i64 ) -> ()
}].denote

def RV64_DivRemOfSelect_opt := [RV64_com| {
  ^entry (%c: !i64, %y: !i64, %x: !i64):
    %v1 = "RV64.divu" ( %y, %x )  : ( !i64, !i64 ) -> (!i64) -- x / y
    "return" (%v1) : (!i64) -> ()
}].denote

theorem RV64_DivRemOfSelect :
 RV64_DivRemOfSelect_src = RV64_DivRemOfSelect_opt :=
  by
  unfold RV64_DivRemOfSelect_src RV64_DivRemOfSelect_opt
  funext Γv
  simp_peephole at Γv
  simp
  intro e1 e2
  unfold RV64.ZICOND_RTYPE_pure64_RISCV_RISCV_CZERO_NEZ RV64.const_func RV64.DIV_pure64_unsigned
  simp only [Nat.sub_zero, Nat.reduceAdd, BitVec.zero_eq, ↓reduceIte, BitVec.extractLsb_toNat,
    Nat.shiftRight_zero, Nat.reducePow, Int.ofNat_eq_coe, Int.ofNat_emod, Nat.cast_ofNat,
    Int.reduceNeg, Int.ofNat_toNat]


def RISCVEgDCE_src := [RV64_com| {
  ^entry (%x1: !i64):
    %0 = "RV64.add" (%x1, %x1) : (!i64, !i64) -> (!i64) -- dead code not used
    %1 = "RV64.add" (%x1, %x1) : (!i64, !i64) -> (!i64)
    "return" (%1) : (!i64) -> ()
}].denote

def RISCVDCE_opt := [RV64_com| {
  ^entry (%x1: !i64):
    %0 = "RV64.add" (%x1, %x1) : (!i64, !i64) -> (!i64)
    "return" (%0) : (!i64) -> ()
}].denote

theorem DCE1 :
  RISCVEgDCE_src = RISCVDCE_opt := by
    unfold RISCVEgDCE_src RISCVDCE_opt
    funext Γv
    simp_peephole at Γv


/-
%r = sdiv 1, %X
  =>
%inc = add %X, 1
%c = icmp ult %inc, 3
%r = select %c, %X, 0
-/


/-
def alive_DivRemOfSelect_src (w : Nat) :=
  [llvm(w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %c0 = llvm.mlir.constant(0) : _
    %v1 = llvm.select %c, %y, %c0
    %v2 = llvm.udiv %x,  %v1
    llvm.return %v2
  }]
def alive_DivRemOfSelect_tgt (w : Nat) :=
  [llvm(w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %v1 = llvm.udiv %x, %y
    llvm.return %v1
  }]
-/

/-
%r = sdiv 1, %X
  =>
%inc = add %X, 1
%c = icmp ult %inc, 3
%r = select %c, %X, 0
-/


/-
  ^entry(%0 : ToyRegion.Ty.int):
    %1 = ToyRegion.Op.const 0 : () → (ToyRegion.Ty.int)
    %2 = ToyRegion.Op.add (%1, %0) : (ToyRegion.Ty.int, ToyRegion.Ty.int) → (ToyRegion.Ty.int)
    %3 = ToyRegion.Op.iterate 0 (%2) ({
      ^entry(%0 : ToyRegion.Ty.int):
        %1 = ToyRegion.Op.const 0 : () → (ToyRegion.Ty.int)
        %2 = ToyRegion.Op.add (%1, %0) : (ToyRegion.Ty.int, ToyRegion.Ty.int) → (ToyRegion.Ty.int)
        return %2 : (ToyRegion.Ty.int) → ()
    }) : (ToyRegion.Ty.int) → (ToyRegion.Ty.int)
    return %3 : (ToyRegion.Ty.int) → ()
}
-/
