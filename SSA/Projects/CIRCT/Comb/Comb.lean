import SSA.Core.Framework
import SSA.Core.Framework.Macro
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Core.Tactic.SimpSet
import SSA.Projects.CIRCT.Comb.CombSemantics

namespace MLIR2Comb

section Dialect

inductive Ty
| bv (w : Nat) : Ty -- A bitvector of width `w`.
| typeSum (w₁ w₂ : Nat) : Ty
| bool : Ty
| nat : Ty
| hList (l : List Nat) : Ty -- List of bitvecs whose length are defined in l
| icmpPred : Ty
deriving DecidableEq, Repr, Lean.ToExpr

inductive Op
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
deriving DecidableEq, Repr, Lean.ToExpr

abbrev Comb : Dialect where
  Op := Op
  Ty := Ty

instance : ToString Ty where
  toString t := repr t |>.pretty
  
def_signature for Comb where
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

instance : TyDenote (Dialect.Ty Comb) where
  toType := fun
  | .bv w => BitVec w
  | .nat  => Nat
  | .bool => Bool
  | .typeSum w₁ w₂ => BitVec w₁ ⊕ BitVec w₂
  | .hList l => HVector BitVec l -- het list of bitvec whose lengths are contained in l
  | .icmpPred => CombOp.IcmpPredicate

def HVector.replicateToList {α : Type} {f : α → Type} {a : α} :
    {n : Nat} → HVector f (List.replicate n a) → List (f a)
  | 0, _ => []
  | n+1, HVector.cons x xs => x :: replicateToList xs

def ofString? (s : String) : Option CombOp.IcmpPredicate :=
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

def_denote for Comb where
  | .add _ _ => fun xs => CombOp.add (HVector.replicateToList (f := TyDenote.toType) xs)
  | .and _ _ => fun xs => CombOp.and (HVector.replicateToList (f := TyDenote.toType) xs)
  | .concat _ => fun xs => CombOp.concat xs
  | .divs _ => BitVec.sdiv
  | .divu _ => BitVec.udiv
  | .extract _ _ => fun x => CombOp.extract x _
  | .icmp p _ => fun x y => CombOp.icmp (Option.get! (ofString? p)) x y
  | .mods _ => BitVec.smod
  | .modu _ => BitVec.umod
  | .mul _ _ => fun xs => CombOp.mul (HVector.replicateToList (f := TyDenote.toType) xs)
  | .mux _ _ => fun x y => CombOp.mux x y
  | .or _ _ => fun xs => CombOp.or (HVector.replicateToList (f := TyDenote.toType) xs)
  | .parity _ => fun x => CombOp.parity x
  | .replicate _ n => fun xs => CombOp.replicate xs n
  | .shl _ => fun x y => CombOp.shl x y
  | .shrs _ => BitVec.sshiftRight'
  | .shru _ => fun x y => CombOp.shru x y
  | .sub _ => BitVec.sub
  | .xor _ _ => fun xs => CombOp.xor (HVector.replicateToList (f := TyDenote.toType) xs)

end Dialect


/-- we currently do not support the parsing of heterogeneous vectors -/
def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM Comb Ty
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
    | _ => throw .unsupportedType
  | MLIR.AST.MLIRType.int _ w =>
    match w with
    | .concrete w' => return .bv w'
    | .mvar _ => throw <| .generic s!"Bitvec size can't be an mvar"
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy Comb 0 where
  mkTy := mkTy

