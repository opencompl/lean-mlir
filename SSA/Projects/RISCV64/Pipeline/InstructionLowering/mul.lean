import SSA.Projects.RISCV64.Pipeline.alltoolchain
open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V
/-
Disabled due to simproc implementation not being re-evaluated correctly
on Lean version "4.20.0-nightly-2025-04-21" -/
set_option Elab.async true


/- # MUL RISCV  -/

def mul_riscv := [LV| {
    ^entry (%r1: i64, %r2: i64 ):
      %x1 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> !i64
      %x2 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> !i64
      %res = mul %x1, %x2 : !i64
      %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i64)
      llvm.return %y : i64
  }]

/- # MUL NO FLAG  -/

def mul_llvm_noflag : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.mul %x, %amount : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

/- # MUL FLAGS -/

def mul_llvm_nsw : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.mul %x, %amount overflow<nsw> : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def mul_llvm_nuw : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.mul %x, %amount overflow<nuw> : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def mul_llvm_flags : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.mul %x, %amount overflow<nsw,nuw> : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def llvm_mul_lower_riscv_noflag : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := mul_llvm_noflag , rhs := mul_riscv ,
    correct :=  by
      unfold mul_llvm_noflag mul_riscv
      simp_peephole
      simp [builtin.unrealized_conversion_cast.riscvToLLVM,builtin.unrealized_conversion_cast.LLVMToriscv ]
      rintro (_|x1) (_|x2) <;> simp ;
      . simp [LLVM.mul]
      . simp [LLVM.mul]
      . simp [LLVM.mul]
      . unfold LLVM.mul
        simp [Option.bind_eq_bind, Option.some_bind]  -- not sure if this is correctly parsed because shouldnt default flag be set to false then
        -- in this case of mul we do not care about overflow
        simp only [LLVM.mul?, MUL_pure64_ftt_bv, BitVec.Refinement]
        exact BitVec.Refinement.bothSome rfl
        }

/- # MUL with  FLAG -/

--nsw and nuw flags
def llvm_mul_lower_riscv_flags : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := mul_llvm_flags , rhs := mul_riscv ,
    correct :=  by
      unfold mul_llvm_flags mul_riscv
      simp_peephole
      rintro (_|a) (_|b)<;> simp [LLVM.mul, LLVM.mul?, builtin.unrealized_conversion_cast.riscvToLLVM, builtin.unrealized_conversion_cast.LLVMToriscv ]
      . case some.some =>
          split
          · case isTrue ht => simp -- in this case the multiplication overflows, llvm poison vs llvm non-poison
          · case isFalse hf => -- no signed overflow case
              split
              · simp -- unsigned overflow
              · simp only [MUL_pure64_ftt_bv] -- no overflow
                simp only [BitVec.Refinement.refl]
       }

def llvm_mul_lower_riscv_nsw_flag : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := mul_llvm_nsw , rhs := mul_riscv ,
    correct :=  by
      unfold mul_llvm_nsw mul_riscv
      simp_peephole
      rintro (_|a) (_|b)<;> simp [LLVM.mul, LLVM.mul?, builtin.unrealized_conversion_cast.riscvToLLVM, builtin.unrealized_conversion_cast.LLVMToriscv ]
      . case some.some =>
          split
          · case isTrue ht => simp -- in this case the multiplication overflows, llvm poison vs llvm non-poison
          · case isFalse hf => -- no signed overflow case
              simp only [MUL_pure64_ftt_bv]
              simp [BitVec.Refinement.refl]
       }

def llvm_mul_lower_riscv_nuw_flag : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := mul_llvm_nuw , rhs := mul_riscv ,
    correct :=  by
      unfold mul_llvm_nuw mul_riscv
      simp_peephole
      rintro (_|a) (_|b)<;> simp [LLVM.mul, LLVM.mul?, builtin.unrealized_conversion_cast.riscvToLLVM, builtin.unrealized_conversion_cast.LLVMToriscv ]
      . case some.some =>
          split
          · case isTrue ht => simp -- in this case the multiplication overflows, llvm poison vs llvm non-poison
          · case isFalse hf => -- no signed overflow case
              simp only [MUL_pure64_ftt_bv]
              simp [BitVec.Refinement.refl]
       }

/-! # Testing and verified lowering of one instruction -/

-- first proven instruction lowering
def _mul_llvm_test0 := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.mul %x, %amount : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]
-- if it gets lowered then in it is correct
def out := rewritePeepholeAt (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_noflag)  0 _mul_llvm_test0
#eval! out

def _mul_riscv_test1 := [LV| {
    ^entry (%r1: i64, %r2: i64,  %r3: i64,  %r4: i64, %r5: i64 ):
      %x1 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> !i64
      %x2 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> !i64
      %x3 = "builtin.unrealized_conversion_cast"(%r3) : (i64) -> !i64
      %x4 = "builtin.unrealized_conversion_cast"(%r4) : (i64) -> !i64
      %x5 = "builtin.unrealized_conversion_cast"(%r5) : (i64) -> !i64
      %res = mul  %x1, %x2 : !i64
      %res1= mul  %x2, %x3 : !i64
      %res2= mul  %x3, %x3 : !i64
      %res3= mul  %x3, %x3 : !i64
      %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i64)
      llvm.return %y : i64
  }]


def _mul_riscv_test2 := [LV| {
    ^entry (%r1: i64, %r2: i64,  %r3: i64,  %r4: i64, %r5: i64 ):
      %x1 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> !i64
      %x2 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> !i64
      %x3 = "builtin.unrealized_conversion_cast"(%r3) : (i64) -> !i64
      %x4 = "builtin.unrealized_conversion_cast"(%r4) : (i64) -> !i64
      %x5 = "builtin.unrealized_conversion_cast"(%r5) : (i64) -> !i64
      %res = mul  %x1, %x1: !i64
      %res1= mul  %x2, %x3 : !i64
      %res2= mul  %x3, %x3 : !i64
      %res3= mul  %x3, %x3 : !i64
      %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i64)
      llvm.return %y : i64
  }]


-- to do ask the inhabited error
-- def out1 :=  rewritePeepholeRecursively 10 (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_noflag) _mul_riscv_test1


/-
def rewritePeepholeRecursively (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ eff t₂) :
    { out : Com d Γ₂ eff t₂ // out.denote = target.denote } :=


-/
