import MLIR.Doc
import MLIR.Dialects
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

inductive MLIRType (δ: Dialect α σ ε) :=
| fn: MLIRType δ -> MLIRType δ -> MLIRType δ
| int: Signedness -> Nat -> MLIRType δ
| float: Nat -> MLIRType δ
| index:  MLIRType δ
| tuple: List (MLIRType δ) -> MLIRType δ
| undefined: String → MLIRType δ
| extended: σ → MLIRType δ

-- We define "MLIRTy" to be just the basic types outside of any dialect
abbrev MLIRTy := @MLIRType _ _ _ Dialect.empty
-- Other useful abbreviations
abbrev MLIRType.i1: MLIRType δ := MLIRType.int .Signless 1
abbrev MLIRType.i32: MLIRType δ := MLIRType.int .Signless 32

mutual
-- | TODO: factor Symbol out from AttrValue
inductive AttrValue (δ: Dialect α σ ε) :=
| symbol: String -> AttrValue δ -- symbol ref attr
| str : String -> AttrValue δ
| int : Int -> MLIRType δ -> AttrValue δ
| bool : Bool -> AttrValue δ
| float : Float -> MLIRType δ -> AttrValue δ
| type : MLIRType δ -> AttrValue δ
| affine: AffineMap -> AttrValue δ
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

-- https://mlir.llvm.org/docs/LangRef/#attributes
-- | TODO: add support for mutually inductive records / structures
inductive AttrEntry (δ: Dialect α σ ε) :=
  | mk: (key: String)
      -> (value: AttrValue δ)
      -> AttrEntry δ

inductive AttrDict (δ: Dialect α σ ε) :=
| mk: List (AttrEntry δ) -> AttrDict δ

end

-- We define "AttrVal" to be just the basic attributes outside of any dialect
abbrev AttrVal := @AttrValue _ _ _ Dialect.empty


mutual
-- | TODO: make this `record` when mutual records are allowed?
-- | TODO: make these arguments optional?
inductive Op (δ: Dialect α σ ε) where
 | mk: (name: String)
      -> (args: List SSAVal)
      -> (bbs: List BBName)
      -> (regions: List (Region δ))
      -> (attrs: AttrDict δ)
      -> (ty: MLIRType δ)
      -> Op δ

inductive BasicBlockStmt (δ: Dialect α σ ε) where
| StmtAssign : SSAVal -> (ix: Option Int) -> Op δ -> BasicBlockStmt δ
| StmtOp : Op δ -> BasicBlockStmt δ


inductive BasicBlock (δ: Dialect α σ ε) where
| mk: (name: String)
      -> (args: List (SSAVal × MLIRType δ))
      -> (ops: List (BasicBlockStmt δ)) -> BasicBlock δ

inductive Region (δ: Dialect α σ ε) where
| mk: (bbs: List (BasicBlock δ)) -> Region δ

end

-- Attribute definition on the form #<name> = <val>
inductive AttrDefn (δ: Dialect α σ ε) where
| mk: (name: String) -> (val: AttrValue δ) -> AttrDefn δ

-- | TODO: this seems like a weird exception. Is this really true?
inductive Module (δ: Dialect α σ ε) where
| mk: (functions: List (Op δ))
      -> (attrs: List (AttrDefn δ))
      ->  Module δ


def Op.name: Op δ -> String
| Op.mk name args bbs regions attrs ty => name

def Op.args: Op δ -> List SSAVal
| Op.mk name args bbs regions attrs ty => args

def Op.bbs: Op δ -> List BBName
| Op.mk name args bbs regions attrs ty => bbs

def Op.regions: Op δ -> List (Region δ)
| Op.mk name args bbs regions attrs ty => regions

def Op.attrs: Op δ -> AttrDict δ
| Op.mk name args bbs regions attrs ty => attrs

def Op.ty: Op δ -> MLIRType δ
| Op.mk name args bbs regions attrs ty => ty

def Region.bbs (r: Region δ): List (BasicBlock δ) :=
  match r with
  | (Region.mk bbs) => bbs


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

instance : Coe (BasicBlock δ) (Region δ) where
  coe (bb: BasicBlock δ) := Region.mk [bb]

instance : Coe (List (BasicBlock δ)) (Region δ) where
  coe (bbs: List (BasicBlock δ)) := Region.mk bbs

