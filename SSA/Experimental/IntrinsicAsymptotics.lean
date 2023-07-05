-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import Std.Data.Option.Lemmas
import Std.Data.Array.Lemmas
import Std.Data.Array.Init.Lemmas
import Mathlib
import Mathlib.Data.List.Indexes


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

/-- The `State` is a map from variables to values that uses relative de Bruijn
    indices. The most recently introduced variable is at the head of the list.
-/
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

structure Absolute where
  v : Nat
  deriving Repr, Inhabited, DecidableEq

def Absolute.ofNat (n: Nat) : Absolute :=
  {v := n}

instance : OfNat Absolute n where
  ofNat := Absolute.ofNat n 

structure VarRel where
  v : Nat
  deriving Inhabited, DecidableEq

def formatVarRel : VarRel → Nat → Std.Format
  | x, _=> repr (x.v)

instance : Repr VarRel where
  reprPrec :=  formatVarRel

def VarRel.ofNat (n: Nat) : VarRel :=
  {v := n}


instance : OfNat VarRel n where
  ofNat := VarRel.ofNat n 

inductive Expr : Type
  | cst (n : Nat)
  | add (a : VarRel) (b : VarRel)
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
  | ret (e : VarRel) : Com
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

abbrev Mapping := List (LeafVar × Nat)
abbrev Lets := List Expr

def ex0 : Com :=
  Com.let .nat (.cst 0) <|
  Com.let .nat (.add 0 0) <|
  Com.let .nat (.add 1 0) <|
  Com.let .nat (.add 2 0) <|
  Com.let .nat (.add 3 0) <|
  Com.ret 0



def getPos (v : VarRel) (currentPos: Nat) : Nat :=
  v.v + currentPos + 1

/-- Apply `matchExpr` on a sequence of `lets` and return a `mapping` from
free variables to their absolute position in the lets array.
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
        let mapping ← matchVar lets (getPos a varPos) a' mapping
        matchVar lets (getPos b varPos) b' mapping
    | _ => none 

#eval matchVar [.add 2 0, .add 1 0, .add 0 0, .cst 1] 0 (.add (.var 0) (.add (.var 1) (.var 2)))
example: matchVar [.add 2 0, .add 1 0, .add 0 0, .cst 1] 0 
         (.add (.var 0) (.add (.var 1) (.var 2))) =
  some [(2, 2), (1, 3), (0, 3)]:= rfl

def getVarAfterMapping (var : LeafVar) (lets : Lets) (m : Mapping) (inputLets : Nat) : Nat :=
 match m with
 | x :: xs => if var = x.1 then
                 x.2 + (lets.length - inputLets)
              else
                 getVarAfterMapping var lets xs inputLets
 | _ => panic! "var should be in mapping"

def getRel (v : Nat) (array: List Expr): VarRel :=
  { v := array.length - v - 1 }

def applyMapping  (pattern : ExprRec) (m : Mapping) (lets : Lets) (inputLets : Nat := lets.length): (Lets × Nat) := 
match pattern with
    | .var v => 
      (lets, getVarAfterMapping v lets m inputLets)
    | .add a b => 
      let res := applyMapping a m lets inputLets
      let res2 := applyMapping b m (res.1) inputLets
      let l := { v := res.2 + (res2.1.length - res.1.length)}
      let r := { v := res2.2 }
      ((Expr.add l r) :: res2.1, 0)
    | .cst n => ((.cst n) :: lets, 0)

def shiftBy (inputProg : Com) (delta: Nat) (pos: Nat := 0): Com := 
  let shift (v : VarRel) : VarRel :=
    if v.v >= pos then
      { v := v.v + delta}
    else
      { v:= v.v }
  match inputProg with
  | .ret x => .ret (shift x)
  | .let ty e body => match e with
    | .add a b => .let ty (Expr.add (shift a) (shift b)) (shiftBy body delta (pos+1))
    | .cst x => .let ty (.cst x) (shiftBy body delta (pos +1))

def VarRel.inc (v : VarRel) : VarRel := 
  { v := v.v + 1}

