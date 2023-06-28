-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import Mathlib

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
  deriving Repr, Inhabited, DecidableEq

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

def get_nat : Value → Nat
  | .nat x => x
  | .bool _ => panic! "boolean values not supported"

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

abbrev Var := Nat
inductive Expr : Type
  | cst (n : Nat)
  | add (a : Var) (b : Var)
  deriving Repr, Inhabited, DecidableEq

abbrev LeafVar := Nat

inductive ExprRec : Type
  | cst (n : Nat)
  | add (a : ExprRec) (b : ExprRec)
  | var (idx : LeafVar)
  deriving Repr, Inhabited

/-- An untyped command; types are always given as in MLIR. -/
inductive Com : Type where
  | let (ty : Ty) (e : Expr) (body : Com) : Com
  | ret (e : Var) : Com
  deriving DecidableEq

def ex' : Com :=
  Com.let .nat (.cst 0) <|
  Com.let .nat (.add 0 0) <|
  Com.let .nat (.add 1 0) <|
  Com.let .nat (.add 2 0) <|
  Com.let .nat (.add 3 3) <|
  Com.let .nat (.add 4 4) <|
  Com.let .nat (.add 5 5) <|
  Com.ret 0

open Lean in 

def formatCom : Com → Nat → Std.Format
  | .ret v, _=> "  .ret " ++ (repr v)
  | .let ty e body, n=> "  .let " ++ (repr ty) ++ " " ++ (repr e) ++ " <|\n" ++ (formatCom body n)

instance : Repr Com where
  reprPrec :=  formatCom

abbrev Mapping := List (LeafVar × Var)
abbrev Lets := Array Expr

def ex0 : Com :=
  Com.let .nat (.cst 0) <|
  Com.let .nat (.add 0 0) <|
  Com.let .nat (.add 1 0) <|
  Com.let .nat (.add 2 0) <|
  Com.let .nat (.add 3 0) <|
  Com.ret 0

def matchVar' (lets : Lets) (varPos: Nat) (matchExpr: ExprRec) (mapping: Mapping): Option Mapping := do
  let var := lets[varPos]!
  match var, matchExpr with
    | .add a b, .add a' b' => 
        let mapping ← match a' with
          | .var x => (x, varPos - 1 - a)::mapping
          | _=>  matchVar' lets (varPos - a - 1) a' mapping
        match b' with
          | .var x => (x, varPos - 1 - b)::mapping
          | _=>  matchVar' lets (varPos - b - 1) a' mapping
    | _, _ => none 

def matchVar (lets : Lets) (varPos: Nat) (matchExpr: ExprRec) : Option Mapping := 
  matchVar' lets varPos matchExpr [] 
  
#eval ex0

def getVarAfterMapping (var : LeafVar) (m : Mapping) : Nat :=
 match m with
 | x :: xs => if var = x.1 then
                 x.2
              else
                 getVarAfterMapping var xs
 | _ => panic! "var should be in mapping"

def applyMapping  (pattern : ExprRec) (m : Mapping) (lets : Lets): (Lets × Nat) := 
match pattern with
    | .var v => (lets, getVarAfterMapping v m)
    | .add a b => 
      let (lets, v1) := applyMapping a m lets
      let (lets, v2) := applyMapping b m lets
      let l := lets.size - v1 - 1
      let r := lets.size - v2 - 1
      (lets.push (Expr.add l r), lets.size)
    | .cst n => (lets.push (.cst n), lets.size)

def shiftBy (inputProg : Com) (delta: Nat) (pos: Nat): Com := 
  let shift (v : Nat) :=
    if v >= pos then
      v + delta
    else
      v
  match inputProg with
  | .ret x => .ret (shift x)
  | .let ty e body => match e with
    | .add a b => .let ty (Expr.add (shift a) (shift b)) (shiftBy body delta (pos+1))
    | .cst x => .let ty (.cst x) (shiftBy body delta (pos +1))

