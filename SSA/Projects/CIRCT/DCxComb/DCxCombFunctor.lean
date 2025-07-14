import Mathlib.Logic.Function.Iterate
import Mathlib.Tactic.Linarith
import SSA.Core.Framework
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.Util
import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Comb.Comb
import SSA.Projects.CIRCT.Stream.Stream

open Ctxt(Var)

namespace DCxCombFunctor

open MLIR2Comb MLIR2DC

open CIRCTStream

open TyDenote


/-- Describes that the dialect Op' has a type whose denotation is 'DenotedTy -/
-- class HasTy (d : Dialect) (DenotedTy : Type) [TyDenote d.Ty] [DialectSignature d] where
--     ty : d.Ty
--     denote_eq : toType ty = DenotedTy := by rfl


-- abbrev HasBool (d : Dialect) [TyDenote d.Ty] [DialectSignature d] : Type := HasTy d Bool
-- abbrev HasInt (d : Dialect) [TyDenote d.Ty] [DialectSignature d] : Type := HasTy d Int
-- abbrev HasNat (d : Dialect) [TyDenote d.Ty] [DialectSignature d] : Type := HasTy d Nat

-- DCxComb contains operations of two types: comb and dc
inductive Op : Type _
  | comb (o : MLIR2Comb.Comb.Op)
  | dc (o : MLIR2DC.DC.Op)
  deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

-- inductive Ty : Type _ -- do the same as Op
--   | comb (o : MLIR2Comb.Comb.Op)
--   | dc (o : MLIR2DC.DC.Op)
--   deriving DecidableEq, Repr


-- we also want bitvecs in the types of the functor. consider an input given by user:
-- comb.add (%1: i64) (%2: i64) → under the hp. that it will automagically be lifted to streams
-- but then we need to differentiate this from
-- comb.add (%1: caluestream i64) (%2: valuestream i64)
-- which is a mess, so we need bv. (even though their denotation is the same!!)

abbrev DCxComb : Dialect where
  Op := Op
  Ty := MLIR2DC.DC.Ty

def liftTy : MLIR2Comb.Ty → MLIR2DC.Ty
| .bitvec w => .valuestream w

-- TODO(yann): Currently we use a small hack to use a default void type for types that have no equivalent going from
-- Comb to DC.  This default value should be a stream to make denotation easier.
def liftSig (sig : Signature MLIR2Comb.Ty) : Signature MLIR2DC.Ty :=
  Signature.mk (sig.sig.map liftTy) [] (liftTy sig.outTy)
-- map bitvecs from comb to streams in dc


instance : DialectSignature DCxComb where
  signature := fun op =>
    match op with
    | .comb o => liftSig (signature o) -- does not assume that regsig is empty
    -- TODO(yann): Need to specify the signature instance directly because it is otherwise trying to get the instance of
    -- DCxComb.
    | .dc o => MLIR2DC.instDialectSignatureDC.signature o

-- this function does not actually sync, it "only" lifts the HVector of Streams we
-- have e.g. in a variadic input into a single stream, where each element of the stream is an HVector
-- representing the entry at that point for
-- HVector (fun i => Stream (BitVec i)) l = "map each i in l to construct a Stream BitVec"
def hv_cast_gen' {l : List Nat} (h : HVector (fun i => Stream (BitVec i)) l) :
    Stream' (HVector (fun i => Option (BitVec i)) l) :=
  fun n =>
    match h with
    | .nil => .nil
    | .cons x xs => HVector.cons (x n) (hv_cast_gen' xs n)

-- problem: we need a proof that this is actually true (i.e., none of the streams in
-- h is full of nones)
-- this function *actually* does the syncing! we take an HVector of Streams and lift it into
-- a Stream that returns none until all the input stream are ready
-- note that Stream := Stream' (Option β)
-- latency insensitive op
def is_ready {l : List Nat} (v : HVector (fun i => Option (BitVec i)) l) :
    Option (HVector (fun i => BitVec i) l) :=
  match v with
        | .nil => some .nil
        | .cons (some x) xs =>
            match is_ready xs with
            | some xs' => some (.cons x xs')
            | none => none
        | .cons none _ => none

-- HVector toType [bv64, bv64] → ⟦bv64⟧

-- HVector toType [stream_bv64, stream_bv64] → ⟦stream_bv64⟧

open MLIR2Comb

example : toType (Ty.bitvec 64 : Comb.Ty) = BitVec 64 := rfl

example : toType (liftTy (Ty.bitvec 64 : Comb.Ty)) = Stream' (Option <| BitVec 64) := rfl

/-
  · f is the semantics of the comb operation
  · argTys is the list of the arg types for the comb op
  · mapping the types that live in the functor to the comb op arg types
    e.g. binary op: f = bv w → bv w → bv w
      liftComb lifts this to be valstr w → valstr w → valstr w
  · this is actually latency insensitive
