/-
Copyright (c) 2023 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Henrik Böving, Siddharth Bhat
-/

import Lean.Data.HashMap

namespace Lean.IR.LLVM.Pure

declare_syntax_cat llvm_ty
declare_syntax_cat llvm_assignment
declare_syntax_cat llvm_instr
declare_syntax_cat llvm_terminator
declare_syntax_cat llvm_bb
-- may need function_def, function_decl
declare_syntax_cat llvm_function
declare_syntax_cat llvm_global

inductive Ty where
| function (args : Array Ty) (ret : Ty)
| void
| int (width : UInt64)
| opaquePointer (addrspace : UInt64 := 0)
| float
| double
| array (elemty : Ty) (nelem : UInt64)
deriving Inhabited, BEq, Repr

-- ptr gets used as keyword in the LLVM grammar, we need to work around it due to the global syntax table
declare_syntax_cat ptr_ident
scoped syntax "ptr" : ptr_ident

scoped syntax llvm_ty " (" (llvm_ty),* ")" : llvm_ty
scoped syntax ident : llvm_ty -- this gets limited to valid types
scoped syntax ptr_ident : llvm_ty
scoped syntax "[" num " × " llvm_ty "]" : llvm_ty

-- TODO: implement
-- instance : DecidableEq Ty := fun x y => sorry

abbrev BBId := UInt64
abbrev Reg := UInt64
def Reg.ofNat : Nat → Reg := UInt64.ofNat

syntax llvm_reg := "%" noWs (num <|> ident)
syntax llvm_bb_label := llvm_reg
syntax llvm_sym := "@" noWs (num <|> ident)
syntax llvm_value := llvm_reg -- TODO: extend with LLVM constants on demand

inductive IntPredicate where
| eq
| ne
| ugt
| uge
| ult
| ule
| sgt
| sge
| slt
| sle
deriving Inhabited, BEq

inductive Instruction where
| alloca (ty : Ty) (name : String)
| load2 (ty : Ty) (val : Reg) (name : String)
| store (val pointer : Reg)
| gep (ty : Ty) (base : Reg) (ixs : Array Reg)
| inboundsgep (ty : Ty) (base : Reg) (ixs : Array Reg)
| sext (val : Reg) (destTy : Ty) -- TODO: add source type argument.
| zext (val : Reg) (destTy : Ty) -- TODO: add source type argument.
| sext_or_trunc (val : Reg) (destTy : Ty) -- TODO: remove pseudo-instruction, provide builder.
| ptrtoint (pointer : Reg) (destTy : Ty)
| mul (lhs rhs : Reg) (name : String)
| add (lhs rhs : Reg) (name : String)
| sub (lhs rhs : Reg) (name : String)
| not (arg : Reg) (name : String)  -- -- TODO: remove pseudo-instruction, provide builder.
| icmp (pred : IntPredicate) (lhs rhs : Reg) (name : String)
| phi (ty : Ty) (args : Array (BBId × Reg))
deriving Inhabited, BEq

/-- Abstraction for values that may or may not need a destination register -/
inductive Named (α : Type) where
| assign (dest : Reg) (value : α)
| do_ (value :  α)

def Named.value : Named α → α
| .assign _ a => a
| .do_ a => a

scoped syntax "alloca" llvm_ty : llvm_instr
scoped syntax "load" llvm_ty ", " ptr_ident llvm_reg : llvm_instr
scoped syntax "store" llvm_ty llvm_value : llvm_instr
scoped syntax "getelemenptr" ("inbounds")? llvm_ty ", " ptr_ident llvm_reg (llvm_ty llvm_reg)* : llvm_instr
scoped syntax "sext" llvm_ty llvm_reg "to" llvm_ty : llvm_instr
scoped syntax "zext" llvm_ty llvm_reg "to" llvm_ty : llvm_instr
scoped syntax "sext_or_trunc" llvm_ty llvm_reg "to" llvm_ty : llvm_instr
scoped syntax "ptrtoint" llvm_ty llvm_reg "to" llvm_ty : llvm_instr
scoped syntax "mul" llvm_ty llvm_reg ", " llvm_reg : llvm_instr
scoped syntax "llvm.add" llvm_ty llvm_reg ", " llvm_reg : llvm_instr -- this is bad, because 'add' is now stolen as syntax.
scoped syntax "sub" llvm_ty llvm_reg ", " llvm_reg : llvm_instr
scoped syntax "not" llvm_ty llvm_reg : llvm_instr

