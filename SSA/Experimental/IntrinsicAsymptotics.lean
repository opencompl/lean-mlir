-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import Std.Data.Option.Lemmas
import Std.Data.Array.Lemmas
import Std.Data.Array.Init.Lemmas
import Std.Data.List.Basic
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
  /-- Nat literals. -/
  | cst (n : Nat) : IExpr Γ .nat
  /-- Variables are represented as indices into the context, i.e. `var 0` is the most recently introduced variable. -/
  | op (a : Fin Γ.length) (b : Fin Γ.length): IExpr Γ .nat
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
  ICom.let (.cst 0) <|
  ICom.let (α := .nat) (.op ⟨0, by decide⟩ ⟨0, by decide⟩) <|
  ICom.let (α := .nat) (.op ⟨1, by decide⟩ ⟨1, by decide⟩) <|
  ICom.let (α := .nat) (.op ⟨2, by decide⟩ ⟨2, by decide⟩) <|
  ICom.let (α := .nat) (.op ⟨3, by decide⟩ ⟨3, by decide⟩) <|
  ICom.let (α := .nat) (.op ⟨4, by decide⟩ ⟨4, by decide⟩) <|
  ICom.let (α := .nat) (.op ⟨5, by decide⟩ ⟨5, by decide⟩) <|
  ICom.ret (.op ⟨0, by decide⟩ ⟨0, by decide⟩)

def get_nat : Value → Nat
  | .nat x => x
  | .bool _ => panic! "boolean values not supported"

def IExpr.denote : IExpr l ty → (ll : State) → (l.length = ll.length) → Value
| .cst n, _, _ => .nat n
| .op a b, ll, h => let a_val : Nat := get_nat (ll.get (Fin.mk a (h ▸ a.isLt)))
                     let b_val : Nat := get_nat (ll.get (Fin.mk b (h ▸ b.isLt)))
                     Value.nat (a_val + b_val)

def ICom.denote : ICom l ty → (ll : State) → (l.length = ll.length) →  Value
| .ret e, l, h => e.denote l h
| .let e body, l, h => body.denote ((e.denote l h) :: l) (by simp [h])

inductive Expr : Type
  | cst (n : Nat)
  | op (a : Nat) (b : Nat)
  deriving Repr, Inhabited, DecidableEq

abbrev MVarId := Nat

inductive ExprRec : Type
  | cst (n : Nat)
  | op (a : ExprRec) (b : ExprRec)
  | mvar (idx : MVarId)
  deriving Repr, Inhabited, DecidableEq

inductive Com : Type where
  | let (e : Expr) (body : Com): Com
  | ret (e : Nat) : Com
  deriving Repr, Inhabited, DecidableEq

def ex' : Com :=
  Com.let (.cst 0) <|
  Com.let (.op 0 0) <|
  Com.let (.op 1 0) <|
  Com.let (.op 2 0) <|
  Com.let (.op 3 3) <|
  Com.let (.op 4 4) <|
  Com.let (.op 5 5) <|
  Com.ret 0

open Lean in

def formatCom : Com → Nat → Std.Format
  | .ret v, _ => "  Com.ret " ++ (repr v)
  | .let e body, n => "  Com.let " ++ "(" ++ ((toString (repr e)).drop 4)
                      ++ ") <|\n" ++ (formatCom body n)

instance : Repr Com where
  reprPrec :=  formatCom

abbrev Mapping := List (MVarId × Nat)
abbrev Lets := List Expr
abbrev FwdLets := List Expr

def ex0 : Com :=
  Com.let (.cst 0) <|
  Com.let (.op 0 0) <|
  Com.let (.op 1 0) <|
  Com.let (.op 2 0) <|
  Com.let (.op 3 0) <|
  Com.ret 0 

def getPos (v : Nat) (currentPos: Nat) : Nat :=
  v + currentPos + 1

/-- Apply `matchExpr` on a sequence of `lets` and return a `mapping` from
free variables to their absolute position in the lets array.
-/
def matchVar (lets : Lets) (varPos: Nat) (matchExpr: ExprRec) (mapping: Mapping := []): Option Mapping :=
  match matchExpr with
  | .mvar x => match mapping.lookup x with
    | some varPos' => if varPos = varPos' then (x, varPos)::mapping else none
    | none => (x, varPos)::mapping
  | .cst n => match lets[varPos]! with
    | .cst n' => if n = n' then some mapping else none
    | _ => none
  | .op a' b' =>
    match lets[varPos]! with
    | .op a b => do
        let mapping ← matchVar lets (getPos a varPos) a' mapping
        matchVar lets (getPos b varPos) b' mapping
    | _ => none

