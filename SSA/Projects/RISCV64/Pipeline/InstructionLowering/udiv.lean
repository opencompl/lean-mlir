import SSA.Projects.RISCV64.Pipeline.alltoolchain
open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V

-- done
/-! # UDIV no exact  -/


def udiv_llvm_no_exact : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.udiv  %x, %y : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]
-- at the moment unsure how the conversion cast will eliminate
def udiv_riscv: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %x1 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%x) : (i64) -> !i64
      %x2 = "builtin.unrealized_conversion_cast.LLVMToriscv"(%y) : (i64) -> !i64
      %1 = divu  %x1, %x2 : !i64 -- value depends on wether to no overflow flag is present or not
      %2 = "builtin.unrealized_conversion_cast.riscvToLLVM" (%1) : (!i64) -> (i64)
      llvm.return %2 : i64
  }]


def llvm_udiv_lower_riscv_no_flag: LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := udiv_llvm_no_exact , rhs := udiv_riscv, correct := by
      unfold udiv_llvm_no_exact udiv_riscv
      simp_peephole
      simp [builtin.unrealized_conversion_cast.riscvToLLVM,builtin.unrealized_conversion_cast.LLVMToriscv ]
      simp [Option.isSome]
      rintro (_|a) (_|b)
      . simp [LLVM.udiv, BitVec.Refinement,builtin.unrealized_conversion_cast.riscvToLLVM]
      . simp [LLVM.udiv, BitVec.Refinement,builtin.unrealized_conversion_cast.riscvToLLVM]
      . simp [LLVM.udiv, BitVec.Refinement,builtin.unrealized_conversion_cast.riscvToLLVM]
      . simp [LLVM.udiv, BitVec.Refinement,builtin.unrealized_conversion_cast.riscvToLLVM]
        split
        case some.some.h_1 h1 =>
          simp [DIV_pure64_unsigned]
          by_cases onB : b = 0#64
          · simp [onB]
            split
            case pos.isTrue =>
              simp [LLVM.udiv?]
            case pos.isFalse =>
              simp
          · simp [onB]
            split
            · simp [LLVM.udiv?, DIV_pure64_unsigned]
              simp [onB]
            · simp
        case some.some.h_2 h2 =>
          split
          · simp
          · simp [LLVM.udiv?, DIV_pure64_unsigned]
            by_cases onB : (b = 0#64)
            · simp [onB]
            · simp [onB]
      }

/-! # UDIV exact   -/

def udiv_llvm_exact : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.udiv exact  %x, %y : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def llvm_udiv_lower_riscv_flag: LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := udiv_llvm_exact , rhs := udiv_riscv, correct := by
      unfold udiv_llvm_exact udiv_riscv
      simp_peephole
      simp [builtin.unrealized_conversion_cast.riscvToLLVM,builtin.unrealized_conversion_cast.LLVMToriscv ]
      rintro (_|a) (_|b)
      . simp [LLVM.udiv]
      . simp [LLVM.udiv]
      . simp [LLVM.udiv]
      . simp [LLVM.udiv]
        split
        case some.some.isTrue =>
          simp
        case some.some.isFalse =>
          simp [LLVM.udiv?, DIV_pure64_unsigned]
          split <;> simp
       }
