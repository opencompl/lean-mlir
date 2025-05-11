import Lean
import SSA.Core.MLIRSyntax.AST
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
open Lean PrettyPrinter Delaborator SubExpr MLIR AST Elab Term Syntax
open PrettyPrinter

-- AFFINE SYNTAX
-- ============

@[app_unexpander AST.AffineExpr.Var]
def unexpandAffineExprVar : Unexpander
  | `($_ $xstr:str) =>
    let xraw := mkIdent $ Name.mkSimple xstr.getString
    `([affine_expr| $xraw:ident])
  | _ => throw ()


@[app_unexpander AST.AffineTuple.mk]
def unexpandAffineTuplemk : Unexpander
  | `($_ [$[$terms],*]) =>
     let affexprs : Array (TSyntax `affine_expr) := terms.map fun term => match term with
      | `([affine_expr| $n]) => n
      | _ => panic! "affine_expr is illformed"
    `([affine_tuple|($affexprs,*)])
  | _ => throw ()


@[app_unexpander AST.AffineMap.mk]
def unexpandAffineMapmk : Unexpander
  | `($_ [affine_tuple|($xs,*)] [affine_tuple|($ys,*)]) =>
    `([affine_map|affine_map< ($xs,*) -> ($ys,*)>])
  | _ => throw ()
/-- info: [affine_expr|foo] : AffineExpr -/
#guard_msgs in #check [affine_expr|foo]

/-- info: [affine_tuple|(a,b,c)] : AffineTuple -/
#guard_msgs in #check [affine_tuple| (a,b,c) ]

/-- info: [affine_map|affine_map<(a,b)->(c,d)>] : AffineMap -/
#guard_msgs in #check [affine_map|affine_map<(a,b)->(c,d)>]


-- EDSL OPERANDS
-- ==============
-- TODO?: unexpander for [mlir_op_operand | $$($q)]


-- TODO: this should become: [mlir_op_operand| %x] : MLIR.SSAVal
/--
info: SSAVal.name (EDSL.IntToString 0) : SSAVal
-/
#guard_msgs in #check [mlir_op_operand| %0]