syntax llvm_icmp_op := ("eq" <|> "ne" <|> "ugt" <|> "uge" <|> "ult" <|> "ule" <|> "sgt" <|> "sge" <|> "slt" <|> "sle")
scoped syntax "icmp" llvm_icmp_op llvm_ty llvm_reg ", " llvm_reg : llvm_instr
scoped syntax "phi" llvm_ty ("[" llvm_value ", " llvm_bb_label "]") : llvm_instr

-- TODO: check why we do not need 'fmul' etc.

inductive Terminator where
| default
| unreachable
| br (bbid : BBId)
| condbr (val : Reg) (then_ else_ : BBId)
| ret (val : Reg)
| switch (val : Reg) (cases : Array (Reg × BBId)) (default : BBId)
deriving Repr

/-- We use Terminator.default to signal that this BB does not have a terminator assigned yet. -/
instance : Inhabited Terminator where
  default := Terminator.default

scoped syntax "unreachable" : llvm_terminator
scoped syntax "br" "label" llvm_bb_label : llvm_terminator
scoped syntax "br" "i1" llvm_reg
   ", " "label" llvm_bb_label
   ", " "label" llvm_bb_label : llvm_terminator
scoped syntax "ret" llvm_ty llvm_value : llvm_terminator
scoped syntax "switch"  llvm_ty llvm_value ", "
  "label" llvm_bb_label
     "[" (llvm_ty llvm_reg ", " "label" llvm_bb_label )* "]" : llvm_terminator

structure BasicBlock where
  name : String
  instrs : Array (Named Instruction) := #[]
  terminator : Terminator := .default

def BasicBlock.pushInstruction (i : Named Instruction) (bb : BasicBlock)  : BasicBlock :=
 { bb with instrs := bb.instrs.push i }


syntax llvm_assignment := llvm_reg " = " llvm_instr
scoped syntax ident noWs ":"
  colGt linebreak
    (colEq (llvm_assignment <|> llvm_instr) linebreak)*
    llvm_terminator : llvm_bb

structure FunctionDeclaration where
  name : String
  args : Array Ty
  retty : Ty


scoped syntax "declare" llvm_ty llvm_sym "(" (llvm_ty),* ")" : llvm_function

structure FunctionDefinition extends FunctionDeclaration where
  body : Array BBId := #[]


scoped syntax "define" llvm_ty llvm_sym "(" (llvm_ty llvm_reg),* ")"
  "{" (llvm_bb)* "}": llvm_function

structure GlobalDeclaration where
  name : String
  ty : Ty

scoped syntax llvm_sym " = " ("global" <|> "constant")  llvm_ty : llvm_global

abbrev GlobalId := UInt64

inductive Initializer where
| zero -- zero initialize.
| undef -- leave undefiend.
| string (string : String)

-- TODO: convert strings to array constants
syntax llvm_initializer := ("zeroinitializer" <|> "undef" <|> str)

structure GlobalDefinition extends GlobalDeclaration where
  initializer : Initializer := .zero

scoped syntax llvm_sym " = " ("global" <|> "constant")
  llvm_ty llvm_initializer : llvm_global

scoped syntax "[llvm_ty|" llvm_ty "]" : term
scoped syntax "[llvm_assignment|" llvm_assignment "]" : term
scoped syntax "[llvm_instr|" llvm_instr "]" : term
scoped syntax "[llvm_terminator|" llvm_terminator "]" : term
scoped syntax "[llvm_bb|" llvm_bb "]" : term
scoped syntax "[llvm_function|" llvm_function "]" : term
scoped syntax "[llvm_global|" llvm_global "]" : term

