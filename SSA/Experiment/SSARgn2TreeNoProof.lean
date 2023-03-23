import Mathlib.Tactic.Linarith
import Aesop
-- A translation from SSA + Regions to Tree, with no proofs.
-- this allows for easy unfolding of the semantics.
-- If we carry around proofs of well formedness, the dependent typing
-- of the well-formedness leads to stuck terms.
-- Thus, we eschew the need to have proofs, and simply YOLO translate from
-- the origina SSA + Regions program into Tree.

namespace SSARgn2Tree

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
abbrev Env (α : Type) := VarName → α

-- | Extend the environment with a new variable.
@[simp]
def Env.extend (name : VarName) (v : α) (e: Env α) : Env α :=
  fun name' => if name = name' then v else e name'

@[simp]
def Env.empty [Inhabited α] : Env α :=
  fun _ => default

@[simp]
def Env.map (f : α → β) (e : Env α) : Env β :=
  fun name => f (e name)

notation "∅" => Env.empty
notation e "[" name "↦" v "]" => Env.extend name v e


-- The input semantics given by the user.
class UserSemantics (opcode : Type)  where
  -- | Arguments given as (<args>, <rgn1>, ... <rgnN>)
  -- | Consider not allowing users to not be access all of 'Env'.
  opcodeEval (op: opcode) (vals : Int × Int) (rgns :  List (Int × Int → Int)) : Int

attribute [simp] UserSemantics.opcodeEval

inductive ASTKind : Type where
| O : ASTKind
| Os : ASTKind
| R : ASTKind
| Rs : ASTKind
deriving Inhabited, DecidableEq

-- | The operations of the language.
inductive AST (opcode : Type): ASTKind → Type where
| assign (ret : VarName) (op : opcode) (args : VarName × VarName) (rgns : AST opcode .Rs) : AST opcode .O
| ops1 (op : AST opcode .O) :  AST opcode .Os
| opsmany (op : AST opcode .O) (ops : AST opcode .Os) : AST opcode .Os
| rgn  (args : VarName × VarName) (body : AST opcode .Os) : AST opcode .R
| rgns0 : AST opcode .Rs
| rgnsmany (rgn : AST opcode .R) (rgns :  AST opcode .Rs) :  AST opcode .Rs

def Region.toRegions : AST opcode .R → AST opcode .Rs
| r => .rgnsmany r .rgns0

instance : Coe (AST opcode .R) (AST opcode .Rs) where
  coe := Region.toRegions

def AST.retname : AST opcode .O → VarName
| .assign (ret := ret) .. => ret

instance [Inhabited opcode] : Inhabited (AST opcode .O) where
  default := .assign .x0 default (.x0, .x0) .rgns0

instance [Inhabited opcode] : Inhabited (AST opcode .Os) where
  default := .ops1 default

instance [Inhabited opcode] : Inhabited (AST opcode .R) where
  default := .rgn (.x0, .x0) default

instance : Inhabited (AST opcode .Rs) where
  default := .rgns0

@[simp]
def Regions.ofRegion : AST opcode .R → AST opcode .Rs 
| r => .rgnsmany r .rgns0 

instance : Coe (AST opcode .R) (AST opcode .Rs) := ⟨Regions.ofRegion⟩
#check DecidableEq
@[simp]
def Regions.ofList : List (AST opcode .R) → AST opcode .Rs
| [] => .rgns0
| r :: rs => .rgnsmany r (Regions.ofList rs)

@[reducible, simp]
instance : Coe (List (AST opcode .R)) (AST opcode .Rs) := ⟨Regions.ofList⟩

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
| .Rs => List (Int × Int → Int)
-- evaluate an operation with repect to a particular user semantics.
@[simp]
def AST.eval [S: UserSemantics opcode]
  {astk: ASTKind} (e: Env Int): AST opcode astk → astk.eval × Env Int
| .assign ret op args rgns =>
    let (arg1, arg2) := args
    let retval := S.opcodeEval op (e arg1, e arg2) (rgns.eval e).fst
    (retval, e.extend ret retval)
| .ops1 op =>
   let (out, env) := op.eval e
   (out, env)
