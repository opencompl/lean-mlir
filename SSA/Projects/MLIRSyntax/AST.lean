import SSA.Experimental.IntrinsicAsymptotics
open Lean PrettyPrinter

namespace MLIR.AST

-- variable (MCtxt : Type*)

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

inductive MLIRType : (Γ : Type*) → Type _ :=
  | int: Signedness -> Nat -> MLIRType Γ
  | float: Nat -> MLIRType Γ
  | tensor1d: MLIRType Γ -- tensor of int values. 
  | tensor2d: MLIRType Γ -- tensor of int values. 
  | tensor4d: MLIRType Γ -- tensor of int values. 
  | index:  MLIRType Γ
  | undefined: String → MLIRType Γ
  | mvar [Inhabited Γ] : (Γ → MLIRType Γ) → MLIRType Γ

instance : DecidableEq (MLIRType PEmpty) := by
  intro t u
  cases t <;> cases u 
  <;> try simp
  <;> infer_instance
  rcases ‹Inhabited PEmpty› with ⟨⟨⟩⟩

instance : Repr (MLIRType Γ) where
  reprPrec t n := match t with
    -- | .int s w => --f!"int {s} {w}"
    | _ => sorry


variable (Γ : Type*)  

-- We define "MLIRTy" to be just the basic types outside of any dialect
abbrev MLIRTy := MLIRType Γ

/-- Shorthand to build <iN> -/
def MLIRTy.i (width : Nat) : MLIRTy Γ := MLIRType.int Signedness.Signless width
-- Other useful abbreviations
abbrev MLIRType.i1: MLIRType Γ := MLIRType.int .Signless 1
abbrev MLIRType.i32: MLIRType Γ := MLIRType.int .Signless 32
def MLIRType.i (width : Nat) : MLIRTy Γ := MLIRType.int Signedness.Signless width

/-- An ssa value (variable name) with a type -/
abbrev TypedSSAVal := SSAVal × MLIRType Γ

mutual
inductive AttrValue :=
  | symbol: String -> AttrValue -- symbol ref attr
  | str : String -> AttrValue
  | int : Int -> MLIRType Γ -> AttrValue
  | nat: Nat -> AttrValue
  | bool : Bool -> AttrValue
  | float : Float -> MLIRType Γ -> AttrValue
  | type : MLIRType Γ -> AttrValue
  | affine: AffineMap -> AttrValue
  | permutation: List Nat -> AttrValue -- a permutation
  | list: List AttrValue -> AttrValue
  | nestedsymbol: AttrValue -> AttrValue -> AttrValue
  | alias: String -> AttrValue
  | dict: AttrDict -> AttrValue
  | opaque_: (dialect: String) -> (value: String) -> AttrValue
  | opaqueElements: (dialect: String) -> (value: String) -> (type: MLIRType Γ) -> AttrValue
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

def AttrEntry.destructure {Γ} : AttrEntry Γ → String × AttrValue Γ
  | .mk name value => (name,value)

def AttrDict.getAttr {Γ} : AttrDict Γ → String →  Option (AttrValue Γ)
  | .mk attrs, name => attrs.map AttrEntry.destructure |>.lookup name

-- We define "AttrVal" to be just the basic attributes outside of any dialect
abbrev AttrVal := AttrValue


mutual
-- | TODO: make this `record` when mutual records are allowed?
-- | TODO: make these arguments optional?
inductive Op where
  | mk: (name: String)
        -> (res: List <| TypedSSAVal Γ)
        -> (args: List <| TypedSSAVal Γ)
        -> (regions: List Region)
        -> (attrs: AttrDict Γ)
        -> Op

inductive Region where
  | mk: (name: String)
        -> (args: List <| TypedSSAVal Γ)
        -> (ops: List Op) -> Region

end

-- Attribute definition on the form #<name> = <val>
inductive AttrDefn where
  | mk: (name: String) -> (val: AttrValue Γ) -> AttrDefn

inductive Module where
  | mk: (functions: List <| Op Γ)
        -> (attrs: List <| AttrDefn Γ)
        ->  Module

def Op.name {Γ} : Op Γ -> String
  | Op.mk name .. => name

def Op.res {Γ} : Op Γ -> List (TypedSSAVal Γ)
  | Op.mk _ res .. => res

def Op.resNames {Γ} : Op Γ → List SSAVal
  | Op.mk _ res .. => res.map Prod.fst

def Op.resTypes {Γ} : Op Γ → List (MLIRType Γ)
  | Op.mk _ res .. => res.map Prod.snd

def Op.args {Γ} : Op Γ -> List (TypedSSAVal Γ)
  | Op.mk _ _ args .. => args

