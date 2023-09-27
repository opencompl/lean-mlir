import SSA.Core.Framework
open Lean PrettyPrinter

namespace MLIR.AST

-- Affine expressions [TODO: find some way to separate this out]
-- ==================
inductive AffineExpr
  | Var: String -> AffineExpr
  deriving DecidableEq, Repr

inductive AffineTuple
  | mk: List AffineExpr -> AffineTuple
  deriving DecidableEq, Repr
  -- TODO: make prettier `Repr` instance

inductive AffineMap
  | mk: AffineTuple -> AffineTuple -> AffineMap
  deriving DecidableEq, Repr

-- EMBEDDING
-- ==========

inductive BBName
  | mk: String -> BBName
  deriving DecidableEq, Repr

/-- An ssa value is a variable name -/
inductive SSAVal : Type where
  | SSAVal : String -> SSAVal
deriving DecidableEq, Repr

def SSAValToString (s: SSAVal): String :=
  match s with
  | SSAVal.SSAVal str => str

instance : ToString SSAVal where
  toString := SSAValToString

inductive Signedness :=
  | Signless -- i*
  | Unsigned -- u*
  | Signed   -- si*
deriving DecidableEq, Repr

inductive MLIRType :=
  | int: Signedness -> Nat -> MLIRType
  | float: Nat -> MLIRType
  | tensor1d: MLIRType -- tensor of int values. 
  | tensor2d: MLIRType -- tensor of int values. 
  | tensor4d: MLIRType -- tensor of int values. 
  | index:  MLIRType
  | undefined: String → MLIRType
deriving DecidableEq, Repr

-- We define "MLIRTy" to be just the basic types outside of any dialect
abbrev MLIRTy := MLIRType

/-- Shorthand to build <iN> -/
def MLIRTy.i (width : Nat) : MLIRTy := MLIRType.int Signedness.Signless width
-- Other useful abbreviations
abbrev MLIRType.i1: MLIRType := MLIRType.int .Signless 1
abbrev MLIRType.i32: MLIRType := MLIRType.int .Signless 32
def MLIRType.i (width : Nat) : MLIRTy := MLIRType.int Signedness.Signless width

/-- An ssa value (variable name) with a type -/
abbrev TypedSSAVal := SSAVal × MLIRType

mutual
inductive AttrValue :=
  | symbol: String -> AttrValue -- symbol ref attr
  | str : String -> AttrValue
  | int : Int -> MLIRType -> AttrValue
  | nat: Nat -> AttrValue
  | bool : Bool -> AttrValue
  | float : Float -> MLIRType -> AttrValue
  | type : MLIRType -> AttrValue
  | affine: AffineMap -> AttrValue
  | permutation: List Nat -> AttrValue -- a permutation
  | list: List AttrValue -> AttrValue
  | nestedsymbol: AttrValue -> AttrValue -> AttrValue
  | alias: String -> AttrValue
  | dict: AttrDict -> AttrValue
  | opaque_: (dialect: String) -> (value: String) -> AttrValue
  | opaqueElements: (dialect: String) -> (value: String) -> (type: MLIRType) -> AttrValue
  | unit: AttrValue

-- https://mlir.llvm.org/docs/LangRef/#attributes
-- | TODO: add support for mutually inductive records / structures
inductive AttrEntry  :=
  | mk: (key: String)
      -> (value: AttrValue)
      -> AttrEntry

inductive AttrDict :=
  | mk: List AttrEntry -> AttrDict

end

def AttrEntry.destructure : AttrEntry → String × AttrValue
  | .mk name value => (name,value)

def AttrDict.getAttr : AttrDict → String →  Option AttrValue
  | .mk attrs, name => attrs.map AttrEntry.destructure |>.lookup name

-- We define "AttrVal" to be just the basic attributes outside of any dialect
abbrev AttrVal := AttrValue


mutual
-- | TODO: make this `record` when mutual records are allowed?
-- | TODO: make these arguments optional?
inductive Op where
  | mk: (name: String)
        -> (res: List TypedSSAVal)
        -> (args: List TypedSSAVal)
        -> (regions: List Region)
        -> (attrs: AttrDict)
        -> Op

inductive Region where
  | mk: (name: String)
        -> (args: List TypedSSAVal)
        -> (ops: List Op) -> Region

end

-- Attribute definition on the form #<name> = <val>
inductive AttrDefn where
  | mk: (name: String) -> (val: AttrValue) -> AttrDefn

inductive Module where
  | mk: (functions: List Op)
        -> (attrs: List (AttrDefn))
        ->  Module

def Op.name : Op -> String
  | Op.mk name .. => name

def Op.res : Op -> List TypedSSAVal
  | Op.mk _ res .. => res

