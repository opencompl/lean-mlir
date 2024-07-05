import SSA.Core.Framework
import SSA.Core.MLIRSyntax.EDSL
import Mathlib.Data.Stream.Defs

open MLIR AST Ctxt


def Val      := Option (Bool)

/-- `DC` is fully deterministic! -/
abbrev Brook := Stream' Val

#check Stream'.corec
#print Stream'


def Brook.corec {β} (s0 : β) (f : β → (Val × β)) : Brook :=
  Stream'.corec (f · |>.fst) (f · |>.snd) s0

def Brook.corec₂ {β} (s0 : β) (f : β → (Val × Val × β)) : Brook × Brook :=
  let f' := fun b =>
    let x := f b
    (x.fst, x.snd.fst)
  let g := (f · |>.snd.snd)
  let x := Stream'.corec f' g s0
  (
    fun i => (x i).fst,
    fun i => (x i).snd,
  )

def Brook.dropFirst (x : Brook) : Brook :=
  fun ix => x (ix + 1)

/-!

x : x1 x2 _ x3
y : y1 _  _ y2
c : f t f _ f

x : x1 x2 _ x3
y : _ _ y2
c : t f _ f
out : y1

-/

namespace Brook

/--
`branch x c` has two output streams,
forwarding tokens from `x` to either
the first or the second output depending on whether the corresponding token of `c` is
`true`, resp. `false`.

If only one input stream has a message available, the component will wait,
not consuming any tokens, until a message becomes available on the other stream as well.
Note that consuming `none`s is still allowed (and in fact neccessary to make progress).

-/
def branch (x c  : Brook) : Brook × Brook :=

  Brook.corec₂ (β := Brook × Brook) (x, c)
    fun ⟨x, c⟩ => Id.run <| do

      let c₀ := c 0
      let c' := c.dropFirst
      let x₀ := x 0
      let x' := x.dropFirst

      match c₀, x₀ with
        | none, _ => (none, none, (x, c'))
        | _, none => (none, none, (x', c))
        | some c₀, some x₀ =>
          if c₀ then
            (some x₀, none, (x', c'))
          else
            (none, some x₀, (x', c'))

/--
`merge x y` is a deterinistic merge which keeps dequeuing from the left stream until it encounters a `none`,
in which case it tries to dequeue from the right stream.  The only case when no token is consumed is when there
is a token in both streams, because only the left one is left through and the right one is saved.
-/
def merge (x y : Brook) : Brook :=
  Brook.corec (β := Brook × Brook) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some x', some _ => (some x', (x.dropFirst, y))
    | some x', none => (some x', (x.dropFirst, y.dropFirst))
    | none, some y' => (some y', (x.dropFirst, y.dropFirst))
    | none, none => (none, (x.dropFirst, y.dropFirst))

end Brook


inductive Op
| merge
| branch
| fst
| snd
deriving Inhabited, DecidableEq, Repr

inductive Ty
| brook : Ty
| brook2 : Ty
deriving Inhabited, DecidableEq, Repr

instance : TyDenote Ty where
toType := fun
| .brook => Brook
| .brook2 => Brook × Brook


/-- `FHE` is the dialect for fully homomorphic encryption -/
abbrev DC : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)


@[simp, reducible]
def Op.sig : Op  → List Ty
| .branch => [Ty.brook, Ty.brook]
| .merge => [Ty.brook, Ty.brook]
| .fst | .snd => [Ty.brook2]

@[simp, reducible]
def Op.outTy : Op → Ty
  | .branch => Ty.brook2
  | .merge => Ty.brook
  | .fst | .snd => Ty.brook

@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []}

instance : DialectSignature DC := ⟨Op.signature⟩

@[simp]
instance : DialectDenote (DC) where
    denote
    | .branch, arg, _ => Brook.branch (arg.getN 0) (arg.getN 1)
    | .merge, arg, _  => Brook.merge (arg.getN 0) (arg.getN 1)
    | .fst, arg, _ => (arg.getN 0).fst
    | .snd, arg, _ => (arg.getN 0).snd



/-- Syntax -/

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM (DC) (DC).Ty
  | MLIR.AST.MLIRType.undefined "brook" => do
    return .brook
  | MLIR.AST.MLIRType.undefined "brook2" => do
    return .brook2
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy (DC) 0 where
  mkTy := mkTy

def branch {Γ : Ctxt _} (a b : Var Γ .brook) : Expr (DC) Γ .pure .brook2  :=
  Expr.mk
    (op := .branch)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def merge {Γ : Ctxt _} (a b : Var Γ .brook) : Expr (DC) Γ .pure .brook  :=
  Expr.mk
    (op := .merge)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def fst {Γ : Ctxt _} (a : Var Γ .brook2) : Expr (DC) Γ .pure .brook  :=
  Expr.mk
    (op := .fst)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def snd {Γ : Ctxt _} (a : Var Γ .brook2) : Expr (DC) Γ .pure .brook  :=
  Expr.mk
    (op := .snd)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def mkExpr (Γ : Ctxt (DC).Ty) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (DC) (Σ eff ty, Expr (DC) Γ eff ty) := do
  match opStx.name with
  | op@"dc.branch" | op@"dc.merge" =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .brook, .brook, "dc.branch" => return ⟨_, .brook2, branch v₁ v₂⟩
      | .brook, .brook, "dc.merge"  => return ⟨_, .brook, merge v₁ v₂⟩
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"dc.fst" | op@"dc.snd" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .brook2, "dc.fst" => return ⟨_, .brook, fst v₁⟩
      | .brook2, "dc.snd"  => return ⟨_, .brook, snd v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"


  | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

instance : MLIR.AST.TransformExpr (DC) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt (DC).Ty) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (DC)
    (Σ eff ty, Com (DC) Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (DC) 0 where
  mkReturn := mkReturn

open Qq MLIR AST Lean Elab Term Meta in
elab "[dc_com" " | " reg:mlir_region "]" : term => do

  SSA.elabIntoCom reg q(DC)

def BranchEg1 := [dc_com| {
  ^entry(%0: !brook, %1: !brook):
    %out = "dc.branch" (%0, %1) : (!brook, !brook) -> (!brook2)
    %outf = "dc.fst" (%out) : (!brook2) -> (!brook)
    %outs = "dc.snd" (%out) : (!brook2) -> (!brook)
    %out2 = "dc.merge" (%outf, %outs) : (!brook, !brook) -> (!brook)
    "return" (%out2) : (!brook) -> ()
  }]

#check BranchEg1
#eval BranchEg1
#reduce BranchEg1
#check BranchEg1.denote
#print axioms BranchEg1

def Brook.ofList (vals : List Val) : Brook :=
  fun i => (vals.get? i).join

def Brook.toList (n : Nat) (x : Brook) : List Val :=
  List.ofFn (fun (i : Fin n) => x i)


namespace Test

def x := Brook.ofList [some true, none, some false, some true, some false]
def c := Brook.ofList [some true, some false, none, some true]

def test : Brook :=
  BranchEg1.denote (Valuation.ofPair c x)

def remNone (lst : List Val) : List Val :=
  lst.filter (fun | some x => true
                  | none => false)

#eval (remNone <| Brook.toList 100 test)
