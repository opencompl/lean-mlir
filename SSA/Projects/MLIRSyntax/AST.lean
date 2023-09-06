import SSA.Projects.MLIRSyntax.Doc
import SSA.Experimental.IntrinsicAsymptotics
open Lean PrettyPrinter

open MLIR.Doc
open Pretty -- open typeclass for `doc`

namespace MLIR.AST

-- Affine expressions [TODO: find some way to separate this out]
-- ==================
inductive AffineExpr
| Var: String -> AffineExpr

instance : Pretty AffineExpr where
  doc e := match e with
  | AffineExpr.Var v => doc v

deriving instance DecidableEq for AffineExpr

inductive AffineTuple
| mk: List AffineExpr -> AffineTuple

instance : Pretty AffineTuple where
  doc t := match t with
  | AffineTuple.mk es => [doc| "(" (es),*  ")"]

deriving instance DecidableEq for AffineTuple

inductive AffineMap
| mk: AffineTuple -> AffineTuple -> AffineMap

 instance : Pretty AffineMap where
  doc t := match t with
  | AffineMap.mk xs ys => doc xs ++ " -> " ++ doc ys

deriving instance DecidableEq for AffineMap



-- EMBEDDING
-- ==========

inductive BBName
| mk: String -> BBName

instance : Pretty BBName where
  doc name := match name with
              | BBName.mk s => [doc| "^" s]

deriving instance DecidableEq for BBName

inductive Dimension
| Known: Nat -> Dimension
| Unknown: Dimension

deriving instance DecidableEq for Dimension


inductive SSAVal : Type where
  | SSAVal : String -> SSAVal
deriving DecidableEq

def SSAValToString (s: SSAVal): String :=
  match s with
  | SSAVal.SSAVal str => str

instance : ToString SSAVal where
  toString := SSAValToString

inductive TensorElem :=
| int: Int -> TensorElem
| float: Float -> TensorElem
| bool: Bool -> TensorElem
| nested: List TensorElem -> TensorElem
| empty: TensorElem

inductive Signedness :=
| Signless -- i*
| Unsigned -- u*
| Signed   -- si*
deriving DecidableEq

-- TODO: add the right interface for dialects here?
class Dialect (α : Type) : Type
abbrev Dialect.empty : Dialect Unit := ⟨⟩

inductive MLIRType (δ: Dialect α) :=
| int: Signedness -> Nat -> MLIRType δ
| float: Nat -> MLIRType δ
| tensor1d: MLIRType δ -- tensor of int values. 
| tensor2d: MLIRType δ -- tensor of int values. 
| tensor4d: MLIRType δ -- tensor of int values. 
| index:  MLIRType δ
| undefined: String → MLIRType δ
| extended: σ → MLIRType δ
| erased: MLIRType δ -- A type that is erased by dialect retraction.

-- We define "MLIRTy" to be just the basic types outside of any dialect
abbrev MLIRTy := MLIRType Dialect.empty 
-- Other useful abbreviations
abbrev MLIRType.i1: MLIRType δ := MLIRType.int .Signless 1
abbrev MLIRType.i32: MLIRType δ := MLIRType.int .Signless 32

-- An SSA value with a type
abbrev TypedSSAVal (δ: Dialect α) := SSAVal × MLIRType δ

mutual
-- | TODO: factor Symbol out from AttrValue
inductive AttrValue (δ: Dialect α) :=
| symbol: String -> AttrValue δ -- symbol ref attr
| str : String -> AttrValue δ
| int : Int -> MLIRType δ -> AttrValue δ
| nat: Nat -> AttrValue δ
| bool : Bool -> AttrValue δ
| float : Float -> MLIRType δ -> AttrValue δ
| type : MLIRType δ -> AttrValue δ
| affine: AffineMap -> AttrValue δ
| permutation: List Nat -> AttrValue δ -- a permutation
| list: List (AttrValue δ) -> AttrValue δ
-- | guaranteee: both components will be AttrValue δ.Symbol.
-- | TODO: factor symbols out.
| nestedsymbol: AttrValue δ -> AttrValue δ -> AttrValue δ
| alias: String -> AttrValue δ
| dict: AttrDict δ -> AttrValue δ
| opaque_: (dialect: String) -> (value: String) -> AttrValue δ
| opaqueElements: (dialect: String) -> (value: String) -> (type: MLIRType δ) -> AttrValue δ
| unit: AttrValue δ
| extended: α → AttrValue δ
| erased: AttrValue δ

