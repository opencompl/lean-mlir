import SSA.Core.Framework
import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.CIRCT.DC.Stream

open MLIR AST Ctxt

/-!

# Semantics for the `DC` Dialect
This file is still in a **highly experimental** state

-/
namespace DC


/-!
## Operation Semantics
-/
section Operations
namespace Stream

/--
`branch x c` has two output streams,
forwarding tokens from `x` to either
the first or the second output depending on whether the corresponding token of `c` is
`true`, resp. `false`.

If only one input stream has a message available, the component will wait,
not consuming any tokens, until a message becomes available on the other stream as well.
Note that consuming `none`s is still allowed (and in fact neccessary to make progress).

-/

def branch (x : Stream α) (c : Stream Bool) : Stream α × Stream α :=

  corec₂ (β := Stream α × Stream Bool) (x, c)
    fun ⟨x, c⟩ => Id.run <| do

      let c₀ := c 0
      let c' := c.tail
      let x₀ := x 0
      let x' := x.tail

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
def merge (x y : Stream α) : Stream α :=
  Stream.corec (β := Stream α × Stream α) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some x', some _ => (some x', (x.tail, y))
    | some x', none => (some x', (x.tail, y.tail))
    | none, some y' => (some y', (x.tail, y.tail))
    | none, none => (none, (x.tail, y.tail))

/-!
Crucially, the `merge` component is *deterministic*, but its output does depend on the presence of
`none`s in the input.

Consider the following inputs streams, where `_` indicates a `none`
x | x₀ _  _  x₁ _ _ ...
y | y₀ y₁ y₂ _  _ _ ...

In this case, the output will be
  | x₀ y₀ y₁ x₁ y₂

However, if we remove some `none` from the inputs, i.e.:
x | x₀ x₁ _  _ ...
y | y₀ y₁ y₂ _

This will give a different output!
  | x₀ x₁ y₀ y₁ y₂



One potential response to this situation is to require components be *determinate*.
That is, by defining our component semantics in such a way that its output does not change
depending on the presence or absence of (a finite sequence of) `none`s in its input.
See `altMerge` for an example semantics for a `merge` component that is fully determinate.
-/

/-- Internal state for `altMerge` component,
indicating from which stream to consume the next message -/
inductive ConsumeFrom
  | left
  | right

/--
`altMerge x y` is a fully determinate merge which will alternate (`some _`) messages from its two input streams.
That is, it will deque messages from the left stream, until it encounters a `some _`,
which it will output and then it switches to dequeing messages from the right stream,
until it encounters a `some _` again.
-/
def altMerge (x y : Stream α) : Stream α :=
  Stream.corec (β := Stream α × Stream α × ConsumeFrom) (x, y, .left) fun ⟨x, y, consume⟩ =>
    match consume with
      | .left  =>
        let x0 := x.head
        let x := x.tail
        let nextConsume := match x0 with
          | some _ => .right
          | none   => .left
        (x0, x, y, nextConsume)
      | .right =>
        let y0 := y.head
        let y := y.tail
        let nextConsume := match y0 with
          | some _ => .left
          | none   => .right
        (y0, x, y, nextConsume)

end Stream
end Operations

/-!
## LeanMLIR Dialect Definitions
Define a `DC` dialect, and connect its semantics to the function defined above
-/
section Dialect

inductive Ty2
  | int : Ty2
  | bool : Ty2
deriving Inhabited, DecidableEq, Repr

inductive Op
| merge (t : Ty2)
| branch (t : Ty2)
| fst (t : Ty2)
| snd (t : Ty2)
deriving Inhabited, DecidableEq, Repr

inductive Ty
| stream (ty2 : Ty2) : Ty
| stream2 (ty2 : Ty2) : Ty
deriving Inhabited, DecidableEq, Repr


instance : TyDenote Ty2 where
toType := fun
|  Ty2.int => Int
|  Ty2.bool => Bool

open TyDenote (toType) in
instance : TyDenote Ty where
toType := fun
| Ty.stream ty2 => Stream (toType ty2)
| Ty.stream2 ty2 => Stream (toType ty2) × Stream (toType ty2)


set_option linter.dupNamespace false in
/-- `FHE` is the dialect for fully homomorphic encryption -/
abbrev DC : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)