example: matchVar [.op 2 0, .op 1 0, .op 0 0, .cst 1] 0
         (.op (.mvar 0) (.op (.mvar 1) (.mvar 2))) =
  some [(2, 2), (1, 3), (0, 3)]:= rfl

def getVarAfterMapping (var : MVarId) (lets : Lets) (m : Mapping) (inputLets : Nat) : Nat :=
 match m with
 | x :: xs => if var = x.1 then
                 x.2 + (lets.length - inputLets)
              else
                 getVarAfterMapping var lets xs inputLets
 | _ => panic! "var should be in mapping"

def getRel (v : Nat) (array: List Expr): Nat :=
  (array.length - v - 1)

def applyMapping  (pattern : ExprRec) (m : Mapping) (lets : Lets) (inputLets : Nat := lets.length): (Lets × Nat) :=
match pattern with
    | .mvar v =>
      (lets, getVarAfterMapping v lets m inputLets)
    | .op a b =>
      let res := applyMapping a m lets inputLets
      let res2 := applyMapping b m (res.1) inputLets
      let l := (res.2 + (res2.1.length - res.1.length))
      let r := res2.2
      ((Expr.op l r) :: res2.1, 0)
    | .cst n => ((.cst n) :: lets, 0)

/-- shift variables after `pos` by `delta` -/
def shiftVarBy (v : Nat) (delta : ℕ) (pos : ℕ) : Nat :=
    if v >= pos then
      (v + delta)
    else
      v

/-- shift variables after `pos` by `delta` in expr -/
def shiftExprBy (e : Expr) (delta : ℕ) (pos : ℕ) : Expr :=
 match e with
    | .op a b => .op (shiftVarBy a delta pos) (shiftVarBy b delta pos)
    | .cst x => (.cst x)

/-- shift variables after `pos` by `delta` in com -/
def shiftComBy (inputProg : Com) (delta : ℕ) (pos : ℕ := 0): Com :=
  match inputProg with
  | .ret x => .ret (shiftVarBy x delta (pos+1))
  | .let e body => .let (shiftExprBy e delta pos) (shiftComBy body delta (pos+1))

structure ComFlat where
  lets : FwdLets -- sequence of let bindings.
  ret : Nat -- return value.
  deriving Repr

def shiftComFlatBy (inputProg : ComFlat) (delta : ℕ) (pos : ℕ := 0): ComFlat where
  lets := inputProg.lets.map fun e => shiftExprBy e delta pos
  ret := shiftVarBy inputProg.ret delta pos

def Nat.inc (v : Nat) : Nat :=
  v + 1

def replaceUsesOfVar (inputProg : Com) (old: Nat) (new : Nat) : Com :=
  let replace (v : Nat) : Nat :=
     if old = v then new else v
  match inputProg with
  | .ret x => .ret (replace x)
  | .let e body => match e with
    | .op a b =>
      .let (Expr.op (replace a) (replace b)) (replaceUsesOfVar body (old.inc) (new.inc))
    | .cst x => .let (.cst x) (replaceUsesOfVar body (old.inc) (new.inc))

def addLetsToProgram (newLets : Lets) (oldProgram : Com) : Com :=
  newLets.foldl (λ acc e => Com.let e acc) oldProgram

def addExprToProgramFlat (e: Expr) (oldProgram : ComFlat) : ComFlat where
  lets := e :: oldProgram.lets
  ret := oldProgram.ret

def addLetsToProgramFlat (lets : FwdLets) (oldProgram : ComFlat) : ComFlat where
  lets := lets ++ oldProgram.lets
  ret := oldProgram.ret

/-- unfolding lemma for `addLetsToProgram` -/
theorem addLetsToProgram_cons (e : Expr) (ls : Lets) (c : Com) :
  addLetsToProgram (e :: ls) c = addLetsToProgram ls (Com.let e c) := by
    simp [addLetsToProgram]

/-- unfolding lemma for `addLetsToProgram` -/
theorem addLetsToProgram_snoc (e : Expr) (ls : Lets) (c : Com) :
  addLetsToProgram (List.concat ls e) c =
  Com.let e (addLetsToProgram ls c) := by
    simp [addLetsToProgram]

