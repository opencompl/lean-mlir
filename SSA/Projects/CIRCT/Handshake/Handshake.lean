import SSA.Core.Framework
import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.CIRCT.Handshake.Stream

open MLIR AST Ctxt

/-!

# Semantics for the `Handshake` Dialect
This file is still in a **highly experimental** state

-/
namespace Handshake


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
def branch (x c  : Stream) : Stream × Stream :=

  corec₂ (β := Stream × Stream) (x, c)
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
def merge (x y : Stream) : Stream :=
  Stream.corec (β := Stream × Stream) (x, y) fun ⟨x, y⟩ =>
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
def altMerge (x y : Stream) : Stream :=
  Stream.corec (β := Stream × Stream × ConsumeFrom) (x, y, .left) fun ⟨x, y, consume⟩ =>
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

-- this is basically the same as the fork in DC
def fork (x : Stream) : Stream × Stream :=
  Stream.corec₂ (β := Stream) x
    fun x => Id.run <| do
      let x0 := x 0
      let x' := x.tail
      (x0, x0, x')

end Stream
end Operations

/-!
## LeanMLIR Dialect Definitions
Define a `Handshake` dialect, and connect its semantics to the function defined above
-/
section Dialect
inductive Op
| merge
| branch
| fst
| snd
deriving Inhabited, DecidableEq, Repr

inductive Ty
| Stream : Ty
| Stream2 : Ty
deriving Inhabited, DecidableEq, Repr

instance : TyDenote Ty where
toType := fun
| .Stream => Stream
| .Stream2 => Stream × Stream


set_option linter.dupNamespace false in
/-- `FHE` is the dialect for fully homomorphic encryption -/
abbrev Handshake : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)


@[simp, reducible]
def Op.sig : Op  → List Ty
| .branch => [Ty.Stream, Ty.Stream]
| .merge => [Ty.Stream, Ty.Stream]
| .fst | .snd => [Ty.Stream2]

@[simp, reducible]
def Op.outTy : Op → Ty
  | .branch => Ty.Stream2
  | .merge => Ty.Stream
  | .fst | .snd => Ty.Stream

@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []}

instance : DialectSignature Handshake := ⟨Op.signature⟩

@[simp]
instance : DialectDenote (Handshake) where
    denote
    | .branch, arg, _ => Stream.branch (arg.getN 0) (arg.getN 1)
    | .merge, arg, _  => Stream.merge (arg.getN 0) (arg.getN 1)
    | .fst, arg, _ => (arg.getN 0).fst
    | .snd, arg, _ => (arg.getN 0).snd

end Dialect



/-!
## LeanMLIR EDSL Syntax for Handshake
Implement the necessary typeclasses for the `handshake` dialect to
be recognized by the LeanMLIR generic syntax parser, and
defines a `[handshake_com| ...]` macro to hook into this generic syntax parser
-/
section Syntax

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM (Handshake) (Handshake).Ty
  | MLIR.AST.MLIRType.undefined "Stream" => do
    return .Stream
  | MLIR.AST.MLIRType.undefined "Stream2" => do
    return .Stream2
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy (Handshake) 0 where
  mkTy := mkTy

def branch {Γ : Ctxt _} (a b : Var Γ .Stream) : Expr (Handshake) Γ .pure .Stream2  :=
  Expr.mk
    (op := .branch)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def merge {Γ : Ctxt _} (a b : Var Γ .Stream) : Expr (Handshake) Γ .pure .Stream  :=
  Expr.mk
    (op := .merge)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def fst {Γ : Ctxt _} (a : Var Γ .Stream2) : Expr (Handshake) Γ .pure .Stream  :=
  Expr.mk
    (op := .fst)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def snd {Γ : Ctxt _} (a : Var Γ .Stream2) : Expr (Handshake) Γ .pure .Stream  :=
  Expr.mk
    (op := .snd)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def mkExpr (Γ : Ctxt (Handshake).Ty) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (Handshake) (Σ eff ty, Expr (Handshake) Γ eff ty) := do
  match opStx.name with
  | op@"handshake.branch" | op@"handshake.merge" =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .Stream, .Stream, "handshake.branch" => return ⟨_, .Stream2, branch v₁ v₂⟩
      | .Stream, .Stream, "handshake.merge"  => return ⟨_, .Stream, merge v₁ v₂⟩
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"handshake.fst" | op@"handshake.snd" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .Stream2, "handshake.fst" => return ⟨_, .Stream, fst v₁⟩
      | .Stream2, "handshake.snd"  => return ⟨_, .Stream, snd v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"


  | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

instance : MLIR.AST.TransformExpr (Handshake) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt (Handshake).Ty) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (Handshake)
    (Σ eff ty, Com (Handshake) Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (Handshake) 0 where
  mkReturn := mkReturn

open Qq MLIR AST Lean Elab Term Meta in
elab "[handshake_com" " | " reg:mlir_region "]" : term => do
  SSA.elabIntoCom reg q(Handshake)

end Syntax



/-!
## Examples
-/
namespace Examples
def BranchEg1 := [handshake_com| {
  ^entry(%0: !Stream, %1: !Stream):
    %out = "handshake.branch" (%0, %1) : (!Stream, !Stream) -> (!Stream2)
    %outf = "handshake.fst" (%out) : (!Stream2) -> (!Stream)
    %outs = "handshake.snd" (%out) : (!Stream2) -> (!Stream)
    %out2 = "handshake.merge" (%outf, %outs) : (!Stream, !Stream) -> (!Stream)
    "return" (%out2) : (!Stream) -> ()
  }]

#check BranchEg1
#eval BranchEg1
#reduce BranchEg1
#check BranchEg1.denote
#print axioms BranchEg1

def x := Stream.ofList [some true, none, some false, some true, some false]
def c := Stream.ofList [some true, some false, none, some true]

def test : Stream :=
  BranchEg1.denote (Valuation.ofPair c x)

def remNone (lst : List Val) : List Val :=
  lst.filter (fun | some x => true
                  | none => false)
end Examples