def replaceUsesOfVar (inputProg : Com) (old: VarRel) (new : VarRel) : Com := 
  let replace (v : VarRel) : VarRel :=
     if old = v then new else v
  match inputProg with
  | .ret x => .ret (replace x)
  | .let ty e body => match e with
    | .add a b => 
      .let ty (Expr.add (replace a) (replace b)) (replaceUsesOfVar body (old.inc) (new.inc))
    | .cst x => .let ty (.cst x) (replaceUsesOfVar body (old.inc) (new.inc))

def addLetsToProgram (newLets : Lets) (oldProgram : Com) : Com :=
  newLets.foldl (λ acc e => Com.let .nat e acc) oldProgram

def applyRewrite (lets : Lets) (inputProg : Com) (rewrite: ExprRec × ExprRec) : Option Com := do
  dbg_trace "applyRewrite"
  let varPos := 0 
  dbg_trace repr lets
  let mapping ← matchVar lets varPos rewrite.1
  dbg_trace repr lets
  dbg_trace repr mapping
  let (newLets, newVar) := applyMapping (rewrite.2) mapping lets
  dbg_trace repr newLets
  let newProgram := inputProg
  let newProgram := shiftBy newProgram (newLets.length - lets.length)
  let newProgram := replaceUsesOfVar newProgram (VarRel.ofNat (newLets.length - lets.length)) (VarRel.ofNat (newVar))
  let newProgram := addLetsToProgram newLets newProgram

  some newProgram

def rewriteAt' (inputProg : Com) (depth : Nat) (lets: Lets) (rewrite: ExprRec × ExprRec) : Option Com :=
  match inputProg with
    | .ret _ => none
    | .let _ expr body =>
        let lets := expr :: lets
        if depth = 0 then
           applyRewrite lets body rewrite
        else
           rewriteAt' body (depth - 1) lets rewrite

def rewriteAt (inputProg : Com) (depth : Nat) (rewrite: ExprRec × ExprRec) : Option Com :=
    rewriteAt' inputProg depth [] rewrite 

def rewrite (inputProg : Com) (depth : Nat) (rewrite: ExprRec × ExprRec) : Com :=
    let x := rewriteAt inputProg depth rewrite 
    match x with
      | none => inputProg
      | some y => y

def getVal (s : State) (v : VarRel) : Nat :=
  get_nat (s.get! v.v)

def Expr.denote (e : Expr) (s : State) : Value :=
  match e with
    | .cst n => .nat n
    | .add a b => .nat ((getVal s a) + (getVal s b))

def Com.denote (c : Com) (s : State) : Value :=
  match c with
    | .ret v => .nat (getVal s v)
    | .let _ e body => denote body (e.denote s :: s) -- introduce binder.

def denote (p: Com) : Value :=
  p.denote []

def Lets.denote (lets : Lets) (env : State := []): State :=
  List.foldr (λ v s => (v.denote s) :: s) env lets

structure ComFlat where
  lets : Lets -- sequence of let bindings.
  ret : VarRel -- return value.

def ComFlat.denote (prog: ComFlat) : Value :=
  let s := prog.lets.denote
  .nat (getVal s prog.ret)

def flatToTree (prog: ComFlat) : Com :=
  addLetsToProgram prog.lets (Com.ret prog.ret)

def ExprRec.denote (e : ExprRec) (s : State) : Value :=
  match e with
    | .cst n => .nat n
    | .add a b => let a_val := get_nat (a.denote s)
                     let b_val := get_nat (b.denote s)
                     Value.nat (a_val + b_val)
    | .var v => s.get! v

theorem key_lemma : 
    (addLetsToProgram lets xs).denote env = xs.denote (lets.denote env) := by
  induction lets generalizing xs <;> simp_all [addLetsToProgram, Com.denote, Lets.denote]

theorem denoteFlatDenoteTree : denote (flatToTree flat) = flat.denote := by
  unfold flatToTree denote; simp [key_lemma]; rfl

