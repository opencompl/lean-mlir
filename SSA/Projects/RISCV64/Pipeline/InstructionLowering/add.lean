import SSA.Projects.RISCV64.Pipeline.alltoolchain


open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V

/-
Disabled due to simproc implementation not being re-evaluated correctly
on Lean version "4.20.0-nightly-2025-04-21" -/
set_option Elab.async true

/- # ADD, riscv   -/
def add_riscv := [LV| {
    ^entry (%lhs: i64, %rhs: i64 ):
      %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
      %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> !i64
      %add1 = add %lhsr, %rhsr : !i64
      %addl = "builtin.unrealized_conversion_cast" (%add1) : (!i64) -> (i64)
      llvm.return %addl : i64
  }]

/- # ADD, no flag  -/

def add_llvm_no_flags : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%lhs: i64, %rhs: i64 ):
      %1 = llvm.add   %lhs, %rhs  : i64
      llvm.return %1 : i64
  }]

/- # ADD,with  flag  -/
def add_llvm_nsw_flags : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%lhs: i64, %rhs: i64 ):
      %1 = llvm.add   %lhs, %rhs overflow<nsw>   : i64
      llvm.return %1 : i64
  }]
def add_llvm_nuw_flags : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%lhs: i64, %rhs: i64 ):
      %1 = llvm.add   %lhs, %rhs overflow<nuw>   : i64
      llvm.return %1 : i64
  }]

def add_llvm_nsw_nuw_flags : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%lhs: i64, %rhs: i64 ):
      %1 = llvm.add   %lhs, %rhs overflow<nsw,nuw>   : i64
      llvm.return %1 : i64
  }]


/- example of very manula proof ->try to extract patterns for automation-/
def llvm_add_lower_riscv_noflags : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs:= add_llvm_no_flags , rhs:= add_riscv ,
   correct := by
    unfold add_llvm_no_flags add_riscv
    set_option pp.analyze true in
    simp_peephole
    simp only [builtin.unrealized_conversion_cast.riscvToLLVM,
      builtin.unrealized_conversion_cast.LLVMToriscv, BitVec.Refinement.some_some]
    --intros a b
    simp [LLVM.add, RTYPE_pure64_RISCV_ADD]
    rintro (_|_) (_|_)
    .
      simp [bind, PoisonOr.ofOption, PoisonOr.ofOption ,PoisonOr.poison]
      congr


/-
    . simp
    . simp
    . simp [LLVM.add?, BitVec.Refinement.refl]-/

  }

def llvm_add_lower_riscv_nsw_flag : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs:= add_llvm_nsw_flags , rhs:= add_riscv ,
   correct := by
    unfold add_llvm_nsw_flags add_riscv
    set_option pp.analyze true in
    simp_peephole
    simp [builtin.unrealized_conversion_cast.riscvToLLVM,  builtin.unrealized_conversion_cast.LLVMToriscv, RTYPE_pure64_RISCV_AND]
    simp [LLVM.add, RTYPE_pure64_RISCV_ADD]
    rintro (_|_) (_|_) ;
    . simp
    . simp
    . simp
    . simp
      split /- split on the overflow case: if overflow then riscv refines
      llvm by providing a default value, else they return the same value -/
      case some.some.isTrue => simp [BitVec.Refinement.none_left] -- case where llvm is poison and riscv defaults to a value
      case some.some.isFalse => simp [LLVM.add?]
  }
def llvm_add_lower_riscv_nuw_flag : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs:= add_llvm_nuw_flags , rhs:= add_riscv ,
   correct := by
    unfold add_llvm_nuw_flags add_riscv
    set_option pp.analyze true in
    simp_peephole
    simp [builtin.unrealized_conversion_cast.riscvToLLVM,  builtin.unrealized_conversion_cast.LLVMToriscv, RTYPE_pure64_RISCV_AND]
    -- intros a b
    simp [LLVM.add, RTYPE_pure64_RISCV_ADD]
    rintro (_|_) (_|_) ;
    . simp
    . simp
    . simp
    . simp
      split /- split on the overflow case: if overflow then riscv refines
      llvm by providing a default value, else they return the same value -/
      case some.some.isTrue => simp [BitVec.Refinement.none_left] -- case where llvm is poison and riscv defaults to a value
      case some.some.isFalse => simp [LLVM.add?]
  }

def llvm_add_lower_riscv_nuw_nsw_flag : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs:= add_llvm_nuw_flags , rhs:= add_riscv ,
   correct := by
    unfold add_llvm_nuw_flags add_riscv
    set_option pp.analyze true in
    simp_peephole
    simp [builtin.unrealized_conversion_cast.riscvToLLVM,  builtin.unrealized_conversion_cast.LLVMToriscv, RTYPE_pure64_RISCV_AND]
    -- intros a b
    simp [LLVM.add, RTYPE_pure64_RISCV_ADD]
    rintro (_|_) (_|_) ;
    . simp
    . simp
    . simp
    . simp
      split /- split on the overflow case: if overflow then riscv refines
      llvm by providing a default value, else they return the same value -/
      case some.some.isTrue => simp [BitVec.Refinement.none_left] -- case where llvm is poison and riscv defaults to a value
      case some.some.isFalse => simp [LLVM.add?]
  }
