/-
## Pattern matching against MLIR programs

This file implements support for a basic matching system. This system is used
in the framework to concisely express syntactic constraints on operations that
can be resolved by unification. While this cannot express anywhere near all the
constraints, it simplifies the most common ones a great deal.

TODO: Provide the matcher
-/

import MLIR.Semantics.Types
import MLIR.Dialects.BuiltinModel
import MLIR.AST
import MLIR.EDSL
open MLIR.AST

/-
### Match term syntax

We have different sorts (operations, values, types, attributes, etc) with typed
variables. This allows us to know types everywhere in terms, and thus avoid
typing mishaps due to bugs (which would be hard to debug), even if we only have
one type for all terms.

Unlike usual first-order matching and unification, we don't have a deeply
recursive structure, and instead mostly rely on having independent equations to
match complex patterns.

We assign *substitution priority levels* to variables in the form of natural
numbers. Lower values indicate variables that have been introduced by the user,
while higher values are assigned to automatically-generated variables. When a
substitution occurs, we always substitute variables with higher priority so
that user-assigned names are preserved.
-/

inductive MSort :=
  -- An MLIR operation. Matches against [Op δ]
  | MOp
  -- An operation parameter. Matches against (SSAVal × MLIRType δ)
  | MOperand
  -- An MLIR type. Matches against [MLIRType δ]
  | MMLIRType
  -- A value. Matches against [SSAVal]
  | MSSAVal
  -- An attribute. Matches against [AttrVal δ]
  | MAttrValue
  -- A natural number (typically int/float bit size). Matches against [Nat]
  | MNat
  -- A string (in operation names). Matches against [String]
  | MString
  -- A dimension (in a vector/tensor). Matches against [Dimension]
  | MDimension
  -- A signedness specification (in integers). Matches against [Signedness]
  | MSignedness
  -- A homogeneous list of objects
  | MList (s: MSort)

inductive MCtor: List MSort → MSort → Type :=
  -- Integer type
  | INT: MCtor [.MSignedness, .MNat] .MMLIRType
  -- Tensor type
  | TENSOR: MCtor [.MList .MDimension, .MMLIRType] .MMLIRType
  -- Operation with known or unknown mnemonic (TODO: MCtor.OP: unfinished)
  | OP: MCtor [.MString, .MList .MOperand, .MList .MOperand] .MOp
  -- Operation argument of return value
  | OPERAND: MCtor [.MSSAVal, .MMLIRType] .MOperand

  -- SPECIAL CASE: We treat LIST specially in inferSort, to allow variadic
  -- arguments without specifying it here
  | LIST (s: MSort): MCtor [] (.MList s)

inductive MTerm (δ: Dialect α σ ε) :=
  -- A typed variable
  | Var (priority: Nat := 0) (name: String) (s: MSort)
  -- A constructor. We allow building mistyped terms (but check them later)
  | App {args_sort: List MSort} {ctor_sort: MSort}
        (ctor: MCtor args_sort ctor_sort) (args: List (MTerm δ))
  -- Constants
  | ConstMLIRType (τ: MLIRType δ)
  | ConstNat (n: Nat)
  | ConstString (s: String)
  | ConstDimension (d: Dimension)
  | ConstSignedness (sgn: Signedness)

-- Accessors

def MCtor.name {s₁ s₂}: MCtor s₁ s₂ → String
  | LIST _  => "LIST"
  | INT     => "INT"
  | TENSOR  => "TENSOR"
  | OP      => "OP"
  | OPERAND => "OPERAND"

-- Common instances

deriving instance Inhabited for MSort
deriving instance Inhabited for MTerm

deriving instance DecidableEq for MCtor
deriving instance DecidableEq for MSort