theorem shifting:
denote (addLetsToProgram lets (shiftBy p n)) = denote p := sorry

theorem letsTheorem 
 (matchExpr : ExprRec) (lets : Lets)
 (h1: matchVar lets pos matchExpr m₀ = some m)
 (hlets: lets.length > 0)
 (hm₀: denote (addLetsToProgram lets (Com.ret (VarRel.ofNat (lets.length - pos - 1) ))) =
       denote (addLetsToProgram (applyMapping matchExpr m₀ lets).1
              (Com.ret 0))):

   denote (addLetsToProgram (lets) (Com.ret (VarRel.ofNat (lets.length - pos - 1)))) =
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
          erw [Option.bind_eq_some] at h1; rcases h1 with ⟨m_intermediate, ⟨h1, h2⟩⟩
          have a_fold := a_ih h1
          have b_fold := b_ih h2
          rw [hm₀]
          unfold applyMapping
          dsimp

          sorry
        sorry
      sorry
          
theorem addLetsToProgramBaseCase: denote (addLetsToProgram [] p) = denote p := rfl

theorem denoteAddLetsToProgram:
  denote (addLetsToProgram lets body) = denote (addLetsToProgram lets (Com.let ty e body)) := by
  simp [denote, Com.denote, addLetsToProgram]
  
  unfold Com.denote
  dsimp
  simp [Array.foldr_eq_foldr_data] 
  induction lets
  simp_all
  cases body
  · simp
    unfold Expr.denote
    simp

    sorry
  · simp
    sorry 
  simp
  rename_i head tail tail_ih


  induction body
  simp_all
  unfold Com.denote
  simp_all
  · simp_all
    sorry
    
  · simp_all
    sorry
  

theorem rewriteAtApplyRewriteCorrect
 (hpos: pos = 0) : 
 rewriteAt' body pos lets rwExpr = applyRewrite (lets ++ [e]) body rwExpr := by
  sorry

theorem rewriteAtAppend:
  rewriteAt' body pos lets rwExpr = rewriteAt' body (pos - 1) (lets ++ [e]) rwExpr := sorry

/--
 (matchExpr : ExprRec) (lets : Lets)
 (h1: matchVar lets pos matchExpr m₀ = some m)
 (hlets: lets.size > 0)
 (hm₀: denote (addLetsToProgram lets (Com.ret (VarRel.ofNat (lets.size - pos - 1) ))) =
       denote (addLetsToProgram (applyMapping matchExpr m₀ lets).1
              (Com.ret 0))):

   denote (addLetsToProgram (lets) (Com.ret (VarRel.ofNat (lets.size - pos - 1)))) =
   denote (addLetsToProgram (applyMapping matchExpr m lets).1 (Com.ret 0)) := by
-/


theorem rewriteAtCorrect'
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec) 
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s)
  (lets : Lets) (successful : rewriteAt' p pos lets rwExpr = some p'):
  denote p' = denote (addLetsToProgram lets p) := by
  induction pos
  case zero =>
    unfold rewriteAt' at successful
    split at successful
    · contradiction
    · simp at successful
      rename_i inputProg ty e body
      sorry
  sorry

  

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
      rw [body_ih]
      · rw [denoteAddLetsToProgram] --weak
      · rw [←successful] 
        dsimp
        sorry
        -- rw [rewriteAtApplyRewriteCorrect] -- weak

    case inr hpos =>
      dsimp
      rw [body_ih]
      · rw [denoteAddLetsToProgram] -- weak
      · rw [←successful] 
        dsimp
        simp at successful
        simp at body_ih
        simp_all
        unfold rewriteAt'
        simp
        cases body
        simp_all
        · simp_all
          sorry

          
        · simp_all
          contradiction
  case ret v =>
    unfold rewriteAt' at successful
    contradiction

theorem preservesSemantics
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec) 
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s):
  denote (rewrite p pos rwExpr) = denote p := by
  unfold rewrite
  unfold rewriteAt
  simp
  split
  · rfl
  · rw [rewriteAtCorrect (successful := by assumption)]
    simp [addLetsToProgram]
    apply rewriteCorrect

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

