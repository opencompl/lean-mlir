/-!
  This file was originally intended to showcase a `failed to generate splitter` error.
  In the process of minimization, that error dissapeared.
  Instead, we triggered an infinite loop
-/


inductive Ty
  | nat

def Ctxt : Type :=
  List Ty

def Ctxt.Var (Γ : Ctxt) (t : Ty) : Type :=
  { i : Nat // Γ.get? i = some t }  


inductive Lets : Ctxt → Ctxt → Type where
  | nil : Lets Γ Γ
  | lete (body : Lets Γ₁ Γ₂) (t : Ty)  : Lets Γ₁ (t :: Γ₂)


def matchVar (t : Ty) (matchLets : Lets Δ_in Δ_out) (w : Δ_out.Var t)  : 
    Option Bool := 
  match matchLets, w with
    | .lete matchLets _, ⟨w+1, h⟩ => -- w† = Var.toSnoc w
        let w := ⟨w, by simp_all[List.get?]⟩
        matchVar t matchLets w
    | _, _ => do
        none


example {Δ : Ctxt } 
  {lets : Lets Γ_in Γ_out} {v : Γ_out.Var t} {w : Δ.Var t} : 
  matchVar t .nil w = none
    := by
        -- uncommenting the `unfold` triggers an infinite loop of sorts, 
        -- consuming 100% CPU without being caught by `maxHeartbeats` timeout
        -- unfold matchVar
        sorry