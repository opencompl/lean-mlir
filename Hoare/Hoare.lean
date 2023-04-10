-- This is based on the "Programming Language Foundations" chapters on Hoare Logic
-- https://softwarefoundations.cis.upenn.edu/plf-current/Hoare.html
-- And Chatper 12 of "Concrete Semantics" by Nipkow and Paulson

-- We first define states

import Lean
import Hoare.ImpSeq
import Aesop

namespace Hoare
open ImpSeq

def Assertion := State → Prop
declare_syntax_cat hoare
syntax "[H|" hoare "]" : term
syntax "(" ident "=" term ")" : hoare -- instead of restricting parentheses, we could just have a restricted set of terms
macro_rules
    | `([H| ($n:ident = $v) ]) => `(fun st => st.lookup $(Lean.quote n.getId) = $v)

def Assertion.Implies (P Q : Assertion) : Prop :=
  ∀ st, P st → Q st

def Assertion.Or (P Q : Assertion) : Assertion :=
  fun st => P st ∨ Q st

def Assertion.And (P Q : Assertion) : Assertion :=
  fun st => P st ∧ Q st

def Assertion.Not (P : Assertion) : Assertion :=
  fun st => ¬ P st

syntax hoare ("→" <|> "->") hoare : hoare
syntax hoare ("↔" <|> "<->") hoare : hoare
syntax hoare ("and") hoare : hoare
syntax hoare ("or") hoare : hoare

macro_rules
    | `([H| $P → $Q]) => `(Assertion.Implies [H|$P] [H|$Q])
    | `([H| $P ↔ $Q]) => `(Assertion.Implies [H|$P] [H|$Q] ∧ Assertion.Implies [H|$Q] [H|$P])
    -- Are these two redundant? I forget how they changed <|>
    | `([H| $P <-> $Q]) => `(Assertion.Implies [H|$P] [H|$Q] ∧ Assertion.Implies [H|$Q] [H|$P])
    | `([H| $P -> $Q]) => `(Assertion.Implies [H|$P] [H|$Q])

    | `([H| $P and $Q]) => `(Assertion.And [H|$P] [H|$Q])
    | `([H| $P or $Q]) => `(Assertion.Or [H|$P] [H|$Q])

namespace Examples
def test_hoare : Assertion := [H| (x = 3) ]
def test_hoare2 : Prop := [H| (x = 3) → (y = 4) ]

end Examples

protected def Triple (P : Assertion) (c : Statement) (Q : Assertion) : Prop :=
  ∀ st st' : State, (st =[ c ]=> st') → P st → Q st'

declare_syntax_cat triple
syntax "{" hoare "}" statement "{" hoare "}" : triple
syntax "[T|" triple "]" : term

macro_rules
    | `([T| { $P } $c { $Q }]) => `(Triple [H|$P] [stmt| $c] [H|$Q])

@[simp]
theorem hoare_skip : ∀ P, Hoare.Triple P Statement.Skip P := by
  intro P
  simp [Hoare.Triple, StatementEval, Statement.eval, Statement.Skip]

@[simp]
theorem hoare_seq : ∀ P Q R c1 c2, Hoare.Triple P c1 Q → Hoare.Triple Q c2 R → Hoare.Triple P (Statement.Seq c1 c2) R := by
  intros P Q R c1 c2 h1 h2 st st'' h12 pre
  cases h12 ; simp [Hoare.Triple, StatementEval, Statement.eval]
  specialize h1 st (Statement.eval c1 st)
  specialize h2 (Statement.eval c1 st) (Statement.eval c2 (Statement.eval c1 st))
  apply h2 <;> simp [StatementEval, Statement.eval]
  apply h1 <;> simp [StatementEval, Statement.eval]
  exact pre

def Assertion.substitute (P : Assertion) (x : Lean.Name) (e : Expr) : Assertion :=
  fun st => P (st.update x (e.eval st))

syntax hoare "[" ident "↦" term "]" : hoare
macro_rules
    | `([H| $P [$x:ident ↦ $e] ]) => `(Assertion.substitute [H|$P] $(Lean.quote x.getId) $e)
notation P "[" x "↦" e "]" => Assertion.substitute P x e