def applyRewrite (lets : Lets) (inputProg : Com) (rewrite: ExprRec × ExprRec) : Option Com := do
  let varPos := 0
  let mapping ← matchVar lets varPos rewrite.1
  let (newLets, newVar) := applyMapping (rewrite.2) mapping lets
  let newProgram := inputProg
  let newProgram := shiftComBy newProgram (newLets.length - lets.length)
  let newProgram := replaceUsesOfVar newProgram ((newLets.length - lets.length)) ((newVar))
  let newProgram := addLetsToProgram newLets newProgram

  some newProgram

def rewriteAt (inputProg : Com) (depth : Nat) (rewrite: ExprRec × ExprRec) (lets: Lets := []) : Option Com :=
  match inputProg with
    | .ret _ => none
    | .let expr body =>
        let lets := expr :: lets
        if depth = 0 then
           applyRewrite lets body rewrite
        else
           rewriteAt body (depth - 1) rewrite lets

def addCstToLets (lets : Lets) (inputProg : ComFlat) : ComFlat :=
  let newLets := Expr.cst 42 :: lets
  let newProgram := inputProg
  let newProgram := shiftComFlatBy newProgram 1
  let newProgram := addLetsToProgramFlat newLets newProgram
  newProgram

def splitProgram (inputProg : ComFlat) (depth : Nat) : Option (Lets × ComFlat) :=
  if inputProg.lets.length < depth then
    none
  else
    let split := inputProg.lets.splitAt depth
    let newProg : ComFlat := ⟨split.2, inputProg.ret⟩
    some (split.1, newProg)

def insertNothing (inputProg : ComFlat) (depth : Nat) : ComFlat :=
  let split := splitProgram inputProg depth
  match split with
  | none => inputProg
  | some split => 
    let ⟨ls, prog⟩ := split
    addLetsToProgramFlat ls prog

def insertCst (inputProg : ComFlat) (depth : Nat) : ComFlat :=
  let split := splitProgram inputProg depth
  match split with
  | none => inputProg
  | some split => 
    let ⟨ls, prog⟩ := split
    let newProg := addCstToLets ls prog
    newProg

def rewrite (inputProg : Com) (depth : Nat) (rewrite: ExprRec × ExprRec) : Com :=
    let x := rewriteAt inputProg depth rewrite
    match x with
      | none => inputProg
      | some y => y

def getVal (s : State) (v : Nat) : Nat :=
  get_nat (s.get! v)

def Expr.denote (e : Expr) (s : State) : Value :=
  match e with
    | .cst n => .nat n
    | .op a b => .nat ((getVal s a) + (getVal s b))

def Com.denote (c : Com) (s : State) : Value :=
  match c with
    | .ret v => .nat (getVal s v)
    | .let e body => denote body (e.denote s :: s) -- introduce binder.

def denote (p: Com) : Value :=
  p.denote []

def Lets.denote (lets : Lets) (s : State := []): State :=
  List.foldr (λ v s => (v.denote s) :: s) s lets

def FwdLets.denote (lets : FwdLets) (s : State := []): State :=
  List.foldl (λ s v => (v.denote s) :: s) s lets


def ComFlat.denote (prog: ComFlat) (s : State := []): Value :=
  let s := prog.lets.denote s
  .nat (getVal s prog.ret)

def flatToTree (prog: ComFlat) : Com :=
  addLetsToProgram prog.lets (Com.ret prog.ret)

def ExprRec.denote (e : ExprRec) (s : State) : Value :=
  match e with
    | .cst n => .nat n
    | .op a b => let a_val := get_nat (a.denote s)
                     let b_val := get_nat (b.denote s)
                     Value.nat (a_val + b_val)
    | .mvar v => s.get! v

theorem key_lemma :
    (addLetsToProgram lets xs).denote s = xs.denote (lets.denote s) := by
  induction lets generalizing xs <;> simp_all [addLetsToProgram, Com.denote, Lets.denote]

theorem denoteFlatDenoteTree : denote (flatToTree flat) = flat.denote := by
  unfold flatToTree denote; simp [key_lemma]; sorry

theorem denoteVar_shift_zero: (shiftVarBy v 0 pos) = v := by
  simp [shiftVarBy]

theorem denoteExpr_shift_zero: Expr.denote (shiftExprBy e 0 pos) s = Expr.denote e s := by
  induction e
  case cst =>
    simp [Expr.denote, shiftExprBy]
  case op =>
    simp [Expr.denote, shiftExprBy, denoteVar_shift_zero]

theorem denoteCom_shift_zero: Com.denote (shiftComBy com 0 pos) s = Com.denote com s := by
 revert pos s
 induction com
 case ret =>
   simp [Com.denote, denoteVar_shift_zero]

 case _ e body IH =>
   simp [Com.denote]
   simp [IH]
   simp [denoteExpr_shift_zero]