/-
def ex22 : ComFlat :=
  { lets := #[
     (.cst 1),
     (.add 0 0),
     (.add 1 0),
     (.add 1 1),
     (.add 1 1)]
   , ret := 0 }

#eval ex22.denote = denote ex2
-/


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

theorem addLets: addLetsToProgram [Expr.add 0 0, Expr.cst 1] (Com.ret 0) = (
  Com.let .nat (Expr.cst 1) <|
  Com.let .nat (Expr.add 0 0) <|
  Com.ret 0) := rfl

theorem letsDenoteZero: Lets.denote [] = [] := rfl
theorem letsComDenoteZero: (addLetsToProgram [] (Com.ret 0)).denote [] = Value.nat 0 := rfl

theorem letsDenoteOne: Lets.denote [Expr.cst 0] [] = [Value.nat 0] := rfl
theorem letsComDenoteOne: (addLetsToProgram [Expr.cst 0] (Com.ret 0)).denote [] = Value.nat 0 := rfl

#eval (addLetsToProgram [Expr.add 0 0, Expr.cst 1] (Com.ret 0)).denote []
theorem letsDenoteTwo:
  Lets.denote [Expr.add 0 0, Expr.cst 1] [] = [Value.nat 2, Value.nat 1] := rfl
#eval addLetsToProgram [Expr.add 0 0, Expr.cst 1] (Com.ret 0)
theorem letsComDenoteTwo:
  (addLetsToProgram [Expr.add 0 0, Expr.cst 1] (Com.ret 0)).denote [] = Value.nat 2 := by
  rfl
theorem letsComDenoteTwo':
  (addLetsToProgram [Expr.add 0 0, Expr.cst 1] (Com.ret 1)).denote [] = Value.nat 1 := by
  rfl

theorem letsDenoteThree:
  Lets.denote [Expr.cst 0, Expr.cst 1, Expr.cst 2] [] =
  [Value.nat 0, Value.nat 1, Value.nat 2] := rfl
theorem letsComDenoteThree:
  (addLetsToProgram [Expr.cst 0, Expr.cst 1, Expr.cst 2] (Com.ret 0)).denote [] = Value.nat 0 := by
  rfl
theorem letsComDenoteThree':
  (addLetsToProgram [Expr.cst 0, Expr.cst 1, Expr.cst 2] (Com.ret 1)).denote [] = Value.nat 1 := by
  rfl
theorem letsComDenoteThree'':
  (addLetsToProgram [Expr.cst 0, Expr.cst 1, Expr.cst 2] (Com.ret 2)).denote [] = Value.nat 2 := by
  rfl

theorem letsDenoteFour:
  Lets.denote [Expr.add 0 1, Expr.cst 3, Expr.cst 5, Expr.cst 7] [] =
  [Value.nat 8, Value.nat 3, Value.nat 5, Value.nat 7] := rfl
theorem letsComDenoteFour:
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 0)).denote [] = Value.nat 1 := by
  rfl
theorem letsComDenoteFour':
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 1)).denote [] = Value.nat 0 := by
  rfl
theorem letsComDenoteFour'':
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 2)).denote [] = Value.nat 1 := by
  rfl