def replaceUsesOfVar (inputProg : Com) (old: Nat) (new : Var) : Com := 
  let replace (v : Nat) :=
     if old = v then new else v
  match inputProg with
  | .ret x => .ret (replace x)
  | .let ty e body => match e with
    | .add a b => 
      .let ty (Expr.add (replace a) (replace b)) (replaceUsesOfVar body (old+1) (new+1))
    | .cst x => .let ty (.cst x) (replaceUsesOfVar body (old+1) (new+1))

def addLetsToProgram' (newLets : Lets) (n : Nat) (newProgram : Com) : Com :=
  match n with
  | 0 => newProgram
  | (x + 1) => if x < newLets.size then
                 let added := Com.let .nat (newLets.get! x) newProgram
                 addLetsToProgram' newLets x (added)
               else
                 newProgram

def addLetsToProgram (newLets : Lets) (newProgram : Com) : Com :=
  addLetsToProgram' newLets newLets.size newProgram

def applyRewrite (lets : Lets) (inputProg : Com) (rewrite: ExprRec × ExprRec) : Option Com := do
  let varPos := lets.size - 1 
  let mapping ← matchVar lets varPos rewrite.1
  let (newLets, newVar) := applyMapping (rewrite.2) mapping lets
  let newProgram := inputProg
  let newProgram := shiftBy newProgram (newLets.size - lets.size) 0
  let newProgram := replaceUsesOfVar newProgram (newLets.size - lets.size) (newLets.size - newVar - 1)
  let newProgram := addLetsToProgram newLets (newLets.size) newProgram

  some newProgram

def rewriteAt' (inputProg : Com) (depth : Nat) (lets: Lets) (rewrite: ExprRec × ExprRec) : Option Com :=
  match inputProg with
    | .ret _ => none
    | .let _ expr body =>
        let lets := lets.push expr
        if depth = 0 then
           applyRewrite lets body rewrite
        else
           rewriteAt' body (depth - 1) lets rewrite

def rewriteAt (inputProg : Com) (depth : Nat) (rewrite: ExprRec × ExprRec) : Option Com :=
    rewriteAt' inputProg depth #[] rewrite 

def rewrite (inputProg : Com) (depth : Nat) (rewrite: ExprRec × ExprRec) : Com :=
    let x := rewriteAt inputProg depth rewrite 
    match x with
      | none => inputProg
      | some y => y

def Expr.denote : Expr → State → Value
| .cst n, _ => .nat n
| .add a b, l => let a_val := get_nat (l.get! a)
                 let b_val := get_nat (l.get! b)
                 Value.nat (a_val + b_val)

def Com.denote : Com → State → Value
| .ret v, l => l.get! v
| .let _ e body, l => denote body ((e.denote l) :: l)

def denote (p: Com) : Value :=
  p.denote []

def ExprRec.denote : ExprRec → State → Value
| .cst n, _ => .nat n
| .add a b, s => let a_val := get_nat (a.denote s)
                 let b_val := get_nat (b.denote s)
                 Value.nat (a_val + b_val)
| .var v, s => s.get! v

theorem letsTheorem 
 (rwExpr : ExprRec × ExprRec) (lets : Lets)
 (h1: matchVar lets (lets.size-1) rwExpr.fst = some m):
   denote (addLetsToProgram (lets) (Com.ret 0)) =
   denote (addLetsToProgram ((applyMapping rwExpr.1 m (lets).1) (Com.ret 0)) := by
      induction ((lets.push e).size)

theorem rewriteAtCorrect 
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec) 
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s)
  (lets : Lets) (successful : rewriteAt' p pos lets rwExpr = some p'):
  denote p' = denote (addLetsToProgram lets lets.size p) := by
  induction p 
  case «let» ty e body body_ih =>
    unfold rewriteAt' at successful
    split at successful
    case inl hpos =>
      unfold applyRewrite at successful
      erw [Option.bind_eq_some] at successful
      rcases successful with ⟨m, ⟨h1, h2⟩⟩



  
  