-- arg type CONF
@[simp, reducible]
def Op.sig : Op  → List Ty
| .branch t₁ => [Ty.stream t₁, Ty.stream Ty2.bool]
| .merge t₁ => [Ty.stream t₁, Ty.stream t₁]
| .fst t | .snd t => [Ty.stream2 t]

-- return type CONF
@[simp, reducible]
def Op.outTy : Op → Ty
  | .branch t₁ => Ty.stream2 t₁
  | .merge t₁ => Ty.stream t₁
  | .fst t | .snd t => Ty.stream t

@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []}

instance : DialectSignature DC := ⟨Op.signature⟩

@[simp]
instance : DialectDenote (DC) where
    denote
    | .branch _, arg, _ => Stream.branch (arg.getN 0) (arg.getN 1)
    | .merge _, arg, _  => Stream.merge (arg.getN 0) (arg.getN 1)
    | .fst _, arg, _ => (arg.getN 0).fst
    | .snd _, arg, _ => (arg.getN 0).snd

end Dialect



/-!
## LeanMLIR EDSL Syntax for DC
Implement the necessary typeclasses for the `dc` dialect to
be recognized by the LeanMLIR generic syntax parser, and
defines a `[dc_com| ...]` macro to hook into this generic syntax parser
-/
section Syntax

def mkTy2 : String → MLIR.AST.ExceptM (DC) Ty2
  | "int" => return (.int)
  | "bool" => return (.bool)
  | _ => throw .unsupportedType

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM (DC) (DC).Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn with
    | ["Stream", r] =>
      return .stream (← mkTy2 r)
    | ["Stream2", r] =>
      return .stream (← mkTy2 r)
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy (DC) 0 where
  mkTy := mkTy

def branch {Γ : Ctxt _} (a : Var Γ (.stream r)) (c : Var Γ (.stream .bool)) : Expr (DC) Γ .pure (.stream2 r) :=
  Expr.mk
    (op := .branch r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons c <| .nil)
    (regArgs := .nil)

def merge {Γ : Ctxt _} (a b : Var Γ (.stream r)) : Expr (DC) Γ .pure (.stream r)  :=
  Expr.mk
    (op := .merge r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def fst {Γ : Ctxt _} (a : Var Γ (.stream2 r)) : Expr (DC) Γ .pure (.stream r)  :=
  Expr.mk
    (op := .fst r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def snd {Γ : Ctxt _} (a : Var Γ (.stream2 r)) : Expr (DC) Γ .pure (.stream r)  :=
  Expr.mk
    (op := .snd r)
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
      | .stream r₁, .stream .bool, "dc.branch" => return ⟨_, .stream2 r₁, branch v₁ v₂⟩
      -- unsure this is correct
      | .stream r₁, _, "dc.merge" => return ⟨_, .stream r₁, merge v₁ v₁⟩
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"dc.fst" | op@"dc.snd" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .stream2 r, "dc.fst" => return ⟨_, .stream r, fst v₁⟩
      | .stream2 r, "dc.snd"  => return ⟨_, .stream r, snd v₁⟩
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

end Syntax



/-!
## Examples
-/
namespace Examples
def BranchEg1 := [dc_com| {
  ^entry(%0: !Stream, %1: !Stream):
    %out = "dc.branch" (%0, %1) : (!Stream, !Stream) -> (!Stream2)
    %outf = "dc.fst" (%out) : (!Stream2) -> (!Stream)
    %outs = "dc.snd" (%out) : (!Stream2) -> (!Stream)
    %out2 = "dc.merge" (%outf, %outs) : (!Stream, !Stream) -> (!Stream)
    "return" (%out2) : (!Stream) -> ()
  }]

#check BranchEg1
#eval BranchEg1
#reduce BranchEg1
#check BranchEg1.denote
#print axioms BranchEg1

def x := Stream.ofList [some true, none, some false, some true, some false]
def c := Stream.ofList [some true, some false, none, some true]

def test : Stream r :=
  BranchEg1.denote (Valuation.ofPair c x)

def remNone (lst : List Val) : List Val :=
  lst.filter (fun | some x => true
                  | none => false)
end Examples