instance : Coe (Region δ) (List (BasicBlock δ)) where
  coe (rgn: Region δ) := match rgn with | Region.mk bbs => bbs

-- Coercions across dialects

mutual
variable [δ₁: Dialect α₁ σ₁ ε₁] [δ₂: Dialect α₂ σ₂ ε₂] [c: CoeDialect δ₁ δ₂]

def coeMLIRType: MLIRType δ₁ → MLIRType δ₂
  | .fn τ₁ τ₂    => .fn (coeMLIRType τ₁) (coeMLIRType τ₂)
  | .int sgn n   => .int sgn n
  | .float n     => .float n
  | .index       => .index
  | .tuple τs    => .tuple (coeMLIRTypeList τs)
  | .undefined n => .undefined n
  | .extended s  => .extended (c.coe_σ _ _ s)

def coeMLIRTypeList: List (MLIRType δ₁) → List (MLIRType δ₂)
  | []    => []
  | τ::τs => coeMLIRType τ :: coeMLIRTypeList τs
end

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (MLIRType δ₁) (MLIRType δ₂) where
  coe := coeMLIRType

-- Useful locally when dealing with tuple types
instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (List (MLIRType δ₁)) (List (MLIRType δ₂)) where
  coe := coeMLIRTypeList

-- Useful locally when dealing with basic block arguments
instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (List (SSAVal × MLIRType δ₁)) (List (SSAVal × MLIRType δ₂)) where
  coe := List.map (fun (v, τ) => (v, Coe.coe τ))

def BasicBlockStmt.op: BasicBlockStmt δ ->  Op δ
| BasicBlockStmt.StmtAssign val ix op => op
| BasicBlockStmt.StmtOp op => op

def BasicBlock.name (bb: BasicBlock δ): BBName :=
  match bb with
  | BasicBlock.mk name args stmts => BBName.mk name

def BasicBlock.args (bb: BasicBlock δ): List (SSAVal × MLIRType δ) :=
  match bb with
  | BasicBlock.mk name args stmts => args


def BasicBlock.stmts (bb: BasicBlock δ): List (BasicBlockStmt δ) :=
  match bb with
  | BasicBlock.mk name args stmts => stmts

def Region.getBasicBlock (r: Region δ) (name: BBName): Option (BasicBlock δ) :=
  r.bbs.find? (fun bb => bb.name == name)


mutual
variable [δ₁: Dialect α₁ σ₁ ε₁] [δ₂: Dialect α₂ σ₂ ε₂] [c: CoeDialect δ₁ δ₂]

private def coeAttrValue: AttrValue δ₁ → AttrValue δ₂
  | .symbol s => .symbol s
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
  | .extended a => .extended (c.coe_α _ _ a)

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

private def coeOp: Op δ₁ → Op δ₂
  | .mk name args bbs regions attrs τ =>
      .mk name args bbs (coeRegionList regions) (Coe.coe attrs) (Coe.coe τ)

private def coeBasicBlockStmt: BasicBlockStmt δ₁ → BasicBlockStmt δ₂
  | .StmtAssign val ix op => .StmtAssign val ix (coeOp op)
  | .StmtOp op => .StmtOp (coeOp op)

private def coeBasicBlockStmtList:
    List (BasicBlockStmt δ₁) → List (BasicBlockStmt δ₂)
  | [] => []
  | s :: bbstmts => coeBasicBlockStmt s :: coeBasicBlockStmtList bbstmts

private def coeBasicBlock: BasicBlock δ₁ → BasicBlock δ₂
  | .mk name args ops => .mk name args (coeBasicBlockStmtList ops)

private def coeBasicBlockList: List (BasicBlock δ₁) → List (BasicBlock δ₂)
  | [] => []
  | bb :: bbs => coeBasicBlock bb :: coeBasicBlockList bbs

private def coeRegion: Region δ₁ → Region δ₂
  | .mk bbs => .mk (coeBasicBlockList bbs)

private def coeRegionList: List (Region δ₁) → List (Region δ₂)
  | [] => []
  | r :: regions => coeRegion r :: coeRegionList regions
