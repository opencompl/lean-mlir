
namespace MLIR

/-- `VarName` is the type of (human-readable) variable names -/
def VarName : Type := String

/-- `BlockLabel` is the type of (human-readable) basic block labels -/
def BlockLabel : Type := String

instance : DecidableEq VarName := by unfold VarName; infer_instance
instance : DecidableEq BlockLabel := by unfold BlockLabel; infer_instance


namespace UnTyped

/- The datastructure is generic over the types of: `Op`erations, `T`erminators and `Var`iables -/
variable (Op T : Type)

mutual

/-- An `Expr` binds the result of a single operation to a new variable. Morally, it represents
`$varName = $op($args) { $regions }` -/
inductive Expr
  | mk (varName : VarName) (op : Op) (args : List VarName) (regions : List Region)

/-- `Lets` is a sequence of operations (without terminator), which grows downwards.
That is, the head of the list represents the first operation to be executed -/
inductive Lets
  | mk (lets : List Expr)

/-- The `Body` of a basic block is a sequence of operations, followed by a terminator -/
inductive Body
  | mk (lets : Lets) (terminator : T)

/-- A basic block has a label, a set of arguments, and then a program -/
inductive BasicBlock
  | mk (label : BlockLabel) (args : List VarName) (body : Body)

/-- A region consists of one or more basic blocks, where the first basic block is known as the
entry block -/
inductive Region
  | mk (entry : BasicBlock) (blocks : List BasicBlock)

end


/-! ## Projections -/
variable {Op T : Type}

def Expr.varName : Expr Op T → VarName
  | ⟨varName, _, _, _⟩ => varName
def Expr.op : Expr Op T → Op
  | ⟨_, op, _, _⟩ => op

@[simp] theorem Expr.op_mk {varName} {op : Op} {args} {regions : List (Region Op T)} :
    Expr.op ⟨varName, op, args, regions⟩ = op := rfl
@[simp] theorem Expr.varName_mk {varName} {op : Op} {args} {regions : List (Region Op T)} :
    Expr.varName ⟨varName, op, args, regions⟩ = varName := rfl

def Lets.inner : Lets Op T → List (Expr Op T)
  | ⟨inner⟩ => inner

@[simp] theorem Lets.mk_inner (lets : Lets Op T) : ⟨lets.inner⟩ = lets := by cases lets; rfl
@[simp] theorem Lets.inner_mk (lets : List (Expr Op T)) : Lets.inner ⟨lets⟩ = lets := rfl

namespace BasicBlock

def args : BasicBlock Op T → List VarName
  | ⟨_, args, _⟩ => args

def body : BasicBlock Op T → Body Op T
  | ⟨_, _, body⟩ => body

end BasicBlock