-- TODO: this is literally BEGGING to be indexed by the type.
abbrev FunctionId := UInt64

structure PureBuilderState where
  instrs : HashMap Reg Instruction := {}
  bbs : HashMap BBId BasicBlock := {}

  functionDefs : HashMap FunctionId FunctionDefinition := {}
  functionDecls : HashMap FunctionId FunctionDeclaration := {}

  globalDefs : HashMap GlobalId GlobalDeclaration := {}
  globalDecls : HashMap GlobalId GlobalDefinition := {}

  reg : UInt64 := 0
  bbid : UInt64 := 0
  functionId : UInt64 := 0
  globalId : UInt64 := 0

  bbInsertionPt? : Option BBId
  functionInsertionPt? : Option FunctionId

/--
We wish to allow users to lift into `MonadExceptString`. However, the classic style of
`BuilderT m α := ...` failed us, since not all monad stacks of interest provide errors
that throw a `String` directly. For example, `IO` throws an `IO.Error`. In theory,
Lean's typeclass inference could have inferred a [MonadExceptOf IO String] by combining
the instance `[MonadExceptOf IO.Error IO]` and `[Coe String IO.Error]` to synthesize a
`[MonadExceptOf String IO]`. Unfortunately, in practice, this does not happen.
-- TODO: should we send an issue upstream?
-- TODO: ask on zulip if this is a bug?
-/
class MonadExceptString (m : Type → Type) where
  throwString : String → m α

-- We want to enable use-cases where `ε = String`, so we
-- depend on `CoeTC` instead of `Coe`, as `Coe` is not reflexive.
instance [CoeTC String ε] [MonadExcept ε m] : MonadExceptString m where
  throwString := throw ∘ CoeTC.coe


class MonadBuilder (m : Type → Type) extends Monad m, MonadState PureBuilderState m, MonadExceptString m where

instance [Monad m] [MonadState PureBuilderState m] [MonadExceptString m] : MonadBuilder m where

-- TODO: change `String` to an error abbreviation.
-- This morally does not need IO, but uses IO to enable `StateRefT`..
abbrev BuilderM := StateRefT PureBuilderState (EST String Unit)

def BuilderM.run (a : BuilderM α) (init : PureBuilderState) : Except String (α × PureBuilderState) :=
  match StateRefT'.run a init |>.run () with
  | .ok (val, state) _ => .ok (val, state)
  | .error err _ => .error err


namespace Builder

export MonadExceptString (throwString)

variable {m : Type → Type} [MonadBuilder m]

def regGen : m Reg :=
  PureBuilderState.reg <$> getModify (fun s => { s with reg := s.reg + 1})

def modifybb  (bbid : BBId) (f : BasicBlock → BasicBlock) : m Unit :=  do
  match (← get).bbs.find? bbid with
  | none => throwString s!"unable to find basic block {bbid}"
  | .some bb => modify fun s => { s with bbs := s.bbs.insert bbid (f bb)}

def insertInstruction (i : Named Instruction) : m Unit := do
  match (← get).bbInsertionPt? with
  | none => -- TODO: improve error message by printing instruction.
    throwString ↑s!"need insertion point to insert instruction"
  | some bbid => modifybb (bbid : BBId) (BasicBlock.pushInstruction i)

def insertTerminator (t : Terminator) : m Unit := do
  match (← get).bbInsertionPt? with
  | none => -- TODO: improve error message by printing terminator.
    throwString ↑s!"need insertion point to insert terminator."
  | some bbid => modifybb (bbid : BBId) (fun bb => { bb with terminator := t})

def buildInstrWithDest (i : Instruction) : m Reg := do
  let dest ← regGen
  insertInstruction (.assign dest i)
  return dest


def Alloca (ty : Ty) (name : String := "") : m Reg :=
  buildInstrWithDest (Instruction.alloca ty name)

def Load2 (ty : Ty) (val : Reg) (name : String) : m Reg :=
  buildInstrWithDest (Instruction.load2 ty val name)

