import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Framework
import SSA.Core.Framework.Macro
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Core.Tactic.SimpSet
import SSA.Projects.CIRCT.DCxComb.Semantics

namespace MLIRDCxComb

section Dialect


inductive Ty
| bv (w : Nat) : Ty
| tokenstream : Ty
| tokenstream2 : Ty
| valuestream (w : Nat) : Ty -- A stream of BitVec w
| valuestream2 (w : Nat) : Ty -- A stream of BitVec w
| valuetokenstream (w : Nat) : Ty -- A product of streams of BitVec w
| typeSum (w₁ w₂ : Nat) : Ty
| bool : Ty
| nat : Ty
| hList (l : List Nat) : Ty -- List of bitvecs whose length are defined in l
| icmpPred : Ty
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

inductive Op
| fst
| snd
| fstVal (w : Nat)
| sndVal (w : Nat)
| merge
| branch
| fork
| join
| select
| sink
| source
| pack (w : Nat)
| unpack (w : Nat)
| popReady (w : Nat) (n : Nat)
| add (w : Nat) (arity : Nat)
| and (w : Nat) (arity : Nat)
| concat (w : List Nat) -- len(w) = #args, wi is the width of the i-th arg
| divs (w : Nat)
| divu (w : Nat)
| extract (w : Nat) (n : Nat)
| icmp (p : String) (w : Nat)
| mods (w : Nat)
| modu (w : Nat)
| mul (w : Nat) (arity : Nat)
| mux (w₁ : Nat) (w₂ : Nat)
| or (w : Nat) (arity : Nat)
| parity (w : Nat)
| replicate (w : Nat) (n : Nat)
| shl (w : Nat)
| shrs (w : Nat)
| shru (w : Nat)
| sub (w : Nat)
| xor (w : Nat) (arity : Nat)
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

abbrev DCxComb : Dialect where
  Op := Op
  Ty := Ty

def_signature for DCxComb where
  | .fst => (Ty.tokenstream2) → (Ty.tokenstream)
  | .fstVal t => (Ty.valuetokenstream t) → Ty.valuestream t
  | .snd => (Ty.tokenstream2) → (Ty.tokenstream)
  | .sndVal t => (Ty.valuetokenstream t) → Ty.tokenstream
  | .merge => (Ty.tokenstream, Ty.tokenstream) → Ty.valuestream 1
  | .branch => (Ty.valuestream 1) → Ty.tokenstream2
  | .fork => (Ty.tokenstream) → Ty.tokenstream2
  | .join => (Ty.tokenstream, Ty.tokenstream) → Ty.tokenstream
  | .select => (Ty.tokenstream, Ty.tokenstream, Ty.valuestream 1) → Ty.tokenstream
  | .sink => (Ty.tokenstream) → Ty.tokenstream
  | .source => () → Ty.tokenstream
  | .pack t => (Ty.valuestream t, Ty.tokenstream) → Ty.valuestream t
  | .unpack t => (Ty.valuestream t) → Ty.valuetokenstream t
  | .popReady w _ => (Ty.valuestream w) → Ty.bv w
  | .add w n => ${List.replicate n (Ty.bv w)} → (Ty.bv w)
  | .and w n => ${List.replicate n (Ty.bv w)} → (Ty.bv w)
  | .concat l => (Ty.hList l) → (Ty.bv l.sum)
  | .divs w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .divu w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .extract w n => (Ty.bv w) → (Ty.bv (w - n))
  | .icmp _ w => (Ty.bv w, Ty.bv w) → (Ty.bool)
  | .mods w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .modu w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .mul w n => ${List.replicate n (Ty.bv w)} → (Ty.bv w)
  | .mux w₁ w₂ => (Ty.bv w₁, Ty.bv w₂, Ty.bool) → (Ty.typeSum w₁ w₂)
  | .or w n => ${List.replicate n (Ty.bv w)} → (Ty.bv w)
  | .parity w => (Ty.bv w) → (Ty.bool)
  | .replicate w n => (Ty.bv w) → (Ty.bv (w * n))
  | .shl w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .shrs w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .shru w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .sub w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .xor w n => ${List.replicate n (Ty.bv w)} → (Ty.bv w)

