import SSA.Core.Framework
import SSA.Core.Framework.Macro
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL2

namespace CombOp

inductive IcmpPredicate where
  | eq
  | ne
  | slt
  | sle
  | sgt
  | sge
  | ult
  | ule
  | ugt
  | uge
deriving Inhabited, DecidableEq, Repr

/-- Variadic `add` operation with a list of bitvectors with width `w` as input -/
def add {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.add (0#w) l

/-- Variadic `and` operation with a list of bitvectors with width `w` as input -/
def and {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.and (0#w) l

/-- Concatenate a list of bitvecs `xs`, where the length of bitvec `xs[i]` is given by
  element `ls[i]` in a list of nat `ls` -/
def concat {ls : List Nat} (xs : HVector BitVec ls) : BitVec (List.sum ls) :=
  match (xs) with
  | (.nil) => 0#0
  | (.cons x xs) =>
     let xsSum := concat xs
     x ++ xsSum

/-- Signed division -/
def divs (x y : BitVec w) : BitVec w :=
  BitVec.sdiv x y

/-- Unsigned division -/
def divu (x y : BitVec w) : BitVec w :=
  BitVec.udiv x y

/-- Extract the `lb` lower bits from BitVec `x` -/
def extract (x : BitVec w) (lb : Nat) : BitVec (w - lb) :=
  BitVec.truncate (w - lb) (BitVec.ushiftRight x lb)

/-- Boolean comparison between two input BitVecs -/
def icmp {w : Nat} (c : IcmpPredicate) (x y : BitVec w) : Bool :=
  match c with
    | .eq  => (x == y)
    | .ne => (x != y)
    | .sgt => (y.slt x)
    | .sge => (y.sle x)
    | .slt => (x.slt y)
    | .sle => (x.sle y)
    | .ugt => (x > y)
    | .uge => (x ≥ y)
    | .ult => (x < y)
    | .ule => (x ≤ y)

/-- Signed modulo -/
def mods (x y : BitVec w) : BitVec w :=
  BitVec.smod x y

/-- Unsigned modulo -/
def modu (x y : BitVec w) : BitVec w :=
  BitVec.umod x y

/-- Variadic `mul` operation with a list of bitvectors with width `w` as input -/
def mul {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.mul (1#w) l

/- Generic `mux` operation for any type α -/
def mux (x y : α) (cond : Bool) : α :=
  bif cond then x else y

/-- Variadic `or` operation with a list of bitvectors with width `w` as input -/
def or {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.or (BitVec.zero w) l

/-- Returns boolean parity value of BitVec `x` -/
def parity (x : BitVec w) : Bool :=
  (BitVec.umod x 2#w) == 1

/-- Replicate input BitVec `x` `n` times -/
def replicate (x : BitVec w) (n : Nat) : BitVec (w * n) :=
  BitVec.replicate n x

/-- Shift left -/
def shl (x y : BitVec w) : BitVec w :=
  x <<< y

/-- Signed shift right -/
def shrs (x y : BitVec w) : BitVec w :=
  BitVec.sshiftRight' x y

/-- Unsigned shift right -/
def shru (x y : BitVec w) : BitVec w :=
  BitVec.ushiftRight x y.toNat

/-- Subtraction -/
def sub (x y : BitVec w) : BitVec w :=
  x - y

/-- Variadic `xor` operation with a list of bitvectors with width `w` as input -/
def xor {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.xor (BitVec.zero w) l

end CombOp

namespace MLIR2Comb

section Dialect

inductive Ty
| bv (w : Nat) : Ty -- A bitvector of width `w`.
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
| icmp (w : Nat)
| mods (w : Nat)
| modu (w : Nat)
| mul (w : Nat) (arity : Nat)
| mux (w : Nat)
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

def_signature for Comb where
  | .add w n => ${List.replicate n (Ty.bv w)} → (Ty.bv w)
  | .and w n => ${List.replicate n (Ty.bv w)} → (Ty.bv w)
  | .concat l => (Ty.hList l) → (Ty.bv l.sum)
  | .divs w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .divu w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .extract w n => (Ty.bv w) → (Ty.bv (w - n))
  | .icmp w => (Ty.icmpPred, Ty.bv w, Ty.bv w) → (Ty.bool)
  | .mods w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .modu w => (Ty.bv w, Ty.bv w) → (Ty.bv w)
  | .mul w n => ${List.replicate n (Ty.bv w)} → (Ty.bv w)
  | .mux w => (Ty.bv w, Ty.bv w, Ty.bool) → (Ty.bv w)
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
  | .hList l => HVector BitVec l -- het list of bitvec whose lengths are contained in l
  | .icmpPred => CombOp.IcmpPredicate

def HVector.replicateToList {α : Type} {f : α → Type} {a : α} :
    {n : Nat} → HVector f (List.replicate n a) → List (f a)
  | 0, _ => []
  | n+1, HVector.cons x xs => x :: replicateToList xs

def_denote for Comb where
  | .add _ _ => fun xs => CombOp.add (HVector.replicateToList (f := TyDenote.toType) xs)
  | .and _ _ => fun xs => CombOp.and (HVector.replicateToList (f := TyDenote.toType) xs)
  | .concat _ => fun xs => CombOp.concat xs
  | .divs _ => fun xs => CombOp.divs xs
  | .divu _ => fun xs => CombOp.divu xs
  | .extract _ n => fun xs => CombOp.extract xs n
  | .icmp _ => fun xs => CombOp.icmp xs
  | .mods _ => fun xs => CombOp.mods xs
  | .modu _ => fun xs => CombOp.modu xs
  | .mul _ _ => fun xs => CombOp.mul (HVector.replicateToList (f := TyDenote.toType) xs)
  | .mux _ => fun xs => CombOp.mux xs
  | .or _ _ => fun xs => CombOp.or (HVector.replicateToList (f := TyDenote.toType) xs)
  | .parity _ => fun xs => CombOp.parity xs
  | .replicate _ n => fun xs => CombOp.replicate xs n
  | .shl _ => fun xs => CombOp.shl xs
  | .shrs _ => fun xs => CombOp.shrs xs
  | .shru _ => fun xs => CombOp.shru xs
  | .sub _ => fun xs => CombOp.sub xs
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
    | ["BitVec", r] =>
      return .bv (r.toNat!)
    | ["IcmpPred"] =>
      -- match icmp
      return .icmpPred
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy Comb 0 where
  mkTy := mkTy


def add {Γ : Ctxt _} (arity: Nat) (a : HVector Γ.Var (List.replicate arity (.bv w))) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .add w arity)
    (ty_eq := by rfl)
    (eff_le := by constructor)
    (args := a) -- cast a to the right type
    (regArgs := .nil)

def and {Γ : Ctxt _} (arity: Nat) (a : HVector Γ.Var (List.replicate arity (.bv w))) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w arity)
    (ty_eq := by rfl)
    (eff_le := by constructor)
    (args := a)
    (regArgs := .nil)

def concat {l : List Nat} {Γ : Ctxt _} (ls : Γ.Var (.hList l)): Expr (Comb) Γ .pure (.bv (l.sum)) :=
  Expr.mk
    (op := .concat l)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons ls <| .nil)
    (regArgs := .nil)

def divs {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .divs w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def divu {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .divu w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def extract {Γ : Ctxt _} (a : Γ.Var (.bv w)) (n : Nat) : Expr (Comb) Γ .pure (.bv (w - n)) :=
  Expr.mk
    (op := .extract w n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def icmp {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) (k : Γ.Var (.icmpPred)) : Expr (Comb) Γ .pure (.bool) :=
  Expr.mk
    (op := .icmp w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons k <| .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def mods {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .mods w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def modu {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .modu w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def mul {Γ : Ctxt _} (arity: Nat) (a : HVector Γ.Var (List.replicate arity (.bv w))) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .mul w arity)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := a)
    (regArgs := .nil)

def mux {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) (cond : Γ.Var (.bool)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .mux w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .cons cond <| .nil)
    (regArgs := .nil)

def or {Γ : Ctxt _} (arity: Nat) (a : HVector Γ.Var (List.replicate arity (.bv w))) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .or w arity)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := a)
    (regArgs := .nil)

def parity {Γ : Ctxt _} (a : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bool) :=
  Expr.mk
    (op := .parity w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def replicate {Γ : Ctxt _} (a : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv (w * n)) :=
  Expr.mk
    (op := .replicate w n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def shl {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .shl w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def shrs {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .shrs w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def shru {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .shru w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def sub {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .sub w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def xor {Γ : Ctxt _} (arity: Nat) (a : HVector Γ.Var (List.replicate arity (.bv w))) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .xor w arity)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := a)
    (regArgs := .nil)


/-- Convert a list of dependent pairs into an HVector -/
def ofList {Γ : Ctxt _} ty : (l : List ((ty : Comb.Ty) × Γ.Var ty)) → (h : l.all (·.1 = ty)) → HVector (Γ.Var) (List.replicate l.length ty)
| [], h => .nil
| ⟨ty', var⟩::rest, h =>
  have hty : ty' = ty := by simp_all
  have hrest : rest.all (·.1 = ty) := by simp_all
  .cons (hty ▸ var) (ofList _ rest hrest)

def ofList' {α : Type u} {f : α → Type v} :
    (xs : List (Σ a, f a)) → HVector f (xs.map Sigma.fst)
  | ⟨_, x⟩ :: xs => .cons x (ofList' xs)
  | [] => .nil

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM Comb (Σ eff ty, Expr Comb Γ eff ty) := do
  match opStx.name with
  | op@"Comb.parity" | op@"Comb.concat" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .bv w, "Comb.parity" => return ⟨_, .bool, parity v₁⟩
      | .hList l, "Comb.concat" => return ⟨_, .bv l.sum, concat v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.add" | op@"Comb.and" | op@"Comb.mul" | op@"Comb.or" | op@"Comb.xor" =>
      let args ← opStx.args.mapM (MLIR.AST.TypedSSAVal.mkVal Γ)
      if hl: args.length ≤ 0 then
        throw <| .generic s!"empty list of arguments for '{repr opStx.args}'"
      else
        have hl' : (0 : Nat) < args.length := by
          simp [Nat.gt_of_not_le (n := args.length) (m := 0) hl]
        match args[0], op with
        | ⟨.bv w, _⟩, "Comb.add" =>
          if hall : args.all (·.1 = .bv w) then
            let argsᵥ := ofList (.bv w) _ hall
            have heq : args.length - 1 + 1 = args.length := by omega
            return ⟨_, .bv w, add args.length (heq ▸ argsᵥ)⟩
          else
            throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
        | ⟨.bv w, _⟩, "Comb.and" =>
            if hall : args.all (·.1 = .bv w) then
              let argsᵥ := ofList (.bv w) _ hall
              have heq : args.length - 1 + 1 = args.length := by omega
              return ⟨_, .bv w, and args.length (heq ▸ argsᵥ)⟩
            else
              throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
        | ⟨.bv w, _⟩, "Comb.mul" =>
            if hall : args.all (·.1 = .bv w) then
              let argsᵥ := ofList (.bv w) _ hall
              have heq : args.length - 1 + 1 = args.length := by omega
              return ⟨_, .bv w, mul args.length (heq ▸ argsᵥ)⟩
            else
              throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
        | ⟨.bv w, _⟩, "Comb.or" =>
            if hall : args.all (·.1 = .bv w) then
              let argsᵥ := ofList (.bv w) _ hall
              have heq : args.length - 1 + 1 = args.length := by omega
              return ⟨_, .bv w, or args.length (heq ▸ argsᵥ)⟩
            else
              throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
        | ⟨.bv w, _⟩, "Comb.xor" =>
            if hall : args.all (·.1 = .bv w) then
              let argsᵥ := ofList (.bv w) _ hall
              have heq : args.length - 1 + 1 = args.length := by omega
              return ⟨_, .bv w, xor args.length (heq ▸ argsᵥ)⟩
            else
              throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
        | _, _ => throw <| .generic s!"Unexpected argument types for '{repr opStx.args}'"
  | op@"Comb.divs" | op@"Comb.divu" | op@"Comb.mods" | op@"Comb.modu" | op@"Comb.replicate" | op@"Comb.shl" | op@"Comb.shrs" | op@"Comb.shru" | op@"Comb.sub"  =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      /- more checks need to be added here to ensure the consistency of operations and bitvec sizes -/
      -- | .bv w₁, .bv w₂, "Comb.concat" =>
      --   return ⟨_, .bv (w₁ + w₂), concat v₁ v₂⟩
      | .bv w₁, .bv w₂, "Comb.divs" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, divs v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.divu" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, divu v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      -- | .bv w, .nat, "Comb.extract" =>
      --   return ⟨_, .bv (w - v₂), extract v₁ v₂⟩
      | .bv w₁, .bv w₂, "Comb.mods" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, mods v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.modu" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, modu v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.shl" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, shl v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.shrs" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, shrs v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.shru" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, shru v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.sub" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, sub v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | _, _, _=> throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.icmp" | op@"Comb.mux" =>
    match opStx.args with
    | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match ty₁, ty₂, ty₃, op with
      | .bv w₁, .bv w₂, .icmpPred, "Comb.icmp" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bool, icmp v₁ v₂ v₃⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, .bool, "Comb.mux" =>
        if h : w₁ = w₂ then
          /- mux should work even if w₁ ≠ w₂ but i need to think about how to implement that in an elegant way -/
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, mux v₁ v₂ v₃⟩
        else
          throw <| .generic s!"type mismatch"
      | _, _, _, _=> throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected three operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | _ =>
    if "Comb.replicate" = opStx.name
    then {
      match (opStx.name).splitOn "_" with
      | [_, n] =>
        match opStx.args with
        | v₁Stx::[] =>
          let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
          match ty₁ with
          | .bv w₁ =>
            let n' := n.toNat!
            return ⟨_, .bv (w₁ * n'), replicate v₁ (n := n')⟩
          | _ => throw <| .generic s!"type mismatch"
        | _ => throw <| .generic s!"type mismatch"
      | _ => throw <| .generic s!"type mismatch"
    }
    else
      throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

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
