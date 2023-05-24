import Mathlib.Tactic.Linarith
import Aesop
-- A translation from SSA to Tree, with no proofs.
-- this allows for easy unfolding of the semantics.
-- If we carry around proofs of well formedness, the dependent typing
-- of the well-formedness leads to stuck terms.
-- Thus, we eschew the need to have proofs, and simply YOLO translate from
-- the origina SSA + Regions program into Tree.

namespace SSA2Tree

inductive VarName
| x0
| x1
| x2
| x3
| x4
| x5
| x6
| x7
deriving DecidableEq

section StxSem

-- | The environment is a mapping from variable names to values.
abbrev Env := VarName → Int

-- | Extend the environment with a new variable.
@[simp]
def Env.extend (name : VarName) (v : Int) (e: Env) : Env :=
  fun name' => if name = name' then v else e name'

@[simp]
def Env.empty : Env :=
  fun _ => default

notation "∅" => Env.empty
notation e "[" name "↦" v "]" => Env.extend name v e


-- The input semantics given by the user.
class UserSemantics (opcode : Type)  where
  -- | Arguments given as (<args>, <rgn1>, ... <rgnN>)
  -- | Consider not allowing users to not be access all of 'Env'.
  opcodeEval :  opcode → Int × Int → Int

attribute [simp] UserSemantics.opcodeEval

inductive ASTKind : Type where
| O : ASTKind
| Os : ASTKind
deriving Inhabited, DecidableEq

-- | The operations of the language.
inductive AST (opcode : Type): ASTKind → Type where
| assign: VarName → opcode → (VarName × VarName) → AST opcode .O
| ops1: AST opcode .O → AST opcode .Os
| opsmany: AST opcode .O → AST opcode .Os ->  AST opcode .Os

def AST.retname : AST opcode .O → VarName
| .assign ret _ _ => ret

instance [Inhabited opcode] : Inhabited (AST opcode .O) where
  default := .assign .x0 default (.x0, .x0)

instance [Inhabited opcode] : Inhabited (AST opcode .Os) where
  default := .ops1 default

@[simp]
def AST.ofList [Inhabited opcode] : List (AST opcode .O) → AST opcode .Os
| [] => panic! "need non-empty list"
| [x] => .ops1 x
| x :: xs => .opsmany x (AST.ofList xs)

-- evaluate an operation with repect to a particular user semantics.
@[simp]
def AST.eval [S: UserSemantics opcode] (e: Env): AST opcode astk → Int × Env
| .assign ret op args =>
    let (arg1, arg2) := args
    let retval := S.opcodeEval op (e arg1, e arg2)
    (retval, e.extend ret retval)
| .ops1 op => op.eval e
| .opsmany op ops =>
    let e' := (op.eval e).snd
    ops.eval e'
end StxSem




namespace SingleInstruction

inductive Opcode
| sub
| mul
| const : Int → Opcode

@[simp]
instance :  UserSemantics Opcode  where
  opcodeEval
  | .mul, ⟨a, b⟩ => a * b
  | .sub, ⟨a, b⟩ => a - b
  | .const i, ⟨_a, _b⟩ => i


def x_minus_x_equals_zero (env: Env):
  let p : AST Opcode .O := .assign .x1 .sub (.x0, .x0)
  let q : AST Opcode .O := .assign .x1 (.const 0) (.x0, .x0)
  p.eval env = q.eval env := by {
    simp only [AST.eval, UserSemantics.opcodeEval]
    simp;
  }

def x_mul_commute_val_eq (env: Env):
  let p : AST Opcode .O := .assign .x2 .mul (.x0, .x1)
  let q : AST Opcode .O := .assign .x2 .mul (.x1, .x0)
  (p.eval env).fst = (q.eval env).fst := by {
    simp;
    sorry
  }

-- even proving that the environment state is the same needs some work.
def x_mul_commute_env_eq (env: Env):
  let p : AST Opcode .O := .assign .x2 .mul (.x0, .x1)
  let q : AST Opcode .O := .assign .x2 .mul (.x1, .x0)
  (p.eval env).snd = (q.eval env).snd := by {
    simp;
    funext ix;
    sorry
  }

end SingleInstruction

namespace MultipleInstruction

inductive Opcode
| add
| mul
| const : Int → Opcode
deriving Inhabited

@[simp]
instance :  UserSemantics Opcode  where
  opcodeEval
  | .mul, ⟨a, b⟩ => a * b
  | .add, ⟨a, b⟩ => a + b
  | .const i, ⟨_a, _b⟩ => i