-- https://mlir.llvm.org/docs/LangRef/#attributes
-- | TODO: add support for mutually inductive records / structures
inductive AttrEntry (δ: Dialect α) :=
  | mk: (key: String)
      -> (value: AttrValue δ)
      -> AttrEntry δ

inductive AttrDict (δ: Dialect α) :=
| mk: List (AttrEntry δ) -> AttrDict δ

end

-- We define "AttrVal" to be just the basic attributes outside of any dialect
abbrev AttrVal := @AttrValue _ Dialect.empty


mutual
-- | TODO: make this `record` when mutual records are allowed?
-- | TODO: make these arguments optional?
inductive Op (δ: Dialect α) where
 | mk: (name: String)
      -> (res: List (TypedSSAVal δ))
      -> (args: List (TypedSSAVal δ))
      -> (regions: List (Region δ))
      -> (attrs: AttrDict δ)
      -> Op δ

inductive Region (δ: Dialect α) where
| mk: (name: String)
      -> (args: List (TypedSSAVal δ))
      -> (ops: List (Op δ)) -> Region δ

end

-- Attribute definition on the form #<name> = <val>
inductive AttrDefn (δ: Dialect α) where
| mk: (name: String) -> (val: AttrValue δ) -> AttrDefn δ

-- | TODO: this seems like a weird exception. Is this really true?
inductive Module (δ: Dialect α) where
| mk: (functions: List (Op δ))
      -> (attrs: List (AttrDefn δ))
      ->  Module δ


def Op.name: Op δ -> String
| Op.mk name .. => name

def Op.res: Op δ -> List (TypedSSAVal δ)
| Op.mk _ res .. => res

def Op.resNames: Op δ → List SSAVal
| Op.mk _ res .. => res.map Prod.fst

def Op.resTypes: Op δ → List (MLIRType δ)
| Op.mk _ res .. => res.map Prod.snd

def Op.args: Op δ -> List (TypedSSAVal δ)
| Op.mk _ _ args .. => args

def Op.argNames: Op δ → List SSAVal
| Op.mk _ _ args .. => args.map Prod.fst

def Op.argTypes: Op δ → List (MLIRType δ)
| Op.mk _ _ args .. => args.map Prod.snd

def Op.regions: Op δ -> List (Region δ)
| Op.mk _ _ _ regions _ => regions

def Op.attrs: Op δ -> AttrDict δ
| Op.mk _ _ _ _ attrs => attrs


instance: Coe String SSAVal where
  coe (s: String) := SSAVal.SSAVal s

instance : Coe Int TensorElem where
  coe (i: Int) := TensorElem.int i

instance : Coe  (List Int) TensorElem where
  coe (xs: List Int) := TensorElem.nested (xs.map TensorElem.int)

instance : Coe String (AttrValue δ) where
  coe (s: String) := AttrValue.str s

instance : Coe Int (AttrValue δ) where
  coe (i: Int) := AttrValue.int i (MLIRType.int .Signless 64)

instance : Coe (MLIRType δ) (AttrValue δ) where
  coe (t: MLIRType δ) := AttrValue.type t

instance : Coe (String × AttrValue δ) (AttrEntry δ) where
  coe (v: String × AttrValue δ) := AttrEntry.mk v.fst v.snd

instance : Coe (String × MLIRType δ) (AttrEntry δ) where
  coe (v: String × MLIRType δ) := AttrEntry.mk v.fst (AttrValue.type v.snd)

instance : Coe  (AttrEntry δ) (String × AttrValue δ) where
  coe (v: AttrEntry δ) :=
  match v with
  | AttrEntry.mk key val => (key, val)

instance : Coe (List (AttrEntry δ)) (AttrDict δ) where
  coe (v: List (AttrEntry δ)) := AttrDict.mk v

 instance : Coe (AttrDict δ) (List (AttrEntry δ)) where
  coe (v: AttrDict δ) := match v with | AttrDict.mk as => as


