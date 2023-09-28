import SSA.Experimental.IntrinsicAsymptotics
open Lean PrettyPrinter


inductive A {Γ : Type*} 
| mk : (Γ → A) → A
| mk2 : A

inductive B {Γ : Type*} {Δ : Type*}
| mk : (Γ → Δ) → B
| mk2 : B

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

inductive MLIRType (MOp : Type) {MTy} [OpSignature MOp MTy] : (Γ : Type*) → Type _ :=
  | int: Signedness -> Nat -> MLIRType MOp Γ
  | float: Nat -> MLIRType MOp Γ
  | tensor1d: MLIRType MOp Γ -- tensor of int values. 
  | tensor2d: MLIRType MOp Γ -- tensor of int values. 
  | tensor4d: MLIRType MOp Γ -- tensor of int values. 
  | index:  MLIRType MOp Γ
  | undefined: String → MLIRType MOp Γ
  | mvar [Inhabited Γ] : (Γ → MTy) → MLIRType MOp Γ

variable (MOp : Type) {MTy} [OpSignature MOp MTy] (Γ : Type*)  

instance : DecidableEq (MLIRType MOp PEmpty) := by
  intro t u
  cases t <;> cases u 
  <;> try simp
  <;> infer_instance
  rcases ‹Inhabited PEmpty› with ⟨⟨⟩⟩

instance : Repr (MLIRType MOp Γ) where
  reprPrec t n := match t with
    -- | .int s w => --f!"int {s} {w}"
    | _ => sorry

-- We define "MLIRTy" to be just the basic types outside of any dialect
abbrev MLIRTy := MLIRType MOp Γ

/-- Shorthand to build <iN> -/
def MLIRTy.i (width : Nat) : MLIRTy MOp Γ := MLIRType.int Signedness.Signless width
-- Other useful abbreviations
abbrev MLIRType.i1: MLIRType MOp Γ := MLIRType.int .Signless 1
abbrev MLIRType.i32: MLIRType MOp Γ := MLIRType.int .Signless 32
def MLIRType.i (width : Nat) : MLIRTy MOp Γ := MLIRType.int Signedness.Signless width

/-- An ssa value (variable name) with a type -/
abbrev TypedSSAVal := SSAVal × MLIRType MOp Γ

mutual
inductive AttrValue :=
  | symbol: String -> AttrValue -- symbol ref attr
  | str : String -> AttrValue
  | int : Int -> MLIRType MOp Γ -> AttrValue
  | nat: Nat -> AttrValue
  | bool : Bool -> AttrValue
  | float : Float -> MLIRType MOp Γ -> AttrValue
  | type : MLIRType MOp Γ -> AttrValue
  | affine: AffineMap -> AttrValue
  | permutation: List Nat -> AttrValue -- a permutation
  | list: List AttrValue -> AttrValue
  | nestedsymbol: AttrValue -> AttrValue -> AttrValue
  | alias: String -> AttrValue
  | dict: AttrDict -> AttrValue
  | opaque_: (dialect: String) -> (value: String) -> AttrValue
  | opaqueElements: (dialect: String) -> (value: String) -> (type: MLIRType MOp Γ) -> AttrValue
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

def AttrEntry.destructure {MOp Γ} : AttrEntry MOp Γ → String × AttrValue MOp Γ
  | .mk name value => (name,value)

def AttrDict.getAttr {MOp Γ} : AttrDict MOp Γ → String →  Option (AttrValue MOp Γ)
  | .mk attrs, name => attrs.map AttrEntry.destructure |>.lookup name

-- We define "AttrVal" to be just the basic attributes outside of any dialect
abbrev AttrVal := AttrValue


mutual
-- | TODO: make this `record` when mutual records are allowed?
-- | TODO: make these arguments optional?
inductive Op where
  | mk: (name: String)
        -> (res: List <| TypedSSAVal MOp Γ)
        -> (args: List <| TypedSSAVal MOp Γ)
        -> (regions: List Region)
        -> (attrs: AttrDict MOp Γ)
        -> Op

inductive Region where
  | mk: (name: String)
        -> (args: List <| TypedSSAVal MOp Γ)
        -> (ops: List Op) -> Region

end

-- Attribute definition on the form #<name> = <val>
inductive AttrDefn where
  | mk: (name: String) -> (val: AttrValue MOp Γ) -> AttrDefn

inductive Module where
  | mk: (functions: List <| Op MOp Γ)
        -> (attrs: List <| AttrDefn MOp Γ)
        ->  Module

def Op.name {MOp Γ} : Op MOp Γ -> String
  | Op.mk name .. => name

def Op.res {MOp Γ} : Op MOp Γ -> List (TypedSSAVal MOp Γ)
  | Op.mk _ res .. => res

def Op.resNames {MOp Γ} : Op MOp Γ → List SSAVal
  | Op.mk _ res .. => res.map Prod.fst

def Op.resTypes {MOp Γ} : Op MOp Γ → List (MLIRType MOp Γ)
  | Op.mk _ res .. => res.map Prod.snd