-/
open MLIR2Comb in
variable {m} [Pure m] in

def liftComb {argTys : List Comb.Ty} {outTy : Comb.Ty}
    (f : HVector toType argTys → ⟦outTy⟧) :
    HVector toType (liftTy <$> argTys) → ⟦liftTy outTy⟧ := fun args =>
  let B := fun
    | .valuestream w => BitVec w
    | _ => BitVec 0
  have h := by
    intro i
    simp [Fin.instGetElemFinVal, liftTy]
    rfl
  Stream.transpose (B := B) args h
    |>.map fun args =>
      f (args.cast (by simp) (by intros; simp[B, liftTy]; rfl))

/-- Given a stream of values α, Peel off the heads of all the streams. -/
-- def heads {l : List Nat}
--     (h : HVector (fun i => Stream α) l) : HVector (fun i => Option α) l := sorry

def hv_cast_gen {l : List Nat} (h : HVector (fun i => Stream (BitVec i)) l) :
    Stream (HVector (fun i => BitVec i) l) :=
  fun n => is_ready (hv_cast_gen' h n)

def HVector.replicateToList {α : Type} {f : α → Type} {a : α} :
    {n : Nat} → HVector f (List.replicate n a) → List (f a)
  | 0, _ => []
  | n + 1, HVector.cons x xs => x :: replicateToList xs

-- example (op : Comb.Op) : DialectSignature.effectKind op = .pure := rfl
example (op : Comb.Op) : DialectSignature.effectKind (d := DCxComb) (.comb op) = .pure := rfl


-- example (op : Comb.Op) : DialectSignature.regSig op = [] := rfl
example (op : Comb.Op) : DialectSignature.regSig (d := DCxComb) (.comb op) = [] := rfl


-- TODO: renamed HVector.cast
def vecCast (h : as = bs) : HVector A as → HVector A bs := (h ▸ ·)

-- semantics is defined already here, no need to redefine it later
def_denote for DCxComb where
  | .comb op =>
      let opDenote :=
        (DialectDenote.denote op · (vecCast (by cases op <;> rfl) HVector.nil))
      let opDenote : HVector _ _ → ⟦_⟧ :=
        EffectKind.coe_toMonad ∘ opDenote
      liftComb opDenote
  | .dc op => MLIR2DC.instDialectDenoteDC.denote op

-- we want to have a latency-sensitive semantics for pack and unpack to eat/produce sync tokens
-- only need to sync with multiple inputs to the comb region (ideally variadic)

def mkTy : MLIR.AST.MLIRType 0 → MLIR.AST.ExceptM DCxComb DCxComb.Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn "_" with
    | ["TokenStream"] =>
      return .tokenstream
    | ["TokenStream2"] =>
      return .tokenstream2
    | ["ValueStream", w] =>
      match w.toNat? with
      | some w' => return .valuestream w'
      | _ => throw <| .generic s!"type mismatch 1"
    | ["ValueStream2", w] =>
      match w.toNat? with
      | some w' => return .valuestream2 w'
      | _ => throw <| .generic s!"type mismatch 2"
    | ["ValueTokenStream", w] =>
    match w.toNat? with
      | some w' => return .valuetokenstream w'
      | _ => throw .unsupportedType
    | ["VariadicValueTokenStream", w] =>
    match w.toNat? with
      | some w' => return .variadicvaluetokenstream w'
      | _ => throw <| .generic s!"type mismatch 3"
    | _ => throw <| .generic s!"type mismatch 4"
  | _ => throw <| .generic s!"type mismatch 5"

instance instTransformTy : MLIR.AST.TransformTy DCxComb 0 where
  mkTy := mkTy

open Qq Lean Meta Elab.Term Elab Command
open MLIR

def getVarWidth {Γ : Ctxt DCxComb.Ty} : (Σ t, Γ.Var t) → Nat
  | ⟨.tokenstream, _⟩ => 1
  | ⟨.tokenstream2, _⟩ => 1
  | ⟨.valuestream w, _⟩ => w
  | ⟨.valuestream2 w, _⟩ => w
  | ⟨.valuetokenstream w, _⟩ => w
  | ⟨.variadicvaluetokenstream w, _⟩ => w

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM DCxComb (Σ eff ty, Expr DCxComb Γ eff ty) := do
  let args ← opStx.parseArgs Γ
  let mkExprOf := opStx.mkExprOf (args? := args) Γ
  -- exclude empty list of args
  match (opStx.name).splitOn "_" with
  -- 0-ary ops
  | ["DCxComb.source"] =>
    mkExprOf <| Op.dc (MLIR2DC.Op.source)
  -- 1-ary ops
  | ["DCxComb.sink"] | ["DCxComb.unpack"] | ["DCxComb.fork"] | ["DCxComb.branch"] | ["DCxComb.fst"]
  | ["DCxComb.snd"] | ["DCxComb.fstVal"] | ["DCxComb.sndVal"] | ["DCxComb.fstVal'"] | ["DCxComb.sndVal'"]
  | ["DCxComb.tokVal'"] | ["DCxComb.pack2"] =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, opStx.name with
      | .tokenstream, "DCxComb.sink" =>  mkExprOf <| Op.dc (MLIR2DC.Op.sink)
      | .valuestream r, "DCxComb.unpack"  => mkExprOf <| Op.dc (MLIR2DC.Op.unpack r)
      | .tokenstream, "DCxComb.fork"  =>  mkExprOf <| Op.dc (MLIR2DC.Op.fork)
      | .valuestream 1, "DCxComb.branch"  =>  mkExprOf <| Op.dc (MLIR2DC.Op.branch)
      | .tokenstream2, "DCxComb.fst" => mkExprOf <| Op.dc (MLIR2DC.Op.fst)
      | .tokenstream2, "DCxComb.snd"  => mkExprOf <| Op.dc (MLIR2DC.Op.snd)
      | .valuetokenstream r, "DCxComb.fstVal" => mkExprOf <| Op.dc (MLIR2DC.Op.fstVal r)
      | .valuetokenstream r, "DCxComb.sndVal"  => mkExprOf <| Op.dc (MLIR2DC.Op.sndVal r)
      | .variadicvaluetokenstream r, "DCxComb.fstval'"  => mkExprOf <| Op.dc (MLIR2DC.Op.fstVal' r)
      | .variadicvaluetokenstream r, "DCxComb.sndval'"  => mkExprOf <| Op.dc (MLIR2DC.Op.sndVal' r)
      | .variadicvaluetokenstream r, "DCxComb.tokval'"  => mkExprOf <| Op.dc (MLIR2DC.Op.tokVal' r)
      | .variadicvaluetokenstream r, "DCxComb.pack2"  => mkExprOf <| Op.dc (MLIR2DC.Op.pack2 r)
      | _, _ => throw <| .generic s!"type mismatch at {repr opStx.args}"
    | _ => throw <| .generic s!"expected one operand, found #'{opStx.args.length}' in '{repr opStx.args}'"
  -- 2-ary ops
  | ["DCxComb.merge"] | ["DCxComb.join"] | ["DCxComb.pack"] | ["DCxComb.unpack2"] =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, opStx.name with
      | .tokenstream, .tokenstream, "DCxComb.merge" => mkExprOf <| Op.dc (MLIR2DC.Op.merge)
      | .tokenstream, .tokenstream, "DCxComb.join"  => mkExprOf <| Op.dc (MLIR2DC.Op.join)
      | .valuestream r, .tokenstream, "DCxComb.pack"  => mkExprOf <| Op.dc (MLIR2DC.Op.pack r)
      | .valuestream r₁, .valuestream r₂, "DCxComb.unpack2"  =>
          if h : r₁ = r₂ then mkExprOf <| Op.dc (MLIR2DC.Op.unpack2 r₁)
          else throw <| .generic s!"typew mismatch in {repr opStx.args}"
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands, found #'{opStx.args.length}' in '{repr opStx.args}'"
  -- special cases
  | ["DCxComb.select"] =>
      match opStx.args with
      | v₁Stx::v₂Stx::v₃Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
        let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
        match ty₁, ty₂, ty₃, opStx.name with
        | .tokenstream, .tokenstream, .valuestream 1, "DCxComb.select" => mkExprOf <| Op.dc (MLIR2DC.Op.select)
        | _, _, _, _=> throw <| .generic s!"type mismatch in the args of '{repr opStx.args}'"
      | _ => throw <| .generic s!"expected three operands, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | ["DCxComb.parity"] =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, opStx.name with
      | .valuestream w, "DCxComb.parity" => mkExprOf <| Op.comb (MLIR2Comb.Op.parity w)
      | _, _ => throw <| .generic s!"type mismatch in the args of '{repr opStx.args}'"
    | _ => throw <| .generic s!"expected one operand, found #'{opStx.args.length}' in '{repr opStx.args}'"
  -- comb variadic ops
  | ["DCxComb.add"] | ["DCxComb.and"] | ["DCxComb.mul"] | ["DCxComb.or"] | ["DCxComb.xor"] =>
      let args ← opStx.args.mapM (MLIR.AST.TypedSSAVal.mkVal Γ)
      if hl: args.length ≤ 0 then
        throw <| .generic s!"empty list of arguments for '{repr opStx.args}'"
      else
        have hl' : (0 : Nat) < args.length := by
          simp [Nat.gt_of_not_le (n := args.length) (m := 0) hl]
        match args[0] with
        | ⟨.valuestream w, _⟩ =>
            if hall : args.all (·.1 = .valuestream w) then
              have heq : args.length - 1 + 1 = args.length := by omega
              match opStx.name with
              | "DCxComb.add" => mkExprOf <| Op.comb (MLIR2Comb.Op.add w args.length)
              | "DCxComb.and" => mkExprOf <| Op.comb (MLIR2Comb.Op.and w args.length)
              | "DCxComb.mul" => mkExprOf <| Op.comb (MLIR2Comb.Op.mul w args.length)
              | "DCxComb.or" => mkExprOf <| Op.comb (MLIR2Comb.Op.or w args.length)
              | "DCxComb.xor" => mkExprOf <| Op.comb (MLIR2Comb.Op.xor w args.length)
              | _ => throw <| .generic s!"unknown comb operation '{repr opStx.args}'"
            else throw <| .generic s!"Wrong argument types for '{repr opStx.args}'"
        | _ => throw <| .generic s!"Wrong argument types for '{repr opStx.args}'"
  -- comb binary ops
  | ["Comb.divs"] | ["Comb.divu"] | ["Comb.mods"] | ["Comb.modu"] | ["Comb.replicate"] | ["Comb.shl"] | ["Comb.shrs"] | ["Comb.shru"] | ["Comb.sub"] =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂ with
      /- more checks need to be added here to ensure the consistency of operations and bitvec sizes -/
      | .valuestream r₁, .valuestream r₂ =>
        if r₁ = r₂ then
          match opStx.name with
          | "Comb.divs" => mkExprOf <| Op.comb (MLIR2Comb.Op.divs r₁)
          | "Comb.divu" => mkExprOf <| Op.comb (MLIR2Comb.Op.divu r₁)
          | "Comb.mods" => mkExprOf <| Op.comb (MLIR2Comb.Op.mods r₁)
          | "Comb.modu" => mkExprOf <| Op.comb (MLIR2Comb.Op.modu r₁)
          | "Comb.shl" => mkExprOf <| Op.comb (MLIR2Comb.Op.shl r₁)
          | "Comb.shrs" => mkExprOf <| Op.comb (MLIR2Comb.Op.shrs r₁)
          | "Comb.shru" => mkExprOf <| Op.comb (MLIR2Comb.Op.shru r₁)
          | "Comb.sub" => mkExprOf <| Op.comb (MLIR2Comb.Op.sub r₁)
          | _ => throw <| .generic s!"unknown comb operation '{repr opStx.args}'"
        else
          throw <| .generic s!"type mismatch in '{repr opStx.args}'"
      | _, _ => throw <| .generic s!"Wrong argument types for '{repr opStx.args}'"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | ["Comb.icmp", icmpPred] =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂ with
      | .valuestream r₁, .valuestream r₂ =>
        if r₁ = r₂ then
          match opStx.name with
          | "Comb.icmp" => mkExprOf <| Op.comb (MLIR2Comb.Op.icmp icmpPred r₁)
          | _ => throw <| .generic s!"unknown comb operation '{repr opStx.args}'"
        else
          throw <| .generic s!"type mismatch in '{repr opStx.args}'"
      | _, _ => throw <| .generic s!"Wrong argument types for '{repr opStx.args}'"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | ["Comb.mux"] =>
      match opStx.args with
      | v₁Stx::v₂Stx::v₃Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
        let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
        match ty₁, ty₂, ty₃ with
        | .valuestream r₁, .valuestream r₂, .valuestream 1 =>
          if r₁ = r₂ then mkExprOf <| Op.comb (MLIR2Comb.Op.mux r₁)
          else  throw <| .generic s!"unknown comb operation '{repr opStx.args}'"
        | _, _, _ => throw <| .generic s!"type mismatch"
      | _ => throw <| .generic s!"expected three operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"


def mkReturn (Γ : Ctxt DCxComb.Ty) (opStx : MLIR.AST.Op 0) :
   MLIR.AST.ReaderM DCxComb (Σ eff ty, Com DCxComb Γ eff ty) := do
  if opStx.name ≠ "return" then
    throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"
  else
    let args ← (← opStx.parseArgs Γ).assumeArity 1
    let ⟨ty, v⟩ := args[0]
    return ⟨.pure, ty, Com.ret v⟩

instance : MLIR.AST.TransformExpr (DCxComb) 0 where
  mkExpr := mkExpr

instance : AST.TransformReturn DCxComb 0 := { mkReturn }

instance : DialectToExpr DCxComb where
  toExprM := .const ``Id [0]
  toExprDialect := .const ``DCxComb []

open Qq MLIR AST Lean Elab Term Meta in
elab "[DCxComb_com| " reg:mlir_region "]" : term => do
  SSA.elabIntoCom' reg DCxComb

/- compose DC on top of Comb-/

end DCxCombFunctor