def x_add_4_times_mul_val_eq (env: Env):
  let p : AST Opcode .Os :=
      AST.ofList [
      .assign .x1 .add (.x0, .x0),
      .assign .x2 .add (.x1, .x1)
      ]
  let q : AST Opcode .Os := AST.ofList [
        .assign .x1 (.const 4) (.x0, .x0)
      , .assign .x2 .mul (.x1, .x0)
    ]
  (p.eval env).fst = (q.eval env).fst := by {
    simp only [AST.ofList, AST.eval, UserSemantics.opcodeEval]
    sorry
     -- still get environments when reasoning about sequence of operations.
  }

end MultipleInstruction

-- OK, so even in the simplest case, when we have multiple instructions,
-- we run into problems. So let's try a different encodings, that of trees.

section Tree
-- closed trees, leaves are integers.
inductive CTree  (opcode : Type) where
| binop: opcode → CTree opcode → CTree opcode → CTree opcode
| leaf: Int → CTree opcode
def CTree.Env (opcode : Type) : Type := VarName → CTree opcode
def CTree.Env.empty (opcode : Type) : CTree.Env opcode :=
   fun _name => .leaf 42 -- note that we return garbage here!
def CTree.Env.extend (name : VarName) (val : CTree opcode)
  (env : CTree.Env opcode) : CTree.Env opcode :=
    fun key => if key == name then val else env key


-- convert an AST into a closed tree under the given environment
-- note that translation into a closed tree needs an environment,
-- to learn the values of variables.
-- This version has an `_` in the name since it needs a `CTree.Env`, not an
-- `Env`. We will writea helper that converts `Env` into `CTree.Env`.
@[simp]
def AST.toCTree_ (e : CTree.Env opcode) : AST opcode astk → CTree opcode × CTree.Env opcode
| .assign ret opcode (u, v) =>
    let t := .binop opcode (e u) (e v)
    (t, e.extend ret t)
| .ops1 op => op.toCTree_ e
| .opsmany os o =>
    let (_, e) := os.toCTree_ e
    o.toCTree_ e

-- wrap every element in a (.leaf) constructor
@[simp]
def CTree.Env.ofEnv (e: SSA2Tree.Env) :  CTree.Env opcode :=
   fun name => .leaf (e name)

-- this converts an AST into a CTree, given an environment
-- and an AST.
def AST.toCTree (e: Env) (a: AST opcode astk) : CTree opcode :=
    (a.toCTree_ (CTree.Env.ofEnv e)).fst

-- evaluate a CTree. note that this needs no environment.
def CTree.eval [UserSemantics opcode] : CTree opcode → Int
| .binop o l r => UserSemantics.opcodeEval o (l.eval, r.eval)
| .leaf v => v

-- -- Open trees, leaves are variables
-- inductive OTree (opcode : Type) where
-- | binop: opcode → OTree opcode → OTree opcode → OTree opcode
-- | leaf: VarName → OTree opcode -- note that the leaves have variables.
-- def OTree.Env (opcode : Type) : Type := VarName → OTree opcode
-- def OTree.Env.empty (opcode : Type) : OTree.Env opcode :=
--    fun name => .leaf name
-- def OTree.Env.extend (name : VarName) (val : OTree S) (env : OTree.Env S) : OTree.Env S :=
--    fun key => if key == name then val else env key

end Tree

namespace MultipleInstructionTree
inductive Opcode
| add
| mul
| const : Int → Opcode
deriving Inhabited

@[simp]
instance :  UserSemantics Opcode  where
  opcodeEval
  | .mul, ⟨a, b⟩ => a * b
  | .add, ⟨a, b⟩ => a + b
  | .const i, ⟨_a, _b⟩ => i


def x_add_4_times_mul_val_eq (env: Env):
  let p : AST Opcode .Os :=
      AST.ofList [
      .assign .x1 .add (.x0, .x0),
      .assign .x2 .add (.x1, .x1)
      ]
  let q : AST Opcode .Os := AST.ofList [
        .assign .x1 (.const 4) (.x0, .x0)
      , .assign .x2 .mul (.x1, .x0)
    ]
  (p.toCTree env).eval = (q.toCTree env).eval := by {
    simp only [AST.ofList, AST.eval, AST.toCTree,  AST.toCTree_];
    -- see that there are environments, which are folded away when calling
    -- CTree.eval.
    simp[CTree.eval];
    generalize (env VarName.x0) = x
    clear env
    -- ⊢ env VarName.x0 + env VarName.x0 + (env VarName.x0 + env VarName.x0) =
    --    4 * env VarName.x0
    -- Ideally, we have proof automation that relabels (env _) into a new
    -- thing and generalizes it away, making it look nice.
    linarith
  }
end MultipleInstructionTree

end SSA2Tree