end

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (Op δ₁) (Op δ₂) where
  coe := coeOp

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (BasicBlockStmt δ₁) (BasicBlockStmt δ₂) where
  coe := coeBasicBlockStmt

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (List (BasicBlockStmt δ₁)) (List (BasicBlockStmt δ₂)) where
  coe := coeBasicBlockStmtList

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (BasicBlock δ₁) (BasicBlock δ₂) where
  coe := coeBasicBlock

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (List (BasicBlock δ₁)) (List (BasicBlock δ₂)) where
  coe := coeBasicBlockList

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (Region δ₁) (Region δ₂) where
  coe := coeRegion

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (List (Region δ₁)) (List (Region δ₂)) where
  coe := coeRegionList


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
variable {α σ ε} [δ: Dialect α σ ε]

partial def docMLIRType: MLIRType δ → Doc
  | .int .Signless k => [doc| "i"k]
  | .int .Unsigned k => [doc| "u"k]
  | .int .Signed k => [doc| "si"k]
  | .float k => [doc| "f"k]
  | .index => [doc| "index"]
  | .tuple ts => [doc| "(" (ts.map docMLIRType),* ")" ]
  | .fn dom codom => (docMLIRType dom) ++ " -> " ++ (docMLIRType codom)
  | .undefined name => [doc| "!" name]
  | .extended sig => DialectTypeIntf.typeStr ε sig

partial def docAttrVal: AttrValue δ → Doc
  | .symbol s => "@" ++ doc_surround_dbl_quot s
  | .nestedsymbol s t => (docAttrVal s) ++ "::" ++ (docAttrVal t)
  | .str str => doc_surround_dbl_quot str
  | .type ty => docMLIRType ty
  | .int i ty => doc i ++ " : " ++ docMLIRType ty
  | .bool b => if b then "true" else "false"
  | .float f ty => doc f ++ " : " ++ docMLIRType ty
  | .affine aff => "affine_map<" ++ doc aff ++ ">"
  | .list xs => "[" ++ Doc.Nest (vintercalate_doc (xs.map docAttrVal) ", ") ++ "]"
  | .alias a => "#" ++ a
  | .dict d => docAttrDict d
  | .opaque_ dialect val => [doc| "#" (dialect) "<"  (val) ">"]
  | .opaqueElements dialect val ty => [doc| "#opaque<" (dialect) ","  (val) ">" ":" (docMLIRType ty)]
  | .unit => "()"
  | .extended a => DialectAttrIntf.str a

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

def op_to_doc: Op δ → Doc
    | (Op.mk name args bbs rgns attrs ty) =>
        /- v3: macros + if stuff-/
        [doc|
          "\"" name "\""
          "(" (args),* ")"
          (ifdoc bbs.isEmpty then "" else "[" (bbs),* "]")
          (ifdoc rgns.isEmpty then "" else "(" (nest (list_rgn_to_doc rgns);*) ")")
          attrs ":" ty]

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

def bb_stmt_to_doc: BasicBlockStmt δ → Doc
  | BasicBlockStmt.StmtAssign lhs none rhs =>
      [doc| lhs "="  (op_to_doc rhs) ]
  | BasicBlockStmt.StmtAssign lhs (some ix) rhs =>
      [doc| lhs ":" ix "="  (op_to_doc rhs) ]
  | BasicBlockStmt.StmtOp rhs => (op_to_doc rhs)

def list_bb_stmt_to_doc: List (BasicBlockStmt δ) → List Doc
  | [] => []
  | stmt :: stmts => bb_stmt_to_doc stmt :: list_bb_stmt_to_doc stmts

-- | TODO: fix the dugly syntax
def bb_to_doc: BasicBlock δ → Doc
  | (BasicBlock.mk name args stmts) =>
    [doc| {
        (ifdoc args.isEmpty
         then  "^" name ":"
         else  "^" name "(" (args.map $ fun (v, t) => [doc| v ":" t]),* ")" ":");
        (nest list_bb_stmt_to_doc stmts);* ; } ]

def list_bb_to_doc: List (BasicBlock δ) → List Doc
  | [] => []
  | bb :: bbs => bb_to_doc bb :: list_bb_to_doc bbs

def rgn_to_doc: Region δ → Doc
  | (Region.mk bbs) => [doc| { "{"; (nest (list_bb_to_doc bbs);*); "}"; }]

def list_rgn_to_doc: List (Region δ) → List Doc
  | [] => []
  | r :: rs => rgn_to_doc r :: list_rgn_to_doc rs