-- Coercions across dialects

-- mutual
-- variable [δ₁: Dialect α₁ σ₁ ε₁] [δ₂: Dialect α₂ σ₂ ε₂] [c: CoeDialect δ₁ δ₂]
-- 
-- def coeMLIRType: MLIRType δ₁ → MLIRType δ₂
--   | .int sgn n   => .int sgn n
--   | .float n     => .float n
--   | .index       => .index
--   | .undefined n => .undefined n
--   | .tensor1d => .tensor1d
--   | .tensor2d => .tensor2d
--   | .tensor4d => .tensor4d
--   | .erased => .erased
--   | .extended s  => .extended (c.coe_σ s)
-- 
-- def coeMLIRTypeList: List (MLIRType δ₁) → List (MLIRType δ₂)
--   | []    => []
--   | τ::τs => coeMLIRType τ :: coeMLIRTypeList τs
-- end
-- 
-- instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
--     Coe (MLIRType δ₁) (MLIRType δ₂) where
--   coe := coeMLIRType
-- 
-- -- Useful locally when dealing with tuple types
-- instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
--     Coe (List (MLIRType δ₁)) (List (MLIRType δ₂)) where
--   coe := coeMLIRTypeList
-- 
-- -- Useful locally when dealing with basic block arguments
-- instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
--     Coe (List (SSAVal × MLIRType δ₁)) (List (SSAVal × MLIRType δ₂)) where
--   coe := List.map (fun (v, τ) => (v, Coe.coe τ))
-- 

def Region.name (region: Region δ): BBName :=
  match region with
  | Region.mk name args ops => BBName.mk name

def Region.ops (region: Region δ): List (Op δ) :=
  match region with
  | Region.mk name args ops => ops

/-
-- TODO: delete CoeDialect
mutual
variable [δ₁: Dialect α₁ σ₁ ε₁] [δ₂: Dialect α₂ σ₂ ε₂] [c: CoeDialect δ₁ δ₂]

private def coeAttrValue: AttrValue δ₁ → AttrValue δ₂
  | .nat n => .nat n
  | .symbol s => .symbol s
  | .permutation p => .permutation p
  | .str s => .str s
  | .int i τ => .int i τ
  | .bool b => .bool b
  | .float f τ => .float f τ
  | .type τ => .type τ
  | .affine map => .affine map
  | .list l => .list (coeAttrValueList l)
  | .nestedsymbol a₁ a₂ => .nestedsymbol (coeAttrValue a₁) (coeAttrValue a₂)
  | .alias s => .alias s
  | .dict d => .dict (coeAttrDict d)
  | .opaque_ d v => .opaque_ d v
  | .opaqueElements d v τ => .opaqueElements d v τ
  | .unit => .unit
  | .extended a => .extended (c.coe_α a)
  | .erased => .erased

private def coeAttrValueList: List (AttrValue δ₁) → List (AttrValue δ₂)
  | [] => []
  | v :: values => coeAttrValue v :: coeAttrValueList values

private def coeAttrEntry: AttrEntry δ₁ → AttrEntry δ₂
  | .mk key value => .mk key (coeAttrValue value)

private def coeAttrEntryList: List (AttrEntry δ₁) → List (AttrEntry δ₂)
  | [] => []
  | e :: entries => coeAttrEntry e :: coeAttrEntryList entries

private def coeAttrDict: AttrDict δ₁ → AttrDict δ₂
  | .mk entries => .mk <| coeAttrEntryList entries
end

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (AttrValue δ₁) (AttrValue δ₂) where
  coe := coeAttrValue

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (AttrEntry δ₁) (AttrEntry δ₂) where
  coe := coeAttrEntry

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (AttrDict δ₁) (AttrDict δ₂) where
  coe := coeAttrDict

mutual
variable [δ₁: Dialect α₁ σ₁ ε₁] [δ₂: Dialect α₂ σ₂ ε₂] [c: CoeDialect δ₁ δ₂]