def Op.resNames : Op → List SSAVal
  | Op.mk _ res .. => res.map Prod.fst

def Op.resTypes : Op → List MLIRType
  | Op.mk _ res .. => res.map Prod.snd

def Op.args : Op -> List TypedSSAVal
  | Op.mk _ _ args .. => args

def Op.argNames : Op → List SSAVal
  | Op.mk _ _ args .. => args.map Prod.fst

def Op.argTypes : Op → List MLIRType
  | Op.mk _ _ args .. => args.map Prod.snd

def Op.regions : Op -> List Region
  | Op.mk _ _ _ regions _ => regions

def Op.attrs : Op -> AttrDict
| Op.mk _ _ _ _ attrs => attrs

instance : Coe String SSAVal where
  coe (s: String) := SSAVal.SSAVal s

instance : Coe String AttrValue where
  coe (s: String) := AttrValue.str s

instance : Coe Int AttrValue where
  coe (i: Int) := AttrValue.int i (MLIRType.int .Signless 64)

instance : Coe MLIRType AttrValue where
  coe (t: MLIRType) := AttrValue.type t

instance : Coe (String × AttrValue) AttrEntry where
  coe (v: String × AttrValue) := AttrEntry.mk v.fst v.snd

instance : Coe (String × MLIRType) AttrEntry where
  coe (v: String × MLIRType) := AttrEntry.mk v.fst (AttrValue.type v.snd)

instance : Coe  AttrEntry (String × AttrValue) where
  coe 
  | AttrEntry.mk key val => (key, val)

instance : Coe (List AttrEntry) (AttrDict) where
  coe
  | v => AttrDict.mk v

 instance : Coe AttrDict (List AttrEntry) where
  coe 
  | AttrDict.mk as => as

def Region.name (region: Region) : BBName :=
  match region with
  | Region.mk name _ _ => BBName.mk name

def Region.args : Region → List TypedSSAVal
  | .mk _ args _ => args

def Region.ops (region: Region) : List (Op) :=
  match region with
  | Region.mk _ _ ops => ops

#check Format

mutual
partial def docAttrVal : AttrValue → Format
  | .symbol s => f!"@\"{s}\""
  | .permutation ps => f!"[permutation {ps}]"
  | .nestedsymbol s t => (docAttrVal s) ++ "::" ++ (docAttrVal t)
  | .str str => f!"\"{str}\""
  | .type ty => repr ty
  | .int x ty | .float x ty => f!"{x} : {repr ty}"
  | .nat i => f!"{i} : index"
  | .bool b => if b then "true" else "false"
  | .affine aff => f!"affine_map< {repr aff} >"
  | .list xs => f!"[" ++ Format.join ((xs.map docAttrVal).intersperse ", ") ++ "]"
  | .alias a => "#" ++ a
  | .dict d => docAttrDict d
  | .opaque_ dialect val => f!"#${dialect}<${val}>"
  | .opaqueElements dialect val ty => f!"#opaque< {dialect}, #{val}> : #{repr ty}"
  | .unit => "()"

partial def docAttrEntry : AttrEntry → Format
  | .mk k v => f!"{k} = " ++ (docAttrVal v)

partial def docAttrDict : AttrDict → Format
  | .mk attrs =>
      if List.isEmpty attrs
      then f!""
      else f!"\{" ++ (Format.join ((attrs.map docAttrEntry).intersperse ", ")) ++ f!"}"
end

instance : Repr AttrValue where
  reprPrec x _ := docAttrVal x

instance : Repr AttrEntry where
  reprPrec x _ := docAttrEntry x

instance : Repr AttrDict where
  reprPrec x _ := docAttrDict x

instance : Repr AttrDefn where
  reprPrec x _ := match x with
    | AttrDefn.mk name val => f!"#{name} := {repr val}"

instance : Repr SSAVal where
  reprPrec x _ := match x with
    | SSAVal.SSAVal name => f!"%{name}"

instance : ToFormat SSAVal where
  format := repr

mutual
partial def op_to_format : Op →  Format
  | Op.mk name res args rgns attrs =>
      let doc_name := f!"\"{name}\""
      let doc_rgns := if rgns.isEmpty
                      then f!""
                      else rgns.map (Format.align true ++ rgn_to_format ·) |> Format.join
      let doc_args := f!"({args.map repr |>.intersperse f!", " |> Format.join})"
      let doc_res := f!"({res.map repr |>.intersperse f!", " |> Format.join})"

      doc_res ++ " := " ++ doc_name ++ doc_args ++ doc_rgns ++ repr attrs

