import SSA.Core

import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import Init.Data.String.Basic

open MLIR AST Ctxt

/-!

# Semantics for the `Handshake` Dialect
This file is still in a **highly experimental** state

-/
namespace CIRCTStream
namespace HandshakeOp

/-!
## Operation Semantics
-/

/-
s`branch x c` has two output streams,
forwarding tokens from `x` to either
the first or the second output depending on whether the corresponding token of `c` is
`true`, resp. `false`.

If only one input stream has a message available, the component will wait,
not consuming any tokens, until a message becomes available on the other stream as well.
Note that consuming `none`s is still allowed (and in fact neccessary to make progress).
-/

def branch (x : Stream α) (c : Stream (BitVec 1)) : Stream α × Stream α :=
  Stream.corec₂ (β := Stream α × Stream (BitVec 1)) (x, c)
    fun ⟨x, c⟩ => Id.run <| do
      let c₀ := c 0
      let c' := c.tail
      let x₀ := x 0
      let x' := x.tail
      match c₀, x₀ with
        | none, _ => (none, none, (x, c'))
        | _, none => (none, none, (x', c))
        | some c₀, some x₀ =>
          if c₀ = 1 then
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

-- this is basically the same as the fork in DC
def fork (x : Stream α) : Stream α × Stream α :=
  Stream.corec₂ (β := Stream α) x
    fun x => Id.run <| do
      let x0 := x 0
      let x' := x.tail
      (x0, x0, x')

-- not entirely nondeterministic (still picks left first)
def controlMerge (x y : Stream α) : Stream α × Stream (BitVec 1) :=
  Stream.corec₂ (β := Stream α × Stream α) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some x', some _ => (some x', some 1, (x.tail, y))
    | some x', none => (some x', some 1, (x.tail, y.tail))
    | none, some y' => (some y', some 0, (x.tail, y.tail))
    | none, none => (none, none, (x.tail, y.tail))


def join (x y : Stream α) : Stream (BitVec 1) :=
  Stream.corec (β := Stream α × Stream α) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some 1, (x.tail, y.tail))
    | some _, none   => (none, (x, y.tail))
    | none, some _   => (none, (x.tail, y))
    | none, none     => (none, (x.tail, y.tail))

-- select stream and two inputs (deterministic mergs)
def mux (x y : Stream α) (c : Stream (BitVec 1)) : Stream α :=
  Stream.corec (β := Stream α × Stream α × Stream (BitVec 1)) (x, y, c) fun ⟨x, y, c⟩ => Id.run <| do
    match x 0, y 0, c 0 with
      | none, _, some 1 => (none, (x.tail, y, c)) -- could not pop anything
      | some _, _, some 1 => (x 0, (x.tail, y, c.tail)) -- pop from x
      | _, none, some 0 => (none, (x, y.tail, c)) -- could not pop anything
      | _, some _, some 0 => (y 0, (x, y.tail, c.tail)) -- pop from y
      | _, _, none => (none, (x, y, c.tail)) -- no pop

-- discards any data: actually this should not return anything
def sink (x : Stream α) : Stream (BitVec 1) :=
  Stream.corec (β := Stream α) (x) fun (x) => (none, x.tail)

-- The source operation represents continuous token source.
-- The source continously sets a ‘valid’ signal which the successor can consume at any point in time.
def source (a: α) : Stream α :=
  Stream.corec (a) fun (a) => (some a, (a))

-- Synchronizes an arbitrary set of inputs.
-- Synchronization implies applying join semantics in between all in- and output ports.
def sync (x y : Stream α) : Stream α × Stream α :=
  Stream.corec₂ (β := Stream α × Stream α) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some x', some y' => (some x', some y', (x.tail, y.tail))
    | some _, none => (none, none, (x, y.tail))
    | none, some _ => (none, none, (x.tail, y))
    | none, none => (none, none, (x.tail, y.tail))

def not (x : Stream (BitVec 1)) : Stream (BitVec 1) :=
  Stream.corec (β := Stream (BitVec 1)) x fun x =>
    match x 0 with
    | some 1 => (some 0, (x.tail))
    | some 0 => (some 0,  (x.tail))
    | none => (none, (x.tail))

def supp (x : Stream α) (c : Stream (BitVec 1)) : Stream α := (branch x c).snd

-- The pack operation constructs a tuple from separate values.
-- The number of operands corresponds to the number of tuple elements.
-- Similar to join, the output is ready when all inputs are ready.

end HandshakeOp

/-!
## LeanMLIR Dialect Definitions
Define a `Handshake` dialect, and connect its semantics to the function defined above
-/

namespace MLIR2Handshake

section Dialect

inductive Ty2
  | bitvec (w : Nat) : Ty2
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr


inductive Ty
| stream (ty2 : Ty2) : Ty -- A stream of values of type `ty2`.
| stream2 (ty2 : Ty2) : Ty -- A product of streams of values of type `ty2`.
| stream2token (ty2 : Ty2) : Ty -- A product of a stream of values of type `ty2` and a stream of `BitVec 1` representing `token`
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

instance : TyDenote Ty2 where
toType := fun
|  Ty2.bitvec w => BitVec w

instance : ToString Ty where
  toString t := repr t |>.pretty

inductive Op
| fst (t : Ty2)
| snd (t : Ty2)
| branch (t : Ty2)
| merge (t : Ty2)
| altMerge (t : Ty2)
| fork (t : Ty2)
| controlMerge (t : Ty2)
| join (t : Ty2)
| mux (t : Ty2)
| sink (t : Ty2)
| sync (t : Ty2)
| supp (t : Ty2)
| not
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

abbrev Handshake : Dialect where
  Op := Op
  Ty := Ty

def_signature for Handshake where
| .fst t => (Ty.stream2 t) → Ty.stream t
| .snd t => (Ty.stream2 t) → Ty.stream t
| .branch t => (Ty.stream t, Ty.stream (Ty2.bitvec 1)) → Ty.stream2 t
| .merge t => (Ty.stream t, Ty.stream t) → Ty.stream t
| .altMerge t => (Ty.stream t, Ty.stream t) → Ty.stream t
| .fork t => (Ty.stream t) → Ty.stream2 t -- returns the product
| .controlMerge t => (Ty.stream t, Ty.stream t) → (Ty.stream2token t)
| .join t => (Ty.stream t, Ty.stream t) → (Ty.stream (Ty2.bitvec 1))
| .mux t => (Ty.stream t, Ty.stream t, Ty.stream (Ty2.bitvec 1)) → Ty.stream t
| .sink t => (Ty.stream t) → (Ty.stream (Ty2.bitvec 1))
| .sync t => (Ty.stream t, Ty.stream t) → Ty.stream2 t
| .supp t => (Ty.stream t, Ty.stream (Ty2.bitvec 1)) → Ty.stream t
| .not => (Ty.stream (Ty2.bitvec 1)) → Ty.stream (Ty2.bitvec 1)

instance instHandshakeTyDenote : TyDenote Ty where
toType := fun
| Ty.stream ty2 => CIRCTStream.Stream (TyDenote.toType ty2)
| Ty.stream2 ty2 => CIRCTStream.Stream (TyDenote.toType ty2) × CIRCTStream.Stream (TyDenote.toType ty2)
| Ty.stream2token ty2 => CIRCTStream.Stream (TyDenote.toType ty2) × CIRCTStream.Stream (TyDenote.toType (Ty2.bitvec 1))

def_denote for Handshake where
| .fst _ => fun s => [s.fst]ₕ
| .snd _ => fun s => [s.snd]ₕ
| .branch _ => fun s c => [HandshakeOp.branch s c]ₕ
| .merge _ => fun s₁ s₂ => [HandshakeOp.merge s₁ s₂]ₕ
| .altMerge _ => fun s₁ s₂ => [HandshakeOp.altMerge s₁ s₂]ₕ
| .fork _ => fun s => [HandshakeOp.fork s]ₕ
| .controlMerge _ => fun s₁ s₂ => [HandshakeOp.controlMerge s₁ s₂]ₕ
| .join _ => fun s₁ s₂ => [HandshakeOp.join s₁ s₂]ₕ
| .mux _ => fun s₁ s₂ c => [HandshakeOp.mux s₁ s₂ c]ₕ
| .sink _ => fun s => [HandshakeOp.sink s]ₕ
| .sync _ => fun s₁ s₂ => [HandshakeOp.sync s₁ s₂]ₕ
| .supp _ => fun s₁ s₂ => [HandshakeOp.supp s₁ s₂]ₕ
| .not => fun s₁ => [HandshakeOp.not s₁]ₕ

end Dialect

/-!
## LeanMLIR EDSL Syntax for Handshake
Implement the necessary typeclasses for the `handshake` dialect to
be recognized by the LeanMLIR generic syntax parser, and
defines a `[handshake_com| ...]` macro to hook into this generic syntax parser
-/

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM Handshake Handshake.Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn "_" with
    | ["Stream", "BitVec", w] =>
      match w.toNat? with
      | some w' => return .stream (.bitvec w')
      | _ => throw .unsupportedType
    | ["Stream2", "BitVec", w] =>
      match w.toNat? with
      | some w' => return .stream2 (.bitvec w')
      | _ => throw .unsupportedType
    | ["Stream2Token", "BitVec", w] =>
      match w.toNat? with
      | some w' => return .stream2token (.bitvec w')
      | _ => throw .unsupportedType
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy Handshake 0 where
  mkTy := mkTy