def coeOp: Op δ₁ → Op δ₂
  | .mk name res args  regions attrs =>
      .mk name res args  (coeRegionList regions) (Coe.coe attrs)

def coeOpList:
    List (Op δ₁) → List (Op δ₂)
  | [] => []
  | s :: ops => coeOp s :: coeOpList ops

def coeRegion: Region δ₁ → Region δ₂
  | .mk name args ops => .mk name args (coeOpList ops)

def coeRegionList: List (Region δ₁) → List (Region δ₂)
  | [] => []
  | r :: rs => coeRegion r :: coeRegionList rs

end

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (Op δ₁) (Op δ₂) where
  coe := coeOp

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (List (Op δ₁)) (List (Op δ₂)) where
  coe := coeOpList

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (Region δ₁) (Region δ₂) where
  coe := coeRegion

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (List (Region δ₁)) (List (Region δ₂)) where
  coe := coeRegionList

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (Region δ₁) (Region δ₂) where
  coe := coeRegion

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (List (Region δ₁)) (List (Region δ₂)) where
  coe := coeRegionList
-/


instance : Pretty Signedness where
  doc sgn :=
    match sgn with
    | .Signless => "Signless"
    | .Unsigned => "Unsigned"
    | .Signed => "Signed"

instance : Pretty Dimension where
  doc dim :=
  match dim with
  | Dimension.Unknown => "?"
  | Dimension.Known i => doc i

partial instance : Pretty TensorElem where
  doc (t: TensorElem) :=
    let rec go (t: TensorElem) :=
      match t with
       | TensorElem.int i => doc i
       | TensorElem.bool b => doc b
       | TensorElem.float f => doc f
       | TensorElem.nested ts => [doc| "["  (ts.map go),* "]" ]
       | TensorElem.empty => ""
    go t

-- | TODO: allow typeclass instances inside mutual blocks
mutual
variable {α σ ε} [δ: Dialect α]

partial def docMLIRType: MLIRType δ → Doc
  | .int .Signless k => [doc| "i"k]
  | .int .Unsigned k => [doc| "u"k]
  | .int .Signed k => [doc| "si"k]
  | .float k => [doc| "f"k]
  | .tensor1d => [doc| "tensor1d"]
  | .tensor2d => [doc| "tensor2d"]
  | .tensor4d => [doc| "tensor4d"]
  | .index => [doc| "index"]
  | .undefined name => [doc| "!" name]
  | .erased => [doc| "erased"]
  | .extended sig => [doc| "interface unimplemented"] --DialectTypeIntf.typeStr ε sig

partial def docAttrVal: AttrValue δ → Doc
  | .symbol s => "@" ++ doc_surround_dbl_quot s
  | .permutation ps => [doc| "[permutation " (ps),* "]"]
  | .nestedsymbol s t => (docAttrVal s) ++ "::" ++ (docAttrVal t)
  | .str str => doc_surround_dbl_quot str
  | .type ty => docMLIRType ty
  | .int i ty => doc i ++ " : " ++ docMLIRType ty
  | .nat i => doc i ++ " : " ++ "index"
  | .bool b => if b then "true" else "false"
  | .float f ty => doc f ++ " : " ++ docMLIRType ty
  | .affine aff => "affine_map<" ++ doc aff ++ ">"
  | .list xs => "[" ++ Doc.Nest (vintercalate_doc (xs.map docAttrVal) ", ") ++ "]"
  | .alias a => "#" ++ a
  | .dict d => docAttrDict d
  | .opaque_ dialect val => [doc| "#" (dialect) "<"  (val) ">"]
  | .opaqueElements dialect val ty => [doc| "#opaque<" (dialect) ","  (val) ">" ":" (docMLIRType ty)]
  | .unit => "()"
  | .extended a => "!Atributes unimplemented" --DialectAttrIntf.str a
  | .erased => "<erased>"

partial def docAttrEntry: AttrEntry δ → Doc
  | .mk k v => k ++ " = " ++ (docAttrVal v)

partial def docAttrDict: AttrDict δ → Doc
  | .mk attrs =>
      if List.isEmpty attrs
      then Doc.Text ""
      else "{" ++ Doc.Nest (vintercalate_doc (attrs.map docAttrEntry)  ", ")  ++ "}"