@[simp]
theorem hoare_assign : ∀ Q X e,  Hoare.Triple (Q [X ↦ e]) (Statement.Assign X e) Q := by
  intros Q X a
  simp [Hoare.Triple, StatementEval, Statement.eval, Assertion.substitute]

@[simp]
theorem hoare_assign_fwd (m : Nat) (a : Expr) (X : Lean.Name) (P : Assertion) :
  Hoare.Triple (fun st => P st ∧ st.lookup X = m) (Statement.Assign X a) (fun st => P (st.update X m) ∧ st.lookup X = a.eval (st.update X m)) := by
  intros st st' heval
  intro ⟨hpre, hxm⟩
  simp only [StatementEval, Statement.eval] at heval
  rw [←hxm, ←heval]
  have hnoop := State.update_noop st X
  constructor  <;> rw [State.update_update, hnoop]
  {
    exact hpre }
  {
    exact State.update_lookup_eq st X (Expr.eval a st)
  }

@[simp]
theorem hoare_consequence_pre : ∀ P P' Q c, Hoare.Triple P' c Q → (Assertion.Implies P P') → Hoare.Triple P c Q := by
  intros _P _P' Q _c h1 h2 st st' eval pre
  specialize h1 st st' eval (h2 st pre)
  exact h1

@[simp]
theorem hoare_consequence_post : ∀ P Q Q' c, Hoare.Triple P c Q' → (Assertion.Implies Q' Q) → Hoare.Triple P c Q := by
  intros _P _Q Q' _c h1 h2 st st' eval pre
  specialize h1 st st' eval pre
  exact h2 st' h1

def Assertion.NatEq (e : Expr) (v : Nat) : Assertion :=
  fun st => e.eval st = v

@[simp]
theorem hoare_ifzero (P Q : Assertion) (e : Expr) (c₁ c₂ : Statement) :
  Hoare.Triple (Assertion.And P (Assertion.NatEq e 0)) c₁ Q →
  Hoare.Triple (Assertion.And P (Assertion.Not (Assertion.NatEq e 0))) c₂ Q →
  Hoare.Triple P (Statement.IfZero e c₁ c₂) Q := by
  intros h1 h2 st st' eval pre
  simp only [Hoare.Triple, StatementEval, Assertion.And, Assertion.NatEq, Assertion.Not] at *
  dsimp [StatementEval, Statement.eval] at eval
  generalize hres :  Expr.eval e st = res
  rw [hres] at eval
  cases res <;> aesop

def pre (s : Statement) (Q : Assertion) : Assertion :=
  match s with
    | Statement.Skip => Q
    | Statement.Assign x e => Assertion.substitute Q x e
    | Statement.Seq c₁ c₂ => pre c₁ (pre c₂ Q)
    | Statement.IfZero e c₁ c₂ =>
      fun st => if e.eval st = 0 then (pre c₁ Q st) else (pre c₂ Q st)

/- we don't need vc since there's no annotations and no while
def vc (s : Statement) (Q : Assertion) : Bool :=
  match s with
    | Statement.Skip => true
    | Statement.Assign _ _ => true
    | Statement.Seq c₁ c₂ => vc c₁ (pre c₂ Q) && vc c₂ Q
    | Statement.IfZero _ c₁ c₂ => vc c₁ Q && vc c₂ Q
-/

@[simp]
def Refinement (s₁ s₂ : Statement) : Prop :=
  ∀ P Q Q', Hoare.Triple P s₁ Q → Hoare.Triple P s₂ Q' → Assertion.Implies Q' Q

notation s₁ " ⊑ " s₂ => Refinement s₁ s₂

namespace Examples

def example_prog1 :=
  [stmt|
    x := 3;
    y := 4
  ]

def example_prog2 :=
  [stmt|
    y := 4;
    x := 3
  ]

def example_prog3 :=
  [stmt|
    x := 3;
    if0 x then
      y := 4
    else
      y := x + 1
  ]

theorem refinement_prog1_prog2 : example_prog1 ⊑ example_prog2 := by
  intros P Q Q' h1 h2 st
  simp [example_prog1, example_prog2] at *
  have step1 := hoare_seq



end Examples

end Hoare
