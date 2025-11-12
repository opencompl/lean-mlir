import SexprPBV.Sexpr

namespace SexprPBV

inductive WidthBinaryRelationKind
| eq
| le
| lt
| ne
-- lt: a < b ↔ a + 1 ≤ b
-- a ≠ b: (a < b ∨ b < a)
deriving DecidableEq, Repr, Inhabited, Lean.ToExpr

inductive BoolBinaryRelationKind
| eq
deriving DecidableEq, Repr, Inhabited, Lean.ToExpr

inductive BinaryRelationKind
| eq
| ne
| ule
| slt
| sle
| ult -- unsigned less than.
deriving DecidableEq, Repr, Inhabited, Lean.ToExpr

inductive WidthExpr where
| const : Nat → WidthExpr
| var : Nat → WidthExpr
| max : WidthExpr → WidthExpr → WidthExpr
| min : WidthExpr → WidthExpr → WidthExpr
| addK : WidthExpr → Nat → WidthExpr
| kadd : (k : Nat) → (v : WidthExpr) → WidthExpr
deriving Inhabited, Repr, Hashable, DecidableEq, Lean.ToExpr

open Std Lean in
def WidthExpr.toSexpr : WidthExpr → Sexpr
| .const n => (Sexpr.array #[.atom "wconst", .atomOf n])
| .var v => (Sexpr.array #[.atom "wvar", .atomOf v])
| .max v w => Sexpr.array #[
    Sexpr.atom "max",
    v.toSexpr,
    w.toSexpr
  ]
| .min v w => Sexpr.array #[
    Sexpr.atom "min",
    v.toSexpr,
    w.toSexpr
  ]
| .addK v k => Sexpr.array #[
    Sexpr.atom "addK",
    v.toSexpr,
    .atomOf k
  ]
| .kadd k v => Sexpr.array #[
    Sexpr.atom "kadd",
    .atomOf k,
    v.toSexpr
  ]

instance : ToSexpr WidthExpr where
  toSexpr := WidthExpr.toSexpr

inductive Term
| ofNat (w : WidthExpr) (n : Nat) : Term
| var (v : Nat) (w : WidthExpr) : Term
| add (w : WidthExpr) (a b : Term) : Term
| zext (a : Term) (wnew : WidthExpr) : Term
| setWidth (a : Term) (wnew : WidthExpr) : Term
| sext (a : Term) (wnew : WidthExpr) : Term
| bor (w : WidthExpr) (a b : Term) : Term
| band (w : WidthExpr) (a b : Term) : Term
| bxor (w : WidthExpr) (a b : Term) : Term
| bnot (w : WidthExpr)  (a : Term) : Term
| mul (w : WidthExpr) (a b : Term) : Term
| udiv (w : WidthExpr) (a b : Term) : Term
| umod (w : WidthExpr) (a b : Term) : Term
| boolVar (v : Nat) : Term
| boolConst (b : Bool) : Term
| shiftl (w : WidthExpr) (a : Term) (k : Nat) : Term
| junk (s : String)  : Term -- junk unknown stuff
deriving DecidableEq, Inhabited, Repr, Lean.ToExpr

def Term.toSexpr : Term → Sexpr
| .mul w a b => Sexpr.array #[
    Sexpr.atom "mul",
    w.toSexpr,
    a.toSexpr,
    b.toSexpr
  ]
| .udiv w a b => Sexpr.array #[
    Sexpr.atom "udiv",
    w.toSexpr,
    a.toSexpr,
    b.toSexpr
  ]
| .umod w a b => Sexpr.array #[
    Sexpr.atom "umod",
    w.toSexpr,
    a.toSexpr,
    b.toSexpr
  ]
| .shiftl w a k => Sexpr.array #[
    Sexpr.atom "shiftl",
    w.toSexpr,
    a.toSexpr,
    .atomOf k
  ]
| .setWidth a w => Sexpr.array #[
    Sexpr.atom "setwidth",
    a.toSexpr,
    w.toSexpr
  ]
| .ofNat w n => Sexpr.array #[
    Sexpr.atom "ofNat",
    w.toSexpr,
    .atomOf n
  ]
| .var v w => Sexpr.array #[
    Sexpr.atom "bvvar",
    .atomOf v,
    w.toSexpr
  ]
| .add w a b => Sexpr.array #[
    Sexpr.atom "add",
    w.toSexpr,
    a.toSexpr,
    b.toSexpr
  ]
| .zext a wnew => Sexpr.array #[
    Sexpr.atom "zext",
    a.toSexpr,
    wnew.toSexpr
  ]
| .sext a wnew => Sexpr.array #[
    Sexpr.atom "sext",
    a.toSexpr,
    wnew.toSexpr
  ]
| .bor w a b => Sexpr.array #[
    Sexpr.atom "bor",
    w.toSexpr,
    a.toSexpr,
    b.toSexpr
  ]