end

instance : Pretty (MLIRType δ) where
 doc := docMLIRType

instance : Pretty (AttrValue δ) where
 doc := docAttrVal

instance : Pretty (AttrEntry δ) where
  doc := docAttrEntry

instance : Pretty (AttrDict δ) where
   doc := docAttrDict

instance : Pretty (AttrDefn δ) where
  doc (v: AttrDefn δ) :=
  match v with
  | AttrDefn.mk name val => "#" ++ name ++ " := " ++ (doc val)

instance : Pretty SSAVal where
   doc (val: SSAVal) :=
     match val with
     | SSAVal.SSAVal name => Doc.Text ("%" ++ name)

instance : ToFormat SSAVal where
    format (x: SSAVal) := layout80col (doc x)

-- | TODO: allow mutual definition of typeclass instances. This code
-- | would be so much nicer if I could pretend that these had real instances.
mutual

def op_to_doc (op: Op δ): Doc :=
    match op with
    | (Op.mk name res args rgns attrs) =>
        /- v3: macros + if stuff-/
        [doc|
          "\"" name "\""
          "(" (op.argNames),* ")"
          (ifdoc rgns.isEmpty then "" else "(" (nest (list_rgn_to_doc rgns);*) ")")
          attrs]

        /- v2: macros, but no if stuff
        [doc|
          "\"" name "\""
          "(" (args),* ")"
          (if bbs.isEmpty then [doc| ""] else [doc| "[" (bbs),* "]"])
          (if rgns.isEmpty then [doc| ""] else[doc| "(" (nest rgns.map rgn_to_doc);* ")"])
          attrs ":" ty] -/

        /- v1: no macros
        let doc_name := doc_surround_dbl_quot name
        let doc_bbs := if bbs.isEmpty
                       then doc ""
                       else "[" ++ intercalate_doc bbs ", " ++ "]"
        let doc_rgns :=
            if rgns.isEmpty
            then Doc.Text ""
            else " (" ++ nest_vgroup (rgns.map rgn_to_doc) ++ ")"
        let doc_args := "(" ++ intercalate_doc args ", " ++ ")"

        doc_name ++ doc_args ++  doc_bbs ++ doc_rgns ++ doc attrs ++ " : " ++ doc ty -/

def list_op_to_doc: List (Op δ) → List Doc
  | [] => []
  | op :: ops => op_to_doc op :: list_op_to_doc ops

-- | TODO: fix the dugly syntax
def rgn_to_doc: Region δ → Doc
  | (Region.mk name args ops) =>
    [doc| {
        (ifdoc args.isEmpty
         then  "^" name ":"
         else  "^" name "(" (args.map $ fun (v, t) => [doc| v ":" t]),* ")" ":");
        (nest list_op_to_doc ops);* ; } ]

def list_rgn_to_doc: List (Region δ) → List Doc
  | [] => []
  | r :: rs => rgn_to_doc r :: list_rgn_to_doc rs
end

instance : Pretty (Op δ) where
  doc := op_to_doc

instance : Pretty (Region δ) where
  doc := rgn_to_doc

instance : Pretty (Region δ) where
  doc := rgn_to_doc

def AttrEntry.key (a: AttrEntry δ): String :=
match a with
| AttrEntry.mk k v => k

def AttrEntry.value (a: AttrEntry δ): AttrValue δ :=
match a with
| AttrEntry.mk k v => v


def AttrDict.empty : AttrDict δ := AttrDict.mk []

def Op.empty (name: String) : Op δ := Op.mk name [] [] [] AttrDict.empty

-- | TODO: needs to happen in a monad to ensure that ty has the right type!
def Op.addArg (o: Op δ) (arg: TypedSSAVal δ): Op δ :=
  match o with
  | Op.mk name res args regions attrs =>
    Op.mk name res (args ++ [arg])  regions attrs

def Op.addResult (o: Op δ) (new_res: TypedSSAVal δ): Op δ :=
 match o with
 | Op.mk name res args  regions attrs =>
    Op.mk name (res ++ [new_res]) args  regions attrs