def MCtor.eq {args_sort₁ ctor_sort₁ args_sort₂ ctor_sort₂}:
    MCtor args_sort₁ ctor_sort₁ → MCtor args_sort₂ ctor_sort₂ → Bool :=
  fun c₁ c₂ =>
    if H: args_sort₁ = args_sort₂ ∧ ctor_sort₁ = ctor_sort₂ then
      cast (by simp [H.1, H.2]) c₁ = c₂
    else
      false

mutual
def MTerm.eq (t₁ t₂: MTerm δ): Bool :=
  match t₁, t₂ with
  | Var _ name₁ s₁, Var _ name₂ s₂ =>
      name₁ = name₂ && s₁ = s₂
  | App ctor₁ args₁, App ctor₂ args₂ =>
      MCtor.eq ctor₁ ctor₂ && eqList args₁ args₂
  | _, _ => false

def MTerm.eqList (l₁ l₂: List (MTerm δ)): Bool :=
  match l₁, l₂ with
  | [], [] => true
  | t₁::l₁, t₂::l₂ => eq t₁ t₂ && eqList l₁ l₂
  | _, _ => false
end
termination_by
  MTerm.eq t1 t2 => sizeOf t1 + sizeOf t2
  MTerm.eqList t1 t2 => sizeOf t1 + sizeOf t2

instance: BEq (MTerm δ) where
  beq := MTerm.eq

def MSort.str: MSort → String
  | .MOp         => "Op"
  | .MOperand    => "Operand"
  | .MMLIRType   => "MLIRType"
  | .MSSAVal     => "SSAVal"
  | .MAttrValue  => "AttrValue"
  | .MNat        => "Nat"
  | .MString     => "String"
  | .MDimension  => "Dimension"
  | .MSignedness => "Signedness"
  | .MList s     => "[" ++ s.str ++ "]"

mutual
def MTerm.str: MTerm δ → String
  -- Short notations for common sorts of variables
  | .Var _ name .MMLIRType => "!" ++ name
  | .Var _ name .MSSAVal => "%" ++ name
  -- General notation
  | .Var _ name s => "name:" ++ s.str
  | .App ctor args => ctor.name ++ " [" ++ MTerm.strList args ++ "]"
  -- Constants
  | ConstMLIRType c
  | ConstNat c
  | ConstString c
  | ConstDimension c
  | ConstSignedness c =>
      toString c

protected def MTerm.strList: List (MTerm δ) → String
  | [] => ""
  | [t] => str t
  | t::ts => str t ++ ", " ++ MTerm.strList ts
end
termination_by
  MTerm.str t  => sizeOf t
  MTerm.strList ts => sizeOf ts


instance: ToString MSort where
  toString := MSort.str
instance: ToString (MTerm δ) where
  toString := MTerm.str

-- Collect variables in a term
def MTerm.vars: MTerm δ → List String
  | .Var _ name _ => [name]
  | .App ctor [] => []
  | .App ctor (arg::args) =>
      vars arg ++ vars (.App ctor args)
  | _ => []

-- Collect variables and their sorts
def MTerm.varsWithSorts: MTerm δ → List (String × MSort)
  | .Var _ name sort => [(name, sort)]
  | .App ctor [] => []
  | .App ctor (arg::args) =>
      varsWithSorts arg ++ varsWithSorts (.App ctor args)
  | _ => []

-- Check whether a variable occurs in a term. We don't check typing here since
-- we have a common pool of unique variable names.
def MTerm.occurs (name: String): MTerm δ→ Bool
  | .Var _ name' _ => name' = name
  | .App ctor [] => false
  | .App ctor (arg::args) =>
      occurs name arg || occurs name (.App ctor args)
  | _ => false

-- Substitute a variable in a term
mutual
def MTerm.subst (t: MTerm δ) (name: String) (repl: MTerm δ): MTerm δ :=
  match t with
  | .Var _ name' _ => if name' = name then repl else t
  | .App ctor args => .App ctor (MTerm.substList args name repl)
  | t => t

protected def MTerm.substList (l: List (MTerm δ)) (name: String)
                              (repl: MTerm δ) : List (MTerm δ) :=
  match l with
  | [] => []
  | t::ts => subst t name repl :: MTerm.substList ts name repl
