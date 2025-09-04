import Lean.Meta.ForEachExpr
import Blase.SingleWidth.Defs

open Lean in
def mkBoolLit (b : Bool) : Expr :=
  match b with
  | true => mkConst ``true
  | false => mkConst ``false

open Lean in
def Term.quote (t : _root_.Term) : Expr :=
  match t with
  | ofNat n => mkApp (mkConst ``Term.ofNat) (mkNatLit n)
  | var n => mkApp (mkConst ``Term.var) (mkNatLit n)
  | zero => mkConst ``Term.zero
  | one => mkConst ``Term.one
  | negOne => mkConst ``Term.negOne
-- | decr t => mkApp (mkConst ``Term.decr) (t.quote)
  -- | incr t => mkApp (mkConst ``Term.incr) (t.quote)
  | neg t => mkApp (mkConst ``Term.neg) (t.quote)
  | not t => mkApp (mkConst ``Term.not) (t.quote)
  | sub t₁ t₂ => mkApp2 (mkConst ``Term.sub) (t₁.quote) (t₂.quote)
  | add t₁ t₂ => mkApp2 (mkConst ``Term.add) (t₁.quote) (t₂.quote)
  | xor t₁ t₂ => mkApp2 (mkConst ``Term.xor) (t₁.quote) (t₂.quote)
  | or t₁ t₂ => mkApp2 (mkConst ``Term.or) (t₁.quote) (t₂.quote)
  | and t₁ t₂ => mkApp2 (mkConst ``Term.and) (t₁.quote) (t₂.quote)
  | shiftL t₁ n => mkApp2 (mkConst ``Term.shiftL) (t₁.quote) (mkNatLit n)

open Lean in
def mkConstBin (atp : Name) : Expr :=
  mkApp (mkConst ``Predicate.binary) (mkConst atp)

open Lean in
def Predicate.quote (p : Predicate) : Expr :=
  match p with
  | .width .eq n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.eq) (mkNatLit n)
  | .width .neq n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.neq) (mkNatLit n)
  | .width .lt n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.lt) (mkNatLit n)
  | .width .le n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.le) (mkNatLit n)
  | .width .gt n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.gt) (mkNatLit n)
  | .width .ge n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.ge) (mkNatLit n)
  | .binary .eq a b => mkApp2 (mkConstBin ``BinaryPredicate.eq) (Term.quote a) (Term.quote b)
  | .binary .neq a b => mkApp2 (mkConstBin ``BinaryPredicate.neq) (Term.quote a) (Term.quote b)
  | .binary .ult a b => mkApp2 (mkConstBin ``BinaryPredicate.ult) (Term.quote a) (Term.quote b)
  | .binary .ule a b => mkApp2 (mkConstBin ``BinaryPredicate.ule) (Term.quote a) (Term.quote b)
  | .binary .slt a b => mkApp2 (mkConstBin ``BinaryPredicate.slt) (Term.quote a) (Term.quote b)
  | .binary .sle a b => mkApp2 (mkConstBin ``BinaryPredicate.sle) (Term.quote a) (Term.quote b)
  | land p q => mkApp2 (mkConst ``Predicate.land) (Predicate.quote p) (Predicate.quote q)
  | lor p q => mkApp2 (mkConst ``Predicate.lor) (Predicate.quote p) (Predicate.quote q)


def Reflect.Map.empty : List (BitVec w) := []

def Reflect.Map.append (w : Nat) (s : BitVec w)  (m : List (BitVec w)) : List (BitVec w) := m.append [s]

def Reflect.Map.get (ix : ℕ) (_ : BitVec w)  (m : List (BitVec w)) : BitVec w := m[ix]!