| .opsmany op ops =>
    let e' := (op.eval e).snd
    ops.eval e'
| .rgn args body =>
    (fun vals =>
      let e1 := e.extend args.fst vals.fst
      let e2 := e1.extend args.snd vals.snd
      let (outval, _) := body.eval e2
      outval, e)
| .rgns0 => ([], e)
| .rgnsmany r rs =>
    let outr := (r.eval e).fst
    let outrs := (rs.eval e).fst
    (List.cons outr outrs, e)

end StxSem


section Tree

inductive CtreeKind
| O -- op
| R -- region (higher order)
| Rs -- regions (higher order)


-- closed trees, leaves are integers.
inductive Ctree  (opcode : Type) : CtreeKind → Type where
| binop
  (op : opcode)
  (lhs : Ctree opcode .O)
  (rhs : Ctree opcode .O)
  (rgns: Ctree opcode .Rs) : Ctree opcode .O
| rgn (f : Int × Int → Ctree opcode .O) : Ctree opcode .R
| rgns0 : Ctree opcode .Rs
| rgns (rgn : Ctree opcode .R) (rgns : Ctree opcode .Rs) : Ctree opcode .Rs
| leaf (val : Int) : Ctree opcode .O

-- convert an AST into a closed tree under the given environment
-- note that translation into a closed tree needs an environment,
-- to learn the values of variables.
-- This version has an `_` in the name since it needs a `Ctree.Env`, not an
-- `Env`. We will writea helper that converts `Env` into `Ctree.Env`.
@[simp, reducible]
def ASTKind.toCTree (opcode : Type) : ASTKind → Type
| .O => Ctree opcode .O
| .Os => Ctree opcode .O
| .R => Ctree opcode .R
| .Rs => Ctree opcode .Rs

@[simp]
def AST.toCtree_ {astk: ASTKind} (e : Env (Ctree opcode .O)) :
  AST opcode astk → (astk.toCTree opcode) × Env (Ctree opcode .O)
| .assign ret opcode (u, v) rgns =>
    let rgnsval := (rgns.toCtree_ e).fst
    let t := .binop opcode (e u) (e v) rgnsval
    (t, e.extend ret t)
| .rgns0 => (.rgns0, e)
| .rgnsmany r rs => (.rgns (r.toCtree_ e).fst (rs.toCtree_ e).fst, e)
| .rgn args body =>
    (.rgn fun vals  =>
      let e1 := e.extend args.fst (.leaf vals.fst)
      let e2 := e1.extend args.snd (.leaf vals.snd)
      (body.toCtree_ e2).fst, e)
| .ops1 op =>
  let (val, e) :=op.toCtree_ e
  (val, e)
| .opsmany os o =>
    let (_, e) := os.toCtree_ e
    o.toCtree_ e

-- wrap every element in a (.leaf) constructor
@[simp]
def Ctree.Env.ofEnv (e: Env Int) : Env (Ctree opcode .O) :=
   fun name => .leaf (e name)

-- this converts an AST into a Ctree, given an environment
-- and an AST.
@[simp]
def Op.toCtree (a: AST opcode .O) (e: Env Int): Ctree opcode .O :=
    (a.toCtree_ (Ctree.Env.ofEnv e)).fst

@[simp]
def Ops.toCtree (a: AST opcode .Os) (e: Env Int) : Ctree opcode .O :=
    (a.toCtree_ (Ctree.Env.ofEnv e)).fst

-- evaluate a Ctree. note that this needs no environment.
@[simp]
def CtreeKind.eval : CtreeKind → Type
| .O => Int
| .R => Int × Int → Int
| .Rs => List (Int × Int → Int)

-- Note: is this literally "just" staging the partial evaluation against the environment?
@[simp]
def Ctree.eval [UserSemantics opcode] : Ctree opcode treek → treek.eval
| .binop o l r rs =>
  UserSemantics.opcodeEval o (l.eval, r.eval) rs.eval
| .leaf v => v
| .rgns0 => []
| .rgn f => fun args => (f args).eval
| .rgns r rs => r.eval :: rs.eval

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