end

instance : Pretty (Op δ) where
  doc := op_to_doc

instance : Pretty (BasicBlock δ) where
  doc := bb_to_doc

instance : Pretty (Region δ) where
  doc := rgn_to_doc

def AttrEntry.key (a: AttrEntry δ): String :=
match a with
| AttrEntry.mk k v => k

def AttrEntry.value (a: AttrEntry δ): AttrValue δ :=
match a with
| AttrEntry.mk k v => v


def MLIRType.unit : MLIRType δ := MLIRType.tuple []
def AttrDict.empty : AttrDict δ := AttrDict.mk []

def Op.empty (name: String) : Op δ :=
  Op.mk name [] [] [] AttrDict.empty (.fn MLIRType.unit MLIRType.unit)
-- | TODO: needs to happen in a monad to ensure that ty has the right type!
def Op.addArg (o: Op δ) (a: SSAVal) (t: MLIRType δ): Op δ :=
  match o with
  | Op.mk name args bbs regions attrs ty =>
    let ty' := match ty with
               | .fn (.tuple ins) outs =>
                   .fn (.tuple $ ins ++ [t]) outs
               | _ => .fn (.tuple [t]) MLIRType.unit
    Op.mk name (args ++ [a]) bbs regions attrs ty'

def Op.addResult (o: Op δ) (t: MLIRType δ): Op δ :=
 match o with
 | Op.mk name args bbs regions attrs ty =>
    let ty' := match ty with
               | .fn ins (.tuple outs) =>
                   .fn ins (.tuple $ outs ++ [t])
               | _ => .fn (.tuple []) (.tuple [t])
    Op.mk name args bbs regions attrs ty'

def Op.appendRegion (o: Op δ) (r: Region δ): Op δ :=
  match o with
  | Op.mk name args bbs regions attrs ty =>
      Op.mk name args bbs (regions ++ [r]) attrs ty


-- | Note: AttrEntry can be given as String × AttrValue
def AttrDict.add (attrs: AttrDict δ) (entry: AttrEntry δ): AttrDict δ :=
    Coe.coe $ (entry :: Coe.coe attrs)

def AttrDict.find (attrs: AttrDict δ) (name: String): Option (AttrValue δ) :=
  match attrs with
  | AttrDict.mk entries =>
      match entries.find? (fun entry => entry.key == name) with
      | some v => v.value
      | none => none

def AttrDict.addString (attrs: AttrDict δ) (k: String) (v: String): AttrDict δ :=
    AttrEntry.mk k (v: AttrValue δ) :: attrs

def AttrDict.addType (attrs: AttrDict δ) (k: String) (v: MLIRType δ): AttrDict δ :=
    AttrEntry.mk k (v: AttrValue δ) :: attrs


-- | Note: AttrEntry can be given as String × AttrValue
def Op.addAttr (o: Op δ) (k: String) (v: AttrValue δ): Op δ :=
 match o with
 | Op.mk name args bbs regions attrs ty =>
    Op.mk name args bbs regions (attrs.add (k, v)) ty

def BasicBlock.empty (name: String): BasicBlock δ := BasicBlock.mk name [] []
def BasicBlock.appendStmt (bb: BasicBlock δ) (stmt: BasicBlockStmt δ): BasicBlock δ :=
  match bb with
  | BasicBlock.mk name args bbs => BasicBlock.mk name args (bbs ++ [stmt])

def BasicBlock.appendStmts (bb: BasicBlock δ) (stmts: List (BasicBlockStmt δ)): BasicBlock δ :=
  match bb with
  | BasicBlock.mk name args bbs => BasicBlock.mk name args (bbs ++ stmts)

def Region.empty: Region δ := Region.mk []

def Region.appendBasicBlock (r: Region δ) (bb: BasicBlock δ) : Region δ :=
  Coe.coe (Coe.coe r ++ [bb])

instance : Pretty (Op δ) where
  doc := op_to_doc

instance : Pretty (BasicBlockStmt δ) where
  doc := bb_stmt_to_doc

instance : Pretty (BasicBlock δ) where
  doc := bb_to_doc

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

instance : Inhabited (BasicBlock δ) where
  default := BasicBlock.empty "INHABITANT"

instance : Inhabited (Region δ) where
  default := Region.empty

