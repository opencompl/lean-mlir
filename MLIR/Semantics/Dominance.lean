/-
## Dominance check

This files defines functions to check that an IR satisfies SSA.
In particular, this will also check that operations have at most one result,
and each region has at most one block.
-/


import MLIR.AST
import MLIR.Semantics.Types
open MLIR.AST

/-
### Dominance Context

Context that holds the names and types of the SSA values that are
defined in the scope.
-/

-- List of typed values that are in scope
abbrev DomContext (δ: Dialect α σ ε) := List (SSAVal × MLIRType δ)

-- Add a typed SSA value in the context
def DomContext.addVal (ctx: DomContext δ) (val: SSAVal) (τ: MLIRType δ) :
    DomContext δ :=
  (val, τ)::ctx

-- Return true if an SSA name is already defined
def DomContext.isValDefined (ctx: DomContext δ) (val: SSAVal) : Bool :=
  (ctx.find? (val == ·.fst)).isSome

-- Return true if an SSA value has already been defined with the correct type
def DomContext.isValUseCorrect (ctx: DomContext δ) (val: SSAVal)
    (τ: MLIRType δ) : Bool :=
  match (ctx.find? (val == ·.fst)) with
  | some (_, τ') => τ == τ'
  | none => false

-- Check that an SSA value definition is correct, and append it to the context
def valDefinitionObeySSA (val: TypedSSAVal δ) (ctx: DomContext δ)
    : Option (DomContext δ) :=
  if ctx.isValDefined val.fst then none else ctx.addVal val.fst val.snd

-- Check that operands are already defined, with
def operandsDefinitionObeySSA (args: List (TypedSSAVal δ)) (ctx: DomContext δ) : Bool :=
  args.all (λ ⟨val, τ⟩ => ctx.isValUseCorrect val τ)

/-
### Dominance check

Check that an IR satisfies SSA.
-/

def MLIR.AST.OpRegion.obeysSSA (op: OpRegion δ k) (ctx: DomContext δ):  Option (DomContext δ) :=
match op with
| .op _ results operands regions _ => do
    -- Check operands
    let _ ← match operandsDefinitionObeySSA operands ctx with
            | true => pure ctx
            | false => none
    -- Check regions
    let _ <- OpRegion.obeysSSA regions ctx
    -- Check results
    let ctx' <- match results with
             | [] => ctx
             | [result] => valDefinitionObeySSA result ctx
             | _ => none
    ctx'
| .opsnil => ctx
| .opscons o os =>  (o.obeysSSA ctx).bind (os.obeysSSA)

| .regionsnil => .some ctx
| .regionscons r rs => do
    -- reuse ctx!
    let _ <- OpRegion.obeysSSA r ctx
    let _ <- OpRegion.obeysSSA rs ctx
    return ctx
| .region name args stmts => do
    let ctx' <- args.foldlM (fun ctx arg => valDefinitionObeySSA arg ctx) ctx
    OpRegion.obeysSSA stmts ctx'


/-
### Uniqueness of SSA names

Check that SSA names are unique, even across regions.
This simplifies a lot our proofs.
This is not always implied by Dominance check, since with dominance check,
two regions in a same operation can have operations defining the same ssa name.
-/

-- Contains the names that are already defined
abbrev NameContext := List SSAVal

-- Add a typed SSA value in the context
def NameContext.addVal (ctx: NameContext) (val: SSAVal) : NameContext :=
  val::ctx

-- Return true if an SSA name is already defined
def NameContext.isValDefined (ctx: NameContext) (val: SSAVal) : Bool :=
  (ctx.find? (val == ·)).isSome

-- Check that an SSA value definition has name that wasn't previously defined
def valDefHasUniqueNames (ctx: NameContext) (val: SSAVal)
    : Option NameContext :=
  if ctx.isValDefined val then
    some (ctx.addVal val)
  else
    none

def MLIR.AST.OpRegion.hasUniqueNames (o: OpRegion δ k) (ctx: NameContext): Option NameContext :=
match o with
| .op _ _ _ regions _ => regions.hasUniqueNames ctx
| .opsnil => none -- wtf
| .opscons o os => (o.hasUniqueNames ctx).bind os.hasUniqueNames
| .regionsnil => none --wtf?
| .regionscons r rs => (r.hasUniqueNames ctx).bind (rs.hasUniqueNames)
| .region name args ops => do
    let ctx' ← args.foldlM (fun ctx arg => valDefHasUniqueNames ctx arg.fst) ctx
    ops.hasUniqueNames ctx'


/-
### Use-def chain operations

Get the definition of a variable, or check if it is used
-/

def isDefined (var: SSAVal) (op: Op δ) : Bool :=
  var ∈ op.resNames

def isDefined' (var: SSAVal) (res: List (TypedSSAVal δ)) : Bool :=
  var ∈ res.map Prod.fst

def MLIR.AST.OpRegion.isSSADef (mVar: SSAVal) (or: OpRegion δ k): Bool :=
match or with
| .op _ res _ regions _ => isDefined' mVar res || regions.isSSADef mVar
| .region _ _ ops => ops.isSSADef mVar
| .opsnil => False
| .opscons o os => o.isSSADef mVar || os.isSSADef mVar
| .regionsnil => False
| .regionscons r rs => r.isSSADef mVar || rs.isSSADef mVar

/-
Check if the variable used by the operation.
Do not check inside the regions inside the operation.
-/

def isUsed (var: SSAVal) (op: Op δ) : Bool :=
  var ∈ op.argNames

def isUsed' (var: SSAVal) (args: List (TypedSSAVal δ)) : Bool :=
  var ∈ args.map Prod.fst

/-
Check if `op` is used by `user`.
An operation is used by another operation if one of its
argument is used by the operation.
-/
def isOpUsed (op user: Op δ) : Bool :=
  op.resNames.any (fun arg => isUsed arg user)


def MLIR.AST.OpRegion.isUsed (mVar: SSAVal) (or: OpRegion δ k): Bool :=
match or with
| .op _ _ args regions _ => isUsed' mVar args || regions.isUsed mVar
| .region _ _ ops => ops.isUsed mVar
| .opsnil => False
| .opscons o os => o.isUsed mVar || os.isUsed mVar
| .regionsnil => False
| .regionscons r rs => r.isUsed mVar || rs.isUsed mVar


def MLIR.AST.OpRegion.getDefiningOp (mVar: SSAVal) (or: OpRegion δ k): Option (Op δ) :=
match or with
| .op name res args regions attrs =>
   if isDefined' mVar res then some (.op name res args regions attrs)
   else regions.getDefiningOp mVar
| .region _ _ ops => ops.getDefiningOp mVar
| .opsnil => none
| .opscons o os =>
    match o.getDefiningOp mVar with
    | .some v => .some v
    | .none => os.getDefiningOp mVar
| .regionsnil => none
| .regionscons r rs =>
    match r.getDefiningOp mVar with
    | .some v => .some v
    | .none => rs.getDefiningOp mVar




/-
Check if the variable is free in a program.
A variable is free if it is not used or defined in the program.
-/

def MLIR.AST.OpRegion.isVarFree (mVar: SSAVal) (or: OpRegion δ k): Bool :=
match or with
| .op _ rets args regions _ =>
   ¬ isUsed' mVar args && ¬ isDefined' mVar rets && regions.isVarFree mVar
| .region _ _ ops => ops.isVarFree mVar
| .opsnil => False
| .opscons o os => o.isVarFree mVar && os.isVarFree mVar
| .regionsnil => False
| .regionscons r rs => r.isVarFree mVar && rs.isVarFree mVar

def freeInOp_implies_not_used :
    op.isVarFree var  -> ¬isUsed var op := by
  unfold OpRegion.isVarFree
  cases op
  simp
  intros H1 H2 H3
  assumption

def freeInOp_implies_not_defined :
    op.isVarFree var -> ¬isDefined var op := by
  unfold OpRegion.isVarFree
  cases op
  simp
  intros H1 H2 H3
  assumption
