/-- This file contains lowering of the llvm or instruction -/

/- # OR non-disjoint  -/

def or_llvm_noflag : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %0 = llvm.or  %x, %y : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %0 : i64
  }]

def or_riscv := [LV| {
    ^entry (%r1: i64, %r2: i64 ):
      %0 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> !i64
      %1 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> !i64
      %2 = or %0, %1 : !i64
      %3= "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def llvm_or_lower_riscv1_noflag : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := or_llvm_noflag , rhs := or_riscv ,
    correct :=  by
      unfold or_llvm_noflag or_riscv
      simp_peephole
      simp [builtin.unrealized_conversion_cast.riscvToLLVM,builtin.unrealized_conversion_cast.LLVMToriscv ]
      rintro (_|x1) (_|x2) <;> simp [RTYPE_pure64_RISCV_OR, LLVM.or];
      . split
        . case some.some.isTrue ht=> simp [BitVec.Refinement.none_left] -- this is the poison case, where llvm returns a poison value but in riscv we ouptut a concret bitvec value for it,
          -- in detail riscv performs the arithemtic shift with the maximum possible shift amount
        . case some.some.isFalse hf =>
            simp[LLVM.or?]
            bv_decide
}

/-! # OR disjoint-/

/- the disjoint flag requries that no two bits at the same index are set in either of the dialects.
This allows an or to be treated as an addition.  -/
def or_llvm_disjoint : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.or disjoint   %x, %y : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def llvm_or_lower_riscv_disjoint : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := or_llvm_disjoint , rhs := or_riscv ,
    correct :=  by
      unfold or_llvm_disjoint or_riscv
      simp_peephole
      simp [builtin.unrealized_conversion_cast.riscvToLLVM,builtin.unrealized_conversion_cast.LLVMToriscv ]
      rintro (_|x1) (_|x2) <;> simp [RTYPE_pure64_RISCV_OR, LLVM.or];
      . split
        . case some.some.isTrue ht=> simp [BitVec.Refinement.none_left] -- this is the poison case, where llvm returns a poison value but in riscv we ouptut a concret bitvec value for it,
          -- in detail riscv performs the arithemtic shift with the maximum possible shift amount
        . case some.some.isFalse hf =>
            simp[LLVM.or?]
            bv_decide
}
