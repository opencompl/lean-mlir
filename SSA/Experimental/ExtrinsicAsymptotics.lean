-- Continuing investigations from `IntrinsicAsymptotics` using a separate wellformedness predicate

inductive Ty
  | nat
  | bool
  deriving DecidableEq, Repr

def Ty.toType
  | nat => Nat
  | bool => Bool

abbrev Ctxt := List Ty

inductive Expr : Type
  | var (v : Nat)
  | nat (n : Nat)
  | add (v: Nat) (v: Nat)
  deriving Repr

inductive Com : Type where
  | ret (ty : Ty) (e : Expr) : Com
  | let (ty : Ty) (e : Expr) (body : Com) : Com
  deriving Repr

inductive Expr.WF (Γ : Ctxt) : Ty → Expr → Prop
  | var (h : v < Γ.length) :  WF Γ (Γ.get ⟨v, h⟩) (.var v)
  | nat : WF Γ .nat (.nat n)

inductive Com.WF : Ctxt → Ty → Com → Prop
  | ret : e.WF Γ ty → WF Γ ty (.ret ty e)
  | let : e.WF Γ ty → WF (ty :: Γ) ty' body → WF Γ ty' (.let ty e body)

def ex' : Com :=
  Com.let .nat (.nat 0) <|
  Com.let .nat (.var 0) <|
  Com.let .nat (.var 1) <|
  Com.let .nat (.var 2) <|
  Com.let .nat (.var 3) <|
  Com.let .nat (.var 4) <|
  Com.let .nat (.var 5) <|
  Com.ret .nat (.var 0)

macro "mk_lets'" n:num init:term : term =>
  n.getNat.foldRevM (fun n stx => `(Com.let .nat (.var $(Lean.quote n)) $stx)) init

macro "mk_com'" n:num : term =>
`(Com.let .nat (.nat 0) <|
  mk_lets' $n
  Com.ret .nat (.var 0))

macro "mk_ex'" n:num : command =>
`(theorem t : Com :=
  mk_com' $n)

def parse : String → Except String Com := sorry

-- We should probably use our own inductive type instead of Except + PLift
def check : (c : Com) → Except String (Σ ty, PLift (c.WF [] ty)) := go []
where
  go (Γ : Ctxt) : (c : Com) → Except String (Σ ty, PLift (c.WF Γ ty))
    | .ret ty e => do
      let ⟨e⟩ ← checkExpr Γ ty e
      return ⟨ty, ⟨.ret e⟩⟩
    | .let ty e body => do
      let ⟨e⟩ ← checkExpr Γ ty e
      let ⟨ty', ⟨body⟩⟩ ← go (ty :: Γ) body
      return ⟨ty', ⟨.let e body⟩⟩
  checkExpr (Γ : Ctxt) : (ty : Ty) → (e : Expr) → Except String (PLift (e.WF Γ ty))
    | .nat, .nat _ => .ok ⟨.nat⟩
    | .bool, .nat _ => .error "type error"
    | ty,   .var v =>
      if h : v < Γ.length then
        if h' : ty = Γ.get ⟨v, h⟩ then h' ▸ .ok ⟨.var h⟩ else .error "type error"
      else .error "var error"

set_option pp.proofs true
#reduce check ex'
-- Cannot show PLift part
--eval check ex'

def checkTy (c : Com) (ty : Ty) : Bool :=
  match check c with
  | .ok ⟨ty', _⟩ => ty = ty'
  | .error _ => false

theorem check_ok : checkTy c ty → c.WF [] ty := by
  unfold checkTy
  split
  next h _ => intro; simp_all; exact h.1
  next => intro; contradiction

-- Proving WF by symbolic reduction
example : ex'.WF [] .nat := check_ok (by decide)

-- ...is not more efficient than elaboration with the intrinsic representation
set_option profiler true
set_option maxRecDepth 10000
example : (mk_com' 50).WF [] .nat := check_ok (by decide)
example : (mk_com' 100).WF [] .nat := check_ok (by decide)

-- However, it becomes virtually instantaneous up to stack overflow-triggering sizes when using native reduction
example : (mk_com' 100).WF [] .nat := check_ok (by native_decide)
example : (mk_com' 1000).WF [] .nat := check_ok (by native_decide)
-- This is despite `check` still being quadratic because of `List.get`.
-- We could replace it with an array to achieve linear run time.
-- This would be more problematic in the intrinsic type as we would have to make sure the incremental
-- array values in it do not actually exist at run time (see `Erased`).

def ICom (Γ : Ctxt) (ty : Ty) := { c : Com // c.WF Γ ty }
def transform : ICom [] ty → ICom [] ty := sorry
def denote : ICom [] ty → ty.toType := sorry
def print : ICom [] ty → String := sorry

theorem td : denote (transform c) = denote c := sorry

def main (args : List String) : IO Unit := do
  let p ← IO.FS.readFile args[0]!
  let p ← IO.ofExcept (parse p)
  let ⟨_ty, wf⟩ ← IO.ofExcept (check p)
  IO.print (print (transform ⟨p, wf.1⟩))