def loop (n : Nat) (f : Int → Int) (v : Int) : Int :=
  match n with
  | 0 => v -- inline id
  | n + 1 => f (loop n f v) -- inline ∘

@[simp]
instance :  UserSemantics Opcode  where
  opcodeEval
  | .not, ⟨a, _⟩, [] => if a = 0 then 1 else 0
  | .mul, ⟨a, b⟩, [] => a * b
  | .add, ⟨a, b⟩, [] => a + b
  | .const i, ⟨_a, _b⟩, [] => i
  | .ite, ⟨v, _⟩, [t, e] => if v ≠ 0 then t ⟨v, 0⟩ else e ⟨v, 0⟩
  | .run, ⟨v, w⟩, [r] => r ⟨v, w⟩
  | .runnot, ⟨v, w⟩, [r] => r ⟨if v = 0 then 0 else 1, w⟩
  | .loop, ⟨n, init⟩, [r] => loop n.toNat (fun i => r ⟨i, 0⟩) init
  | _, _, _ => 42


def x_add_4_times_mul_val_eq (env: Env Int):
  let p : AST Opcode .Os :=
      Ops.ofList [
      .assign .x1 .add (.x0, .x0) .rgns0,
      .assign .x2 .add (.x1, .x1) .rgns0
      ]
  let q : AST Opcode .Os := Ops.ofList [
        .assign .x1 (.const 4) (.x0, .x0) .rgns0
      , .assign .x2 .mul (.x1, .x0) .rgns0
    ]
  (Ops.toCtree p env).eval = (Ops.toCtree q env).eval := by {
    simp only [Ops.ofList, AST.eval, Ops.toCtree,  AST.toCtree_];
    -- see that there are environments, which are folded away when calling
    -- Ctree.eval.
    simp[Ctree.eval];
    simp[CtreeKind.eval];
    linarith
  }


def run_inline (env: Env Int) (o : AST Opcode .Os):
  let p : AST Opcode .Os :=
      Ops.ofList [
      .assign .x2 .add (.x0, .x1) .rgns0 
      ]
  let q : AST Opcode .Os := Ops.ofList [
      .assign .x2 .run (.x0, .x1) (AST.rgn ⟨.x5, .x6⟩ (Ops.ofList [
        .assign .y1 .add (.x5, .x6) .rgns0
      ]))
    ]
  (Ops.toCtree p env).eval = (Ops.toCtree q env).eval := by {
    simp
    -- see that this cannot be simplified away by pure 'simp'. Some thought
    -- is needed here.
  }

def runnot_inline (env: Env Int) (r : AST Opcode .R):
  let p : AST Opcode .Os :=
      Ops.ofList [
      .assign .y1 .not ⟨.x0, .null⟩ .rgns0
      , .assign .y2 .run (.x1, .y1) r
      ]
  let q : AST Opcode .Os := Ops.ofList [
      .assign .x2 .runnot (.x0, .x1) (AST.rgn ⟨.z1, .z2⟩ (Ops.ofList [
        .assign .y2 .run ⟨.z1, .z2⟩ r
      ]))
    ]
  (Ops.toCtree p env).eval = (Ops.toCtree q env).eval := by {
    simp
    -- see that this cannot be simplified away by pure 'simp'. Some thought
    -- is needed here.
    sorry
  }

def ite_switch_branch_negate_cond (env: Env Int) (r1 r2 : AST Opcode .R):
  let p : AST Opcode .Os :=
      Ops.ofList [
      .assign .x1 .not (.x0, .null) .rgns0,
      .assign .x2 .ite (.x1, .null) (Regions.ofList [r2, r1])
      ]
  let q : AST Opcode .Os := Ops.ofList [
      .assign .x2 .ite (.x0, .null) (Regions.ofList [r1, r2])
    ]
  (Ops.toCtree p env).eval = (Ops.toCtree q env).eval := by {
    simp
    by_cases X0:env VarName.x0 = 0  <;> simp[X0]
    
    -- see that this cannot be simplified away by pure 'simp'. Some thought
    -- is needed here.
    sorry
    sorry
  }
end MultipleInstructionTree

end SSARgn2Tree