instance instDCxCombTyDenote : TyDenote Ty where
toType := fun
| Ty.bv w => BitVec w
| Ty.tokenstream => CIRCTStream.DCxCombOp.TokenStream
| Ty.tokenstream2 => CIRCTStream.DCxCombOp.TokenStream × CIRCTStream.DCxCombOp.TokenStream
| Ty.valuestream w => CIRCTStream.DCxCombOp.ValueStream (BitVec w)
| Ty.valuestream2 w => CIRCTStream.DCxCombOp.ValueStream (BitVec w) × CIRCTStream.DCxCombOp.ValueStream (BitVec w)
| Ty.valuetokenstream w => CIRCTStream.DCxCombOp.ValueStream (BitVec w) × CIRCTStream.DCxCombOp.TokenStream
| .nat  => Nat
| .bool => Bool
| .typeSum w₁ w₂ => BitVec w₁ ⊕ BitVec w₂
| .hList l => HVector BitVec l -- het list of bitvec whose lengths are contained in l
| .icmpPred => CIRCTStream.DCxCombOp.IcmpPredicate

def HVector.replicateToList {α : Type} {f : α → Type} {a : α} :
    {n : Nat} → HVector f (List.replicate n a) → List (f a)
  | 0, _ => []
  | n+1, HVector.cons x xs => x :: replicateToList xs

def ofString? (s : String) : Option CIRCTStream.DCxCombOp.IcmpPredicate :=
  match s with
  | "eq" => some .eq
  | "ne" => some .ne
  | "slt" => some .slt
  | "sle" => some .sle
  | "sgt" => some .sgt
  | "sge" => some .sge
  | "ult" => some .ult
  | "ule" => some .ule
  | "ugt" => some .ugt
  | "uge" => some .uge
  | _     => none

def_denote for DCxComb where
  | .fst => fun s => s.fst
  | .fstVal _ => fun s => s.fst
  | .snd => fun s => s.snd
  | .sndVal _ => fun s => s.snd
  | .merge => fun s₁ s₂ => CIRCTStream.DCxCombOp.merge s₁ s₂
  | .branch => fun s => CIRCTStream.DCxCombOp.branch s
  | .fork => fun s => CIRCTStream.DCxCombOp.fork s
  | .join => fun s₁ s₂ => CIRCTStream.DCxCombOp.join s₁ s₂
  | .select => fun s₁ s₂ c => CIRCTStream.DCxCombOp.select s₁ s₂ c
  | .sink => fun s => CIRCTStream.DCxCombOp.sink s
  | .source => fun s => CIRCTStream.DCxCombOp.source s
  | .pack _ => fun s₁ s₂ => CIRCTStream.DCxCombOp.pack s₁ s₂
  | .unpack _ => fun s => CIRCTStream.DCxCombOp.unpack s
  | .popReady _ n => fun s => CIRCTStream.DCxCombOp.popReady s n
    | .add _ _ => fun xs => CIRCTStream.DCxCombOp.add (HVector.replicateToList (f := TyDenote.toType) xs)
  | .and _ _ => fun xs => CIRCTStream.DCxCombOp.and (HVector.replicateToList (f := TyDenote.toType) xs)
  | .concat _ => fun xs => CIRCTStream.DCxCombOp.concat xs
  | .divs _ => BitVec.sdiv
  | .divu _ => BitVec.udiv
  | .extract _ _ => fun x => CIRCTStream.DCxCombOp.extract x _
  | .icmp p _ => fun x y => CIRCTStream.DCxCombOp.icmp (Option.get! (ofString? p)) x y
  | .mods _ => BitVec.smod
  | .modu _ => BitVec.umod
  | .mul _ _ => fun xs => CIRCTStream.DCxCombOp.mul (HVector.replicateToList (f := TyDenote.toType) xs)
  | .mux _ _ => fun x y => CIRCTStream.DCxCombOp.mux x y
  | .or _ _ => fun xs => CIRCTStream.DCxCombOp.or (HVector.replicateToList (f := TyDenote.toType) xs)
  | .parity _ => fun x => CIRCTStream.DCxCombOp.parity x
  | .replicate _ n => fun xs => CIRCTStream.DCxCombOp.replicate xs n
  | .shl _ => fun x y => CIRCTStream.DCxCombOp.shl x y
  | .shrs _ => BitVec.sshiftRight'
  | .shru _ => fun x y => CIRCTStream.DCxCombOp.shru x y
  | .sub _ => BitVec.sub
  | .xor _ _ => fun xs => CIRCTStream.DCxCombOp.xor (HVector.replicateToList (f := TyDenote.toType) xs)


end Dialect