| .band w a b => Sexpr.array #[
    Sexpr.atom "band",
    w.toSexpr,
    a.toSexpr,
    b.toSexpr
  ]
| .bxor w a b => Sexpr.array #[
    Sexpr.atom "bxor",
    w.toSexpr,
    a.toSexpr,
    b.toSexpr
  ]
| .bnot w a => Sexpr.array #[
    Sexpr.atom "bnot",
    w.toSexpr,
    a.toSexpr
  ]
| .boolVar v => Sexpr.array #[
    Sexpr.atom "boolvar",
    .atomOf v
  ]
| .boolConst b => Sexpr.array #[
    Sexpr.atom "boolConst",
    .atomOf b
  ]
| .junk f => Sexpr.array #[
    Sexpr.atom "bvjunk",
    .atomOf f
  ]

instance : ToSexpr Term where
  toSexpr := Term.toSexpr


inductive Predicate
| binWidthRel (k : WidthBinaryRelationKind) (wa wb : WidthExpr) : Predicate
| binRel (k : BinaryRelationKind) (w : WidthExpr)
    (a : Term) (b : Term) : Predicate
| or (p1 p2 : Predicate) : Predicate
| and (p1 p2 : Predicate) : Predicate
| eq (p1 p2 : Predicate) : Predicate -- WTF?
| xor (p1 p2 : Predicate) : Predicate -- WTF?
| var (v : Nat) : Predicate
| boolBinRel (k : BoolBinaryRelationKind)
    (a b : Term) : Predicate
| not (p : Predicate) : Predicate
| boolConstPred (b : Bool) : Predicate
| ite (cond : Predicate) (thenP : Predicate) (elseP : Predicate) : Predicate
| junk (s : String)  : Predicate -- junk unknown stuff
deriving DecidableEq, Inhabited, Repr, Lean.ToExpr


def Predicate.toSexpr : Predicate → Sexpr
| .binWidthRel k wa wb =>
  match k with
  | .eq => Sexpr.array #[
      Sexpr.atom "weq",
      wa.toSexpr,
      wb.toSexpr
    ]
  | .le => Sexpr.array #[
      Sexpr.atom "wle",
      wa.toSexpr,
      wb.toSexpr
    ]
  | .lt => Sexpr.array #[
      Sexpr.atom "wlt",
      wa.toSexpr,
      wb.toSexpr
    ]
  | .ne =>  Sexpr.array #[
      Sexpr.atom "wne",
      wa.toSexpr,
      wb.toSexpr
    ]
| .binRel k w a b =>
  match k with
  | .eq => Sexpr.array #[
      Sexpr.atom "bveq",
      w.toSexpr,
      a.toSexpr,
      b.toSexpr
    ]
  | .ne => Sexpr.array #[
      Sexpr.atom "bvne",
      w.toSexpr,
      a.toSexpr,
      b.toSexpr
    ]
  | .ult => Sexpr.array #[
      Sexpr.atom "bvult",
      w.toSexpr,
      a.toSexpr,
      b.toSexpr
    ]
  | .ule => Sexpr.array #[
      Sexpr.atom "bvule",
      w.toSexpr,
      a.toSexpr,
      b.toSexpr
    ]
  | .slt => Sexpr.array #[
      Sexpr.atom "bvslt",
      w.toSexpr,
      a.toSexpr,
      b.toSexpr
    ]
  | .sle => Sexpr.array #[
      Sexpr.atom "bvsle",
      w.toSexpr,
      a.toSexpr,
      b.toSexpr
    ]
| .or p1 p2 => Sexpr.array #[
    Sexpr.atom "por",
    p1.toSexpr,
    p2.toSexpr
  ]
| .and p1 p2 => Sexpr.array #[
    Sexpr.atom "pand",
    p1.toSexpr,
    p2.toSexpr
  ]
| .eq p1 p2 => Sexpr.array #[
    Sexpr.atom "peq",
    p1.toSexpr,
    p2.toSexpr
  ]
| .xor p1 p2 => Sexpr.array #[
    Sexpr.atom "pxor",
    p1.toSexpr,
    p2.toSexpr
  ]
| .var v => Sexpr.array #[
    Sexpr.atom "pvar",
    .atomOf v
  ]
| .boolBinRel k a b =>
  match k with
  | .eq => Sexpr.array #[
      Sexpr.atom "boolEq",
      a.toSexpr,
      b.toSexpr
   ]
| .not p => Sexpr.array #[
    Sexpr.atom "pnot",
    p.toSexpr
  ]
| .ite cond thenP elseP => Sexpr.array #[
    Sexpr.atom "pite",
    cond.toSexpr,
    thenP.toSexpr,
    elseP.toSexpr
  ]
| .boolConstPred b => Sexpr.array #[
    Sexpr.atom "pBoolConst",
    .atomOf b
  ]
| .junk f =>
  Sexpr.array #[
    Sexpr.atom "pjunk",
    .atomOf f
  ]
end SexprPBV