def ComFlat.addLet (prog : ComFlat) : ComFlat :=
  let newLet := Expr.cst 42
  let newLets := prog.lets ++ [newLet]
  { lets := newLets, ret := (prog.ret + 1) }

def ComFlat.addLets (prog : ComFlat) (n : Nat) : ComFlat :=
  if n = 0 then prog else prog.addLets (n-1)

def exFlat := ComFlat.mk [Expr.op 0 1, Expr.cst 3, Expr.cst 5] 0

theorem unfortunate:
  Expr.denote e (FwdLets.denote ls s) :: FwdLets.denote ls s = FwdLets.denote (ls ++ [e]) s := by
    simp [FwdLets.denote]

theorem shiftExprBy_zero:
  shiftExprBy e 0 pos = e := by
  induction e generalizing pos <;> simp_all [shiftExprBy, shiftVarBy]  

theorem Expr.denote_shift_one:
    Expr.denote (shiftExprBy e 1 0) (x :: s) = Expr.denote e s  := by
  unfold denote
  simp [shiftExprBy]
  cases e
  case cst =>
    simp
  case op a b =>
    simp
    unfold shiftVarBy
    simp
    unfold getVal
    simp

theorem Expr.denote_shift_ls:
    Expr.denote (shiftExprBy e (x.length) 0) (x ++ s) = Expr.denote e s  := by
  induction x generalizing s
  unfold denote
  simp [shiftExprBy]
  cases e
  case cst =>
    simp
  case op a b =>
    simp [shiftVarBy]
  case cons e' ls IH =>
    unfold denote
    unfold shiftExprBy
    unfold getVal
    cases e
    case cst =>
      simp
    case op a b =>
      simp
      unfold shiftVarBy
      simp [List.get?_append_right]
      unfold denote at IH
      unfold shiftExprBy at IH
      unfold shiftVarBy at IH
      simp at IH
      unfold getVal at IH
      simp [IH]

theorem FwdLets.denote_empty :
    FwdLets.denote [] s = s  := by
  simp [FwdLets.denote]

theorem FwdLets.denote_append :
    FwdLets.denote (l₁ ++ l₂) s = FwdLets.denote l₂ (FwdLets.denote l₁ s) := by
  simp [FwdLets.denote]

theorem FwdLets.denote_cons :
     FwdLets.denote (e :: ls) s = FwdLets.denote ls (e.denote s :: s) := by
  rfl

theorem shiftComFlatBy_zero:
  shiftComFlatBy p 0 = p := by
  simp [shiftExprBy_zero, shiftVarBy, shiftComFlatBy]

theorem ComFlat.denote_addLetsToProgram :
    ComFlat.denote (addLetsToProgramFlat ls c) s = ComFlat.denote c (ls.denote s) := by 
  induction ls using List.reverseRecOn
  case H0 =>
    simp [addLetsToProgramFlat, ComFlat.denote, FwdLets.denote]
  case H1 ls e IH =>
    simp [addLetsToProgramFlat, ComFlat.denote, FwdLets.denote, IH]

theorem ComFlat.denote_shiftComFlatBy :
    ComFlat.denote (shiftComFlatBy p (List.length ls)) (FwdLets.denote ls s) = ComFlat.denote p s := by
  induction ls using List.reverseRecOn generalizing p s
  case H0 =>
    simp [List.length]
    simp [FwdLets.denote]
    simp [shiftComFlatBy_zero]
  case H1 ls e IH =>
    simp [List.length]
    simp [FwdLets.denote_append]
    simp [ComFlat.denote_shift_cancellation]
    simp [IH]

theorem ComFlat.denote_concatExpr:
    ComFlat.denote (addLetsToProgramFlat (ls ++ [e]) c) s =
    ComFlat.denote c (FwdLets.denote [e] (FwdLets.denote ls s)) := by
  unfold addLetsToProgramFlat
  unfold ComFlat.denote
  simp [FwdLets.denote_append]
  simp [FwdLets.denote_cons]
  simp [FwdLets.denote]

theorem ComFlat.denote_addLet :
    ComFlat.denote (exFlat.addLet) = ComFlat.denote exFlat := by
  simp [ComFlat.addLet, ComFlat.denote]