theorem preservesSemantics
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec) 
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s):
  denote (rewrite p pos rwExpr) = denote p := by
  unfold rewrite
  unfold rewriteAt
  simp
  split
  rfl
  rw [rewriteAtCorrect (successful := by assumption)]
  simp[addLetsToProgram]
  exact rewriteCorrect

def ex1 : Com :=
  Com.let .nat (.cst 1) <|
  Com.let .nat (.add 0 0) <|
  Com.ret 0

def ex2 : Com :=
  Com.let .nat (.cst 1) <|
  Com.let .nat (.add 0 0) <|
  Com.let .nat (.add 1 0) <|
  Com.let .nat (.add 1 1) <|
  Com.let .nat (.add 1 1) <|
  Com.ret 0

-- a + b => b + a
def m := ExprRec.add (.var 0) (.var 1)
def r := ExprRec.add (.var 1) (.var 0)

def testRewrite (p : Com) (r : ExprRec) (pos : Nat) : Com :=
  let new := rewriteAt p pos (m, r) 
  dbg_trace "# Before"
  dbg_trace repr p
  match new with
    | none => (Com.ret 0) -- Failure
    | some y => 
      dbg_trace ""
      dbg_trace "# After"
      dbg_trace repr y
      dbg_trace ""
      y

#eval testRewrite ex1 r 1
example : denote ex1 = denote (testRewrite ex1 r 1) := by rfl

#eval testRewrite ex2 r 1
example : denote ex2 = denote (testRewrite ex2 r 1) := by rfl

#eval testRewrite ex2 r 2
example : denote ex2 = denote (testRewrite ex2 r 2) := by rfl

#eval testRewrite ex2 r 3
example : denote ex2 = denote (testRewrite ex2 r 3) := by rfl

#eval testRewrite ex2 r 4
example : denote ex2 = denote (testRewrite ex2 r 4) := by rfl

-- a + b => b + (0 + a)
def r2 := ExprRec.add (.var 1) (.add (.cst 0) (.var 0))

#eval testRewrite ex2 r2 1
example : denote ex2 = denote (testRewrite ex2 r2 1) := by rfl

#eval testRewrite ex2 r2 2
example : denote ex2 = denote (testRewrite ex2 r2 2) := by rfl

#eval testRewrite ex2 r2 3
example : denote ex2 = denote (testRewrite ex2 r2 3) := by rfl

#eval testRewrite ex2 r2 4
example : denote ex2 = denote (testRewrite ex2 r2 4) := by rfl

-- a + b => (0 + a) + b
def r3 := ExprRec.add (.add (.cst 0 ) (.var 0)) (.var 1)

#eval testRewrite ex2 r3 1
example : denote ex2 = denote (testRewrite ex2 r3 1) := by rfl

#eval testRewrite ex2 r3 2
example : denote ex2 = denote (testRewrite ex2 r3 2) := by rfl

#eval testRewrite ex2 r3 3
example : denote ex2 = denote (testRewrite ex2 r3 3) := by rfl

#eval testRewrite ex2 r3 4
example : denote ex2 = denote (testRewrite ex2 r3 4) := by rfl

  

macro "mk_lets'" n:num init:term : term =>
  n.getNat.foldRevM (fun n stx => `(Com.let .nat (.add $(Lean.quote n) $(Lean.quote n)) $stx)) init

macro "mk_com'" n:num : term =>
`(Com.let .nat (.cst 0) <|
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
    | .ret e => do
      let e ← checkExpr Γ e
      return ⟨ty, .ret e⟩
    | .let ty e body => do
      let e ← checkExpr Γ ty e
      let ⟨ty, body⟩ ← go (ty :: Γ) body
      return ⟨ty, .let e body⟩
  checkExpr (Γ : Ctxt) : (ty : Ty) → Expr → Except String (IExpr Γ ty)
    | .nat, .cst n => .ok (.nat n)
    | .bool, .cst _ => .error "type error"
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


def main (args : List String) : IO Unit := do
  let p ← IO.FS.readFile args[0]!
  let p ← IO.ofExcept (parse p)
  let ⟨_ty, p⟩ ← IO.ofExcept (check p)
  IO.print (print (transform p))