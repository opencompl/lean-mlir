import Mathlib.Tactic.Linarith
import Aesop
-- A translation from SSA + Regions to Tree, with no proofs.
-- this allows for easy unfolding of the semantics.
-- If we carry around proofs of well formedness, the dependent typing
-- of the well-formedness leads to stuck terms.
-- Thus, we eschew the need to have proofs, and simply YOLO translate from
-- the origina SSA + Regions program into Tree.

namespace SSARgnVar2Tree

inductive RgnName
| r0
| r1
| r2
| r3
| r4
deriving DecidableEq

inductive VarName
| null
| x0
| x1
| x2
| x3
| x4
| x5
| x6
| x7
| y1
| y2
| y3
| y4
| z1
| z2
| z3
| z4
deriving DecidableEq



section StxSem

-- | The environment is a mapping from variable names to values.
abbrev Env (k : Type) (α : Type) := k → α


-- | Extend the environment with a new variable.
@[simp]
def Env.extend [DecidableEq k] (name : k) (v : α) (e: Env k α) : Env k α :=
  fun name' => if name = name' then v else e name'

@[simp]
def Env.empty [Inhabited α] : Env k α :=
  fun _ => default

@[simp]
def Env.map (f : α → β) (e : Env k α) : Env k β :=
  fun name => f (e name)

notation "∅" => Env.empty
notation e "[" name "↦" v "]" => Env.extend name v e

abbrev VarEnv (α : Type) := Env VarName α
abbrev RgnEnv (α : Type) := Env RgnName α

-- The input semantics given by the user.
class UserSemantics (opcode : Type)  where
  -- | Arguments given as (<args>, <rgn1>, ... <rgnN>)
  -- | Consider not allowing users to not be access all of 'Env'.
  opcodeEval (op: opcode) (vals : Int × Int) (rgns : (Int × Int → Int)) : Int

attribute [simp] UserSemantics.opcodeEval

inductive ASTKind : Type where
| O : ASTKind
| Os : ASTKind
| R : ASTKind
deriving Inhabited, DecidableEq

-- | The operations of the language.
inductive AST (opcode : Type): ASTKind → Type where
| assign (ret : VarName) (op : opcode)
  (args : VarName × VarName)
  (rgns : AST opcode .R) : AST opcode .O
| ops1 (op : AST opcode .O) :  AST opcode .Os
| opsmany (op : AST opcode .O) (ops : AST opcode .Os) : AST opcode .Os
| rgn (args : VarName × VarName) (body : AST opcode .Os) : AST opcode .R
| rgnvar (var : RgnName) : AST opcode .R
| rgn0 : AST opcode .R

def AST.retname : AST opcode .O → VarName
| .assign (ret := ret) .. => ret

instance [Inhabited opcode] : Inhabited (AST opcode .O) where
  default := .assign .x0 default (.x0, .x0) .rgn0

instance [Inhabited opcode] : Inhabited (AST opcode .Os) where
  default := .ops1 default

instance [Inhabited opcode] : Inhabited (AST opcode .R) where
  default := .rgn (.x0, .x0) default



@[simp]
def Ops.ofList [Inhabited opcode] : List (AST opcode .O) → AST opcode .Os
| [] => panic! "need non-empty list"
| [x] => .ops1 x
| x :: xs => .opsmany x (Ops.ofList xs)

@[reducible, simp]
instance [Inhabited opcode] : Coe (List (AST opcode .O)) (AST opcode .Os) := ⟨Ops.ofList⟩

@[simp, reducible]
def ASTKind.eval : ASTKind → Type
| .O => Int
| .Os => Int
| .R => (Int × Int → Int)
-- evaluate an operation with repect to a particular user semantics.
@[simp]
def AST.eval [S: UserSemantics opcode]
  {astk: ASTKind} (e: VarEnv Int)
  (re: RgnEnv (Int × Int → Int)): AST opcode astk → astk.eval × VarEnv Int
| .assign ret op args r =>
    let (arg1, arg2) := args
    let retval := S.opcodeEval op (e arg1, e arg2) (r.eval e re).fst
    (retval, e.extend ret retval)
| .ops1 op =>
   let (out, env) := op.eval e re
   (out, env)
| .opsmany op ops =>
    let e' := (op.eval e re).snd
    ops.eval e' re