def Op.args {MOp Γ} : Op MOp Γ -> List (TypedSSAVal MOp Γ)
  | Op.mk _ _ args .. => args

def Op.argNames {MOp Γ} : Op MOp Γ → List SSAVal
  | Op.mk _ _ args .. => args.map Prod.fst

def Op.argTypes {MOp Γ} : Op MOp Γ → List (MLIRType MOp Γ)
  | Op.mk _ _ args .. => args.map Prod.snd

def Op.regions {MOp Γ} : Op MOp Γ -> List (Region MOp Γ)
  | Op.mk _ _ _ regions _ => regions

def Op.attrs {MOp Γ} : Op MOp Γ -> (AttrDict MOp Γ)
| Op.mk _ _ _ _ attrs => attrs

instance : Coe String SSAVal where
  coe (s: String) := SSAVal.SSAVal s

instance : Coe String (AttrValue MOp Γ) where
  coe (s: String) := AttrValue.str s

instance : Coe Int (AttrValue MOp Γ) where
  coe (i: Int) := AttrValue.int i (MLIRType.int .Signless 64)

instance : Coe (MLIRType MOp Γ) (AttrValue MOp Γ) where
  coe := AttrValue.type

instance : Coe (String × AttrValue MOp Γ) (AttrEntry MOp Γ) where
  coe v := AttrEntry.mk v.fst v.snd

instance : Coe (String × MLIRType MOp Γ) (AttrEntry MOp Γ) where
  coe v := AttrEntry.mk v.fst (AttrValue.type v.snd)

instance : Coe (AttrEntry MOp Γ) (String × AttrValue MOp Γ) where
  coe 
  | AttrEntry.mk key val => (key, val)

instance : Coe (List (AttrEntry MOp Γ)) (AttrDict MOp Γ) where
  coe
  | v => AttrDict.mk v

 instance : Coe (AttrDict MOp Γ) (List (AttrEntry MOp Γ)) where
  coe 
  | AttrDict.mk as => as

def Region.name (region : Region MOp Γ) : BBName :=
  match region with
  | Region.mk name _ _ => BBName.mk name

def Region.args : Region MOp Γ → List (TypedSSAVal MOp Γ)
  | .mk _ args _ => args

def Region.ops (region: Region MOp Γ) : List (Op MOp Γ) :=
  match region with
  | Region.mk _ _ ops => ops


mutual
partial def docAttrVal {MOp Γ} : AttrValue MOp Γ → Format
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

partial def docAttrEntry {MOp Γ} : AttrEntry MOp Γ → Format
  | .mk k v => f!"{k} = " ++ (docAttrVal v)

partial def docAttrDict {MOp Γ} : AttrDict MOp Γ → Format
  | .mk attrs =>
      if List.isEmpty attrs
      then f!""
      else f!"\{" ++ (Format.join ((attrs.map docAttrEntry).intersperse ", ")) ++ f!"}"
end

instance : Repr (AttrValue MOp Γ) where
  reprPrec x _ := docAttrVal x

instance : Repr (AttrEntry MOp Γ) where
  reprPrec x _ := docAttrEntry x

instance : Repr (AttrDict MOp Γ) where
  reprPrec x _ := docAttrDict x

instance : Repr (AttrDefn MOp Γ) where
  reprPrec x _ := match x with
    | AttrDefn.mk name val => f!"#{name} := {repr val}"

instance : Repr SSAVal where
  reprPrec x _ := match x with
    | SSAVal.SSAVal name => f!"%{name}"

instance : ToFormat SSAVal where
  format := repr

mutual
partial def op_to_format {MOp Γ} : Op MOp Γ →  Format
  | Op.mk name res args rgns attrs =>
      let doc_name := f!"\"{name}\""
      let doc_rgns := if rgns.isEmpty
                      then f!""
                      else rgns.map (Format.align true ++ rgn_to_format ·) |> Format.join
      let doc_args := f!"({args.map repr |>.intersperse f!", " |> Format.join})"
      let doc_res := f!"({res.map repr |>.intersperse f!", " |> Format.join})"

      doc_res ++ " := " ++ doc_name ++ doc_args ++ doc_rgns ++ repr attrs

partial def rgn_to_format {MOp Γ} : Region MOp Γ → Format
  | Region.mk name args ops => 
      let doc_args := if args.isEmpty then
          f!""
        else
          f!"({args.map (fun (v, t) => f!"{repr v} : {repr t}") |>.intersperse "," |> Format.join})"
      let doc_ops := 
        ops.map (Format.align true ++ op_to_format ·) |> Format.join
      f!"^{name}{doc_args} : " ++ doc_ops
end

instance : Repr (Op MOp Γ) := ⟨fun x _ => op_to_format x⟩
instance : Repr (Region MOp Γ) := ⟨fun x _ => rgn_to_format x⟩

def AttrEntry.key {MOp Γ} : AttrEntry MOp Γ → String
  | AttrEntry.mk k _ => k

def AttrEntry.value {MOp Γ} : AttrEntry MOp Γ → AttrValue MOp Γ
  | AttrEntry.mk _ v => v