instance : Pretty (Module δ) where
  doc (m: Module δ) :=
    match m with
    | Module.mk fs attrs =>
      Doc.VGroup (attrs.map doc ++ fs.map doc)

instance : Coe (Op δ) (BasicBlockStmt δ) where
   coe := BasicBlockStmt.StmtOp

def Region.fromBlock (bb: BasicBlock δ): Region δ := Region.mk [bb]
def BasicBlock.fromOps (os: List (Op δ)) (name: String := "entry"): BasicBlock δ :=
  BasicBlock.mk name [] (os.map BasicBlockStmt.StmtOp)

def BasicBlock.setArgs (bb: BasicBlock δ) (args: List (SSAVal × MLIRType δ)) : Region δ :=
match bb with
  | (BasicBlock.mk name _ stmts) => (BasicBlock.mk name args stmts)

def Region.fromOps (os: List (Op δ)): Region δ := Region.mk [BasicBlock.fromOps os]

-- | return the only region in the block
def Op.singletonRegion (o: Op δ): Region δ :=
  match o.regions with
  | (r :: []) => r
  -- FIXME: Adding (doc o) here produces a kernel error in PatternMatch.RewriteInfo.toPDL
  -- (I'm pretty sure it's a Lean bug)
  | _ => panic ("expected op with single region: ")-- ++ (doc o))

def Op.mutateSingletonRegion (o: Op δ) (f: Region δ -> Region δ): Op δ :=
 match o with
 | Op.mk name args bbs [r] attrs ty => Op.mk name args bbs [f r] attrs ty
 | _ => o -- panic ("expected op with single region: " ++ (doc o))


mutual
-- | TODO: how the fuck do we run this lens?!
inductive ValLens (δ: Dialect α σ ε): Type -> Type _ where
| id: ValLens δ SSAVal
| op: (opKind: String) -> (lens: OpLens δ o) -> ValLens δ o

inductive OpLens (δ: Dialect α σ ε): Type -> Type _ where
| region: Nat -> RegionLens δ o -> OpLens δ o
| id: OpLens δ (Op δ)
| arg: Nat -> ValLens δ o -> OpLens δ o

inductive RegionLens (δ: Dialect α σ ε): Type -> Type _ where
| block: Nat -> BasicBlockLens δ o -> RegionLens δ o
| id: RegionLens δ (Region δ)

inductive BasicBlockLens (δ: Dialect α σ ε): Type -> Type _ where
| op: Nat -> OpLens δ o -> BasicBlockLens δ o
| id: BasicBlockLens δ (BasicBlock δ)
end


-- | defunctionalized lens where `s` is lensed by `l t` to produce a `t`
class Lensed (s: Type _) (l: Type _ -> Type _) where
  lensId: l s -- create the identity lens for this source
  -- view: s -> l t -> t -- view using the lens at the target
  update: [Applicative f] -> l t -> (t -> f t) -> (s -> f s)


-- | ignore the x
structure PointedConst (t: Type) (v: t) (x: Type) where
  (val: t)

instance : Coe (PointedConst t v x) (PointedConst t v y) where
  coe a := { val := a.val }

instance: Functor (PointedConst t v) where
  map f p := p

instance: Pure (PointedConst t v) where
  pure x := PointedConst.mk v

instance: SeqLeft (PointedConst t v) where
  seqLeft pc _ := pc

instance: SeqRight (PointedConst t v) where
  seqRight pc _ := pc

instance: Seq (PointedConst t v) where
  seq f pc := pc ()

instance : Applicative (PointedConst t v) where
  map      := fun x y => Seq.seq (pure x) fun _ => y
  seqLeft  := fun a b => Seq.seq (Functor.map (Function.const _) a) b
  seqRight := fun a b => Seq.seq (Functor.map (Function.const _ id) a) b


def Lensed.get [Lensed s l] (lens: l t) (sval: s) (default_t: t): t :=
  (Lensed.update lens (fun t => @PointedConst.mk _ default_t _ t) sval).val

def Lensed.set [Lensed s l] (lens: l t) (sval: s) (tnew: t): s :=
  Lensed.update (f := Id) lens (fun t => tnew) sval

def Lensed.map [Lensed s l] (lens: l t) (sval: s) (tfun: t -> t): s :=
  Lensed.update (f := Id) lens tfun sval