def Op.argNames {Γ} : Op Γ → List SSAVal
  | Op.mk _ _ args .. => args.map Prod.fst

def Op.argTypes {Γ} : Op Γ → List (MLIRType Γ)
  | Op.mk _ _ args .. => args.map Prod.snd

def Op.regions {Γ} : Op Γ  -> List (Region Γ)
  | Op.mk _ _ _ regions _ => regions

def Op.attrs {Γ} : Op Γ  -> (AttrDict Γ)
| Op.mk _ _ _ _ attrs => attrs

instance : Coe String SSAVal where
  coe (s: String) := SSAVal.SSAVal s

instance : Coe String (AttrValue Γ) where
  coe (s: String) := AttrValue.str s

instance : Coe Int (AttrValue Γ) where
  coe (i: Int) := AttrValue.int i (MLIRType.int .Signless 64)

instance : Coe (MLIRType Γ) (AttrValue Γ) where
  coe := AttrValue.type

instance : Coe (String × AttrValue Γ) (AttrEntry Γ) where
  coe v := AttrEntry.mk v.fst v.snd

instance : Coe (String × MLIRType Γ) (AttrEntry Γ) where
  coe v := AttrEntry.mk v.fst (AttrValue.type v.snd)

instance : Coe (AttrEntry Γ) (String × AttrValue Γ) where
  coe 
  | AttrEntry.mk key val => (key, val)

instance : Coe (List (AttrEntry Γ)) (AttrDict Γ) where
  coe
  | v => AttrDict.mk v

 instance : Coe (AttrDict Γ) (List (AttrEntry Γ)) where
  coe 
  | AttrDict.mk as => as

def Region.name (region : Region Γ) : BBName :=
  match region with
  | Region.mk name _ _ => BBName.mk name

def Region.args : Region Γ → List (TypedSSAVal Γ)
  | .mk _ args _ => args

def Region.ops (region: Region Γ) : List (Op Γ) :=
  match region with
  | Region.mk _ _ ops => ops


mutual
partial def docAttrVal {Γ} : AttrValue Γ → Format
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

partial def docAttrEntry {Γ} : AttrEntry Γ → Format
  | .mk k v => f!"{k} = " ++ (docAttrVal v)

partial def docAttrDict {Γ} : AttrDict Γ → Format
  | .mk attrs =>
      if List.isEmpty attrs
      then f!""
      else f!"\{" ++ (Format.join ((attrs.map docAttrEntry).intersperse ", ")) ++ f!"}"
end

instance : Repr (AttrValue Γ) where
  reprPrec x _ := docAttrVal x

instance : Repr (AttrEntry Γ) where
  reprPrec x _ := docAttrEntry x

instance : Repr (AttrDict Γ) where
  reprPrec x _ := docAttrDict x

instance : Repr (AttrDefn Γ) where
  reprPrec x _ := match x with
    | AttrDefn.mk name val => f!"#{name} := {repr val}"

instance : Repr SSAVal where
  reprPrec x _ := match x with
    | SSAVal.SSAVal name => f!"%{name}"

instance : ToFormat SSAVal where
  format := repr

mutual
partial def op_to_format {Γ} : Op Γ →  Format
  | Op.mk name res args rgns attrs =>
      let doc_name := f!"\"{name}\""
      let doc_rgns := if rgns.isEmpty
                      then f!""
                      else rgns.map (Format.align true ++ rgn_to_format ·) |> Format.join
      let doc_args := f!"({args.map repr |>.intersperse f!", " |> Format.join})"
      let doc_res := f!"({res.map repr |>.intersperse f!", " |> Format.join})"

      doc_res ++ " := " ++ doc_name ++ doc_args ++ doc_rgns ++ repr attrs

partial def rgn_to_format {Γ} : Region Γ → Format
  | Region.mk name args ops => 
      let doc_args := if args.isEmpty then
          f!""
        else
          f!"({args.map (fun (v, t) => f!"{repr v} : {repr t}") |>.intersperse "," |> Format.join})"
      let doc_ops := 
        ops.map (Format.align true ++ op_to_format ·) |> Format.join
      f!"^{name}{doc_args} : " ++ doc_ops
end

instance : Repr (Op Γ) := ⟨fun x _ => op_to_format x⟩
instance : Repr (Region Γ) := ⟨fun x _ => rgn_to_format x⟩

def AttrEntry.key {Γ} : AttrEntry Γ → String
  | AttrEntry.mk k _ => k

def AttrEntry.value {Γ} : AttrEntry Γ → AttrValue Γ
  | AttrEntry.mk _ v => v