| .rgnvar v => (re v, e)
| .rgn args body =>
    (fun vals =>
      let e := Env.empty
      let e1 := e.extend args.fst vals.fst
      let e2 := e1.extend args.snd vals.snd
      let (outval, _e) := body.eval e2 re
      outval, e)
| .rgn0 => (fun _ => default, e)

end StxSem


section Tree

inductive CtreeKind
| O -- op
| R -- region (higher order)
deriving Inhabited

-- closed trees, leaves are integers.
inductive Ctree  (opcode : Type) : CtreeKind → Type where
| binop
  (op : opcode)
  (lhs : Ctree opcode .O)
  (rhs : Ctree opcode .O)
  (rgns: Ctree opcode .R) : Ctree opcode .O
| rgn (f : Int × Int → Ctree opcode .O) : Ctree opcode .R
| rgn0 : Ctree opcode .R
| leaf (val : Int) : Ctree opcode .O

instance : Inhabited (Ctree opcode .O) where
  default := .leaf 10

instance : Inhabited (Ctree opcode .R) where
  default := .rgn0

-- convert an AST into a closed tree under the given environment
-- note that translation into a closed tree needs an environment,
-- to learn the values of variables.
-- This version has an `_` in the name since it needs a `Ctree.VarEnv`, not an
-- `Env`. We will writea helper that converts `Env` into `Ctree.VarEnv`.
@[simp, reducible]
def ASTKind.toCTree (opcode : Type) : ASTKind → Type
| .O => Ctree opcode .O
| .Os => Ctree opcode .O
| .R => Ctree opcode .R

@[simp]
def AST.toCtree_ {astk: ASTKind} (e : VarEnv (Ctree opcode .O))
  (re: RgnEnv (Ctree opcode .R)):
  AST opcode astk → (astk.toCTree opcode) × VarEnv (Ctree opcode .O)
| .assign ret opcode (u, v) r =>
    let rval := (r.toCtree_ e re).fst
    let t := .binop opcode (e u) (e v) rval
    (t, e.extend ret t)
| .rgnvar var => let e := Env.empty; (re var, e)
| .rgn0 => let e := Env.empty; (.rgn0, e)
| .rgn args body =>
    let e := Env.empty -- NOTE: regions are now isolated from above
    (.rgn fun vals =>
      let e1 := e.extend args.fst (.leaf vals.fst)
      let e2 := e1.extend args.snd (.leaf vals.snd)
      (body.toCtree_ e2 re).fst, e)
| .ops1 op =>
  let (val, e) := op.toCtree_ e re
  (val, e)
| .opsmany os o =>
    let (_, e) := os.toCtree_ e re
    o.toCtree_ e re

-- wrap every element in a (.leaf) constructor
@[simp]
def Ctree.VarEnv.ofEnv (e: VarEnv Int) : VarEnv (Ctree opcode .O) :=
   fun name => .leaf (e name)

-- TODO: should these be coercions?
@[simp]
def Ctree.RgnEnv.ofEnv (re: RgnEnv (Int × Int → Int)) :
  RgnEnv (Ctree opcode .R) :=
   fun name => Ctree.rgn (fun args => .leaf (re name args))

-- this converts an AST into a Ctree, given an environment
-- and an AST.
@[simp]
def Op.toCtree (a: AST opcode .O) (e: VarEnv Int)
  (re: RgnEnv (Int × Int → Int)) : Ctree opcode .O :=
    (a.toCtree_ (Ctree.VarEnv.ofEnv e) (Ctree.RgnEnv.ofEnv re)).fst

@[simp]
def Ops.toCtree (a: AST opcode .Os)
  (e: VarEnv Int) (re: RgnEnv (Int × Int → Int)) : Ctree opcode .O :=
    (a.toCtree_ (Ctree.VarEnv.ofEnv e) (Ctree.RgnEnv.ofEnv re)).fst

@[simp]
def Region.toCtree (a: AST opcode .R)
  (e: VarEnv Int)
  (re: RgnEnv (Int × Int → Int)): Ctree opcode .R :=
    (a.toCtree_ (Ctree.VarEnv.ofEnv e) (Ctree.RgnEnv.ofEnv re)).fst


-- evaluate a Ctree. note that this needs no environment.
@[simp]
def CtreeKind.eval : CtreeKind → Type
| .O => Int
| .R => Int × Int → Int

-- Note: is this literally "just" staging the partial evaluation against the environment?
def Ctree.eval [UserSemantics opcode] : Ctree opcode treek → treek.eval
| .binop o l r rs =>
  UserSemantics.opcodeEval o (l.eval, r.eval) rs.eval
