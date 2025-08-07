import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-! # UDIV no exact  -/
@[simp_denote]
def udiv_llvm_no_exact : Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
    .pure (.llvm (.bitvec 64)) := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.udiv  %x, %y : i64
      llvm.return %1 : i64
  }]

@[simp_denote]
def udiv_riscv: Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
    .pure (.llvm (.bitvec 64)) := [LV| {
    ^entry (%reg1: i64, %reg2: i64):
      %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i64) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i64) -> (!i64)
      %2 = divu %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def llvm_udiv_lower_riscv_no_flag: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := udiv_llvm_no_exact, rhs := udiv_riscv}

/-! # UDIV exact   -/
@[simp_denote]
def udiv_llvm_exact : Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
    .pure (.llvm (.bitvec 64)) := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.udiv exact %x, %y : i64
      llvm.return %0 : i64
  }]

def llvm_udiv_lower_riscv_flag: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := udiv_llvm_exact, rhs := udiv_riscv}

def udiv_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_udiv_lower_riscv_flag, llvm_udiv_lower_riscv_no_flag]

/-! # UDIV i32 no exact  -/
@[simp_denote]
def udiv_llvm_no_exact_32 : Com  LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
    .pure (.llvm (.bitvec 32)) := [LV| {
    ^entry (%x: i32, %y: i32 ):
      %1 = llvm.udiv  %x, %y : i32
      llvm.return %1 : i32
  }]

@[simp_denote]
def udiv_riscv_32: Com  LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
    .pure (.llvm (.bitvec 32)) := [LV| {
    ^entry (%reg1: i32, %reg2: i32):
      %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i32) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i32) -> (!i64)
      %2 = divu %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i32)
      llvm.return %3 : i32
  }]

def llvm_udiv_lower_riscv_no_flag_32: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs := udiv_llvm_no_exact_32, rhs := udiv_riscv_32, correct :=
    by
    simp_lowering
    ·sorry
    ·sorry

    }

/-! # UDIV exact   -/
@[simp_denote]
def udiv_llvm_exact_32 : Com  LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
    .pure (.llvm (.bitvec 32)) := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.udiv exact %x, %y : i32
      llvm.return %0 : i32
  }]

def llvm_udiv_lower_riscv_flag_32: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs := udiv_llvm_exact_32, rhs := udiv_riscv_32, correct := sorry }

def udiv_match_32 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_udiv_lower_riscv_flag_32, llvm_udiv_lower_riscv_no_flag_32]
