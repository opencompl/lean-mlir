import SSA.Projects.RISCV.RV64
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Util

open MLIR AST in

--typing test

theorem addTwice_eq_shiftLeftOnce :
  [RV64_com| {
  ^entry (%0: !i64 ):
  %1 = "RV64.add" (%0, %0) : (!i64, !i64) -> (!i64)
  "return" (%1) : (!i64) -> ()
  }].denote =
  [RV64_com| {
  ^entry (%0 : !i64 ):
    %1 = "RV64.slli" (%0) { shamt = 1 : !i64 } : ( !i64) -> (!i64)
    "return" (%1) : ( !i64 ) -> ()
}].denote := by
  funext Γv
  simp_peephole at Γv
  simp
  unfold RV64.RTYPE_pure64_RISCV_ADD RV64.SHIFTIOP_pure64_RISCV_SLLI
  bv_decide

theorem bitvec : e + e + (e + e) = BitVec.mul e 4#64 := by bv_decide

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
  intro
  rw [bitvec]
  bv_decide

theorem andZero_eq_zero :
  [RV64_com| {
  ^entry (%0: !i64 ):
    %1 = "RV64.const" (%0) { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %2 = "RV64.and" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    "return" (%2) : ( !i64) -> ()
}].denote =
  [RV64_com| {
  ^entry (%0 : !i64 ):
     %1 = "RV64.const" (%0) { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    "return" (%1) : ( !i64 ) -> ()
}].denote := by
    funext Γv
    simp_peephole at Γv
    simp
    unfold RV64.RTYPE_pure64_RISCV_AND RV64.const_func
    bv_decide


theorem t2 :
  [RV64_com| {
  ^entry (%0: !i64 ):
    %1 = "RV64.const" (%0) { val = 1 : !i64  } : ( !i64 ) -> (!i64)
    %2 = "RV64.mul" (%0, %1)  { high = 0 : !i64 , s1 = 0 : !i64, s2 = 0 : !i64  } : ( !i64, !i64 ) -> (!i64)
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
    intro
    simp
    bv_decide




def RISCVEg25 := [RV64_com| {
  ^entry (%0: !i64 ):
    %1 = "RV64.const" (%0) { val = 2 : !i64  } : ( !i64 ) -> (!i64)
    %2 = "RV64.mul" (%0, %1)  { high = 0 : !i64 , s1 = 0 : !i64, s2 = 0 : !i64  } : ( !i64, !i64 ) -> (!i64)
    "return" (%2) : ( !i64, !i64 ) -> ()
}]

def RISCVEg26 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "RV64.mul" (%0, %1)  { high = 0 : !i64 , s1 = 0 : !i64, s2 = 0 : !i64  } : ( !i64, !i64 ) -> (!i64)
    "return" (%2) : ( !i64, !i64 ) -> ()
}]

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
