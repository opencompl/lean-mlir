import SSA.Projects.RISCV64.Pipeline.alltoolchain
open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic

open InstCombine(LLVM) -- analog to RISC-V
-- done

/- # ASHR, not exact -/
def ashr_llvm_no_flag : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.ashr %x, %amount : i64
      llvm.return %1 : i64
  }]

/- # ASHR,  exact -/
def ashr_llvm_exact_flag : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.ashr exact %x, %amount : i64
      llvm.return %1 : i64
  }]
def ashr_riscv := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %base = "builtin.unrealized_conversion_cast"(%x) : (i64) -> !i64
      %shamt = "builtin.unrealized_conversion_cast"(%amount) : (i64) -> !i64
       %res = sra %base, %shamt : !i64
       %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i64)
      llvm.return %y : i64
  }]


set_option Elab.async true in
-- shifts the first arguemnt by the value of the second argument
def llvm_ashr_lower_riscv_no_flag : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := ashr_llvm_no_flag , rhs := ashr_riscv ,
    correct :=  by
      unfold ashr_llvm_no_flag ashr_riscv -- think of adding these to simp peephole
      simp_peephole
      simp [builtin.unrealized_conversion_cast.riscvToLLVM,builtin.unrealized_conversion_cast.LLVMToriscv ]
      rintro (_|x1) (_|x2) <;> simp [RTYPE_pure64_RISCV_SRA, LLVM.ashr?]
      · simp [LLVM.ashr]
      · simp [LLVM.ashr]
      · simp [LLVM.ashr]
      · simp [LLVM.ashr]
        split
        · simp
        · simp [LLVM.ashr?]
          split
          case some.some.isFalse.isTrue ht  => simp
          case some.some.isFalse.isFalse hf =>
            simp at hf
            rw [Nat.mod_eq_of_lt (a:= x2.toNat) (b:= 64)]
            simp
            bv_omega
  }

def llvm_ashr_lower_riscv_flag : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := ashr_llvm_exact_flag , rhs := ashr_riscv ,
    correct :=  by
      unfold ashr_llvm_exact_flag ashr_riscv -- think of adding these to simp peephole
      simp_peephole
      simp_alive_undef
      simp [builtin.unrealized_conversion_cast.riscvToLLVM,builtin.unrealized_conversion_cast.LLVMToriscv ]
      rintro (_|x1) (_|x2) <;> simp [RTYPE_pure64_RISCV_SRA, LLVM.ashr?]
      split
      case some.some.isTrue ht  =>
        simp
      case some.some.isFalse hf  =>
            simp at hf
            split
            · case isTrue htt =>
                simp
            · case isFalse hff =>
                simp at hff
                rw [Nat.mod_eq_of_lt (a:= x2.toNat) (b:= 64)]
                simp
                bv_omega
  }