section Compat
open LeanMLIR.SingleReturnCompat

def branch {r} {Γ : Ctxt _} (a : Var Γ (.stream r)) (c : Var Γ (.stream (.bitvec 1))) : Expr (Handshake) Γ .pure (.stream2 r) :=
  Expr.mk
    (op := .branch r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons c <| .nil)
    (regArgs := .nil)

def merge {Γ : Ctxt _} (a b : Var Γ (.stream r)) : Expr (Handshake) Γ .pure (.stream r)  :=
  Expr.mk
    (op := .merge r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def fst {Γ : Ctxt _} (a : Var Γ (.stream2 r)) : Expr (Handshake) Γ .pure (.stream r)  :=
  Expr.mk
    (op := .fst r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def snd {Γ : Ctxt _} (a : Var Γ (.stream2 r)) : Expr (Handshake) Γ .pure (.stream r)  :=
  Expr.mk
    (op := .snd r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def sync {Γ : Ctxt _} (a b : Var Γ (.stream r)) : Expr (Handshake) Γ .pure (.stream2 r)  :=
  Expr.mk
    (op := .sync r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def not {Γ : Ctxt _} (a : Var Γ (.stream (.bitvec 1))) : Expr (Handshake) Γ .pure (.stream (.bitvec 1))  :=
  Expr.mk
    (op := .not)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def supp {Γ : Ctxt _} (a : Var Γ (.stream r)) (b : Var Γ (.stream (.bitvec 1))) : Expr (Handshake) Γ .pure (.stream r)  :=
  Expr.mk
    (op := .supp r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)


end Compat

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (Handshake) (Σ eff ty, Expr (Handshake) Γ eff ty) := do
  match opStx.name with
  | op@"handshake.branch" | op@"handshake.merge" =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .stream r₁, .stream (.bitvec 1), "handshake.branch" => return ⟨_, [.stream2 r₁], @branch r₁ _ v₁ v₂⟩
      -- unsure this is correct
      | .stream r₁, _, "handshake.merge" => return ⟨_, [.stream r₁], merge v₁ v₁⟩
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"handshake.fst" | op@"handshake.snd" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .stream2 r, "handshake.fst" => return ⟨_, [.stream r], fst v₁⟩
      | .stream2 r, "handshake.snd"  => return ⟨_, [.stream r], snd v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"handshake.not" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .stream (.bitvec 1), "handshake.not" => return ⟨_, [.stream (.bitvec 1)], not v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"handshake.supp" =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .stream r, .stream (.bitvec 1), "handshake.supp" => return ⟨_, [.stream r], supp v₁ v₂⟩
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"handshake.sync" =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .stream r₁, .stream r₂, "handshake.sync" =>
        if h : r₁ = r₂ then
          have h': Γ.Var (Ty.stream r₁) = Γ.Var (Ty.stream r₂) := by simp_all
          return ⟨_, [.stream2 r₁], sync v₁ (h'▸v₂)⟩
        else
          throw <| .generic s!"type mismatch"
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

instance : MLIR.AST.TransformExpr (Handshake) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (Handshake)
    (Σ eff ty, Com Handshake Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, [ty], Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (Handshake) 0 where
  mkReturn := mkReturn

instance : DialectToExpr Handshake where
  toExprM := .const ``Id [0]
  toExprDialect := .const ``Handshake []

open Qq MLIR AST Lean Elab Term Meta in
elab "[handshake_com| " reg:mlir_region "]" : term => do SSA.elabIntoCom' reg Handshake

end MLIR2Handshake