theorem ComFlat.denote_addLets :
    (exFlat.addLets n).denote = exFlat.denote := by
  induction n
  case zero =>
    simp [ComFlat.addLets, ComFlat.denote]
  case succ n h =>
    unfold ComFlat.addLets
    simp [ Nat.succ_sub_one]
    apply h

theorem denoteFlat_addExpr :
  ComFlat.denote (addExprToProgramFlat e c) s =
  ComFlat.denote c (Expr.denote e s :: s) := by
    simp [ComFlat.denote, addExprToProgramFlat]
    simp [FwdLets.denote]


/-- @sid: this theorem statement is wrong. I need to think properly about what shift is saying.
Anyway, proof outline: prove a theorem that tells us how the index changes when we add a single let
binding. Push the `denote` through and then rewrite across the single index change. -/
theorem shifting:
  ComFlat.denote (addLetsToProgramFlat ls (shiftComFlatBy p (ls.length))) s =
  ComFlat.denote p s := by
  simp [ComFlat.denote_addLetsToProgram]
  simp [ComFlat.denote_shiftComFlatBy]

theorem addLetsToProgram_append: 
  addLetsToProgramFlat (ls₁ ++ ls₂) p = addLetsToProgramFlat ls₁ (addLetsToProgramFlat ls₂ p) := by
  induction ls₁ using List.reverseRecOn generalizing p <;>  simp [addLetsToProgramFlat]

theorem splitProgramAddLets
     (h: splitProgram p pos = some split) :
     addLetsToProgramFlat split.fst split.snd = p := by
   unfold splitProgram at h
   split at h
   case inl =>
     contradiction
   case inr h' =>
     simp at h
     unfold addLetsToProgramFlat
     cases h
     simp
     

theorem denoteInsertNothing :
    ComFlat.denote (insertNothing prog pos) s = ComFlat.denote prog s := by
  unfold insertNothing
  simp
  split
  case h_1 =>
    simp
  case h_2 _ split heq =>
    rw [splitProgramAddLets heq]

--  simp [FwdLets.denote_append]
--  simp [FwdLets.denote_cons]
--  simp [FwdLets.denote]


theorem hgh:
  ComFlat.denote (addExprToProgramFlat e (shiftComFlatBy prog 1)) s = ComFlat.denote prog (s) := by


theorem asd:
  ComFlat.denote (addLetsToProgramFlat [e] (shiftComFlatBy prog 1)) s =
  ComFlat.denote (addLetsToProgramFlat [] prog) s := by
    simp [addLetsToProgramFlat]
    simp [ComFlat.denote, addExprToProgramFlat]
    simp [FwdLets.denote]
    c

theorem yyyy:
  ComFlat.denote (addLetsToProgramFlat (ls ++ [e]) (shiftComFlatBy prog 1)) s =
  ComFlat.denote (addLetsToProgramFlat ls prog) s := by
  induction ls generalizing prog s
  case nil =>
    simp
    

    simp [FwdLets.denote_empty]
    simp [ComFlat.denote_addLetsToProgram]
    simp [ComFlat.denote_shiftComFlatBy]
    unfold ComFlat.denote
    simp
    simp [FwdLets.denote_append]
    -- [FwdLets.denote_cons]
    simp [getVal, FwdLets.denote]
    simp
    unfold shiftComFlatBy
    simp
    simp [Expr.denote_shift_one]


  sorry

theorem xxx 
  (h: splitProgram prog pos = some split):
  ComFlat.denote
    (addLetsToProgramFlat (split.fst ++ [e]) (shiftComFlatBy split.snd 1)) s =
  ComFlat.denote prog s := by
  unfold splitProgram at h
  split at h

  case inl =>
    contradiction

  case inr h' =>
        
    simp_all
    unfold ComFlat.denote
    simp_all
    simp [FwdLets.denote_append]
    simp [FwdLets.denote_cons]
    unfold addLetsToProgramFlat
    simp
    unfold shiftComFlatBy
    simp
    simp[Expr.denote_shift_one]
    cases h
    induction prog.lets generalizing s

    case nil =>
      simp_all
      simp [FwdLets.denote_append]
      simp [FwdLets.denote_cons]
      simp [FwdLets.denote_empty]
      unfold shiftVarBy 
      unfold getVal
      simp

    case refl.cons csl ls IH =>
      simp_all
      simp [FwdLets.denote_append]
      simp [FwdLets.denote_cons]
      simp [FwdLets.denote_empty]
      unfold shiftVarBy 
      unfold getVal
      
      simp [IH]

      simp_all
      
      unfold ComFlat.denote
      simp
      unfold addLetsToProgramFlat
      simp
      simp [FwdLets.denote_append]
      

      

    

    simp
    

    simp at h
    unfold shiftComFlatBy
    cases

    simp



    cases h
    simp


