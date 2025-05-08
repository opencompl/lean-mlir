import SSA.Projects.RISCV64.Pipeline.alltoolchain

open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V

/- # AND -/
def and_llvm : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%lhs: i64, %rhs: i64 ):
      %1 = llvm.and %lhs, %rhs : i64
      llvm.return %1 : i64
      --llvm.return %lhs : i64
  }]

def and_riscv := [LV| {
    ^entry (%lhs: i64, %rhs: i64 ):
      %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
      %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> !i64
       %add1 = and %lhsr, %rhsr : !i64
       %addl = "builtin.unrealized_conversion_cast" (%add1) : (!i64) -> (i64)
      llvm.return %addl : i64
  }]


def llvm_and_lower_riscv1 : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs:= and_llvm , rhs:= and_riscv ,
   correct := by
    unfold and_llvm and_riscv
    simp_peephole
    simp [builtin.unrealized_conversion_cast.riscvToLLVM,  builtin.unrealized_conversion_cast.LLVMToriscv]
    simp [LLVM.and, RTYPE_pure64_RISCV_AND]
    rintro (_|foo) (_|bar)
    · simp
    · simp
    · simp
    · simp
      simp only [LLVM.and?, BitVec.Refinement.some_some]
      bv_decide
    }


def and_riscv_bv_test := [LV| {
    ^entry (%lhs: i64, %rhs: i64 ):
      %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
      %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> !i64
       %add1 =and %lhsr, %lhsr : !i64
      %add2 = and %rhsr, %add1 : !i64
      %add3 = and %rhsr , %add2: !i64
       %addl = "builtin.unrealized_conversion_cast" (%add3) : (!i64) -> (i64)
      llvm.return %addl : i64
  }]


def llvm_and_lower_riscv_test : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs:= and_llvm , rhs:= and_riscv_bv_test ,
   correct := by
    unfold and_llvm and_riscv_bv_test
    simp_peephole
    simp [builtin.unrealized_conversion_cast.riscvToLLVM,  builtin.unrealized_conversion_cast.LLVMToriscv]
    simp [LLVM.and, RTYPE_pure64_RISCV_AND]
    rintro (_|foo) (_|bar)
    · simp
    · simp
    · simp
    · simp
      simp only [LLVM.and?, BitVec.Refinement.some_some]
      bv_decide
    }
