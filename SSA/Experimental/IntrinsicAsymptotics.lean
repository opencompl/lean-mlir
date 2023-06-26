-- Investigations on asymptotic behavior of representing programs with large explicit contexts

/-- A very simple type universe. -/
inductive Ty
  | nat
  | bool
  deriving DecidableEq, Repr

def Ty.toType
  | nat => Nat
  | bool => Bool

inductive Value where
  | nat : Nat → Value
  | bool : Bool → Value
  deriving Repr, Inhabited

abbrev State := List Value

/-- A context is a list of types, growing to the left for simplicity. -/
abbrev Ctxt := List Ty

/-- A very simple intrinsically typed expression. -/
inductive IExpr : Ctxt → Ty → Type
  /-- Variables are represented as indices into the context, i.e. `var 0` is the most recently introduced variable. -/
  | add (a : Fin Γ.length) (b : Fin Γ.length): IExpr Γ .nat
  /-- Nat literals. -/
  | nat (n : Nat) : IExpr Γ .nat
  deriving Repr

/-- A very simple intrinsically typed program: a sequence of let bindings. -/
inductive ICom : List Ty → Ty → Type where
  | ret (e : IExpr Γ α) : ICom Γ α
  | let (e : IExpr Γ α) (body : ICom (α :: Γ) β) : ICom Γ β
  deriving Repr

set_option profiler true
set_option pp.proofs.withType false  -- hide `Fin` statements

-- A simple first program
-- Observation: without the type annotation, we accumulate an exponentially large tree of nested contexts and `List.get`s.
-- By repeatedly referring to the last variable in the context, we force proof (time)s to grow linearly, resulting in
-- overall quadratic elaboration times.
def ex: ICom [] .nat :=
  ICom.let (.nat 0) <|
  ICom.let (α := .nat) (.add ⟨0, by decide⟩ ⟨0, by decide⟩) <|
  ICom.let (α := .nat) (.add ⟨1, by decide⟩ ⟨1, by decide⟩) <|
  ICom.let (α := .nat) (.add ⟨2, by decide⟩ ⟨2, by decide⟩) <|
  ICom.let (α := .nat) (.add ⟨3, by decide⟩ ⟨3, by decide⟩) <|
  ICom.let (α := .nat) (.add ⟨4, by decide⟩ ⟨4, by decide⟩) <|
  ICom.let (α := .nat) (.add ⟨5, by decide⟩ ⟨5, by decide⟩) <|
  ICom.ret (.add ⟨0, by decide⟩ ⟨0, by decide⟩)

def get_nat : Value → Nat := sorry 

def IExpr.denote : IExpr l ty → (ll : State) → (l.length = ll.length) → Value 
| .nat n, _, _ => .nat n
| .add a b, ll, h => let a_val : Nat := get_nat (ll.get (Fin.mk a (h ▸ a.isLt)))
                     let b_val : Nat := get_nat (ll.get (Fin.mk a (h ▸ a.isLt)))
                     Value.nat (a_val + b_val)

def ICom.denote : ICom l ty → (ll : State) → (l.length = ll.length) →  Value
| .ret e, l, h => e.denote l h
| .let e body, l, h => body.denote ((e.denote l h) :: l) (by simp [h])