def Lensed.mapM [Lensed s l]  [Monad m] (lens: l t) (sval: s) (tfun: t -> m t): m s :=
  Lensed.update lens tfun sval

-- | TODO: for now, when lens fails, we just return.
mutual
-- | how can this lens ever be run? Very interesting...
def vallens_update {f: Type _ -> Type _} {t: Type _} [Applicative f] (lens: ValLens δ t) (transform: t -> f t) (src: SSAVal) : f SSAVal :=
    match lens with
    | ValLens.id => transform src
    | ValLens.op kind oplens => pure src -- TODO: how do we encode this?

def oplens_update {f: Type _ -> Type _} {t: Type _} [Applicative f] (lens: OpLens δ t) (transform: t -> f t) (src: Op δ) : f (Op δ) :=
    match lens with
    | OpLens.id => transform src
    | OpLens.arg ix vlens =>
        match src with
        | Op.mk name args bbs regions attrs ty =>
        match args.get? ix with
        | none => Pure.pure src
        | some v => Functor.map (fun v => Op.mk name (args.set ix v) bbs regions attrs ty)
                               (vallens_update vlens transform v)
    | OpLens.region ix rlens =>
      match src with
      | Op.mk name args bbs  regions attrs ty =>
      match regions.get? ix with
      | none => Pure.pure src
      | some r =>  Functor.map (fun r => Op.mk name args bbs (regions.set ix r) attrs ty)
                               (regionlens_update rlens transform r)

def regionlens_update {f: Type _ -> Type _} {t: Type _} [Applicative f] (lens: RegionLens δ t) (transform: t -> f t) (src: Region δ) : f (Region δ) :=
    match lens with
    | RegionLens.id => transform src
    | RegionLens.block ix bblens =>
      match src with
      | Region.mk bbs =>
        match bbs.get? ix with
        | none => Pure.pure src
        | some bb =>  Functor.map (fun bb => Region.mk (bbs.set ix bb)) (blocklens_update bblens transform bb)


def blocklens_update {f: Type _ -> Type _} {t: Type _}[Applicative f] (lens: BasicBlockLens δ t) (transform: t -> f t) (src: BasicBlock δ) : f (BasicBlock δ) :=
    match lens with
    | BasicBlockLens.id => transform src
    | BasicBlockLens.op ix oplens =>
      match src with
      | BasicBlock.mk name args ops =>
        match ops.get? ix with
        | none => Pure.pure src
        | some stmt =>
            let stmt := match stmt with
            | BasicBlockStmt.StmtAssign lhs ix op => (BasicBlockStmt.StmtAssign lhs ix) <$> (oplens_update oplens transform op)
            | BasicBlockStmt.StmtOp op => BasicBlockStmt.StmtOp <$> (oplens_update oplens transform op)
            (fun stmt => BasicBlock.mk name args (ops.set ix stmt)) <$> stmt
end

instance : Lensed (Op δ) (OpLens δ) where
  lensId := OpLens.id
  update := oplens_update

instance : Lensed (Region δ) (RegionLens δ) where
  lensId := RegionLens.id
  update := regionlens_update

instance : Lensed (BasicBlock δ) (BasicBlockLens δ) where
  lensId := BasicBlockLens.id
  update := blocklens_update

def Region.singletonBlock (r: Region δ): BasicBlock δ :=
  match r.bbs with
  | (bb :: []) => bb
  -- FIXME: Adding (doc r) here produces a kernel error in PatternMatch.RewriteInfo.toPDL
  -- (I'm pretty sure it's a Lean bug)
  | _ => panic ("expected region with single bb" ++ (doc r))

-- | Ensure that region has an entry block.
def Region.ensureEntryBlock (r: Region δ): Region δ :=
match r with
| (Region.mk bbs) =>
  match bbs with
  | []  => @BasicBlock.empty _ _ _ δ "entry"
  | _ => r


-- | replace entry block arguments.
def Region.setEntryBlockArgs (r: Region δ) (args: List (SSAVal × MLIRType δ)) : Region δ :=
match r with
| (Region.mk bbs) =>
  match bbs with
  | []  => r
  | ((BasicBlock.mk name _ stmts) :: bbs) => Region.mk $ (BasicBlock.mk name args stmts) :: bbs

end MLIR.AST