partial def rgn_to_format : Region → Format
  | Region.mk name args ops => 
      let doc_args := if args.isEmpty then
          f!""
        else
          f!"({args.map (fun (v, t) => f!"{repr v} : {repr t}") |>.intersperse "," |> Format.join})"
      let doc_ops := 
        ops.map (Format.align true ++ op_to_format ·) |> Format.join
      f!"^{name}{doc_args} : " ++ doc_ops
end

instance : Repr Op := ⟨fun x _ => op_to_format x⟩
instance : Repr Region := ⟨fun x _ => rgn_to_format x⟩

def AttrEntry.key : AttrEntry → String
  | AttrEntry.mk k _ => k

def AttrEntry.value : AttrEntry → AttrValue
  | AttrEntry.mk _ v => v


def AttrDict.empty : AttrDict := AttrDict.mk []

def Op.empty (name : String) : Op := Op.mk name [] [] [] AttrDict.empty

def Op.addArg (o : Op) (arg: TypedSSAVal) : Op :=
  match o with
  | Op.mk name res args regions attrs =>
    Op.mk name res (args ++ [arg])  regions attrs

def Op.addResult (o : Op) (new_res: TypedSSAVal) : Op :=
 match o with
 | Op.mk name res args  regions attrs =>
    Op.mk name (res ++ [new_res]) args  regions attrs

def Op.appendRegion (o : Op) (r: Region) : Op :=
  match o with
  | Op.mk name res args regions attrs =>
      Op.mk name res args (regions ++ [r]) attrs


-- | Note: AttrEntry can be given as String × AttrValue
def AttrDict.add (attrs : AttrDict) (entry : AttrEntry) : AttrDict :=
    Coe.coe <| entry :: Coe.coe attrs

def AttrDict.find (attrs : AttrDict) (name : String) : Option AttrValue :=
  match attrs with
  | AttrDict.mk entries =>
      match entries.find? (fun entry => entry.key == name) with
      | some v => v.value
      | none => none

def AttrDict.find_nat (attrs : AttrDict) (name : String) : Option Nat := 
  match attrs.find name with
  | .some (AttrValue.nat i) =>  .some i
  | _ => .none

def AttrDict.find_int (attrs : AttrDict) 
  (name : String): Option (Int × MLIRType) :=
  match attrs.find name with
  | .some (AttrValue.int i ty) =>  .some (i, ty)
  | _ => .none

def AttrDict.find_int' (attrs : AttrDict) (name : String): Option Int :=
  match attrs.find name with
  | .some (AttrValue.int i _) =>  .some i
  | _ => .none

@[simp] theorem AttrDict.find_none:
    AttrDict.find (AttrDict.mk []) n' = none := by
  simp [AttrDict.find, List.find?]

@[simp] theorem AttrDict.find_next (v: AttrValue)
  (l: List AttrEntry):
    AttrDict.find (AttrDict.mk (AttrEntry.mk n v :: l)) n' =
    if n == n' then some v else AttrDict.find (AttrDict.mk l) n' := by
  cases H: n == n' <;>
  simp [AttrDict.find, List.find?, AttrEntry.key, AttrEntry.value, H]

def AttrDict.addString (attrs: AttrDict) (k: String) (v: String): AttrDict :=
    AttrEntry.mk k (v: AttrValue) :: attrs

def AttrDict.addType (attrs: AttrDict) (k: String) (v: MLIRType): AttrDict :=
    AttrEntry.mk k (v: AttrValue) :: attrs


def Op.addAttr (o: Op) (k: String) (v: AttrValue): Op :=
 match o with
 | Op.mk name res args regions attrs =>
    Op.mk name res args regions (attrs.add (k, v))

def Region.empty (name: String): Region := Region.mk name [] []
def Region.appendOp (bb: Region) (op: Op): Region :=
  match bb with
  | Region.mk name args bbs => Region.mk name args (bbs ++ [op])

def Region.appendOps (bb: Region) (ops: List Op): Region :=
  match bb with
  | Region.mk name args bbs => Region.mk name args (bbs ++ ops)


instance : Inhabited MLIRType where
  default := MLIRType.undefined "INHABITANT"

instance : Inhabited AttrValue where
  default := AttrValue.str "INHABITANT"

instance : Inhabited Op where
  default := Op.empty "INHABITANT"

instance : Inhabited Region where
  default := Region.empty "INHABITANT"

instance : Repr Module where
  reprPrec
  | Module.mk fs attrs, _ =>
      attrs.map repr ++ fs.map repr |>.map (Format.align true ++ ·) |> Format.join

def Region.fromOps (os: List (Op)) (name: String := "entry"): Region :=
  Region.mk name [] os

def Region.setArgs (bb: Region) (args: List (SSAVal × MLIRType)) : Region :=
  match bb with
    | (Region.mk name _ ops) => (Region.mk name args ops)


end MLIR.AST
