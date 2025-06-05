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

def ValueStream := CIRCTStream.Stream

def TokenStream := CIRCTStream.Stream Unit
-- the more general version will use an hvector
def VariadicValueTokenStream (w : Nat) := CIRCTStream.Stream (List (BitVec w))


def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM DCxComb DCxComb.Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn "_" with
    | ["TokenStream"] =>
      return .tokenstream
    | ["TokenStream2"] =>
      return .tokenstream2
    | ["ValueStream", w] =>
      match w.toNat? with
      | some w' => return .valuestream w'
      | _ => throw .unsupportedType
    | ["ValueStream2", w] =>
      match w.toNat? with
      | some w' => return .valuestream2 w'
      | _ => throw .unsupportedType
    | ["ValueTokenStream", w] =>
    match w.toNat? with
      | some w' => return .valuetokenstream w'
      | _ => throw .unsupportedType
    | ["VariadicValueTokenStream", w] =>
    match w.toNat? with
      | some w' => return .variadicvaluetokenstream w'
      | _ => throw .unsupportedType
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

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
  -- 1-ary ops
  let unW : AST.ReaderM (DCxComb) (Nat) := do
    let args ← args.assumeArity 1
    return getVarWidth args[0]
  -- 2-ary ops
  let binW : AST.ReaderM (DCxComb) (Nat) := do
    let args ← args.assumeArity 2
    return getVarWidth args[0]
  -- 3-ary ops
  let terW : AST.ReaderM (DCxComb) (Nat) := do
    let args ← args.assumeArity 3
    return getVarWidth args[0]
  -- n-ary ops
  let args' ← opStx.args.mapM (MLIR.AST.TypedSSAVal.mkVal Γ) -- will need to find a better way to do this
  if h : args'.length = 0 then
    throw <| .generic s!" empty list of argument provided for the variadic op {repr opStx.args}"
  else
    let nnW : AST.ReaderM (Comb) (Nat) := do
      let args ← args.assumeArity args'.length
      return getVarWidth args[0]
    let mkExprOf := opStx.mkExprOf (args? := args) Γ
    if opStx.args.length > 0 then
      throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    else
    match (opStx.name).splitOn "_" with
    | ["DCxComb.source"] =>
      -- mkExprOf <| Op.dc (MLIR2DC.Op.source) does not work, we'll do old school for now
      return ⟨_, .tokenstream, Expr.mk (op := Op.dc (MLIR2DC.Op.source)) (eff := .pure)
              (ty_eq := rfl) (eff_le := by constructor)  (args := .nil) (regArgs := .nil)⟩
    | [op@"DCxComb.sink"] | [op@"DCxComb.unpack"] | [op@"DCxComb.fork"] | [op@"DCxComb.branch"] | [op@"DCxComb.fst"] | [op@"DCxComb.snd"] | [op@"DCxComb.fstVal"] | [op@"DCxComb.sndVal"] | [op@"DCxComb.fstVal'"] | [op@"DCxComb.sndVal'"] =>
      match opStx.args with
      | v₁Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        match ty₁, op with
        | .tokenstream2, "DCxComb.fst" => return ⟨_, .tokenstream, Expr.mk (op := Op.dc (MLIR2DC.Op.fst)) (eff := .pure)
              (ty_eq := rfl) (eff_le := by constructor)  (args := .cons v₁ <| .nil) (regArgs := .nil)⟩
        | .tokenstream2, "DCxComb.snd"  => return ⟨_, .tokenstream, Expr.mk (op := Op.dc (MLIR2DC.Op.snd)) (eff := .pure)
              (ty_eq := rfl) (eff_le := by constructor)  (args := .cons v₁ <| .nil) (regArgs := .nil)⟩
        | .valuetokenstream r, "DCxComb.fstVal" => return ⟨_, .valuestream r, Expr.mk (op := Op.dc (MLIR2DC.Op.fstVal r)) (eff := .pure)
              (ty_eq := rfl) (eff_le := by constructor)  (args := .cons v₁ <| .nil) (regArgs := .nil)⟩
        | .valuetokenstream r, "DCxComb.sndVal"  => return ⟨_, .tokenstream, Expr.mk (op := Op.dc (MLIR2DC.Op.sndVal r)) (eff := .pure)
              (ty_eq := rfl) (eff_le := by constructor)  (args := .cons v₁ <| .nil) (regArgs := .nil)⟩
        | .tokenstream, "DCxComb.sink" => return ⟨_, .tokenstream, Expr.mk (op := Op.dc (MLIR2DC.Op.sink)) (eff := .pure)
              (ty_eq := rfl) (eff_le := by constructor)  (args := .cons v₁ <| .nil) (regArgs := .nil)⟩
        | .valuestream r, "DCxComb.unpack"  => sorry
        | .tokenstream, "DCxComb.fork"  => return ⟨_, .tokenstream2, Expr.mk (op := Op.dc (MLIR2DC.Op.fork)) (eff := .pure)
              (ty_eq := rfl) (eff_le := by constructor)  (args := .cons v₁ <| .nil) (regArgs := .nil)⟩
        | .valuestream 1, "DCxComb.branch"  => return ⟨_, .tokenstream2, Expr.mk (op := Op.dc (MLIR2DC.Op.branch)) (eff := .pure)
              (ty_eq := rfl) (eff_le := by constructor)  (args := .cons v₁ <| .nil) (regArgs := .nil)⟩

        | .variadicvaluetokenstream r, "DCxComb.fstval'"  => return ⟨_, .valuestream r, Expr.mk (op := Op.dc (MLIR2DC.Op.fstVal' r)) (eff := .pure)
              (ty_eq := rfl) (eff_le := by constructor)  (args := .cons v₁ <| .nil) (regArgs := .nil)⟩

        | .variadicvaluetokenstream r, "DCxComb.sndval'"  => return ⟨_, .valuestream r, Expr.mk (op := Op.dc (MLIR2DC.Op.sndVal' r)) (eff := .pure)
              (ty_eq := rfl) (eff_le := by constructor)  (args := .cons v₁ <| .nil) (regArgs := .nil)⟩

        | .variadicvaluetokenstream r, "DCxComb.tokval'"  => return ⟨_, .tokenstream, Expr.mk (op := Op.dc (MLIR2DC.Op.tokVal' r)) (eff := .pure)
              (ty_eq := rfl) (eff_le := by constructor)  (args := .cons v₁ <| .nil) (regArgs := .nil)⟩

        | .variadicvaluetokenstream r₁, "DCxComb.pack2"  =>
            return ⟨_, .valuestream2 r₁, Expr.mk (op := Op.dc (MLIR2DC.Op.pack2 r₁)) (eff := .pure)
            (ty_eq := rfl) (eff_le := by constructor) (args := .cons v₁ <| .nil) (regArgs := .nil)⟩

        | _, _ => throw <| .generic s!"type mismatch"
      | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    | [op@"DCxComb.merge"] | [op@"DCxComb.join"] | [op@"DCxComb.pack"] | [op@"DCxComb.unpack2"] | [op@"DCxComb.pack2"] =>
      match opStx.args with
      | v₁Stx::v₂Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
        match ty₁, ty₂, op with
        | .tokenstream, .tokenstream, "DCxComb.merge" => return ⟨_, .valuestream 1, Expr.mk (op := Op.dc (MLIR2DC.Op.merge)) (eff := .pure)
          (ty_eq := rfl) (eff_le := by constructor) (args := .cons v₁ <| .cons v₂ <| .nil) (regArgs := .nil)⟩
        | .tokenstream, .tokenstream, "DCxComb.join"  => return ⟨_, .tokenstream, Expr.mk (op := Op.dc (MLIR2DC.Op.join)) (eff := .pure)
          (ty_eq := rfl) (eff_le := by constructor) (args := .cons v₁ <| .cons v₂ <| .nil) (regArgs := .nil)⟩
        | .valuestream r, .tokenstream, "DCxComb.pack"  => sorry
        | .valuestream r, .valuestream r', "DCxComb.add" =>
            if h : r = r' then
              return ⟨_, .valuestream r, (Expr.mk (op := Op.comb (MLIR2Comb.Op.add r 2)) (eff := .pure)
                  (ty_eq := rfl)  (eff_le := by sorry) (args := .cons v₁ <| .cons (h▸ v₂)<| .nil) (regArgs := .nil))⟩
            else sorry
        | .valuestream r₁, .valuestream r₂, "DCxComb.unpack2"  =>
            if h : r₁ = r₂ then
              return ⟨_, .variadicvaluetokenstream r₁, Expr.mk (op := Op.dc (MLIR2DC.Op.unpack2 r₁)) (eff := .pure)
                (ty_eq := rfl) (eff_le := by constructor) (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil)⟩
            else
              throw <| .generic s!"type mismatch"
        | _, _, _ => throw <| .generic s!"type mismatch"
      | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    | [op@"DCxComb.select"] =>
      match opStx.args with
      | v₁Stx::v₂Stx::v₃Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
        let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
        match ty₁, ty₂, ty₃, op with
        | .tokenstream, .tokenstream, .valuestream 1, "DCxComb.select" => return ⟨_, .tokenstream, Expr.mk (op := Op.dc (MLIR2DC.Op.select)) (eff := .pure)
          (ty_eq := rfl) (eff_le := by constructor) (args := .cons v₁ <| .cons v₂ <| .cons v₃ <| .nil) (regArgs := .nil)⟩
        | _, _, _, _=> throw <| .generic s!"type mismatch"
      | _ => throw <| .generic s!"expected three operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    | [op@"DCxComb.parity"] => -- [op@"DCxComb.concat"] =>
      match opStx.args with
      | v₁Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        match ty₁, op with
        | .valuestream w, "DCxComb.parity" => return ⟨_, .valuestream 1, (Expr.mk (op := Op.comb (MLIR2Comb.Op.parity w)) (eff := .pure)
          (ty_eq := rfl)  (eff_le := by sorry) (args := .cons v₁ <| .nil) (regArgs := .nil))⟩
        -- | .hList l, "Comb.concat" => return ⟨_, .bitvec l.sum, Expr.mk (op := Op.comb (MLIR2Comb.Op.c w))
          -- (ty_eq := sorry)  (eff_le := by constructor) (args := sorry) (regArgs := .nil)⟩
        | _, _ => throw <| .generic s!"type mismatch"
      | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    | [op@"DCxComb.add"] | [op@"DCxComb.and"] | [op@"DCxComb.mul"] | [op@"DCxComb.or"] | [op@"DCxComb.xor"] =>
        let args ← opStx.args.mapM (MLIR.AST.TypedSSAVal.mkVal Γ)
        if hl: args.length ≤ 0 then
          throw <| .generic s!"empty list of arguments for '{repr opStx.args}'"
        else
          have hl' : (0 : Nat) < args.length := by
            simp [Nat.gt_of_not_le (n := args.length) (m := 0) hl]
          match args[0], op with
          | ⟨.valuestream w, _⟩, "DCxComb.add" => sorry
              -- if hall : args.all (·.1 = .valuestream w) then
              --   let argsv := ofList (liftTy (.bitvec w)) _ hall
              --   have heq : args.length - 1 + 1 = args.length := by omega
              --   sorry
              -- else
              --   sorry
            -- if hall : args.all (·.1 = .valuestream w) then
            --   (Expr.mk (op := Op.comb (MLIR2Comb.Op.parity w)) (eff := .pure)
            -- (ty_eq := rfl)  (eff_le := by sorry) (args := .cons v₁ <| .nil) (regArgs := .nil))⟩
            --     let argsᵥ := ofList (.bitvec w) _ hall
            --     have heq : args.length - 1 + 1 = args.length := by omega
            --     return ⟨_, .bitvec w, add args.length (heq ▸ argsᵥ)⟩
            --   else
            --     throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
          | ⟨.valuestream w, _⟩, "Comb.and" => sorry
              -- if hall : args.all (·.1 = .bitvec w) then sorry
                -- let argsᵥ := ofList (.bitvec w) _ hall
                -- have heq : args.length - 1 + 1 = args.length := by omega
                -- return ⟨_, .bitvec w, and args.length (heq ▸ argsᵥ)⟩
              -- else
                -- throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
          | ⟨.valuestream w, _⟩, "Comb.mul" => sorry
              -- if hall : args.all (·.1 = .bitvec w) then sorry
                -- let argsᵥ := ofList (.bitvec w) _ hall
                -- have heq : args.length - 1 + 1 = args.length := by omega
                -- return ⟨_, .bitvec w, mul args.length (heq ▸ argsᵥ)⟩
              -- else
              --   throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
          | ⟨.valuestream w, _⟩, "Comb.or" => sorry
              -- if hall : args.all (·.1 = .bitvec w) then sorry
                -- let argsᵥ := ofList (.bitvec w) _ hall
                -- have heq : args.length - 1 + 1 = args.length := by omega
                -- return ⟨_, .bitvec w, or args.length (heq ▸ argsᵥ)⟩
              -- else
              --   throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
          | ⟨.valuestream w, _⟩, "Comb.xor" => sorry
              -- if hall : args.all (·.1 = .bitvec w) then
              --   sorry
                -- let argsᵥ := ofList (.bitvec w) _ hall
                -- have heq : args.length - 1 + 1 = args.length := by omega
                -- return ⟨_, .bitvec w, xor args.length (heq ▸ argsᵥ)⟩
              -- else
              --   throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
          | _, _ => throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
    | [op@"Comb.divs"] | [op@"Comb.divu"] | [op@"Comb.mods"] | [op@"Comb.modu"] | [op@"Comb.replicate"] | [op@"Comb.shl"] | [op@"Comb.shrs"] | [op@"Comb.shru"] | [op@"Comb.sub"]  => sorry
      -- match opStx.args with
      -- | v₁Stx::v₂Stx::[] =>
      --   let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      --   let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      --   match ty₁, ty₂, op with
      --   /- more checks need to be added here to ensure the consistency of operations and bitvec sizes -/
      --   -- | .bitvec w₁, .bitvec w₂, "Comb.concat" =>
      --   --   return ⟨_, .bitvec (w₁ + w₂), concat v₁ v₂⟩
      --   | .valuestream w, .valuestream w, "Comb.divs" => sorry
      --   | .valuestream w, .valuestream w, "Comb.divu" => sorry
      --   | .valuestream w, .valuestream w, "Comb.mods" => sorry
      --   | .valuestream w, .valuestream w, "Comb.modu" => sorry
      --   | .valuestream w, .valuestream w, "Comb.shl" => sorry
      --   | .valuestream w, .valuestream w, "Comb.shrs" => sorry
      --   | .valuestream w, .valuestream w, "Comb.shru" => sorry
      --   | .valuestream w, .valuestream w, "Comb.sub" => sorry
      --   | _, _, _=> throw <| .generic s!"type mismatch"
      -- | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    | [op@"Comb.icmp"] | [op@"Comb.mux"] => sorry
      -- match opStx.args with
      -- | v₁Stx::v₂Stx::v₃Stx::[] =>
      --   let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      --   let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      --   let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      --   sorry
      --   -- match ty₁, ty₂, ty₃, op with
      --   -- -- problem: icmp
      --   -- --  | .bitvec w₁, .bitvec w₂, Op.dc (MLIR2DC.Op.select), "Comb.icmp" => sorry
      --   -- --     throw <| .generic s!"type mismatch"
      --   -- | .bitvec w₁, .bitvec w₂, .bitvec 1, "Comb.mux" => sorry
      --   --     throw <| .generic s!"type mismatch"
      --   -- | _, _, _, _=> throw <| .generic s!"type mismatch"
      -- | _ => throw <| .generic s!"expected three operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    | _ =>
    -- handle replicate
      -- if "Comb.replicate" = opStx.name
      -- then {
      --   match (opStx.name).splitOn "_" with
      --   | [_, n] =>
      --     match opStx.args with
      --     | v₁Stx::[] =>
      --       let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      --       match ty₁ with
      --       | .bitvec w₁ =>
      --         let n' := n.toNat!
      --         return ⟨_, .bitvec (w₁ * n'), replicate v₁ (n := n')⟩
      --       | _ => throw <| .generic s!"type mismatch"
      --     | _ => throw <| .generic s!"type mismatch"
      --   | _ => throw <| .generic s!"type mismatch"
      -- }
      -- else
        throw <| .unsupportedOp s!"unsupported operation {repr opStx}"


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
  SSA.elabIntoCom' reg Comb

/- compose DC on top of Comb-/

-- abbrev DCComb := DC MLIR2Comb.Comb

-- the only ops where dc and comb meet are pack and unpack, so we only need to re-define
-- the semantics for that

-- def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM DCComb DCComb.Ty
--   | MLIR.AST.MLIRType.int _ w => do
--     match w with
--     | .concrete w' => return .bitvec w'
--     | .mvar _ => throw <| .generic s!"Bitvec size can't be an mvar"
--   | MLIR.AST.MLIRType.undefined s => do
--     match s.splitOn "_" with
--     | ["TokenStream"] =>
--       return .tokenstream
--     | ["TokenStream2"] =>
--       return .tokenstream2
--     | ["ValueStream", w] =>
--       match w.toNat? with
--       | some w' => return .valuestream w'
--       | _ => throw .unsupportedType
--     | ["ValueStream2", w] =>
--       match w.toNat? with
--       | some w' => return .valuestream2 w'
--       | _ => throw .unsupportedType
--     | ["ValueTokenStream", w] =>
--     match w.toNat? with
--       | some w' => return .valuetokenstream w'
--       | _ => throw .unsupportedType
--     | _ => throw .unsupportedType
--   | _ => throw .unsupportedType

-- abbrev DCComb := DC MLIR2Comb.Comb

-- abbrev DCComb := DC MLIR2Comb.Comb

-- problem with lifting comb to streams: what do we do with the optons?
-- opt 1. bisimulation modulo options
-- opt 2. wait for everything to be ready (latency sensitive) → ensure they sync (cfr. pack/unpack). we like this better to claim it's an accurate semantics of dc!

-- un/pack: the unit sig it sends out tells us when the signal is ready
end DCxCombFunctor


/-

     -
     -
     0#3
     -
     -

   unpack

   -   0
   -   0
   1   0
   -   0
   -   0

pack syncs depending on the left stream

we will proceed as if this will work.

-/