def Store (val pointer : Reg) : m Unit :=
  insertInstruction (.do_ <| .store val pointer)

def Gep (ty : Ty) (base : Reg) (ixs : Array Reg) : m Reg :=
  buildInstrWithDest (.gep ty base ixs)

def Inboundsgep (ty : Ty) (base : Reg) (ixs : Array Reg) : m Reg :=
  buildInstrWithDest (.inboundsgep ty base ixs)

def Sext (val : Reg) (destTy : Ty) : m Reg :=
  buildInstrWithDest (.sext val destTy)

def Zext (val : Reg) (destTy : Ty) : m Reg :=
  buildInstrWithDest (.zext val destTy)

def Ptrtoint (pointer : Reg) (destTy : Ty) : m Reg :=
  buildInstrWithDest (.ptrtoint pointer destTy)

def Mul (lhs rhs : Reg) (name : String) : m Reg :=
  buildInstrWithDest (.mul lhs rhs name)

def Add (lhs rhs : Reg) (name : String) : m Reg :=
  buildInstrWithDest (.add lhs rhs name)

def Sub (lhs rhs : Reg) (name : String) : m Reg :=
  buildInstrWithDest (.sub lhs rhs name)

def Not (arg : Reg) (name : String) : m Reg :=
  buildInstrWithDest (.not arg name)

def Icmp (pred : IntPredicate) (lhs rhs : Reg) (name : String) : m Reg :=
  buildInstrWithDest (.icmp pred lhs rhs name)

def Phi (ty : Ty) (args : Array (BBId × Reg)) : m Reg :=
  buildInstrWithDest (.phi ty args)

def Unreachable : m Unit := insertTerminator (.unreachable)

def Br (bbid : BBId) : m Unit :=  insertTerminator (.br bbid)

def Condbr (val : Reg) (then_ else_ : BBId) : m Unit := insertTerminator (.condbr val then_ else_)

def Ret (val : Reg) : m Unit := insertTerminator (.ret val)

def Switch (val : Reg) (cases : Array (Reg × BBId)) (default : BBId): m Unit :=
  insertTerminator (.switch val cases default)

def appendBB (bb : BasicBlock): m BBId := do
  let st ← get
  let bbid := st.bbid
  if let some i := st.functionInsertionPt? then
    if let some fn := st.functionDefs.find? i then
      let fn' := { fn with body := fn.body.push bbid }
      modify (fun s => {
        s with
        bbid := s.bbid + 1,
        bbs := s.bbs.insert bbid bb,
        functionDefs := s.functionDefs.insert i fn'
      })
      return bbid
    else
      throwString s!"The insertion point is {i} but that function definition does not exist"
  else
    throwString s!"No function insertion pointer is available"

def setInsertionPoint (bbid : BBId) : m Unit := do
  modify fun s => { s with bbInsertionPt? := bbid }

def functionIdGen : m FunctionId :=
  PureBuilderState.functionId <$> getModify (fun s => { s with functionId := s.functionId + 1})

def buildFunctionDeclaration (decl : FunctionDeclaration) : m FunctionId := do
  let fid ← functionIdGen
  modify (fun s => { s with functionDecls := s.functionDecls.insert fid decl })
  return fid

def buildFunctionDefinition (defn : FunctionDefinition): m FunctionId := do
  let fid ← functionIdGen
  modify (fun s => { s with functionDefs := s.functionDefs.insert fid defn })
  return fid

def setFunctionInsertionPoint (fid : FunctionId) : m Unit :=
  modify (fun s => { s with functionInsertionPt? := fid })

def globalIdGen : m GlobalId :=
  PureBuilderState.globalId <$> getModify (fun s => { s with functionId := s.functionId + 1})

def buildGlobalDeclaration (decl : FunctionDeclaration) : m GlobalId := do
  let gid ← globalIdGen
  modify (fun s => { s with functionDecls := s.functionDecls.insert gid decl })
  return gid

