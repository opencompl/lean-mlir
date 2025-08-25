import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.icmp` instruction for types i32 and i64.
  We implement `eq` adn `neq` both as an architectural instruction and as a pseudo-instructions
  (see `pseudo.lean`)
-/

/-! ### i32 -/

@[simp_denote]
def icmp_ugt_llvm_32 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 1))  := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.ugt %lhs, %rhs  : i32
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_ugt_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = sltu %rhsr, %lhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_ugt_riscv_eq_icmp_ugt_llvm_32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_ugt_llvm_32, rhs:= icmp_ugt_riscv_32}

@[simp_denote]
def icmp_uge_llvm_32 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.uge %lhs, %rhs  : i32
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_uge_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = sltu %lhsr, %rhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_uge_riscv_eq_icmp_uge_llvm_32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_uge_llvm_32, rhs:= icmp_uge_riscv_32 }

@[simp_denote]
def icmp_ult_llvm_32 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.ult %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_ult_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32 ):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = sltu %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_ult_riscv_eq_icmp_ult_llvm_32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_ult_llvm_32, rhs:= icmp_ult_riscv_32}

@[simp_denote]
def icmp_ule_llvm_32 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.ule %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_ule_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = sltu %rhsr, %lhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_ule_riscv_eq_icmp_ule_llvm_32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_ule_llvm_32, rhs:= icmp_ule_riscv_32}

@[simp_denote]
def icmp_sgt_llvm_32 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.sgt %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_sgt_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = slt %rhsr, %lhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_sgt_riscv_eq_icmp_slt_llvm_32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_sgt_llvm_32, rhs:= icmp_sgt_riscv_32}

@[simp_denote]
def icmp_sge_llvm_32 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.sge %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_sge_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = slt %lhsr, %rhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_sge_riscv_eq_icmp_sge_llvm_32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_sge_llvm_32, rhs:= icmp_sge_riscv_32}

@[simp_denote]
def icmp_slt_llvm_32 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.slt %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_slt_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = slt %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_slt_riscv_eq_icmp_slt_llvm_32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_slt_llvm_32, rhs:= icmp_slt_riscv_32}

@[simp_denote]
def icmp_sle_llvm_32 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.sle %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_sle_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = slt    %rhsr, %lhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_sle_riscv_eq_icmp_sle_llvm_32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_sle_llvm_32, rhs:= icmp_sle_riscv_32}


@[simp_denote]
def icmp_eq_llvm_32 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.eq %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_eq_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = xor    %lhsr, %rhsr : !i64
    %1 = sltiu %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_eq_riscv_eq_icmp_eq_llvm_32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_eq_llvm_32, rhs:= icmp_eq_riscv_32}

@[simp_denote]
def icmp_neq_llvm_32 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.ne %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_neq_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = xor    %lhsr, %rhsr : !i64
    %c0 = li (0) : !i64
    %1 = sltu %c0, %0 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_neq_riscv_eq_icmp_neq_llvm_32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_neq_llvm_32, rhs:= icmp_neq_riscv_32}


/-! ### i64 -/

@[simp_denote]
def icmp_ugt_llvm_64 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 1))  := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.ugt %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_ugt_riscv_64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = sltu %rhsr, %lhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_ugt_riscv_eq_icmp_ugt_llvm_64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_ugt_llvm_64, rhs:= icmp_ugt_riscv_64,
   correct := by
  unfold icmp_ugt_llvm_64 icmp_ugt_riscv_64
  simp_peephole
  simp_alive_undef
  simp_riscv
  simp_alive_ops
  simp_alive_case_bash
  simp_alive_split
  all_goals
  bv_decide
  }

@[simp_denote]
def icmp_uge_llvm_64 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.uge %lhs, %rhs : i64
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_uge_riscv_64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = sltu %lhsr, %rhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_uge_riscv_eq_icmp_uge_llvm_64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_uge_llvm_64, rhs:= icmp_uge_riscv_64}

@[simp_denote]
def icmp_ult_llvm_64 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.ult %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_ult_riscv_64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = sltu %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_ult_riscv_eq_icmp_ult_llvm_64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_ult_llvm_64, rhs:= icmp_ult_riscv_64}

@[simp_denote]
def icmp_ule_llvm_64 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.ule %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_ule_riscv_64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = sltu %rhsr, %lhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_ule_riscv_eq_icmp_ule_llvm_64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_ule_llvm_64, rhs:= icmp_ule_riscv_64}

@[simp_denote]
def icmp_sgt_llvm_64 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.sgt %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_sgt_riscv_64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = slt %rhsr, %lhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_sgt_riscv_eq_icmp_slt_llvm_64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_sgt_llvm_64, rhs:= icmp_sgt_riscv_64}

@[simp_denote]
def icmp_sge_llvm_64 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.sge %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_sge_riscv_64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = slt %lhsr, %rhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_sge_riscv_eq_icmp_sge_llvm_64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_sge_llvm_64, rhs:= icmp_sge_riscv_64}

@[simp_denote]
def icmp_slt_llvm_64 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.slt %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_slt_riscv_64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = slt %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_slt_riscv_eq_icmp_slt_llvm_64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_slt_llvm_64, rhs:= icmp_slt_riscv_64}

@[simp_denote]
def icmp_sle_llvm_64 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.sle %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_sle_riscv_64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = slt %rhsr, %lhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_sle_riscv_eq_icmp_sle_llvm_64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_sle_llvm_64, rhs:= icmp_sle_riscv_64}

@[simp_denote]
def icmp_eq_llvm_64 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.eq %lhs, %rhs : i64
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_eq_riscv_64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = xor    %lhsr, %rhsr : !i64
    %1 = sltiu %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_eq_riscv_eq_icmp_eq_llvm_64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_eq_llvm_64, rhs:= icmp_eq_riscv_64}

@[simp_denote]
def icmp_neq_llvm_64 : Com LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.ne %lhs, %rhs : i64
    llvm.return %1 : i1
  }]

@[simp_denote]
def icmp_neq_riscv_64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = xor    %lhsr, %rhsr : !i64
    %c0 = li (0) : !i64
    %1 = sltu %c0, %0 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_neq_riscv_eq_icmp_neq_llvm_64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_neq_llvm_64, rhs:= icmp_neq_riscv_64}

def icmp_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_uge_riscv_eq_icmp_uge_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_slt_riscv_eq_icmp_slt_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_sle_riscv_eq_icmp_sle_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_ule_riscv_eq_icmp_ule_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_sgt_riscv_eq_icmp_slt_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_sge_riscv_eq_icmp_sge_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_ugt_riscv_eq_icmp_ugt_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_ult_riscv_eq_icmp_ult_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_eq_riscv_eq_icmp_eq_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_neq_riscv_eq_icmp_neq_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_uge_riscv_eq_icmp_uge_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_slt_riscv_eq_icmp_slt_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_sle_riscv_eq_icmp_sle_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_ule_riscv_eq_icmp_ule_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_sgt_riscv_eq_icmp_slt_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_sge_riscv_eq_icmp_sge_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_ugt_riscv_eq_icmp_ugt_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_ult_riscv_eq_icmp_ult_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_eq_riscv_eq_icmp_eq_llvm_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_neq_riscv_eq_icmp_neq_llvm_32)


]
