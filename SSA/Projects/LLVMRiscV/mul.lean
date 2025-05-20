/- # MUL RISCV  -/

def mul_riscv := [LV| {
    ^entry (%r1: i64, %r2: i64 ):
      %0 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> !i64
      %1 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> !i64
      %2 = mul %0, %1 : !i64
      %3= "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
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
        simp only [LLVM.mul?, pure_semantics.MUL_pure64_ftt_bv, BitVec.Refinement]
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
              · simp only [pure_semantics.MUL_pure64_ftt_bv] -- no overflow
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
              simp only [pure_semantics.MUL_pure64_ftt_bv]
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
              simp only [pure_semantics.MUL_pure64_ftt_bv]
              simp [BitVec.Refinement.refl]
       }
