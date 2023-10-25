import Mathlib.Data.Erased

inductive Ty
  | nat

def Ctxt : Type :=
  Erased <| List Ty

noncomputable def Ctxt.snoc (Γ : Ctxt) (t : Ty) : Ctxt :=
  Erased.mk <| t :: Γ.out

def Ctxt.Var (Γ : Ctxt) (t : Ty) : Type :=
  { i : Nat // Γ.out.get? i = some t }

inductive CtxtProp : Ctxt → Type
  | nil : CtxtProp (Erased.mk [])
  | snoc : CtxtProp Δ → CtxtProp (Δ.snoc t)


noncomputable def matchVar {t : Ty} {Δ : Ctxt} : CtxtProp Δ → Δ.Var t → Option Bool
  | .snoc d, ⟨w+1, h⟩ => -- w† = Var.toSnoc w
      let w : Ctxt.Var _ t := ⟨w, by simp_all[List.get?, Ctxt.snoc]⟩
      matchVar d w
  -- Neither spelling out all cases, nor having a single fallback case work
  | .snoc _, ⟨0, _⟩ | .nil, ⟨0, _⟩ | .nil, ⟨_+1, h⟩ => none
  -- | _, _ => none


example {Δ : Ctxt} (d : CtxtProp Δ) {w : Δ.Var t} :
  matchVar d w = none
    := by
        unfold matchVar /- throws error:
          failed to generate splitter for match auxiliary declaration 'matchVar.match_1', unsolved subgoal:
            case x
            t: Ty
            motive: (Δ : Ctxt) → CtxtProp Δ → Ctxt.Var Δ t → Sort u_1
            h_1: (Γ : Ctxt) →
              (t_2 : Ty) →
                (d : CtxtProp Γ) →
                  (w : ℕ) →
                    (h : List.get? (Erased.out (Ctxt.snoc Γ t_2)) (w + 1) = some t) →
                      motive (Ctxt.snoc Γ t_2) (CtxtProp.snoc d) { val := Nat.succ w, property := h }
            h_2: (Γ : Ctxt) →
              (t_2 : Ty) →
                (a : CtxtProp Γ) →
                  (property : List.get? (Erased.out (Ctxt.snoc Γ t_2)) 0 = some t) →
                    (∀ (Γ_1 : Ctxt) (t_1 : Ty) (d : CtxtProp Γ_1) (w : ℕ)
                        (h : List.get? (Erased.out (Ctxt.snoc Γ_1 t_1)) (w + 1) = some t),
                        ((fun b => t_2 :: Erased.out Γ = b) = fun b => t_1 :: Erased.out Γ_1 = b) →
                          HEq (_ : ∃ a, (fun b => a = b) = fun b => t_2 :: Erased.out Γ = b)
                              (_ : ∃ a, (fun b => a = b) = fun b => t_1 :: Erased.out Γ_1 = b) →
                            HEq (CtxtProp.snoc a) (CtxtProp.snoc d) →
                              HEq { val := 0, property := property } { val := Nat.succ w, property := h } → False) →
                      motive (Ctxt.snoc Γ t_2) (CtxtProp.snoc a) { val := 0, property := property }
            h_3: (property : List.get? (Erased.out (Erased.mk [])) 0 = some t) →
              motive (Erased.mk []) CtxtProp.nil { val := 0, property := property }
            h_4: (n : ℕ) →
              (h : List.get? (Erased.out (Erased.mk [])) (n + 1) = some t) →
                motive (Erased.mk []) CtxtProp.nil { val := Nat.succ n, property := h }
            Δ✝: Ctxt
            t✝: Ty
            a✝: CtxtProp Δ✝
            x✝²: Ctxt.Var (Ctxt.snoc Δ✝ t✝) t
            val✝: ℕ
            property✝¹: List.get? (Erased.out (Ctxt.snoc Δ✝ t✝)) val✝ = some t
            property✝: List.get? (Erased.out (Ctxt.snoc Δ✝ t✝)) Nat.zero = some t
            Γ: Ctxt
            t_1: Ty
            d: CtxtProp Γ
            w: ℕ
            h: List.get? (Erased.out (Ctxt.snoc Γ t_1)) (w + 1) = some t
            fst_eq: (fun b => t✝ :: Erased.out Δ✝ = b) = fun b => t_1 :: Erased.out Γ = b
            snd_eq: HEq (_ : ∃ a, (fun b => a = b) = fun b => t✝ :: Erased.out Δ✝ = b)
              (_ : ∃ a, (fun b => a = b) = fun b => t_1 :: Erased.out Γ = b)
            x_1: HEq (CtxtProp.snoc a✝) (CtxtProp.snoc d)
            x_2: HEq { val := 0, property := property✝ } { val := Nat.succ w, property := h }
            x✝¹: CtxtProp (Ctxt.snoc Δ✝ t✝)
            x✝: Ctxt.Var (Ctxt.snoc Δ✝ t✝) t
            ⊢ False
        -/
        sorry