theorem denoteInsertCst : ComFlat.denote (insertCst prog pos) s = ComFlat.denote prog s := by
  unfold insertCst
  simp
  split
  case h_1 =>
    simp
  
  case h_2 _ split heq =>
    unfold addCstToLets
    simp
    rw [xxx heq]
     


      
theorem letsTheorem
 (matchExpr : ExprRec) (lets : Lets)
 (h1: matchVar lets pos matchExpr m₀ = some m)
 (hlets: lets.length > 0)
 (hm₀: denote (addLetsToProgram lets (Com.ret ((lets.length - pos - 1) ))) =
       denote (addLetsToProgram (applyMapping matchExpr m₀ lets).1
              (Com.ret 0))):

   denote (addLetsToProgram (lets) (Com.ret ((lets.length - pos - 1)))) =
   denote (addLetsToProgram (applyMapping matchExpr m lets).1 (Com.ret 0)) := by
      induction matchExpr generalizing m₀ m pos
      unfold applyMapping
      case cst n =>
        simp [applyMapping, hm₀]

      case op a b a_ih b_ih =>
        simp [matchVar] at h1
        split at h1
        case h_1 x avar bvar heq =>
          erw [Option.bind_eq_some] at h1; rcases h1 with ⟨m_intermediate, ⟨h1, h2⟩⟩
          have a_fold := a_ih h1
          have b_fold := b_ih h2
          rw [hm₀]

          unfold applyMapping
          sorry

        case h_2 x x' =>
          contradiction

      case mvar idx =>
        simp [applyMapping, hm₀]

-- We probably need to know 'Com.denote body env' is well formed. We want to say that if
-- body succeeds at env, then it succeeds in a larger env.
-- Actually this is not even true, we need to shift body.
-- @grosser: since this theorem cannot be true, we see that denoteAddLetsToProgram
-- also cannot possibly be true.
theorem Com_denote_invariant_under_extension_false_theorem :
   ComFlat.denote prog s = ComFlat.denote prog (s ++ [v]) := by
   unfold ComFlat.denote
   unfold FwdLets.denote
   simp
   induction prog.lets generalizing s
   case nil =>
    simp
    simp [getVal]
    unfold List.get!
    simp




    case ret =>
      intros env; simp [Com.denote]
      simp [getVal]
      sorry
   case ret =>
    intros env; simp [Com.denote]
    simp [getVal]
    sorry

   case _ => sorry

theorem denoteAddLetsToProgram:
  denote (addLetsToProgram lets body) = denote (addLetsToProgram lets (Com.let e body)) := by
  simp [denote]
  simp [key_lemma (lets := lets) (xs := body)]
  simp [key_lemma]
  simp [Com.denote]
  generalize H : (Lets.denote lets) = env'
  -- we know that this theorem must be false, because it asserts that
  -- ⊢ Com.denote body env' = Com.denote body (Expr.denote e env' :: env')
  -- but this is absurd, because if body were a variable, we need to at least shift the
  -- variables in the RHS.
  sorry -- The statement is likely not complete enough to be proven.

theorem rewriteAtApplyRewriteCorrect
 (hpos: pos = 0) :
 rewriteAt body pos rwExpr lets = applyRewrite (lets ++ [e]) body rwExpr := by
  sorry

theorem rewriteAtAppend:
  rewriteAt body pos rwExpr lets = rewriteAt body (pos - 1) rwExpr (lets ++ [e]) := sorry

theorem rewriteAtCorrect'
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec)
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s)
  (lets : Lets) (successful : rewriteAt p pos rwExpr lets = some p'):
  denote p' = denote (addLetsToProgram lets p) := by
  induction pos
  case zero =>
    unfold rewriteAt at successful
    split at successful
    · contradiction
    · simp at successful
      rename_i inputProg e body
      sorry
  sorry

theorem rewriteAtCorrect
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec)
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s)
  (lets : Lets) (successful : rewriteAt p pos rwExpr lets = some p'):
  denote p' = denote (addLetsToProgram lets p) := by
  induction p
  case «let» e body body_ih =>
    unfold rewriteAt at successful
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
        unfold rewriteAt
        simp
        cases body
        simp_all
        · simp_all
          sorry


        · simp_all
          contradiction
  case ret v =>
    unfold rewriteAt at successful
    contradiction

theorem preservesSemantics
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec)
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s):
  denote (rewrite p pos rwExpr) = denote p := by
  unfold rewrite
  simp
  split
  · rfl
  · rw [rewriteAtCorrect (successful := by assumption)]
    simp [addLetsToProgram]
    apply rewriteCorrect