-- let's automate
macro "mk_lets" n:num init:term : term =>
  n.getNat.foldRevM (fun n stx => `(ICom.let (α := .nat) (.var ⟨$(Lean.quote n), by decide⟩) $stx)) init

macro "mk_com" n:num : term =>
`(show ICom [] .nat from
  ICom.let (.nat 0) <|
  mk_lets $n
  ICom.ret (.var ⟨0, by decide⟩))

macro "mk_ex" n:num : command =>
`(theorem t : ICom [] .nat :=
  mk_com $n)

-- type checking took 146ms
-- elaboration took 327ms
mk_ex 50
-- type checking took 574ms
-- elaboration took 1.41s
mk_ex 100
-- type checking took 911ms
-- elaboration took 2.26s
mk_ex 120

-- Clearly not linear!

-- Apart from proving transformations of specific (sub)programs, we are also interested in applying such
-- verified transformations to larger programs parsed at run time.

/-- An untyped expression as an intermediate step of input processing. -/
inductive Expr : Type
  | add (a : Nat) (b : Nat)
  | nat (n : Nat)
  deriving Repr

/-- An untyped command; types are always given as in MLIR. -/
inductive Com : Type where
  | ret (ty : Ty) (e : Expr) : Com
  | let (ty : Ty) (e : Expr) (body : Com) : Com
  deriving Repr

def ex' : Com :=
  Com.let .nat (.nat 0) <|
  Com.let .nat (.add 0 0) <|
  Com.let .nat (.add 1 1) <|
  Com.let .nat (.add 2 2) <|
  Com.let .nat (.add 3 3) <|
  Com.let .nat (.add 4 4) <|
  Com.let .nat (.add 5 5) <|
  Com.ret .nat (.add 0 0)

def replace_pattern : Com → ... → Com 
| 


def Expr.denote : Expr → State → Value
| .nat n, _ => .nat n
| .add a b, l => let a_val := get_nat (l.get! a)
                 let b_val := get_nat (l.get! b)
                 Value.nat (a_val + b_val)

def Com.denote : Com → State → Value
| .ret _ e, l => e.denote l
| .let _ e body, l => denote body ((e.denote l) :: l)


macro "mk_lets'" n:num init:term : term =>
  n.getNat.foldRevM (fun n stx => `(Com.let .nat (.add $(Lean.quote n) $(Lean.quote n)) $stx)) init

macro "mk_com'" n:num : term =>
`(Com.let .nat (.nat 0) <|
  mk_lets' $n
  Com.ret .nat (.add 0 0))

macro "mk_ex'" n:num : command =>
`(theorem t : Com :=
  mk_com' $n)

-- just for comparison, creating untyped terms takes insignificant time
mk_ex' 50
mk_ex' 100
set_option maxRecDepth 10000 in
mk_ex' 1000

-- Stubs of the desired program pipeline

def parse : String → Except String Com := sorry

def check : Com → Except String (Σ ty, ICom [] ty) := go []
where
  go (Γ : Ctxt) : Com → Except String (Σ ty, ICom Γ ty)
    | .ret ty e => do
      let e ← checkExpr Γ ty e
      return ⟨ty, .ret e⟩
    | .let ty e body => do
      let e ← checkExpr Γ ty e
      let ⟨ty, body⟩ ← go (ty :: Γ) body
      return ⟨ty, .let e body⟩
  checkExpr (Γ : Ctxt) : (ty : Ty) → Expr → Except String (IExpr Γ ty)
    | .nat, .nat n => .ok (.nat n)
    | .bool, .nat _ => .error "type error"
    | ty,   .add a b =>
      if h : a < Γ.length && b < Γ.length then
        let v_a : Fin Γ.length := ⟨v_a, h⟩
        if h_a : ty = Γ.get v_a then h ▸ .ok (.add v_a v_b) else .error "type error"
      else .error "var error"

set_option pp.proofs true in
set_option profiler.threshold 10
#reduce check ex'
#eval check ex'

-- run-time execution should still be quadratic because of `List.get`
#eval check (mk_com' 100)
#eval check (mk_com' 200)
#eval check (mk_com' 300)
#eval check (mk_com' 400)

def transform : ICom [] ty → ICom [] ty := sorry
def denote : ICom [] ty → ty.toType := sorry
def print : ICom [] ty → String := sorry

-- The big theorem; `parse/check/print` are probably not interesting to verify,
-- except to show that `check` does not change the program.
theorem td : denote (transform c) = denote c := sorry

def main (args : List String) : IO Unit := do
  let p ← IO.FS.readFile args[0]!
  let p ← IO.ofExcept (parse p)
  let ⟨_ty, p⟩ ← IO.ofExcept (check p)
  IO.print (print (transform p))
