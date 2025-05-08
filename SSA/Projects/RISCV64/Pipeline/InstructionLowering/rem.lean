import SSA.Projects.RISCV64.Pipeline.alltoolchain

open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V

/-! # REM -/

-- to do

def rem_llvm : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.srem  %x, %y : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]
-- at the moment unsure how the conversion cast will eliminate
def rem_riscv: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %x1 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%x) : (i64) -> !i64
      %x2 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%y) : (i64) -> !i64
      %1 = rem  %x1, %x2 : !i64 -- value depends on wether to no overflow flag is present or not
      %2 = "builtin.unrealized_conversion_cast.riscvToLLVM" (%1) : (!i64) -> (i64)
      llvm.return %2 : i64
  }]


def llvm_rem_lower_riscv_disjoint : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := rem_llvm , rhs := rem_riscv,
    correct :=  by
      unfold rem_llvm rem_riscv
      simp_peephole
      simp [builtin.unrealized_conversion_cast.riscvToLLVM,builtin.unrealized_conversion_cast.LLVMToriscv ]
      rintro (_|x1) (_|x2) <;> simp [REM_pure64_signed, LLVM.srem, LLVM.srem?]
      . split -- poison if reminder by zero or int min reminder by -1
        . case some.some.isTrue ht=> simp [BitVec.Refinement.none_left] -- this is the poison case, where llvm returns a poison value but in riscv we ouptut a concret bitvec value for it,
          -- in detail riscv performs the arithemtic shift with the maximum possible shift amount
        . case some.some.isFalse hf =>
            simp[LLVM.srem?,REM_pure64_signed ]
            simp at hf
            cases hf
            . case intro h1 h2 =>
                split
                . case isTrue  ht =>
                    -- contradiction
                    sorry
                . case isFalse hf =>
                    sorry

}