def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM DCxComb DCxComb.Ty
  | MLIR.AST.MLIRType.int _ w => do
    match w with
    | .concrete w' => return .bv w'
    | .mvar _ => throw <| .generic s!"Bitvec size can't be an mvar"
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn "_" with
    | ["Bool"] =>
      return .bool
    | ["Nat"] =>
      return .nat
    | ["IcmpPred"] =>
      return .icmpPred
    | ["TypeSum", w₁, w₂] =>
      match w₁.toNat?, w₂.toNat? with
      | some w₁', some w₂' => return .typeSum w₁' w₂'
      | _, _ => throw .unsupportedType
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
    | _ => throw .unsupportedType
  | _ => throw <| .generic s!"unkwown type"

instance instTransformTy : MLIR.AST.TransformTy DCxComb 0 where
  mkTy := mkTy

def popReady {Γ : Ctxt _} (a : Γ.Var (.valuestream w)) (n : Nat) : Expr (DCxComb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .popReady w n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def source : Expr (DCxComb) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .source)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .nil)
    (regArgs := .nil)

def sink {Γ : Ctxt _} (a : Γ.Var (.tokenstream)) : Expr (DCxComb) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .sink)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def unpack {r} {Γ : Ctxt _} (a : Γ.Var (.valuestream r)) : Expr (DCxComb) Γ .pure (.valuetokenstream r) :=
  Expr.mk
    (op := .unpack r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def pack {r} {Γ : Ctxt _} (a : Γ.Var (.valuestream r)) (b : Γ.Var (.tokenstream)) : Expr (DCxComb) Γ .pure (.valuestream r) :=
  Expr.mk
    (op := .pack r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def branch {Γ : Ctxt _} (a : Γ.Var (.valuestream 1)) : Expr (DCxComb) Γ .pure (.tokenstream2) :=
  Expr.mk
    (op := .branch)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def fork (a : Γ.Var (.tokenstream)) : Expr (DCxComb) Γ .pure (.tokenstream2) :=
  Expr.mk
    (op := .fork)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def join {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) : Expr (DCxComb) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .join)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def merge {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) : Expr (DCxComb) Γ .pure (.valuestream 1) :=
  Expr.mk
    (op := .merge)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def select {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) (c : Γ.Var (.valuestream 1)) : Expr (DCxComb) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .select)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .cons c <| .nil)
    (regArgs := .nil)