def ex1 : Com :=
  Com.let (.cst 1) <|
  Com.let (.op 0 0) <|
  Com.ret 0

def ex2 : Com :=
  Com.let (.cst 1) <|
  Com.let (.op 0 0) <|
  Com.let (.op 1 0) <|
  Com.let (.op 1 1) <|
  Com.let (.op 1 1) <|
  Com.ret 0

theorem addLets: addLetsToProgram [Expr.op 0 0, Expr.cst 1] (Com.ret 0) = (
  Com.let (Expr.cst 1) <|
  Com.let (Expr.op 0 0) <|
  Com.ret 0) := rfl

theorem letsDenoteZero: Lets.denote [] = [] := rfl
theorem letsComDenoteZero: (addLetsToProgram [] (Com.ret 0)).denote [] = Value.nat 0 := rfl

theorem letsDenoteOne: Lets.denote [Expr.cst 0] [] = [Value.nat 0] := rfl
theorem letsComDenoteOne: (addLetsToProgram [Expr.cst 0] (Com.ret 0)).denote [] = Value.nat 0 := rfl

theorem letsDenoteTwo:
  Lets.denote [Expr.op 0 0, Expr.cst 1] [] = [Value.nat 2, Value.nat 1] := rfl

theorem letsComDenoteTwo:
  (addLetsToProgram [Expr.op 0 0, Expr.cst 1] (Com.ret 0)).denote [] = Value.nat 2 := by
  rfl
theorem letsComDenoteTwo':
  (addLetsToProgram [Expr.op 0 0, Expr.cst 1] (Com.ret 1)).denote [] = Value.nat 1 := by
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
  Lets.denote [Expr.op 0 1, Expr.cst 3, Expr.cst 5, Expr.cst 7] [] =
  [Value.nat 8, Value.nat 3, Value.nat 5, Value.nat 7] := rfl
theorem letsComDenoteFour:
  (addLetsToProgram [Expr.op 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.op 0 1] (Com.ret 0)).denote [] = Value.nat 1 := by
  rfl
theorem letsComDenoteFour':
  (addLetsToProgram [Expr.op 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.op 0 1] (Com.ret 1)).denote [] = Value.nat 0 := by
  rfl
theorem letsComDenoteFour'':
  (addLetsToProgram [Expr.op 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.op 0 1] (Com.ret 2)).denote [] = Value.nat 1 := by
  rfl