@[app_unexpander AST.SSAVal] -- broken?
def unexpandSSAValSSSAVal: Unexpander
  | `($_ $xstr:str) =>
    let xraw := mkIdent $ Name.mkSimple xstr.getString
    `([mlir_op_operand| % $xraw:ident])
  | `($_ $a) => match a with
    | `(EDSL.IntToString $n:num) => `([mlir_op_operand| % $n:num])
    | _ => throw ()
  | _ => throw ()

-- TODO: This should become: [mlir_op_operand| %x] : MLIR.SSAVal
/--
info: SSAVal.name "x" : SSAVal
-/
#guard_msgs in #check [mlir_op_operand| %x]

-- TODO: This should become: [mlir_op_operand| %0] : MLIR.SSAVal
/--
info: SSAVal.name (EDSL.IntToString 0) : SSAVal
-/
#guard_msgs in #check [mlir_op_operand| %0]


-- EDSL OP-SUCCESSOR-ARGS
-- =================

-- successor-list       ::= `[` successor (`,` successor)* `]`
-- successor            ::= caret-id (`:` bb-arg-list)?


@[app_unexpander AST.BBName.mk]
def unexpandBBNamemk : Unexpander
  | `($_ $xstr:str) =>
    let xraw := mkIdent $ Name.mkSimple xstr.getString
    `([mlir_op_successor_arg| ^ $xraw:ident ])
  | _ => throw ()

/--
info: [mlir_op_successor_arg|^bb] : BBName
-/
#guard_msgs in #check [mlir_op_successor_arg| ^bb]


-- EDSL MLIR TYPES
-- ===============

-- TODO: Hardcoded meta-variable case?
@[app_unexpander AST.MLIRType.int]
def unexpandMLIRTypeint : Unexpander
  | `($_ Signedness.Signless $n:num) =>
    let xid := mkIdent $ Name.mkSimple  ("i" ++ n.getNat.repr)
    `([mlir_type|$xid:ident])
  | _ => throw ()

#check [mlir_type| i32]


@[app_unexpander AST.MLIRType.float]
def unexpandMLIRTypefloat : Unexpander
  | `($_ $n:num) =>
    let xid := mkIdent $ Name.mkSimple  ("f" ++ n.getNat.repr)
    `([mlir_type|$xid:ident])
  | _ => throw ()

#check [mlir_type| f32]


@[app_unexpander AST.MLIRType.index]
def unexpandMLIRTypefindex : Unexpander
  | `($_ ) =>
    let id := mkIdent $ Name.mkSimple  ("index")
    `([mlir_type|$id:ident])

#check [mlir_type| index]


@[app_unexpander AST.MLIRType.undefined]
def unexpandMLIRTypeundefined : Unexpander
  | `($_ $x:str) =>
    `([mlir_type| ! $x:str ])
  | `($_ $x:ident) =>
    `([mlir_type| ! $x:ident ])
  | _ => throw ()

-- unexpander currently has no way of determining between idents and strings because
-- the macro sends them both to strings
#check [mlir_type| !shape.value]
#check [mlir_type| !"lz.int"]


@[app_unexpander  AST.MLIRType.tensor1d]
def unexpandMLIRTypetensor1d : Unexpander
  | `($_ ) =>
      `([mlir_type|tensor1d])

#check [mlir_type| tensor1d]


@[app_unexpander  AST.MLIRType.tensor2d]
def unexpandMLIRTypetensor2d : Unexpander
  | `($_ ) =>
      `([mlir_type|tensor2d])

#check [mlir_type| tensor2d]


-- === VECTOR TYPE ===
--skipping vector <> for now because it may currently have bugs



-- EDSL MLIR USER ATTRIBUTES
-- =========================


-- EDSL MLIR BASIC BLOCK OPERANDS
-- ==============================


-- EDSL MLIR BASIC BLOCKS
-- ======================


def stringToMLIRuniform_op(op_name : String): UnexpandM (TSyntax `MLIR.Pretty.uniform_op) :=
  match op_name with
    | "llvm.return" => `(MLIR.Pretty.uniform_op|llvm.return)
    | "llvm.copy"   => `(MLIR.Pretty.uniform_op|llvm.copy)
    | "llvm.neg"    => `(MLIR.Pretty.uniform_op|llvm.neg)
    | "llvm.not"    => `(MLIR.Pretty.uniform_op|llvm.not)
    --| "llvm.add"    => `(MLIR.Pretty.exact_op|llvm.add)
    | "llvm.and"    => `(MLIR.Pretty.uniform_op|llvm.and)
    --| "llvm.ashr"   => `(MLIR.Pretty.uniform_op|llvm.ashr)
    --| "llvm.lshr"   => `(MLIR.Pretty.uniform_op|llvm.lshr)
    --| "llvm.mul"    => `(MLIR.Pretty.uniform_op|llvm.mul)
    --| "llvm.or"     => `(MLIR.Pretty.uniform_op|llvm.or)
    --| "llvm.sdiv"   => `(MLIR.Pretty.uniform_op|llvm.sdiv)
    --| "llvm.shl"    => `(MLIR.Pretty.uniform_op|llvm.shl)
    | "llvm.srem"   => `(MLIR.Pretty.uniform_op|llvm.srem)
    --| "llvm.sub"    => `(MLIR.Pretty.uniform_op|llvm.sub)
    --| "llvm.udiv"   => `(MLIR.Pretty.uniform_op|llvm.udiv)
    | "llvm.urem"   => `(MLIR.Pretty.uniform_op|llvm.urem)
    | "llvm.xor"    => `(MLIR.Pretty.uniform_op|llvm.xor)
    | _ => throw ()


def AttrDictToneg_num(attrDict : TSyntax `term) : UnexpandM (TSyntax `MLIR.EDSL.neg_num) :=
  match attrDict with
    | `(AttrDict.mk [AttrEntry.mk "value" $attrValue]) =>
      match attrValue with
      | `(AttrValue.int $val $t) =>
        match val with
        | `($v:num) => `(MLIR.EDSL.neg_num| $v:num)
        | `(-$v:num) => `(MLIR.EDSL.neg_num| -$v:num)
        | _ => throw ()
      | _ => throw ()
    | _ => throw ()


@[app_unexpander AST.Region.mk]
def unexpandRegionmk : Unexpander
  |  `($_ $xstr:str [$[$argsList],*] [$[$opsList],*]) => do
      let xraw := mkIdent $ Name.mkSimple xstr.getString
      let mut args : Array (TSyntax `mlir_bb_operand) := Array.empty
      for term in argsList do
         match term with
          | `(([mlir_op_operand| $name], [mlir_type|$ty])) =>
            let x ← `(mlir_bb_operand|$name:mlir_op_operand : $ty:mlir_type)
            args := args.push x
          | _ => throw ()
      let mut ops : Array (TSyntax `mlir_op) := Array.empty
      for op in opsList do
        match op with
          | `(Op.mk $name:str [$[$res],*] [$[$operands],*] [$[$rgnsList],*] $attrDict) =>
              if name.getString == "llvm.mlir.constant"
              then
                match (res[0]!) with
                  | `(([mlir_op_operand| $arg], [mlir_type| $ty])) =>
                    let neg ← AttrDictToneg_num attrDict
                    ops := ops.push (← `(mlir_op| $arg:mlir_op_operand = llvm.mlir.constant ($neg) : $ty))
                  | _ => throw ()
              else
                let op_function_name ← stringToMLIRuniform_op name.getString
                let mlir_op_operands := operands.map fun  operand => match operand with
                | `(([mlir_op_operand| $arg], [mlir_type| $ty])) => arg
                | _ => panic! ""
                if res == Array.empty
                then
                  throw ()
                  -- TODO: This was disabled as it did not compile
                  -- match (operands[0]!) with
                  --   | `(([mlir_op_operand| $arg], [mlir_type| $ty])) =>
                  --     ops := ops.push (← `(mlir_op| $arg:mlir_op_operand = $op_function_name $mlir_op_operands,* : $ty))
                  --   | _ => throw ()
                else
                  throw ()
                  -- TODO: This was disabled as it did not compile
                  -- match (res[0]!) with
                  --  | `(([mlir_op_operand| $arg], [mlir_type| $ty])) =>
                  --    ops := ops.push (← `(mlir_op| $arg:mlir_op_operand = $op_function_name $mlir_op_operands,* : $ty))
                  --  | _ => throw ()
          | _ => pure ()
      let rgn_ops ← `(mlir_ops| $[ $ops ]*)
      `([mlir_region|{^$xraw:ident ($[$args],*) : $rgn_ops}])
  | _ => throw ()


-- [mlir_region|{
--     ^bb0(%arg0: i32):
--     %0 = llvm.mlir.constant(-8) : i32
--       %1 = llvm.mlir.constant(31) : i32
--       %2 = llvm.ashr %arg0, %1 : i32
--       %3 = llvm.and %2, %0 : i32
--       %4 = llvm.add %3, %2 : i32
--       %4 = llvm.return %4 : i32
--       }] : Region ?m.28125
#check [mlir_region| {
  ^bb0(%arg0: i32):
    %0 = llvm.mlir.constant(-8) : i32
    %1 = llvm.mlir.constant(31) : i32
    %2 = llvm.ashr %arg0, %1 : i32
    %3 = llvm.and %2, %0 : i32
    %4 = llvm.add %3, %2 : i32
    llvm.return %4 : i32
  }]