def fst {Γ : Ctxt _} (a : Γ.Var (.tokenstream2)) : Expr (DCxComb) Γ .pure (.tokenstream)  :=
  Expr.mk
    (op := .fst)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def fstVal {r} {Γ : Ctxt _} (a : Γ.Var (.valuetokenstream r))  : Expr (DCxComb) Γ .pure (.valuestream r)  :=
  Expr.mk
    (op := .fstVal r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def sndVal {r} {Γ : Ctxt _} (a : Γ.Var (.valuetokenstream r))  : Expr (DCxComb) Γ .pure (.tokenstream)  :=
  Expr.mk
    (op := .sndVal r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def snd {Γ : Ctxt _} (a : Γ.Var (.tokenstream2)) : Expr (DCxComb) Γ .pure (.tokenstream)  :=
  Expr.mk
    (op := .snd)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def ofList {Γ : Ctxt _} ty : (l : List ((ty : DCxComb.Ty) × Γ.Var ty)) → (h : l.all (·.1 = ty)) → HVector (Γ.Var) (List.replicate l.length ty)
| [], h => .nil
| ⟨ty', var⟩::rest, h =>
  have hty : ty' = ty := by simp_all
  have hrest : rest.all (·.1 = ty) := by simp_all
  .cons (hty ▸ var) (ofList _ rest hrest)

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (DCxComb) (Σ eff ty, Expr (DCxComb) Γ eff ty) := do
  match opStx.name with
  | op@"DCxComb.parity" | op@"DCxComb.concat" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .bv w, "DCxComb.parity" =>
        return ⟨_, .bool,
          (Expr.mk (op := .parity w) (ty_eq := rfl) (eff_le := by constructor)
            (args := .cons v₁ <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bool))⟩
      | .hList l, "DCxComb.concat" =>
        return ⟨_, .bv l.sum,
          (Expr.mk (op := .concat l) (ty_eq := rfl) (eff_le := by constructor)
            (args := .cons v₁ <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv (l.sum)))⟩
      | _, _ => throw <| .generic s!"type mismatch for {opStx.name}"
    | _ => throw <| .generic s!"expected one operand found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DCxComb.add" | op@"DCxComb.and" | op@"DCxComb.mul" | op@"DCxComb.or" | op@"DCxComb.xor" =>
      let args ← opStx.args.mapM (MLIR.AST.TypedSSAVal.mkVal Γ)
      if hl: args.length ≤ 0 then
        throw <| .generic s!"empty list of arguments for '{repr opStx.args}'"
      else
        match args[0] with
        | ⟨.bv w, _⟩ =>
          if hall : args.all (·.1 = .bv w) then
            match op with
            | "DCxComb.add" =>
                return ⟨_, .bv w,
                  (Expr.mk (op := .add w args.length) (ty_eq := rfl) (eff_le := by constructor)
                    (args := ofList (.bv w) _ hall) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w))⟩
            | "DCxComb.and" =>
                return ⟨_, .bv w,
                (Expr.mk (op := .and w args.length) (ty_eq := rfl) (eff_le := by constructor)
                  (args := ofList (.bv w) _ hall) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w))⟩
            | "DCxComb.mul" =>
                return ⟨_, .bv w,
                (Expr.mk (op := .mul w args.length) (ty_eq := rfl) (eff_le := by constructor)
                  (args := ofList (.bv w) _ hall) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w))⟩
            | "DCxComb.or" =>
                return ⟨_, .bv w,
                (Expr.mk (op := .or w args.length) (ty_eq := rfl) (eff_le := by constructor)
                  (args := ofList (.bv w) _ hall) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w))⟩
            | "DCxComb.xor" =>
                return ⟨_, .bv w,
                (Expr.mk (op := .xor w args.length) (ty_eq := rfl) (eff_le := by constructor)
                  (args := ofList (.bv w) _ hall) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w))⟩
            | _ => throw <| .generic s!"Unknown operation"
          else
            throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
        | _ => throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
  | op@"DCxComb.divs" | op@"DCxComb.divu" | op@"DCxComb.mods" | op@"DCxComb.modu" | op@"DCxComb.shl" | op@"DCxComb.shrs" | op@"DCxComb.shru" | op@"DCxComb.sub"  =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂ with
      | .bv w₁, .bv w₂=>
        if h : w₁ = w₂ then
          match op with
          | "DCxComb.divs" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .divs w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w₁))⟩
          | "DCxComb.divu" =>
            return ⟨_, .bv w₁,
                (Expr.mk (op := .divu w₁) (ty_eq := rfl) (eff_le := by constructor)
                  (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w₁))⟩
          | "DCxComb.mods" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .mods w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w₁))⟩
          | "DCxComb.modu" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .modu w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w₁))⟩
          | "DCxComb.shl" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .shl w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w₁))⟩
          | "DCxComb.shrs" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .shrs w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w₁))⟩
          | "DCxComb.shru" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .shru w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w₁))⟩
          | "DCxComb.sub" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .sub w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv w₁))⟩
          | _ => throw <| .generic s!"Unknown operation"
        else
          throw <| .generic s!"bitvector sizes don't match for '{repr opStx.args}' in {opStx.name}"
      | _, _ => throw <| .generic s!"type mismatch in {opStx.name}"
    | _ => throw <| .generic s!"expected two operands, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DCxComb.mux" =>
    match opStx.args with
    | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match ty₁, ty₂, ty₃, op with
      | .bv w₁, .bv w₂, .bool, "DCxComb.mux" =>
        /- mux currently only works if w₁ = w₂, since we need to fix the output type of the operation
          it should work even if w₁ ≠ w₂ but i need to think about how to implement that in an elegant way -/
        return ⟨_, .typeSum w₁ w₂,
          (Expr.mk (op := .mux w₁ w₂) (ty_eq := rfl) (eff_le := by constructor)
            (args := .cons v₁ <| .cons v₂ <| .cons v₃ <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.typeSum w₁ w₂))⟩
      | _, _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected three operands, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DCxComb.source" =>
    if opStx.args.length > 0 then
      throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    else
      return ⟨_, .tokenstream, source⟩
  | op@"DCxComb.sink" | op@"DCxComb.unpack" | op@"DCxComb.fork" | op@"DCxComb.branch" | op@"DCxComb.fst" | op@"DCxComb.snd" | op@"DCxComb.fstVal" | op@"DCxComb.sndVal" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .tokenstream2, "DCxComb.fst" => return ⟨_, .tokenstream, fst v₁⟩
      | .tokenstream2, "DCxComb.snd"  => return ⟨_, .tokenstream, snd v₁⟩
      | .valuetokenstream r, "DCxComb.fstVal" => return ⟨_, .valuestream r, fstVal v₁⟩
      | .valuetokenstream _, "DCxComb.sndVal"  => return ⟨_, .tokenstream, sndVal v₁⟩
      | .tokenstream, "DCxComb.sink" => return ⟨_, .tokenstream, sink v₁⟩
      | .valuestream r, "DCxComb.unpack"  => return ⟨_, .valuetokenstream r, unpack v₁⟩
      | .tokenstream, "DCxComb.fork"  => return ⟨_, .tokenstream2, fork v₁⟩
      | .valuestream 1, "DCxComb.branch"  => return ⟨_, .tokenstream2, branch v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DCxComb.merge" | op@"DCxComb.join" | op@"DCxComb.pack"  =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .tokenstream, .tokenstream, "DCxComb.merge" => return ⟨_, .valuestream 1, merge v₁ v₂⟩
      | .tokenstream, .tokenstream, "DCxComb.join"  => return ⟨_, .tokenstream, join v₁ v₂⟩
      | .valuestream r, .tokenstream, "DCxComb.pack"  => return ⟨_, .valuestream r, pack v₁ v₂⟩
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DCxComb.select" =>
    match opStx.args with
    | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match ty₁, ty₂, ty₃, op with
      | .tokenstream, .tokenstream, .valuestream 1, "DCxComb.select" => return ⟨_, .tokenstream, select v₁ v₂ v₃⟩
      | _, _, _, _=> throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected three operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | _ =>
    match (opStx.name).splitOn "_" with
    | ["DCxComb.popReady", n] =>
      match n.toNat? with
      | some n' =>
        match opStx.args with
        | v₁Stx::[] =>
          let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
          match ty₁ with
          | .valuestream w => return ⟨_, .bv w, popReady v₁ n'⟩
          | _ =>  throw <| .unsupportedOp s!"unsupported type for  {repr opStx}"
        | _ =>  throw <| .unsupportedOp s!"unsupported type for  {repr opStx}"
      | _ => throw <| .unsupportedOp s!"unsupported stream size for {repr opStx}"
    | ["DCxComb.replicate", n] =>
      match opStx.args with
      | v₁Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        match ty₁, n.toNat? with
        | .bv w, some n' =>
          return ⟨_, .bv (w * n'),
            (Expr.mk (op := .replicate w n') (ty_eq := rfl) (eff_le := by constructor)
              (args := .cons v₁ <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv (w * n')))⟩
        | _, none => throw <| .generic s!"invalid parameter in {repr opStx}"
        | _, _ => throw <| .generic s!"type mismatch in {repr opStx}"
      | _ => throw <| .generic s!"type mismatch in {repr opStx}"
    | ["DCxComb.extract", n] =>
      match opStx.args with
      | v₁Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        match ty₁, n.toNat? with
        | .bv w, some n' =>
          return ⟨_, .bv (w - n'),
            (Expr.mk (op := .extract w n') (ty_eq := rfl) (eff_le := by constructor)
              (args := .cons v₁ <| .nil) (regArgs := .nil) : Expr (DCxComb) Γ .pure (.bv (w - n')))⟩
        | _, none => throw <| .generic s!"invalid parameter in {repr opStx}"
        | _, _ => throw <| .generic s!"type mismatch in {repr opStx}"
      | _ => throw <| .generic s!"type mismatch in {repr opStx}"
    | ["DCxComb.icmp", p] =>
      match opStx.args with
      | v₁Stx::v₂Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
        match ty₁, ty₂, (ofString? p) with
        | .bv w₁, .bv w₂, some p' =>
          if h : w₁ = w₂ then
            return ⟨_, .bool,
              (Expr.mk (op := .icmp p w₁)  (ty_eq := rfl)  (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil): Expr (DCxComb) Γ .pure (.bool))⟩
          else throw <| .generic s!"bitvector sizes don't match for '{repr opStx.args}' in {opStx.name}"
        | _, _, none => throw <| .generic s!"unknown predicate in {repr opStx}"
        | _, _, _ => throw <| .generic s!"type mismatch in {repr opStx}"
      | _ => throw <| .generic s!"expected two operands, found #'{opStx.args.length}' in '{repr opStx.args}'"
    | _ => throw <| .generic s!"unknown operation '{repr opStx.args}'"

instance : MLIR.AST.TransformExpr (DCxComb) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (DCxComb)
    (Σ eff ty, Com DCxComb Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (DCxComb) 0 where
  mkReturn := mkReturn

instance : DialectToExpr DCxComb where
  toExprM := .const ``Id [0]
  toExprDialect := .const ``DCxComb []

open Qq MLIR AST Lean Elab Term Meta in
elab "[DCxComb_com| " reg:mlir_region "]" : term => do SSA.elabIntoCom' reg DCxComb

end MLIRDCxComb
