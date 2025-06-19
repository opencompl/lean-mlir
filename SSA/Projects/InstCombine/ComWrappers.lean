/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.LLVM.SimpSet

/- Wrapper around Com, Expr constructors to easily hand-write IR -/
namespace ComWrappers
open InstCombine (LLVM)

macro_rules
| `(tactic| get_elem_tactic_trivial) => `(tactic| simp [Ctxt.snoc])

@[simp_denote]
def const {Γ : Ctxt _} (w : ℕ) (n : ℤ) : Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.const w n)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)

@[simp_denote]
def not {Γ : Ctxt _} (w : ℕ) (l : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic):
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.not w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def neg {Γ : Ctxt _} (w : ℕ) (l : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic):
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.neg w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def and {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.and w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def or {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.or w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def xor {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.xor w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def shl {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.shl w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def lshr {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.lshr w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def ashr {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.ashr w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def sub {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.sub w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def add {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.add w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def mul {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.mul w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def sdiv {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.sdiv w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def udiv {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.udiv w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def srem {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.srem w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def urem {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.urem w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def icmp {Γ : Ctxt _} (w : ℕ) (pred : LLVM.IntPred) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec 1) :=
  Expr.mk
    (op := InstCombine.MOp.icmp pred w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

@[simp_denote]
def select {Γ : Ctxt _} (w : ℕ) (l m r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)))
      := by get_elem_tactic)
    (mp : (Ctxt.get? Γ m = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ .pure (LLVM.Ty.bitvec w)  :=
  Expr.mk
    (op := InstCombine.MOp.select w)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨m, mp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def test (w : ℕ) :
    Com InstCombine.LLVM [LLVM.Ty.bitvec w] .pure (LLVM.Ty.bitvec w) :=
  .var (const  w 0  ) <|
  .var (not    w 0  ) <|
  .var (neg    w 0  ) <|
  .var (and    w 0 0) <|
  .var (or     w 0 0) <|
  .var (xor    w 0 0) <|
  .var (shl    w 0 0) <|
  .var (lshr   w 0 0) <|
  .var (ashr   w 0 0) <|
  .var (sub    w 0 0) <|
  .var (add    w 0 0) <|
  .var (mul    w 0 0) <|
  .var (sdiv   w 0 0) <|
  .var (udiv   w 0 0) <|
  .var (srem   w 0 0) <|
  .var (urem   w 0 0) <|
  .var (icmp   w .eq 0 0) <|
  .var (select w 0 1 1) <|
  .ret ⟨0, by simp [Ctxt.snoc]⟩

end ComWrappers
