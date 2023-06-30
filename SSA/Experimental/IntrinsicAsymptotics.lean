-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import Std.Data.Option.Lemmas
import Std.Data.Array.Lemmas
import Std.Data.Array.Init.Lemmas

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
                     let b_val : Nat := get_nat (ll.get (Fin.mk b (h ▸ b.isLt)))
                     Value.nat (a_val + b_val)

def ICom.denote : ICom l ty → (ll : State) → (l.length = ll.length) →  Value
| .ret e, l, h => e.denote l h
| .let e body, l, h => body.denote ((e.denote l h) :: l) (by simp [h])

-- let's automate
macro "mk_lets" n:num init:term : term =>
  n.getNat.foldRevM (fun n stx => `(ICom.let (α := .nat) (.nat ⟨$(Lean.quote n), by decide⟩) $stx)) init

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
-- mk_ex 50
-- type checking took 574ms
-- elaboration took 1.41s
-- mk_ex 100
-- type checking took 911ms
-- elaboration took 2.26s
-- mk_ex 120

-- Clearly not linear!

-- Apart from proving transformations of specific (sub)programs, we are also interested in applying such
-- verified transformations to larger programs parsed at run time.

/-- An untyped expression as an intermediate step of input processing. -/

structure Abs where

  v : Nat
  deriving Repr, Inhabited, DecidableEq

def Abs.ofNat (n: Nat) : Abs :=
  {v := n}

instance : OfNat Abs n where
  ofNat := Abs.ofNat n 

structure Rel where
  v : Nat
  deriving Repr, Inhabited, DecidableEq

def Rel.ofNat (n: Nat) : Rel :=
  {v := n}

instance : OfNat Rel n where
  ofNat := Rel.ofNat n 

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
  deriving Repr, Inhabited, DecidableEq

inductive RegTmp : Type
  | concreteRegion (c : Com)
  | regionVar (n : Nat)

/-- An untyped command; types are always given as in MLIR. -/
inductive Com : Type where
  | let (ty : Ty) (e : Expr) (body : Com): Com
  | ret (e : Var) : Com
  deriving Repr, Inhabited, DecidableEq

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

/-- Apply `matchExpr` on a sequence of `lets` and return a `mapping` from
free variables to their absolute position in the lets array.

Example:
  matchVar #[.cst 1, .add 0 0, .add 1 0, .add 2 0] 3 m2 =
  some [(2, 1), (1, 0), (0, 0)]:= rfl

-/
def matchVar (lets : Lets) (varPos: Nat) (matchExpr: ExprRec) (mapping: Mapping := []): Option Mapping :=
  match matchExpr with 
  | .var x => match mapping.lookup x with
    | some varPos' => if varPos = varPos' then (x, varPos)::mapping else none
    | none => (x, varPos)::mapping
  | .cst n => match lets[varPos]! with
    | .cst n' => if n = n' then some mapping else none
    | _ => none
  | .add a' b' =>
    match lets[varPos]! with 
    | .add a b => do
        let mapping ← matchVar lets (varPos - a - 1) a' mapping
        matchVar lets (varPos - b - 1) b' mapping
    | _ => none 

example: matchVar #[.cst 1, .add 0 0, .add 1 0, .add 2 0] 3 
         (.add (.var 0) (.add (.var 1) (.var 2))) =
  some [(2, 1), (1, 0), (0, 0)]:= rfl

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
      let res := applyMapping a m lets
      let res2 := applyMapping b m (res.1)
      let l := lets.size - res.2 - 1
      let r := lets.size - res2.2 - 1
      ((res2.1).push (Expr.add l r), res2.1.size)
    | .cst n => (lets.push (.cst n), lets.size)

def shiftBy (inputProg : Com) (delta: Nat) (pos: Nat := 0): Com := 
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
  -- Add fold?!
  | 0 => newProgram
  | (x + 1) => let added := Com.let .nat (newLets[x]!) newProgram
               addLetsToProgram' newLets x (added)

def addLetsToProgram (newLets : Lets) (newProgram : Com) : Com :=
  addLetsToProgram' newLets newLets.size newProgram

def applyRewrite (lets : Lets) (inputProg : Com) (rewrite: ExprRec × ExprRec) : Option Com := do
  let varPos := lets.size - 1 
  let mapping ← matchVar lets varPos rewrite.1
  let (newLets, newVar) := applyMapping (rewrite.2) mapping lets
  let newProgram := inputProg
  let newProgram := shiftBy newProgram (newLets.size - lets.size)
  let newProgram := replaceUsesOfVar newProgram (newLets.size - lets.size) (newLets.size - newVar - 1)
  let newProgram := addLetsToProgram newLets newProgram

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

def Expr.denote (e : Expr) (s : State) : Value :=
  match e with
    | .cst n => .nat n
    | .add a b => let a_val := get_nat (s.get! a)
                   let b_val := get_nat (s.get! b)
                   Value.nat (a_val + b_val)

def Com.denote (c : Com) (s : State) : Value :=
  match c with
    | .ret v => s.get! v
    | .let _ e body => denote body ((e.denote s) :: s)

def denote (p: Com) : Value :=
  p.denote []

def ExprRec.denote (e : ExprRec) (s : State) : Value :=
  match e with
    | .cst n => .nat n
    | .add a b => let a_val := get_nat (a.denote s)
                     let b_val := get_nat (b.denote s)
                     Value.nat (a_val + b_val)
    | .var v => s.get! v

theorem shifting:
denote (addLetsToProgram lets (shiftBy p n)) = denote p := sorry

theorem letsTheorem 
 (matchExpr : ExprRec) (lets : Lets)
 (h1: matchVar lets pos matchExpr m₀ = some m)
 (hlets: lets.size > 0)
 (hm₀: denote (addLetsToProgram lets (Com.ret (lets.size - pos - 1) )) =
       denote (addLetsToProgram (applyMapping matchExpr m₀ lets).1
              (Com.ret 0))):

   denote (addLetsToProgram (lets) (Com.ret (lets.size - pos - 1))) =
   denote (addLetsToProgram (applyMapping matchExpr m lets).1 (Com.ret 0)) := by
      induction matchExpr generalizing m₀ m pos
      unfold applyMapping
      simp
      case cst =>
        simp [matchVar] at h1
        split at h1
        rename_i x n heq
        · rw [hm₀]
          split at h1 <;> unfold applyMapping <;> simp
        · contradiction
      
      case add a b a_ih b_ih =>
        simp [matchVar] at h1
        split at h1
        rename_i x avar bvar heq
        · 
          rw [hm₀]
          clear hm₀
          erw [Option.bind_eq_some] at h1; rcases h1 with ⟨m_intermediate, ⟨h1, h2⟩⟩

          have a_fold := a_ih h1
          have b_fold := b_ih h2
          
/-

a_fold: denote (addLetsToProgram lets (Com.ret (Array.size lets - (pos - avar - 1) - 1))) =
        denote (addLetsToProgram (applyMapping a m₀ lets).fst (Com.ret 0)) →

        denote (addLetsToProgram lets (Com.ret (Array.size lets - (pos - avar - 1) - 1))) =
        denote (addLetsToProgram (applyMapping a m_intermediate lets).fst (Com.ret 0))

b_fold: denote (addLetsToProgram lets (Com.ret (Array.size lets - (pos - bvar - 1) - 1))) =
        denote (addLetsToProgram (applyMapping b m_intermediate lets).fst (Com.ret 0)) →

        denote (addLetsToProgram lets (Com.ret (Array.size lets - (pos - bvar - 1) - 1))) =
        denote (addLetsToProgram (applyMapping b m lets).fst (Com.ret 0))
-/
          
          unfold applyMapping
          dsimp

          sorry
        
        · contradiction

      case var =>
        simp [matchVar] at h1
        split at h1
        rename_i x n heq
        · split at h1 <;> rw [hm₀] <;> unfold applyMapping <;> simp
        · rw [hm₀]; unfold applyMapping; simp

theorem rewriteAtCorrect 
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec) 
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s)
  (lets : Lets) (successful : rewriteAt' p pos lets rwExpr = some p'):
  denote p' = denote (addLetsToProgram lets p) := by
  induction p 
  case «let» ty e body body_ih =>
    unfold rewriteAt' at successful
    split at successful
    case inl hpos =>
      unfold applyRewrite at successful
      erw [Option.bind_eq_some] at successful
      rcases successful with ⟨m, ⟨h1, h2⟩⟩
      sorry
    sorry
  sorry


  
  


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
  sorry -- exact rewriteCorrect
  sorry


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

/-
def prog_map_before : Com :=
  %0 := cst [0, 1, 2] : !list
  %1 := map %0 ({
    bb^(%l1)
      %l2 = addi %l1, 1
      yield %l2
  })

  %2 := map %1 ({
    bb^(%l1)
      %l2 = addi %l1, 1
      yield %l2
  })

def prog_map_after : Com :=
  %0 := cst [0, 1, 2] : !list
  %2 := map %0 ({
    bb^(%l1)
      %l2 = addi %l1, 1
      %l3 = addi %l2, 1
      yield %l3
  })

def match_strip_mining := ExprRec.map (.map (.var 0) (.rgn 0)) (.rgn 1))

-/


def m2 := ExprRec.add (.var 0) (.add (.var 1) (.var 2))

theorem mv0:
  matchVar #[.cst 1, .add 0 0, .add 1 0, .add 2 0] 0 m = none := rfl

theorem mv1:
  matchVar #[.cst 1, .add 0 0, .add 1 0, .add 2 0] 1 m = some [(1, 0), (0, 0)]:= rfl

theorem mv2:
  matchVar #[.cst 1, .add 0 0, .add 1 0, .add 2 0] 2 m = some [(1, 1), (0, 0)]:= rfl

theorem mv3:
  matchVar #[.cst 1, .add 0 0, .add 1 0, .add 2 0] 3 m = some [(1, 2), (0, 0)]:= rfl

theorem mv20:
  matchVar #[.cst 1, .add 0 0, .add 1 0, .add 2 0] 0 m2 = none := rfl

theorem mv21:
  matchVar #[.cst 1, .add 0 0, .add 1 0, .add 2 0] 1 m2 = none := rfl

theorem mv22:
  matchVar #[.cst 1, .add 0 0, .add 1 0, .add 2 0] 2 m2 =
  some [(2, 0), (1, 0), (0, 0)] := rfl

theorem mv23:
  matchVar #[.cst 1, .add 0 0, .add 1 0, .add 2 0] 3 m2 =
  some [(2, 1), (1, 0), (0, 0)]:= rfl

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
        let v_a : Fin Γ.length := sorry -- ⟨v_a, h⟩
        if h_a : ty = Γ.get v_a then sorry /-h ▸ .ok (.add v_a v_b)-/ else .error "type error"
      else .error "var error"

set_option pp.proofs true in
set_option profiler.threshold 10
#reduce check ex'
/-
#eval check ex'

-- run-time execution should still be quadratic because of `List.get`
#eval check (mk_com' 100)
#eval check (mk_com' 200)
#eval check (mk_com' 300)
#eval check (mk_com' 400)-/

def transform : ICom [] ty → ICom [] ty := sorry
def print : ICom [] ty → String := sorry


def main (args : List String) : IO Unit := do
  let p ← IO.FS.readFile args[0]!
  let p ← IO.ofExcept (parse p)
  let ⟨_ty, p⟩ ← IO.ofExcept (check p)
  IO.print (print (transform p))