/-- Convert a list of dependent pairs into an HVector -/
def ofList {Γ : Ctxt _} ty : (l : List ((ty : Comb.Ty) × Γ.Var ty)) → (h : l.all (·.1 = ty)) → HVector (Γ.Var) (List.replicate l.length ty)
| [], h => .nil
| ⟨ty', var⟩::rest, h =>
  have hty : ty' = ty := by simp_all
  have hrest : rest.all (·.1 = ty) := by simp_all
  .cons (hty ▸ var) (ofList _ rest hrest)

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM Comb (Σ eff ty, Expr Comb Γ eff ty) := do
  match opStx.name with
  | op@"Comb.parity" | op@"Comb.concat" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .bv w, "Comb.parity" =>
        return ⟨_, .bool,
          (Expr.mk (op := .parity w) (ty_eq := rfl) (eff_le := by constructor)
            (args := .cons v₁ <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bool))⟩
      | .hList l, "Comb.concat" =>
        return ⟨_, .bv l.sum,
          (Expr.mk (op := .concat l) (ty_eq := rfl) (eff_le := by constructor)
            (args := .cons v₁ <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv (l.sum)))⟩
      | _, _ => throw <| .generic s!"type mismatch for {opStx.name}"
    | _ => throw <| .generic s!"expected one operand found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.add" | op@"Comb.and" | op@"Comb.mul" | op@"Comb.or" | op@"Comb.xor" =>
      let args ← opStx.args.mapM (MLIR.AST.TypedSSAVal.mkVal Γ)
      if hl: args.length ≤ 0 then
        throw <| .generic s!"empty list of arguments for '{repr opStx.args}'"
      else
        match args[0] with
        | ⟨.bv w, _⟩ =>
          if hall : args.all (·.1 = .bv w) then
            match op with
            | "Comb.add" =>
                return ⟨_, .bv w,
                  (Expr.mk (op := .add w args.length) (ty_eq := rfl) (eff_le := by constructor)
                    (args := ofList (.bv w) _ hall) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w))⟩
            | "Comb.and" =>
                return ⟨_, .bv w,
                (Expr.mk (op := .and w args.length) (ty_eq := rfl) (eff_le := by constructor)
                  (args := ofList (.bv w) _ hall) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w))⟩
            | "Comb.mul" =>
                return ⟨_, .bv w,
                (Expr.mk (op := .mul w args.length) (ty_eq := rfl) (eff_le := by constructor)
                  (args := ofList (.bv w) _ hall) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w))⟩
            | "Comb.or" =>
                return ⟨_, .bv w,
                (Expr.mk (op := .or w args.length) (ty_eq := rfl) (eff_le := by constructor)
                  (args := ofList (.bv w) _ hall) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w))⟩
            | "Comb.xor" =>
                return ⟨_, .bv w,
                (Expr.mk (op := .xor w args.length) (ty_eq := rfl) (eff_le := by constructor)
                  (args := ofList (.bv w) _ hall) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w))⟩
            | _ => throw <| .generic s!"Unknown operation"
          else
            throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
        | _ => throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
  | op@"Comb.divs" | op@"Comb.divu" | op@"Comb.mods" | op@"Comb.modu" | op@"Comb.shl" | op@"Comb.shrs" | op@"Comb.shru" | op@"Comb.sub"  =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂ with
      | .bv w₁, .bv w₂=>
        if h : w₁ = w₂ then
          match op with
          | "Comb.divs" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .divs w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w₁))⟩
          | "Comb.divu" =>
            return ⟨_, .bv w₁,
                (Expr.mk (op := .divu w₁) (ty_eq := rfl) (eff_le := by constructor)
                  (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w₁))⟩
          | "Comb.mods" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .mods w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w₁))⟩
          | "Comb.modu" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .modu w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w₁))⟩
          | "Comb.shl" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .shl w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w₁))⟩
          | "Comb.shrs" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .shrs w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w₁))⟩
          | "Comb.shru" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .shru w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w₁))⟩
          | "Comb.sub" =>
            return ⟨_, .bv w₁,
              (Expr.mk (op := .sub w₁) (ty_eq := rfl) (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv w₁))⟩
          | _ => throw <| .generic s!"Unknown operation"
        else
          throw <| .generic s!"bitvector sizes don't match for '{repr opStx.args}' in {opStx.name}"
      | _, _ => throw <| .generic s!"type mismatch in {opStx.name}"
    | _ => throw <| .generic s!"expected two operands, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.mux" =>
    match opStx.args with
    | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match ty₁, ty₂, ty₃, op with
      | .bv w₁, .bv w₂, .bool, "Comb.mux" =>
        /- mux currently only works if w₁ = w₂, since we need to fix the output type of the operation
          it should work even if w₁ ≠ w₂ but i need to think about how to implement that in an elegant way -/
        return ⟨_, .typeSum w₁ w₂,
          (Expr.mk (op := .mux w₁ w₂) (ty_eq := rfl) (eff_le := by constructor)
            (args := .cons v₁ <| .cons v₂ <| .cons v₃ <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.typeSum w₁ w₂))⟩
      | _, _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected three operands, found #'{opStx.args.length}' in '{repr opStx.args}'"
  |  _ =>
    match (opStx.name).splitOn "_" with
    | ["Comb.replicate", n]=>
      match opStx.args with
      | v₁Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        match ty₁, n.toNat? with
        | .bv w, some n' =>
          return ⟨_, .bv (w * n'),
            (Expr.mk (op := .replicate w n') (ty_eq := rfl) (eff_le := by constructor)
              (args := .cons v₁ <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv (w * n')))⟩
        | _, none => throw <| .generic s!"invalid parameter in {repr opStx}"
        | _, _ => throw <| .generic s!"type mismatch in {repr opStx}"
      | _ => throw <| .generic s!"type mismatch in {repr opStx}"
    | ["Comb.extract", n] =>
      match opStx.args with
      | v₁Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        match ty₁, n.toNat? with
        | .bv w, some n' =>
          return ⟨_, .bv (w - n'),
            (Expr.mk (op := .extract w n') (ty_eq := rfl) (eff_le := by constructor)
              (args := .cons v₁ <| .nil) (regArgs := .nil) : Expr (Comb) Γ .pure (.bv (w - n')))⟩
        | _, none => throw <| .generic s!"invalid parameter in {repr opStx}"
        | _, _ => throw <| .generic s!"type mismatch in {repr opStx}"
      | _ => throw <| .generic s!"type mismatch in {repr opStx}"
    | ["Comb.icmp", p] =>
      match opStx.args with
      | v₁Stx::v₂Stx::[] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
        match ty₁, ty₂, (ofString? p) with
        | .bv w₁, .bv w₂, some p' =>
          if h : w₁ = w₂ then
            return ⟨_, .bool,
              (Expr.mk (op := .icmp p w₁)  (ty_eq := rfl)  (eff_le := by constructor)
                (args := .cons v₁ <| .cons (h ▸ v₂) <| .nil) (regArgs := .nil): Expr (Comb) Γ .pure (.bool))⟩
          else throw <| .generic s!"bitvector sizes don't match for '{repr opStx.args}' in {opStx.name}"
        | _, _, none => throw <| .generic s!"unknown predicate in {repr opStx}"
        | _, _, _ => throw <| .generic s!"type mismatch in {repr opStx}"
      | _ => throw <| .generic s!"expected two operands, found #'{opStx.args.length}' in '{repr opStx.args}'"
    | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"


instance : MLIR.AST.TransformExpr (Comb) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (Comb)
    (Σ eff ty, Com Comb Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (Comb) 0 where
  mkReturn := mkReturn

instance : DialectToExpr Comb where
  toExprM := .const ``Id [0]
  toExprDialect := .const ``Comb []

open Qq MLIR AST Lean Elab Term Meta in
elab "[Comb_com| " reg:mlir_region "]" : term => do SSA.elabIntoCom' reg Comb

end MLIR2Comb
