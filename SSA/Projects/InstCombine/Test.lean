import SSA.Projects.InstCombine.Base
import SSA.Experimental.IntrinsicAsymptotics

open InstCombine

-- Examples
abbrev cst {w : Nat} (x : Bitvec w) (Γ : Ctxt Ty := ∅) : IExpr Op Γ (Ty.bitvec w) := 
  {op := @Op.const w x,
         ty_eq := by simp [OpSignature.outTy],
         args := HVector.nil}

abbrev sub {w : Nat} (Γ : Ctxt Ty) (x y : Γ.Var (Ty.bitvec w)) : IExpr Op Γ (Ty.bitvec w) :=
  {op := @Op.sub w,
         ty_eq := by simp [OpSignature.outTy],
         args := HVector.cons x (HVector.cons y HVector.nil) }

def progZero (w : Nat) (Γ : Ctxt Ty): ICom Op Γ (Ty.bitvec w) :=
  .lete (cst 0 (w:=w) Γ) <|
  .ret ⟨0, by simp [Ctxt.snoc]⟩

def progXMinusX (w : Nat) (x : Bitvec w) (Γ : Ctxt Ty): ICom Op Γ (Ty.bitvec w) :=
  .lete (cst x (w:=w) Γ) <|
  .lete (sub (w:=w) (x:=⟨0, by simp [Ctxt.snoc]⟩) (y:=⟨0, by simp [Ctxt.snoc]⟩)) <|
  .ret ⟨0, by simp [Ctxt.snoc]⟩

def xMinusX (w : Nat) (x : Bitvec w) (Γ : Ctxt Ty): PeepholeRewrite Op [Ty.bitvec w] (Ty.bitvec w) :=
  { lhs := progZero w _,
    rhs := progXMinusX w x _,
    correct := by simp_peephole; simp [Op.denote, HVector.toPair, HVector.toTuple, pure, pure, Option.map, Option.bind_eq_some',bind_assoc, bind] }