end
termination_by
  MTerm.subst t name repl  => sizeOf t
  MTerm.substList ts name repl => sizeOf ts

-- Substitue a set of variables in a term
def MTerm.substVars (t: MTerm δ) (repl: List (String × MTerm δ)): MTerm δ :=
  repl.foldl (fun t (name, repl) => t.subst name repl) t

/-
### Sort inference

In order to ensure we only manipulate well typed match terms and equalities
despite mixing constructors, we aggressively check typing during matching and
unification.
-/

mutual
variable {δ: Dialect α σ ε} -- We need this for termination somehow

def MTerm.inferSort: MTerm δ → Option MSort
  | Var _ _ s => some s
  | App (.LIST s) args => do
      let l ← inferSortList args
      if l.all (· = s) then some (.MList s) else none
  | @App _ _ _ _ args_sort ctor_sort ctor args =>
      if args.length != args_sort.length then
        none
      else if inferSortList args |>.isEqSome args_sort then
        some ctor_sort
      else
        none
  | ConstMLIRType _     => some .MMLIRType
  | ConstNat _          => some .MNat
  | ConstString _       => some .MString
  | ConstDimension _    => some .MDimension
  | ConstSignedness _   => some .MSignedness

def MTerm.inferSortList: List (MTerm δ) → Option (List MSort)
  | [] => some []
  | t::l => do return (← inferSort t) :: (← inferSortList l)
end
termination_by
  MTerm.inferSort t => sizeOf t
  MTerm.inferSortList ts => sizeOf ts

@[reducible]
def MSort.toType (δ: Dialect α σ ε): MSort -> Type
| .MOp => Bool -- TODO MLIR.AST.BasicBlockStmt δ
| .MOperand => MLIR.AST.SSAVal × MLIR.AST.MLIRType δ
| .MMLIRType => MLIR.AST.MLIRType δ
| .MSSAVal => MLIR.AST.SSAVal
| .MAttrValue => Bool -- TODO MLIR.AST.AttrValue δ
| .MNat => Nat
| .MString => String
| .MDimension => Dimension
| .MSignedness => MLIR.AST.Signedness
| .MList mTerm => List (mTerm.toType δ)

def MSort_toType_decEq {δ: Dialect α σ ε} (s: MSort)
    : DecidableEq (s.toType δ) :=
  match s with
  | .MOp => decEq
  | .MOperand => decEq
  | .MMLIRType => decEq
  | .MSSAVal => decEq
  | .MAttrValue => decEq
  | .MNat => decEq
  | .MString => decEq
  | .MDimension => decEq
  | .MSignedness => decEq
  | .MList term => @List.hasDecEq _ (MSort_toType_decEq term)

instance {δ: Dialect α σ ε} (s: MSort): DecidableEq (s.toType δ) :=
  MSort_toType_decEq s

/-
### Variable context for MTerms

This structure contains an assignment from MTerm variables to concrete
structures. It is used both for matching, and for concretizing MTerms into
concrete strucctures.
-/

-- Matching context. Contains the assignment of matching variables.
abbrev VarCtx (δ: Dialect α σ ε) :=
  List ((s: MSort) × List (String × (s.toType δ)))

-- Get the assignment of a variable.
def VarCtx.get (ctx: VarCtx δ) (s: MSort) (name: String) :
    Option (s.toType δ) :=
  match ctx with
  | ⟨so, sortCtx⟩::ctx' =>
    match H: so == s with
    | false => get ctx' s name
    | true => do
      let res ← List.find? (·.fst == name) ((of_decide_eq_true H) ▸ sortCtx)
      return res.snd
  | [] => none