end Builder
/-
inductive Instruction where
| alloca (ty : Ty) (name : String)
| load2 (ty : Ty) (val : Reg) (name : String)
| store (val pointer : Reg)
| gep (ty : Ty) (base : Reg) (ixs : Array Reg)
| inboundsgep (ty : Ty) (base : Reg) (ixs : Array Reg)
| sext (val : Reg) (destTy : Ty) -- TODO: add source type argument.
| zext (val : Reg) (destTy : Ty) -- TODO: add source type argument.
| sext_or_trunc (val : Reg) (destTy : Ty) -- TODO: remove pseudo-instruction, provide builder.
| ptrtoint (pointer : Reg) (destTy : Ty)
| mul (lhs rhs : Reg) (name : String)
| add (lhs rhs : Reg) (name : String)
| sub (lhs rhs : Reg) (name : String)
| not (arg : Reg) (name : String) -- -- TODO: remove pseudo-instruction, provide builder.
| icmp (pred : IntPredicate) (lhs rhs : Reg) (name : String)
| phi (ty : Ty) (args : Array (BBId × Reg))
deriving Inhabited, BEq

scoped syntax "alloca" llvm_ty : llvm_instr
scoped syntax "load" llvm_ty ", " ptr_ident llvm_reg : llvm_instr
scoped syntax "store" llvm_ty llvm_value : llvm_instr
scoped syntax "getelemenptr" ("inbounds")? llvm_ty ", " ptr_ident llvm_reg (llvm_ty llvm_reg)* : llvm_instr
scoped syntax "sext" llvm_ty llvm_reg "to" llvm_ty : llvm_instr
scoped syntax "zext" llvm_ty llvm_reg "to" llvm_ty : llvm_instr
scoped syntax "sext_or_trunc" llvm_ty llvm_reg "to" llvm_ty : llvm_instr
scoped syntax "ptrtoint" llvm_ty llvm_reg "to" llvm_ty : llvm_instr
scoped syntax "mul" llvm_ty llvm_reg ", " llvm_reg : llvm_instr
scoped syntax "llvm.add" llvm_ty llvm_reg ", " llvm_reg : llvm_instr
scoped syntax "sub" llvm_ty llvm_reg ", " llvm_reg : llvm_instr
scoped syntax "not" llvm_ty llvm_reg : llvm_instr

syntax llvm_icmp_op := ("eq" <|> "ne" <|> "ugt" <|> "uge" <|> "ult" <|> "ule" <|> "sgt" <|> "sge" <|> "slt" <|> "sle")
scoped syntax "icmp" llvm_icmp_op llvm_ty llvm_reg ", " llvm_reg : llvm_instr
scoped syntax "phi" llvm_ty ("[" llvm_value ", " llvm_bb_label "]") : llvm_instr
-/

-- scoped syntax "build" llvm_instr : llvm_builder_instr
-- builder newbb ""

macro_rules
| `([llvm_ty| void]) => ``(Ty.void)
| `([llvm_ty| float]) => ``(Ty.float)
| `([llvm_ty| double]) => ``(Ty.double)
| `([llvm_ty| ptr]) => ``(Ty.opaquePointer 0)
| `([llvm_ty| $i:ident]) => do
  let str := i.getId.toString
  if str.startsWith "i" then
    if let some width := str.drop 1 |>.toNat? then
      return ←``(Ty.int $(Lean.quote width))
  Macro.throwErrorAt i s!"Unknown LLVM type: {str}"
| `([llvm_ty| $retty:llvm_ty ( $[$args:llvm_ty],* )]) => do
  let expanders : Array (TSyntax `term) ← args.mapM fun t => ``([llvm_ty| $t])
  let args : TSyntax `term ← ``(#[ $[ $expanders ],* ])
  ``(Ty.function $args [llvm_ty| $retty])
| `([llvm_ty| [ $n:num × $ty:llvm_ty ]]) =>
    ``(Ty.array [llvm_ty| $ty] ($n : UInt64))
| `([llvm_ty| $$($q)]) => `($q)


end Lean.IR.LLVM.Pure