| .leaf v => v
| .rgn0 => fun _ => default
| .rgn f => fun args => (f args).eval

end Tree

namespace MultipleInstructionTree
inductive Opcode
| add
| mul
| loop : Opcode
| ite : Opcode
| run : Opcode
| runnot : Opcode
| not : Opcode
| const : Int → Opcode
deriving Inhabited

def loopSemantics (n : Nat) (f : Int → Int) (v : Int) : Int :=
  match n with
  | 0 => v -- inline id
  | n + 1 => f (loopSemantics n f v) -- inline ∘

@[simp]
instance :  UserSemantics Opcode  where
  opcodeEval
  | .not, ⟨a, _⟩, _ => if a = 0 then 1 else 0
  | .mul, ⟨a, b⟩, _ => a * b
  | .add, ⟨a, b⟩, _ => a + b
  | .const i, ⟨_a, _b⟩, _ => i
  | .run, ⟨v, w⟩, r => r ⟨v, w⟩
  | .runnot, ⟨v, w⟩, r => r ⟨if v = 0 then 1 else 0, w⟩ -- execute: 'r(not v, w)'
  | .loop, ⟨n, init⟩, r => loopSemantics n.toNat (fun i => r ⟨i, 0⟩) init
  | _, _, _ => 42


def x_add_4_times_mul_val_eq (env: VarEnv Int):
  let p : AST Opcode .Os :=
      Ops.ofList [
      .assign .x1 .add (.x0, .x0) .rgn0,
      .assign .x2 .add (.x1, .x1) .rgn0
      ]
  let q : AST Opcode .Os := Ops.ofList [
        .assign .x1 (.const 4) (.x0, .x0) .rgn0
      , .assign .x2 .mul (.x1, .x0) .rgn0
    ]
  (Ops.toCtree p env renv).eval = (Ops.toCtree q env renv).eval := by {
    simp only [Ops.ofList, AST.eval, Ops.toCtree,  AST.toCtree_];
    -- see that there are environments, which are folded away when calling
    -- Ctree.eval.
    simp[Ctree.eval];
    linarith
  }


def run_inline :
  let p : AST Opcode .R :=
    AST.rgn ⟨.x0, .x1⟩ $ Ops.ofList [
      .assign .x2 .add (.x0, .x1) .rgn0 -- x2 := x0 + x1
      ]
  let q : AST Opcode .R :=
    AST.rgn ⟨.x0, .x1⟩ $ Ops.ofList [
      .assign .x2 .run (.x0, .x1) (AST.rgn ⟨.x5, .x6⟩ (Ops.ofList [
        -- x2 := run (x0, x1) { ^(x5, x6): return x5 + x6 }
        .assign .y1 .add (.x5, .x6) .rgn0
      ]))
    ]
  (Region.toCtree p Env.empty Env.empty).eval =
  (Region.toCtree q Env.empty Env.empty).eval := by {
    simp
    dsimp only[Ctree.eval]
  }


-- trying to convert an AST to a Ctree at any environment
-- is equivalent to converting it in an empty environment.
@[simp]
theorem AST.toCtree_rgn_equiv_empty
  (r: AST opcode .R)
  [Inhabited opcode] :
  AST.toCtree_ env renv r = AST.toCtree_ Env.empty renv r := by {
  simp; cases r <;> simp;
}

def runnot_inline:
  let p : AST Opcode .R :=
    AST.rgn ⟨.x0, .x1⟩ $ Ops.ofList [
      .assign .y1 .run ⟨.x0, .x1⟩ (.rgnvar .r1) -- y1 := r(x0, x1)
    ]
  (Region.toCtree p Env.empty Env.empty).eval =
  (Region.toCtree (.rgnvar .r1 : AST Opcode .R) Env.empty Env.empty).eval := by {
    simp
    simp[Ctree.eval];
    -- this stil cannot be simplified away, since this is in fact false.
    -- We need some notion of the fact that z1, z2 is free in 'r',
    -- so that we can say that we can remove 'z2, z1' in the 'q'
    -- environment when we run 'r'.
    -- if we have this, then we are good, and we can prove the theorem.
    -- but how do we convince people that use MLIR that this is a sensible
    -- thing to reason about?

  }

end MultipleInstructionTree

end SSARgnVar2Tree