def AttrDict.empty {MOp Γ} : AttrDict MOp Γ := AttrDict.mk []

def Op.empty {MOp Γ} (name : String) : Op MOp Γ := Op.mk name [] [] [] AttrDict.empty

def Op.addArg {MOp Γ} (o : Op MOp Γ) (arg : TypedSSAVal MOp Γ) : Op MOp Γ :=
  match o with
  | Op.mk name res args regions attrs =>
    Op.mk name res (args ++ [arg])  regions attrs

def Op.addResult {MOp Γ} (o : Op MOp Γ) (new_res : TypedSSAVal MOp Γ) : Op MOp Γ :=
 match o with
 | Op.mk name res args  regions attrs =>
    Op.mk name (res ++ [new_res]) args  regions attrs

def Op.appendRegion {MOp Γ} (o : Op MOp Γ) (r : Region MOp Γ) : Op MOp Γ :=
  match o with
  | Op.mk name res args regions attrs =>
      Op.mk name res args (regions ++ [r]) attrs


-- | Note: AttrEntry can be given as String × AttrValue
def AttrDict.add {MOp Γ} (attrs : AttrDict MOp Γ) (entry : AttrEntry MOp Γ) : AttrDict MOp Γ :=
    Coe.coe <| entry :: Coe.coe attrs

def AttrDict.find {MOp Γ} (attrs : AttrDict MOp Γ) (name : String) : Option (AttrValue MOp Γ) :=
  match attrs with
  | AttrDict.mk entries =>
      match entries.find? (fun entry => entry.key == name) with
      | some v => v.value
      | none => none

def AttrDict.find_nat {MOp Γ} (attrs : AttrDict MOp Γ) (name : String) : Option Nat := 
  match attrs.find name with
  | .some (AttrValue.nat i) =>  .some i
  | _ => .none

def AttrDict.find_int {MOp Γ} (attrs : AttrDict MOp Γ) 
  (name : String): Option (Int × MLIRType MOp Γ) :=
  match attrs.find name with
  | .some (AttrValue.int i ty) =>  .some (i, ty)
  | _ => .none

def AttrDict.find_int' {MOp Γ} (attrs : AttrDict MOp Γ) (name : String): Option Int :=
  match attrs.find name with
  | .some (AttrValue.int i _) =>  .some i
  | _ => .none

@[simp] theorem AttrDict.find_none :
    AttrDict.find (@AttrDict.mk MOp Γ []) n' = none := by
  simp [AttrDict.find, List.find?]

@[simp] theorem AttrDict.find_next (v : AttrValue MOp Γ)
  (l : List (AttrEntry MOp Γ)):
    AttrDict.find (AttrDict.mk (AttrEntry.mk n v :: l)) n' =
    if n == n' then some v else AttrDict.find (AttrDict.mk l) n' := by
  cases H: n == n' <;>
  simp [AttrDict.find, List.find?, AttrEntry.key, AttrEntry.value, H]

def AttrDict.addString (attrs: AttrDict MOp Γ) (k: String) (v: String): AttrDict MOp Γ :=
    AttrEntry.mk k (v : AttrValue MOp Γ) :: attrs

def AttrDict.addType (attrs: AttrDict MOp Γ) (k: String) (v: MLIRType MOp Γ): AttrDict MOp Γ :=
    AttrEntry.mk k (v : AttrValue MOp Γ) :: attrs


def Op.addAttr (o: Op MOp Γ) (k: String) (v: AttrValue MOp Γ): Op MOp Γ :=
 match o with
 | Op.mk name res args regions attrs =>
    Op.mk name res args regions (attrs.add (k, v))

def Region.empty {MOp Γ} (name: String): Region MOp Γ := Region.mk name [] []
def Region.appendOp (bb: Region MOp Γ) (op: Op MOp Γ): Region MOp Γ :=
  match bb with
  | Region.mk name args bbs => Region.mk name args (bbs ++ [op])

def Region.appendOps (bb: Region MOp Γ) (ops: List (Op MOp Γ)): Region MOp Γ :=
  match bb with
  | Region.mk name args bbs => Region.mk name args (bbs ++ ops)


instance : Inhabited (MLIRType MOp Γ) where
  default := MLIRType.undefined "INHABITANT"

instance : Inhabited (AttrValue MOp Γ) where
  default := AttrValue.str "INHABITANT"

instance : Inhabited (Op MOp Γ) where
  default := Op.empty "INHABITANT"

instance : Inhabited (Region MOp Γ) where
  default := Region.empty "INHABITANT"

instance : Repr (Module MOp Γ) where
  reprPrec
  | Module.mk fs attrs, _ =>
      attrs.map repr ++ fs.map repr |>.map (Format.align true ++ ·) |> Format.join

def Region.fromOps (os: List (Op MOp Γ)) (name: String := "entry") : Region MOp Γ :=
  Region.mk name [] os

def Region.setArgs (bb: Region MOp Γ) (args: List (SSAVal × MLIRType MOp Γ)) : Region MOp Γ :=
  match bb with
    | (Region.mk name _ ops) => (Region.mk name args ops)

end MLIR.AST