theorem letsComDenoteFour''':
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 3)).denote [] = Value.nat 2 := by
  rfl

def lets1 : Lets := [Expr.cst 1]
theorem letsDenote1: (addLetsToProgram lets1 xs).denote [] = xs.denote (lets1.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

def lets2 : Lets := [Expr.cst 1, Expr.cst 2]
theorem letsDenote2: (addLetsToProgram lets2 xs).denote [] = xs.denote (lets2.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

def lets3 : Lets := [Expr.cst 1, Expr.cst 2, Expr.cst 3]
theorem letsDenote3: (addLetsToProgram lets3 xs).denote [] = xs.denote (lets3.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

def lets4 : Lets := [Expr.cst 1, Expr.cst 2, Expr.cst 3, Expr.add 0 1]
theorem letsDenote4: (addLetsToProgram lets4 xs).denote [] = xs.denote (lets4.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

-- a + b => b + a
def m := ExprRec.add (.var 0) (.var 1)
def r := ExprRec.add (.var 1) (.var 0)

def lets := [Expr.add 2 0, .add 1 0 , .add 0 0, .cst 1]
def m2 := ExprRec.add (.var 0) (.add (.var 1) (.var 2))

theorem mv3:
  matchVar lets 3 m = none := rfl

theorem mv2:
  matchVar lets 2 m = some [(1, 3), (0, 3)]:= rfl

theorem mv1:
  matchVar lets 1 m = some [(1, 2), (0, 3)]:= rfl

theorem mv0:
  matchVar lets 0 m = some [(1, 1), (0, 3)]:= rfl

theorem mv23:
  matchVar lets 3 m2 = none := rfl

theorem mv22:
  matchVar lets 2 m2 = none := rfl

theorem mv21:
  matchVar lets 1 m2 =
  some [(2, 3), (1, 3), (0, 3)] := rfl

theorem mv20:
  matchVar lets 0 m2 =
  some [(2, 2), (1, 3), (0, 3)]:= rfl

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
example : rewriteAt ex1 1 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)    <|
     .let Ty.nat (Expr.add 0 0)  <|
     .let Ty.nat (Expr.add 1 1)  <|
     .ret 0) := by rfl
example : denote ex1 = denote (testRewrite ex1 r 1) := by rfl


-- a + b => b + a

#eval testRewrite ex2 r 0
example : rewriteAt ex2 0 (m, r) = none := by rfl
example : denote ex2 = denote (testRewrite ex2 r 1) := by rfl

#eval testRewrite ex2 r 1
example : rewriteAt ex2 1 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 2 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 1) := by rfl

#eval testRewrite ex2 r 2
example : rewriteAt ex2 2 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 2) <|
     .let Ty.nat (Expr.add 2 2) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 2) := by rfl

#eval testRewrite ex2 r 3
example : rewriteAt ex2 3 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 2 2) <|
     .let Ty.nat (Expr.add 2 2) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 3) := by rfl

#eval testRewrite ex2 r 4
example : rewriteAt ex2 4 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 2 2) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 4) := by rfl

def ex2' : Com :=
  Com.let .nat (.cst 1) <|
  Com.let .nat (.add 0 0) <|
  Com.let .nat (.add 1 0) <|
  Com.let .nat (.add 1 1) <|
  Com.let .nat (.add 1 1) <|
  Com.ret 0

-- a + b => b + (0 + a)
def r2 := ExprRec.add (.var 1) (.add (.cst 0) (.var 0))

#eval testRewrite ex2 r2 1
example : rewriteAt ex2 1 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 2) <|
     .let Ty.nat (Expr.add 3 0) <|
     .let Ty.nat (Expr.add 4 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 1) := by rfl

#eval testRewrite ex2 r2 2
example : rewriteAt ex2 2 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 3 0) <|
     .let Ty.nat (Expr.add 4 4) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 2) := by rfl

#eval testRewrite ex2 r2 3
example : rewriteAt ex2 3 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 0) <|
     .let Ty.nat (Expr.add 4 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 3) := by rfl

#eval testRewrite ex2 r2 4
example : rewriteAt ex2 4 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 0) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 4) := by rfl

-- a + b => (0 + a) + b
def r3 := ExprRec.add (.add (.cst 0 ) (.var 0)) (.var 1)

#eval testRewrite ex2 r3 1
example : rewriteAt ex2 1 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 2) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 1) := by rfl

#eval testRewrite ex2 r3 2
example : rewriteAt ex2 2 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 4) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 2) := by rfl

#eval testRewrite ex2 r3 3
example : rewriteAt ex2 3 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 0 4) <|
     .let Ty.nat (Expr.add 4 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 3) := by rfl

#eval testRewrite ex2 r3 4
example : rewriteAt ex2 4 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 0 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 4) := by rfl