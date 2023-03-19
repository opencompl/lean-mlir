import Mathlib.Tactic.Linarith
import Aesop
-- A translation from SSA + Regions to Tree, with no proofs.
-- this allows for easy unfolding of the semantics.
-- If we carry around proofs of well formedness, the dependent typing
-- of the well-formedness leads to stuck terms.
-- Thus, we eschew the need to have proofs, and simply YOLO translate from
-- the origina SSA + Regions program into Tree.

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
structure UserSemantics (opcode : Type)  where
  -- | Arguments given as (<args>, <rgn1>, ... <rgnN>)
  -- | Consider not allowing users to not be access all of 'Env'.
  opcodeEval :  opcode → Int × Int → Int

attribute [simp] UserSemantics.opcodeEval

inductive ASTKind : Type where
| O : ASTKind
| Os : ASTKind
deriving Inhabited, DecidableEq

-- | The operations of the language.
inductive AST (S: UserSemantics opcode): ASTKind → Type where
| assign: VarName → opcode → (VarName × VarName) → AST S .O
| ops1: AST S .O → AST S .Os
| opsmany: AST S .Os → AST S .O → AST S .Os

def AST.retname {S: UserSemantics opcode} : AST S .O → VarName
| .assign ret _ _ => ret

-- evaluate an operation with repect to a particular user semantics.
@[simp]
def AST.eval {S: UserSemantics opcode} (e: Env): AST S astk → Int × Env
| .assign ret op args =>
    let (arg1, arg2) := args
    let retval := S.opcodeEval op (e arg1, e arg2)
    (retval, e.extend ret retval)
| .ops1 op => op.eval e
| .opsmany ops op =>
    let e' := (op.eval e).snd
    ops.eval e'
end StxSem

section SubXX

inductive Opcode
| add
| sub
| mul
| const : Int → Opcode

@[simp]
def S : UserSemantics Opcode  where
  opcodeEval
  | .add, ⟨a, b⟩ => a + b
  | .mul, ⟨a, b⟩ => a * b
  | .sub, ⟨a, b⟩ => a - b
  | .const i, ⟨_a, _b⟩ => i

-- attribute [simp] S.opcodeEval

def x_minus_x_equals_zero (env: Env):
  let p : AST S .O := .assign .x1 .sub (.x0, .x0)
  let q : AST S .O := .assign .x1 (.const 0) (.x0, .x0)
  p.eval env = q.eval env := by {
    simp only [S]
    simp only[AST.eval._eq_1]
    simp;
  }

def x_mul_commute_val_eq (env: Env):
  let p : AST S .O := .assign .x2 .mul (.x0, .x1)
  let q : AST S .O := .assign .x2 .mul (.x1, .x0)
  (p.eval env).fst = (q.eval env).fst := by {
    simp;
    sorry
  }


def x_mul_commute_env_eq (env: Env):
  let p : AST S .O := .assign .x2 .mul (.x0, .x1)
  let q : AST S .O := .assign .x2 .mul (.x1, .x0)
  (p.eval env).snd = (q.eval env).snd := by {
    simp;
    funext ix;
    sorry
  }

end SubXX