def Op.appendRegion (o: Op δ) (r: Region δ): Op δ :=
  match o with
  | Op.mk name res args regions attrs =>
      Op.mk name res args (regions ++ [r]) attrs


-- | Note: AttrEntry can be given as String × AttrValue
def AttrDict.add (attrs: AttrDict δ) (entry: AttrEntry δ): AttrDict δ :=
    Coe.coe $ (entry :: Coe.coe attrs)

def AttrDict.find (attrs: AttrDict δ) (name: String): Option (AttrValue δ) :=
  match attrs with
  | AttrDict.mk entries =>
      match entries.find? (fun entry => entry.key == name) with
      | some v => v.value
      | none => none

def AttrDict.find_nat (attrs: AttrDict δ) 
  (name: String): Option Nat := 
  match attrs.find name with
  | .some (AttrValue.nat i) =>  .some i
  | _ => .none

def AttrDict.find_int (attrs: AttrDict δ) 
  (name: String): Option (Int × MLIRType δ) :=
  match attrs.find name with
  | .some (AttrValue.int i ty) =>  .some (i, ty)
  | _ => .none

def AttrDict.find_int' (attrs: AttrDict δ) (name: String): Option Int :=
  match attrs.find name with
  | .some (AttrValue.int i _) =>  .some i
  | _ => .none

@[simp] theorem AttrDict.find_none {δ: Dialect α}:
    AttrDict.find (δ := δ) (AttrDict.mk []) n' = none := by
  simp [AttrDict.find, List.find?]

@[simp] theorem AttrDict.find_next {δ: Dialect α} (v: AttrValue δ)
  (l: List (AttrEntry δ)):
    AttrDict.find (AttrDict.mk (AttrEntry.mk n v :: l)) n' =
    if n == n' then some v else AttrDict.find (AttrDict.mk l) n' := by
  cases H: n == n' <;>
  simp [AttrDict.find, List.find?, AttrEntry.key, AttrEntry.value, H]

def AttrDict.addString (attrs: AttrDict δ) (k: String) (v: String): AttrDict δ :=
    AttrEntry.mk k (v: AttrValue δ) :: attrs

def AttrDict.addType (attrs: AttrDict δ) (k: String) (v: MLIRType δ): AttrDict δ :=
    AttrEntry.mk k (v: AttrValue δ) :: attrs


def Op.addAttr (o: Op δ) (k: String) (v: AttrValue δ): Op δ :=
 match o with
 | Op.mk name res args regions attrs =>
    Op.mk name res args regions (attrs.add (k, v))

def Region.empty (name: String): Region δ := Region.mk name [] []
def Region.appendOp (bb: Region δ) (op: Op δ): Region δ :=
  match bb with
  | Region.mk name args bbs => Region.mk name args (bbs ++ [op])

def Region.appendOps (bb: Region δ) (ops: List (Op δ)): Region δ :=
  match bb with
  | Region.mk name args bbs => Region.mk name args (bbs ++ ops)


instance : Pretty (Op δ) where
  doc := op_to_doc

instance : Pretty (Region δ) where
  doc := rgn_to_doc

instance [Pretty a] : ToString a where
  toString (v: a) := layout80col (doc v)

instance : ToFormat (Op δ) where
    format (x: Op δ) := layout80col (doc x)


instance : Inhabited (MLIRType δ) where
  default := MLIRType.undefined "INHABITANT"

instance : Inhabited (AttrValue δ) where
  default := AttrValue.str "INHABITANT"

instance : Inhabited (Op δ) where
  default := Op.empty "INHABITANT"

instance : Inhabited (Region δ) where
  default := Region.empty "INHABITANT"

instance : Pretty (Module δ) where
  doc (m: Module δ) :=
    match m with
    | Module.mk fs attrs =>
      Doc.VGroup (attrs.map doc ++ fs.map doc)

def Region.fromOps (os: List (Op δ)) (name: String := "entry"): Region δ :=
  Region.mk name [] os

def Region.setArgs (bb: Region δ) (args: List (SSAVal × MLIRType δ)) : Region δ :=
match bb with
  | (Region.mk name _ ops) => (Region.mk name args ops)


end MLIR.AST