theorem letsComDenoteFour''':
  (addLetsToProgram [Expr.op 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.op 0 1] (Com.ret 3)).denote [] = Value.nat 2 := by
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

def lets4 : Lets := [Expr.cst 1, Expr.cst 2, Expr.cst 3, Expr.op 0 1]
theorem letsDenote4: (addLetsToProgram lets4 xs).denote [] = xs.denote (lets4.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

-- a + b => b + a
def m := ExprRec.op (.mvar 0) (.mvar 1)
def r := ExprRec.op (.mvar 1) (.mvar 0)

def lets := [Expr.op 2 0, .op 1 0 , .op 0 0, .cst 1]
def m2 := ExprRec.op (.mvar 0) (.op (.mvar 1) (.mvar 2))

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

example : rewriteAt ex1 1 (m, r) = (
  Com.let (Expr.cst 1)    <|
     .let (Expr.op 0 0)  <|
     .let (Expr.op 1 1)  <|
     .ret 0) := by rfl
example : denote ex1 = denote (testRewrite ex1 r 1) := by rfl

-- a + b => b + a

example : rewriteAt ex2 0 (m, r) = none := by rfl
example : denote ex2 = denote (testRewrite ex2 r 1) := by rfl

example : rewriteAt ex2 1 (m, r) = (
  Com.let (Expr.cst 1)   <|
     .let (Expr.op 0 0) <|
     .let (Expr.op 1 1) <|
     .let (Expr.op 2 0) <|
     .let (Expr.op 1 1) <|
     .let (Expr.op 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 1) := by rfl

example : rewriteAt ex2 2 (m, r) = (
  Com.let (Expr.cst 1)   <|
     .let (Expr.op 0 0) <|
     .let (Expr.op 1 0) <|
     .let (Expr.op 1 2) <|
     .let (Expr.op 2 2) <|
     .let (Expr.op 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 2) := by rfl

example : rewriteAt ex2 3 (m, r) = (
  Com.let (Expr.cst 1)   <|
     .let (Expr.op 0 0) <|
     .let (Expr.op 1 0) <|
     .let (Expr.op 1 1) <|
     .let (Expr.op 2 2) <|
     .let (Expr.op 2 2) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 3) := by rfl

example : rewriteAt ex2 4 (m, r) = (
  Com.let (Expr.cst 1)   <|
     .let (Expr.op 0 0) <|
     .let (Expr.op 1 0) <|
     .let (Expr.op 1 1) <|
     .let (Expr.op 1 1) <|
     .let (Expr.op 2 2) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 4) := by rfl

def ex2' : Com :=
  Com.let (.cst 1) <|
  Com.let (.op 0 0) <|
  Com.let (.op 1 0) <|
  Com.let (.op 1 1) <|
  Com.let (.op 1 1) <|
  Com.ret 0

-- a + b => b + (0 + a)
def r2 := ExprRec.op (.mvar 1) (.op (.cst 0) (.mvar 0))

example : rewriteAt ex2 1 (m, r2) = (
  Com.let (Expr.cst 1) <|
     .let (Expr.op 0 0) <|
     .let (Expr.cst 0) <|
     .let (Expr.op 0 2) <|
     .let (Expr.op 3 0) <|
     .let (Expr.op 4 0) <|
     .let (Expr.op 1 1) <|
     .let (Expr.op 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 1) := by rfl

example : rewriteAt ex2 2 (m, r2) = (
  Com.let (Expr.cst 1) <|
     .let (Expr.op 0 0) <|
     .let (Expr.op 1 0) <|
     .let (Expr.cst 0) <|
     .let (Expr.op 0 3) <|
     .let (Expr.op 3 0) <|
     .let (Expr.op 4 4) <|
     .let (Expr.op 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 2) := by rfl

example : rewriteAt ex2 3 (m, r2) = (
  Com.let (Expr.cst 1) <|
     .let (Expr.op 0 0) <|
     .let (Expr.op 1 0) <|
     .let (Expr.op 1 1) <|
     .let (Expr.cst 0) <|
     .let (Expr.op 0 3) <|
     .let (Expr.op 4 0) <|
     .let (Expr.op 4 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 3) := by rfl

example : rewriteAt ex2 4 (m, r2) = (
  Com.let (Expr.cst 1) <|
     .let (Expr.op 0 0) <|
     .let (Expr.op 1 0) <|
     .let (Expr.op 1 1) <|
     .let (Expr.op 1 1) <|
     .let (Expr.cst 0) <|
     .let (Expr.op 0 3) <|
     .let (Expr.op 4 0) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 4) := by rfl

-- a + b => (0 + a) + b
def r3 := ExprRec.op (.op (.cst 0 ) (.mvar 0)) (.mvar 1)

example : rewriteAt ex2 1 (m, r3) = (
  Com.let (Expr.cst 1) <|
     .let (Expr.op 0 0) <|
     .let (Expr.cst 0) <|
     .let (Expr.op 0 2) <|
     .let (Expr.op 0 3) <|
     .let (Expr.op 4 0) <|
     .let (Expr.op 1 1) <|
     .let (Expr.op 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 1) := by rfl

example : rewriteAt ex2 2 (m, r3) = (
  Com.let (Expr.cst 1) <|
     .let (Expr.op 0 0) <|
     .let (Expr.op 1 0) <|
     .let (Expr.cst 0) <|
     .let (Expr.op 0 3) <|
     .let (Expr.op 0 3) <|
     .let (Expr.op 4 4) <|
     .let (Expr.op 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 2) := by rfl

example : rewriteAt ex2 3 (m, r3) = (
  Com.let (Expr.cst 1) <|
     .let (Expr.op 0 0) <|
     .let (Expr.op 1 0) <|
     .let (Expr.op 1 1) <|
     .let (Expr.cst 0) <|
     .let (Expr.op 0 3) <|
     .let (Expr.op 0 4) <|
     .let (Expr.op 4 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 3) := by rfl

example : rewriteAt ex2 4 (m, r3) = (
  Com.let (Expr.cst 1) <|
     .let (Expr.op 0 0) <|
     .let (Expr.op 1 0) <|
     .let (Expr.op 1 1) <|
     .let (Expr.op 1 1) <|
     .let (Expr.cst 0) <|
     .let (Expr.op 0 3) <|
     .let (Expr.op 0 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 4) := by rfl
