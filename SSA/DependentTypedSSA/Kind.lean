namespace AST

/-
Kinds of values. We must have 'pair' to take multiple arguments.
-/
inductive Kind where
  | int : Kind
  | nat : Kind
  | float : Kind
  | pair : Kind → Kind → Kind
  | arrow : Kind → Kind → Kind
  | unit: Kind
  deriving Inhabited, DecidableEq, BEq

instance : ToString Kind where
  toString k :=
    let rec go : Kind → String
    | .nat => "nat"
    | .int => "int"
    | .float => "float"
    | .unit => "unit"
    | .pair p q => s!"{go p} × {go q}"
    | .arrow p q => s!"{go p} → {go q}"
    go k

-- compile time constant values.
inductive Const : (k : Kind) → Type where
  | int : Int → Const Kind.int
  | float : Float → Const Kind.float
  | unit : Const Kind.unit
  | pair {k₁ k₂} : Const k₁ → Const k₂ → Const (Kind.pair k₁ k₂)
  deriving BEq

instance {k : Kind} : ToString (Const k) where
  toString :=
    let rec go (k : Kind) : Const k → String
    | .int i => toString i
    | .float f => toString f
    | .unit => "()"
    | .pair p q => s!"({go _ p}, {go _ q})"
    go k

-- Lean type that corresponds to kind.
@[reducible, simp]
def Kind.eval: Kind → Type
  | .int => Int
  | .nat => Nat
  | .unit => Unit
  | .float => Float
  | .pair p q => p.eval × q.eval
  | .arrow p q => p.eval → q.eval

end AST