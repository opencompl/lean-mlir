import SSA.Experimental.IntrinsicAsymptotics.Context

def Ctxt.IsVarOfType (Γ : Ctxt) (n : Nat) (t: Ty) : Prop :=
  Γ.out.get? n = some t

/-- A very simple expression, without type information. -/
inductive ExprRaw : Type
  | add : Nat → Nat → ExprRaw
  /-- Nat literals. -/
  | nat : Nat → ExprRaw

/-- A recursive expression, without type information. -/
inductive ExprRecRaw : Type
  | add : ExprRecRaw → ExprRecRaw → ExprRecRaw
  /-- Nat literals -/
  | nat : Nat → ExprRecRaw
  /-- Free/meta variables -/
  | var : Nat → ExprRecRaw


inductive ExprRaw.IsWellTyped (Γ : Ctxt) : Ty → ExprRaw → Prop
  | add {v w : Nat} : Γ.IsVarOfType v .nat → Γ.IsVarOfType w .nat → IsWellTyped Γ .nat (.add v w)
  | nat {n : Nat} : IsWellTyped Γ .nat (.nat n)

inductive ExprRecRaw.IsWellTyped (Γ : Ctxt) : Ty → ExprRecRaw → Prop
  | add {e₁ e₂ : ExprRecRaw} : IsWellTyped Γ .nat e₁ → IsWellTyped Γ .nat e₂ → IsWellTyped Γ .nat (.add e₁ e₂)
  | nat {n : Nat} : IsWellTyped Γ .nat (.nat n)

inductive Lets.IsWellTyped : Ctxt → Ctxt → List ExprRaw → Prop
  | nil   : IsWellTyped Γ Γ []
  | lete  : IsWellTyped Γin Γout lets → ExprRaw.IsWellTyped Γout t e 
            → IsWellTyped Γin (Γout.snoc t) (e :: lets)




structure IExpr (Γ : Ctxt) (t : Ty) where
  raw : ExprRaw
  wt : raw.IsWellTyped Γ t

structure IExprRec (Γ : Ctxt) (t : Ty) where
  raw : ExprRecRaw
  wt : raw.IsWellTyped Γ t


structure Lets (Γ_in Γ_out : Ctxt) where
  raw : Array ExprRaw
  wt : Lets.IsWellTyped Γ_in Γ_out raw.1.reverse


def Lets.snocLet (lets : Lets Γi Γo) (e : IExpr Γo t) : Lets Γi (Γo.snoc t) where 
  raw := lets.raw.push e.raw
  wt  := by
    simp only [Array.push, Array.data, List.concat_eq_append, List.reverse_append, 
                List.reverse_cons, List.reverse_nil, List.nil_append, List.singleton_append]
    exact IsWellTyped.lete lets.wt e.wt

def Lets.size : Lets Γi Γo → Nat :=
  Array.size ∘ Lets.raw  

def Lets.IsWellTyped.wtTail : IsWellTyped Γ 

def Lets.outContext (lets : Lets Γi Γo) : { Δ : Ctxt // Γo = Γi ++ Δ} :=
  go _ lets.raw.1.reverse lets.wt
where
  go (Γo' : Ctxt) : (lets : List ExprRaw) → IsWellTyped Γi Γo' lets → { Δ : Ctxt // Γo' = Γi ++ Δ}
    | [], wt => ⟨∅, by cases wt; simp⟩
    | e::lets, wt => 
        let Γo' : Ctxt := by 
          cases Γo'
          next => exfalso; cases wt
        let r := go Γo' lets (by cases wt; next wt => exact wt)
        _

def Lets.get (lets : Lets Γi Γo) (v : Γo.Var t) : 
    Option ((Γo' : Ctxt) × (Γo'.hom Γo) × IExpr Γo' t) :=
    
  