-- Assign a variable.
def VarCtx.set (ctx: VarCtx δ) (s: MSort) (name: String) (value: s.toType δ):
    VarCtx δ :=
  match ctx with
  | ⟨so, sortCtx⟩::ctx' =>
    match H: so == s with
    | false => ⟨so, sortCtx⟩::(set ctx' s name value)
    | true => ⟨so, (name, (of_decide_eq_true H) ▸ value)::sortCtx⟩::ctx'
  | [] => [{fst := s, snd := [(name, value)]}]

/-
### Concretization of MTerm

This section defines some functions to transform a MTerm into some
concrete structure, given a variable context.
-/

-- We provide an expected sort, since we do not want to carry the
-- proof that terms are well typed.
def MTerm.concretizeVariable (m: MTerm δ) (s: MSort) (ctx: VarCtx δ) :
    Option (s.toType δ) :=
  match m with
  | Var _ name sort =>
    if s == sort then ctx.get s name else none
  | _ => none

def MTerm.concretizeSign (m: MTerm δ) (ctx: VarCtx δ) : Option Signedness :=
  match m with
  | Var _ _ _ => m.concretizeVariable .MSignedness ctx
  | ConstSignedness s => some s
  | _ => none

def MTerm.concretizeNat (m: MTerm δ) (ctx: VarCtx δ) : Option Nat :=
  match m with
  | Var _ _ _ => m.concretizeVariable .MNat ctx
  | ConstNat n => some n
  | _ => none

def MTerm.concretizeDim (m: MTerm δ) (ctx: VarCtx δ) : Option Dimension :=
  match m with
  | Var _ _ _ => m.concretizeVariable .MDimension ctx
  | ConstDimension d => some d
  | _ => none

def MTerm.concretizeType (m: MTerm δ) (ctx: VarCtx δ) :
    Option (MLIR.AST.MLIRType δ) :=
  match m with
  | Var _ _ _ => m.concretizeVariable .MMLIRType ctx
  | .App .INT [mSign, mNat] => do
    let sign ← mSign.concretizeSign ctx
    let nat ← mNat.concretizeNat ctx
    return MLIRType.int sign nat
  | _ => none

def MTerm.concretizeOperand (m: MTerm δ) (ctx: VarCtx δ) :
    Option (MLIR.AST.SSAVal × MLIR.AST.MLIRType δ) :=
  match m with
  | Var _ _ _ => m.concretizeVariable .MOperand ctx
  | .App .OPERAND [mVal, mType] => do
    let val ← mVal.concretizeVariable .MSSAVal ctx
    let type ← mType.concretizeType ctx
    return (val, type)
  | _ => none

def MTerm.concretizeOperands (m: MTerm δ) (ctx: VarCtx δ) :
    Option (List (MLIR.AST.TypedSSAVal δ)) :=
  match m with
  | .App (.LIST .MOperand) l => l.mapM (fun m' => m'.concretizeOperand ctx)
  | _ => none

def MTerm.concretizeOp (m: MTerm δ) (ctx: VarCtx δ) : Option (Op δ) :=
  match m with
  | .App .OP [ .ConstString mName, mOperands, mRes ] => do
    let operands ← MTerm.concretizeOperands mOperands ctx
    let res ← MTerm.concretizeOperands mRes ctx
    match res with
    | [resVal] =>
      return .mk mName [resVal] operands .regionsnil (AttrDict.mk [])
    | _ => none
  | _ => none

def MTerm.concretizeProg (m: List (MTerm δ)) (ctx: VarCtx δ) :
    Option (List (Op δ)) :=
  m.mapM (fun m' => m'.concretizeOp ctx)

/-
### Simple MTerm matching

This section defines functions to match an MTerm with a concrete structure.
Note that here, the matching does not match recursively inside the concrete
structure.
-/

-- Match a MTerm variable.
def matchVariable {δ: Dialect α σ ε} (s: MSort) (name: String)
                  (val: s.toType δ) (ctx: VarCtx δ) : Option (VarCtx δ) :=
  match ctx.get s name with
  | some matchedVal => if val == matchedVal then some ctx else none
  | none => some (ctx.set s name val)

-- Match a signedness with a MTerm.
def matchMSignedness {δ: Dialect α σ ε} (mSgn: MTerm δ) (sgn: Signedness)
                     (ctx: VarCtx δ): Option (VarCtx δ) :=
  match mSgn with
  | .Var _ name .MSignedness => matchVariable .MSignedness name sgn ctx
  | .ConstSignedness mSgn => if sgn == mSgn then some ctx else none
  | _ => none

-- Match a dimension with a MTerm.
def matchMDimension {δ: Dialect α σ ε} (mDim: MTerm δ) (dim: Dimension)
                    (ctx: VarCtx δ): Option (VarCtx δ) :=
  match mDim with
  | .Var _ name .MDimension => matchVariable .MDimension name dim ctx
  | .ConstDimension mDim => if dim == mDim then some ctx else none
  | _ => none

-- Match a string with a MTerm.
def matchMString {δ: Dialect α σ ε} (mStr: MTerm δ) (str: String)
                 (ctx: VarCtx δ): Option (VarCtx δ) :=
  match mStr with
  | .Var _ name .MString => matchVariable .MString name str ctx
  | .ConstString mStr => if str == mStr then some ctx else none
  | _ => none

-- Match a nat with a MTerm.
def matchMNat {δ: Dialect α σ ε} (mNat: MTerm δ) (nat: Nat)
              (ctx: VarCtx δ): Option (VarCtx δ) :=
  match mNat with
  | .Var _ name .MNat => matchVariable .MNat name nat ctx
  | .ConstNat mNat => if nat == mNat then some ctx else none
  | _ => none

-- Match a type with a MTerm.
def matchMType (mType: MTerm δ) (type: MLIRType δ)
               (ctx: VarCtx δ): Option (VarCtx δ) :=
  match mType, type with
  | .Var _ name .MMLIRType, _ => matchVariable .MMLIRType name type ctx
  | .ConstMLIRType mType, _ => if type == mType then some ctx else none
  | .App .INT [mSgn, mNat], MLIRType.int sgn nat =>
    (matchMSignedness mSgn sgn ctx).bind (matchMNat mNat nat ·)
  | _, _ => none

-- Match a type SSA value with a MTerm.
def matchMSSAVal (mOperand: MTerm δ) (operand: TypedSSAVal δ)
                  (ctx: VarCtx δ) : Option (VarCtx δ) :=
  match mOperand with
  | .App .OPERAND [.Var _ ssaName .MSSAVal, mType] => do
    let ctx' ← matchMType mType operand.snd ctx
    matchVariable MSort.MSSAVal ssaName operand.fst ctx'
  | _ => none

-- Match a list of typed SSA values with a list of MTerm.
def matchMSSAVals (operands: List (TypedSSAVal δ)) (mOperands: List (MTerm δ))
    (ctx: VarCtx δ): Option (VarCtx δ) :=
  match operands, mOperands with
  | [], [] => some ctx
  | operand::operands, mOperand::mOperands => do
    let ctx' ← matchMSSAVal mOperand operand ctx
    matchMSSAVals operands mOperands ctx'
  | _, _ => none

-- Match a basic block statement with an MTerm.
def matchMOp (op: Op δ) (mterm: MTerm δ) (ctx: VarCtx δ) : Option (VarCtx δ) :=
  match op, mterm with
  | Op.mk name res operands .regionsnil (AttrDict.mk []),
    .App .OP [ .ConstString mName, .App (.LIST .MOperand) mOperands,
      .App (.LIST .MOperand) mRes ] =>
    if name != mName then
      none
    else
      (matchMSSAVals operands mOperands ctx).bind
      (matchMSSAVals res mRes ·)
  | _, _ => none

/-
### Recursive MTerm op matching

This section defines functions to match an op MTerm inside a concrete
structure. Here, the matching is done recursively inside the regions/BBs/Ops.

We first define functions that match all possible ops in the IR. Then, we use
this to match a program in an IR.
-/

mutual
-- Get all possible operations matching an MTerm in an op.
def matchAllMOpInOp (op: Op δ) (mOp: MTerm δ) (ctx: VarCtx δ)
    : List (Op δ × VarCtx δ) :=
  match op with
  | .mk _ _ _ regions _ =>
    let nextMatches := matchAllMOpInRegions regions mOp ctx
    match matchMOp op mOp ctx with
    | some ctx' => (op, ctx')::nextMatches
    | none => nextMatches