def AttrDict.empty {Γ} : AttrDict Γ := AttrDict.mk []

def Op.empty {Γ} (name : String) : Op Γ := Op.mk name [] [] [] AttrDict.empty

def Op.addArg {Γ} (o : Op Γ) (arg : TypedSSAVal Γ) : Op Γ :=
  match o with
  | Op.mk name res args regions attrs =>
    Op.mk name res (args ++ [arg])  regions attrs

def Op.addResult {Γ} (o : Op Γ) (new_res : TypedSSAVal Γ) : Op Γ :=
 match o with
 | Op.mk name res args  regions attrs =>
    Op.mk name (res ++ [new_res]) args  regions attrs

def Op.appendRegion {Γ} (o : Op Γ) (r : Region Γ) : Op Γ :=
  match o with
  | Op.mk name res args regions attrs =>
      Op.mk name res args (regions ++ [r]) attrs


-- | Note: AttrEntry can be given as String × AttrValue
def AttrDict.add {Γ} (attrs : AttrDict Γ) (entry : AttrEntry Γ) : AttrDict Γ :=
    Coe.coe <| entry :: Coe.coe attrs

def AttrDict.find {Γ} (attrs : AttrDict Γ) (name : String) : Option (AttrValue Γ) :=
  match attrs with
  | AttrDict.mk entries =>
      match entries.find? (fun entry => entry.key == name) with
      | some v => v.value
      | none => none

def AttrDict.find_nat {Γ} (attrs : AttrDict Γ) (name : String) : Option Nat := 
  match attrs.find name with
  | .some (AttrValue.nat i) =>  .some i
  | _ => .none

def AttrDict.find_int {Γ} (attrs : AttrDict Γ) 
  (name : String): Option (Int × MLIRType Γ) :=
  match attrs.find name with
  | .some (AttrValue.int i ty) =>  .some (i, ty)
  | _ => .none

def AttrDict.find_int' {Γ} (attrs : AttrDict Γ) (name : String): Option Int :=
  match attrs.find name with
  | .some (AttrValue.int i _) =>  .some i
  | _ => .none

@[simp] theorem AttrDict.find_none:
    AttrDict.find (Γ := Γ) (AttrDict.mk []) n' = none := by
  simp [AttrDict.find, List.find?]

@[simp] theorem AttrDict.find_next (v : AttrValue Γ)
  (l : List (AttrEntry Γ)):
    AttrDict.find (AttrDict.mk (AttrEntry.mk n v :: l)) n' =
    if n == n' then some v else AttrDict.find (AttrDict.mk l) n' := by
  cases H: n == n' <;>
  simp [AttrDict.find, List.find?, AttrEntry.key, AttrEntry.value, H]

def AttrDict.addString (attrs: AttrDict Γ) (k: String) (v: String): AttrDict Γ :=
    AttrEntry.mk k (v : AttrValue Γ) :: attrs

def AttrDict.addType (attrs: AttrDict Γ) (k: String) (v: MLIRType Γ): AttrDict Γ :=
    AttrEntry.mk k (v : AttrValue Γ) :: attrs


def Op.addAttr (o: Op Γ) (k: String) (v: AttrValue Γ): Op Γ :=
 match o with
 | Op.mk name res args regions attrs =>
    Op.mk name res args regions (attrs.add (k, v))

def Region.empty {Γ} (name: String): Region Γ := Region.mk name [] []
def Region.appendOp (bb: Region Γ) (op: Op Γ): Region Γ :=
  match bb with
  | Region.mk name args bbs => Region.mk name args (bbs ++ [op])

def Region.appendOps (bb: Region Γ) (ops: List (Op Γ)): Region Γ :=
  match bb with
  | Region.mk name args bbs => Region.mk name args (bbs ++ ops)


instance : Inhabited (MLIRType Γ) where
  default := MLIRType.undefined "INHABITANT"

instance : Inhabited (AttrValue Γ) where
  default := AttrValue.str "INHABITANT"

instance : Inhabited (Op Γ) where
  default := Op.empty "INHABITANT"

instance : Inhabited (Region Γ) where
  default := Region.empty "INHABITANT"

instance : Repr (Module Γ) where
  reprPrec
  | Module.mk fs attrs, _ =>
      attrs.map repr ++ fs.map repr |>.map (Format.align true ++ ·) |> Format.join

def Region.fromOps (os: List (Op Γ)) (name: String := "entry") : Region Γ :=
  Region.mk name [] os

def Region.setArgs (bb: Region Γ) (args: List (SSAVal × MLIRType Γ)) : Region Γ :=
  match bb with
    | (Region.mk name _ ops) => (Region.mk name args ops)

end MLIR.AST