-- Get all possible operations matching an MTerm in a list of ops.
def matchAllMOpInOps (ops: (Ops δ)) (mOp: MTerm δ)
                     (ctx: VarCtx δ) : List (Op δ × VarCtx δ) :=
  match ops with
  | .opscons op ops' => (matchAllMOpInOp op mOp ctx).append
    (matchAllMOpInOps ops' mOp ctx)
  | .opsnil => []

-- Get all possible operations matching an MTerm in a basic block.
def matchAllMOpInRegion (rgn: Region δ) (mOp: MTerm δ)
                    (ctx: VarCtx δ) : List (Op δ × VarCtx δ) :=

  match rgn with
  | .mk _ _ ops => matchAllMOpInOps ops mOp ctx

-- Get all possible operations matching an MTerm in a list of regions.
def matchAllMOpInRegions (regions: (Regions δ)) (mOp: MTerm δ)
                         (ctx: VarCtx δ) :
    List (Op δ × VarCtx δ) :=
  match regions with
  | .regionscons region regions' => (matchAllMOpInRegion region mOp ctx).append
    (matchAllMOpInRegions regions' mOp ctx)
  | .regionsnil => []
end
termination_by
  matchAllMOpInOp op _ _ => sizeOf op
  matchAllMOpInOps ops _ _ => sizeOf ops
  matchAllMOpInRegion region _ _ => sizeOf region
  matchAllMOpInRegions regions _ _ => sizeOf regions

mutual
variable {δ: Dialect α σ ε} -- We need this for termination somehow

#check Preorder
-- Match a program defined by a list of MTerm (one Operation per MTerm) in
-- an operation.
def matchMProgInOp (op: Op δ) (mOps: List (MTerm δ)) (ctx: VarCtx δ) :
    Option ((List (Op δ)) × VarCtx δ) :=
  match mOps with
  -- Try all matches of the first operation.
  | mOp::mOps' =>
    matchMProgInOpAux op mOps' (matchAllMOpInOp op mOp ctx)
  | [] => some ([], ctx)

-- Match a program defined by a list of MTerm (one Operation per MTerm) in
-- an operation. `matchOps` correspond to the possible matches of the current
-- MTerm being matched.
def matchMProgInOpAux (op: Op δ) (mOps: List (MTerm δ))
                      (matchOps: List (Op δ × VarCtx δ))
                      : Option (List (Op δ) × VarCtx δ) :=
  -- For all possible match, we check if we can match the remaining of the
  -- program with the match assignment
  match matchOps with
  | (matchOp, ctx')::matchOps' =>
    match matchMProgInOp op mOps ctx' with
    -- If we do match the remaining of the program, we are finished.
    | some (matchedOps, ctx'') => some (matchOp::matchedOps, ctx'')
    -- Otherwise, we check the next match for the current operation.
    | none => matchMProgInOpAux op mOps matchOps'
  | [] => none
end

decreasing_by sorry
/-
termination_by
  matchMProgInOpAux _ mOps matchOps => sizeOf (mOps, matchOps)
  matchMProgInOp _ mOps ctx  =>
    sizeOf (mOps, let t : List (Op δ × VarCtx δ) := []; t)
-/

-- variable type
def MTerm.buildTypeVar (name: String) : MTerm δ := .Var 2 name .MMLIRType
-- constant type

def MTerm.buildTypeConst (type: MLIRType δ) : MTerm δ := .ConstMLIRType type

-- operand. For now, assume monomorhpic types.
def MTerm.buildOperand (name: String) (type: MLIRType δ): MTerm δ :=
  .App .OPERAND [ .Var (priority := 2) name .MSSAVal,
                  MTerm.buildTypeConst type ]

def MTerm.buildOp (name: String) (args: List (MTerm δ)) (res: List (MTerm δ)) :
    MTerm δ :=
  .App .OP [ .ConstString name, .App (.LIST .MOperand) args,
    .App (.LIST .MOperand) res ]

private def test_addi_multiple_pattern: List (MTerm δ) :=
  [.App .OP [
    .ConstString "std.addi",
    .App (.LIST .MOperand) [
      .App .OPERAND [.Var 2 "op_x" .MSSAVal, .Var 2 "T" .MMLIRType],
      .App .OPERAND [.Var 2 "op_y" .MSSAVal, .Var 2 "T" .MMLIRType]],
    .App (.LIST .MOperand) [
      .App .OPERAND [.Var 2 "op_res" .MSSAVal, .Var 2 "T" .MMLIRType]]
  ],
  .App .OP [
    .ConstString "std.addi",
    .App (.LIST .MOperand) [
      .App .OPERAND [.Var 2 "op_res" .MSSAVal, .Var 2 "T" .MMLIRType],
      .App .OPERAND [.Var 2 "op_res" .MSSAVal, .Var 2 "T" .MMLIRType]],
    .App (.LIST .MOperand) [
      .App .OPERAND [.Var 2 "op_res2" .MSSAVal, .Var 2 "T" .MMLIRType]]
  ]]

private def multiple_example: Op builtin := [mlir_op|
  "builtin.module"() ({
    ^entry:
    %r2 = "std.addi"(%t2, %t3): (i32, i32) -> i32
    %r = "std.addi"(%t0, %t1): (i32, i32) -> i32
    %r3 = "std.addi"(%r, %r): (i32, i32) -> i32
  }) : () -> ()
]

private def test_addi_one: MTerm δ :=
  (.App .OP [
    .ConstString "std.addi",
    .App (.LIST .MOperand) [
      .App .OPERAND [.Var 2 "op_x" .MSSAVal, .Var 2 "T" .MMLIRType],
      .App .OPERAND [.Var 2 "op_y" .MSSAVal, .Var 2 "T" .MMLIRType]],
    .App (.LIST .MOperand) [
      .App .OPERAND [.Var 2 "op_res" .MSSAVal, .Var 2 "T" .MMLIRType]]
  ])

private def one_example: Op builtin := [mlir_op|
    %r2 = "std.addi"(%t2, %t3): (i32, i32) -> i32
]

-- Match an MTerm program in some IR, then concretize
-- the MTerm using the resulting matching context.
def multiple_example_result : Option (List (Op builtin)) := do
  let (_, ctx) ←
    matchMProgInOp multiple_example test_addi_multiple_pattern []
  let res ← MTerm.concretizeProg test_addi_multiple_pattern ctx
  res

#eval multiple_example_result


/-
### Exact program matching
This section defines functions to check if an operation, or SSA values
definitions/uses are inside a bigger program.

The operation to match should not have any regions or attributes.
-/

def eqOp (op1 op2: Op δ) : Bool :=
  match op1, op2 with
  | .mk name res args .regionsnil (.mk []), .mk name' res' args' .regionsnil (.mk []) =>
    name == name' && res == res' && args == args'
  | _, _ => false


def isOpIn (mOp: Op δ) : OpRegion δ k → Bool
| .op name res args regions attrs =>
    eqOp (.op name res args regions attrs) mOp || isOpIn mOp regions
| .opsnil => False
| .opscons o os => isOpIn mOp o || isOpIn mOp os
| .region name args body => isOpIn mOp body
| .regionsnil => False
| .regionscons r rs => isOpIn mOp r || isOpIn mOp rs
