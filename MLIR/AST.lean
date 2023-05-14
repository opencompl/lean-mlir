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
abbrev MLIRTy := @MLIRType _ _ _ Dialect.empty
-- Other useful abbreviations
abbrev MLIRType.i1: MLIRType δ := MLIRType.int .Signless 1
abbrev MLIRType.i32: MLIRType δ := MLIRType.int .Signless 32

-- An SSA value with a type
abbrev TypedSSAVal (δ: Dialect α σ ε) := SSAVal × MLIRType δ

mutual
-- | TODO: factor Symbol out from AttrValue
inductive AttrValue (δ: Dialect α σ ε) :=
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
inductive AttrEntry (δ: Dialect α σ ε) :=
  | mk: (key: String)
      -> (value: AttrValue δ)
      -> AttrEntry δ

inductive AttrDict (δ: Dialect α σ ε) :=
| mk: List (AttrEntry δ) -> AttrDict δ

end

-- We define "AttrVal" to be just the basic attributes outside of any dialect
abbrev AttrVal := @AttrValue _ _ _ Dialect.empty


/-
mutual
-- | TODO: make this `record` when mutual records are allowed?
-- | TODO: make these arguments optional?
inductive Op (δ: Dialect α σ ε) where
 | mk: (name: String)
      -> (res: List (TypedSSAVal δ))
      -> (args: List (TypedSSAVal δ))
      -> (regions: List (Region δ))
      -> (attrs: AttrDict δ)
      -> Op δ

inductive Region (δ: Dialect α σ ε) where
| mk: (name: String)
      -> (args: List (TypedSSAVal δ))
      -> (ops: List (Op δ)) -> Region δ

end
-/

-- op / region tag
inductive OR
| O : OR -- op
| Os : OR -- list of ops
| R : OR -- region
| Rs: OR -- list of regions
inductive OpRegion (δ: Dialect α σ ε): OR -> Type where
 | op: (name: String)
      -> (res: List (TypedSSAVal δ))
      -> (args: List (TypedSSAVal δ))
      -> (regions: OpRegion δ .Rs)
      -> (attrs: AttrDict δ)
      -> OpRegion δ .O
 | opsnil : OpRegion δ .Os
 | opscons : (head : OpRegion δ .O)
            -> (tail: OpRegion δ .Os)
            -> OpRegion δ  .Os
 | regionsnil : OpRegion δ .Rs
 | regionscons : (head : OpRegion δ .R)
                 -> (tail: OpRegion δ  .Rs)
                 -> OpRegion δ .Rs
 | region: (name : String)
          -> (args: List (TypedSSAVal δ))
          -> (ops: OpRegion δ .Os)
          ->  OpRegion δ  .R


abbrev Op (δ : Dialect α σ ε): Type := OpRegion δ .O
abbrev Region (δ : Dialect α σ ε): Type := OpRegion δ .R
abbrev Regions (δ : Dialect α σ ε): Type := OpRegion δ .Rs
abbrev Ops (δ : Dialect α σ ε): Type := OpRegion δ .Os

/-
fold over ops and regions with a unary type 'a'.
-/
def OpRegion.fold
   {δ: Dialect α σ ε}
   {k}
   (fop: Op δ → a)
   (fops: a × (a → a → a))
   (frgn: Region δ → a)
   (frgns: a × (a → a → a)): OpRegion δ k → a
| .opsnil => fops.1
| .opscons head tl => fops.2 (head.fold fop fops frgn frgns) (tl.fold fop fops frgn frgns)
| .regionsnil => frgns.1
| .regionscons head tl => frgns.2 (head.fold fop fops frgn frgns) (tl.fold fop fops frgn frgns)
| .region name args ops => frgn (.region name args ops)
| .op name res args regions attrs => fop (.op name res args regions attrs)


def Regions.isEmpty: Regions δ → Bool
| .regionsnil => True
| .regionscons k ks => False

def Regions.snoc: Regions δ → Region δ → Regions δ
| .regionsnil, r => .regionscons r .regionsnil
| (.regionscons r rs),  r' => .regionscons r (Regions.snoc rs r)

def Regions.fromList: List (Region δ) → Regions δ
| [] => .regionsnil
| r :: rs => .regionscons r (Regions.fromList rs)


def Ops.snoc: Ops δ → Op δ → Ops δ
| .opsnil, x => .opscons x .opsnil
| (.opscons x xs),  x' => .opscons x (Ops.snoc xs x')

def Ops.append: Ops δ → Ops δ → Ops δ
| .opsnil, xs => xs
| (.opscons x xs),  xs' => .opscons x (Ops.append xs xs')

def Ops.fromList: List (Op δ) → Ops δ
| [] => .opsnil
| x :: xs => .opscons x (Ops.fromList xs)

@[match_pattern]
abbrev Op.mk {δ: Dialect α σ ε}
    (name: String)
    (res: List (TypedSSAVal δ))
    (args: List (TypedSSAVal δ))
    (regions: Regions δ)
    (attrs: AttrDict δ) : OpRegion δ .O :=
  OpRegion.op name res args regions attrs

@[match_pattern]
abbrev Region.mk {δ: Dialect α σ ε}
    (name: String)
    (args: List (TypedSSAVal δ))
    (ops: Ops δ): OpRegion δ .R :=
  OpRegion.region name args ops

@[match_pattern]
abbrev Ops.nil  {δ: Dialect α σ ε}: Ops δ :=
  OpRegion.opsnil

@[match_pattern]
abbrev Ops.cons  {δ: Dialect α σ ε} (o: Op δ) (os: Ops δ): Ops δ :=
  OpRegion.opscons o os

@[match_pattern]
abbrev Regions.nil  {δ: Dialect α σ ε}: Regions δ :=
  OpRegion.regionsnil

@[match_pattern]
abbrev Regions.cons  {δ: Dialect α σ ε} (r: Region δ) (rs: Regions δ): Regions δ :=
  OpRegion.regionscons r rs

def Ops.toList {δ: Dialect α σ ε}: Ops δ → List (Op δ)
  | .opsnil => []
  | .opscons o os => o :: toList os

def Regions.toList {δ: Dialect α σ ε}: Regions δ → List (Region δ)
  | .regionsnil => []
  | .regionscons r rs => r :: toList rs

mutual
  def Op.countSize: Op δ -> Int
  | Op.mk name res args regions attrs => 1 + Regions.countSize regions

  def Ops.countSize: Ops δ -> Int
  | .nil => 0
  | .cons o os => Op.countSize o + Ops.countSize os

  def Region.countSize: Region δ -> Int
  | Region.mk name args  ops => 1 + Ops.countSize ops

  def Regions.countSize: Regions δ -> Int
  | .nil => 0
  | .cons r rs => Region.countSize r + Regions.countSize rs
end


/-
Note that this uses WellFounded.fix.
Why does this STILL use WellFounded.fix?
-/
#print Op.countSize
#print Op.countSize._unary._mutual


/-
WTF, why does the explicit (implicit '{δ : Dialect α σ ε}') parameter
change the elaboration?
-/

def OpRegion.countSize1: OpRegion δ k → Int
| .regionsnil => 0
| .regionscons r rs => r.countSize1 + rs.countSize1
| .opsnil => 0
| .opscons o os => o.countSize1 + os.countSize1
| .op name res args regions  attrs => regions.countSize1 + 1
| .region name args ops => 1 + ops.countSize1
/-
def MLIR.AST.OpRegion.countSize1 : {α σ : Type} →
  {ε : σ → Type} → {δ : Dialect α σ ε} → {k : OR} → OpRegion δ k → Int :=
-/
#print OpRegion.countSize1


-- <non-varying> <varying>
def OpRegion.countSize2 {δ: Dialect α σ ε}: OpRegion δ k → Int
| .regionsnil => 0
| .regionscons r rs => r.countSize2 + rs.countSize2
| .opsnil => 0
| .opscons o os => o.countSize2 + os.countSize2
| .op name res args regions attrs => regions.countSize2 + 1
| .region name res ops => 1 + ops.countSize2

/-
This still uses WellFounded.fix.
Question: Is it the extra Dialect argument that confuses the codegen?
-/
/-
def MLIR.AST.OpRegion.countSize2 : {α σ : Type} →
  {ε : σ → Type} → {k : OR} →  {δ : Dialect α σ ε} → OpRegion δ k → Int :=
                   ^^^^^^^
-/
#print OpRegion.countSize2
#print OpRegion.countSize2._unary

-- <non-varying> <varying>
def OpRegion.countSize3 {δ: Dialect α σ ε} {k}: OpRegion δ k → Int
| .regionsnil => 0
| .regionscons r rs => r.countSize2 + rs.countSize2
| .opsnil => 0
| .opscons o os => o.countSize2 + os.countSize2
| .op name res args regions attrs => regions.countSize2 + 1
| .region name args ops => 1 + ops.countSize2


#print OpRegion.countSize3

/-=== Stuff that is defined only once ===-/

-- Subset of OpRegion object types that do not correspond to nested inductives
inductive OR' := | O | R

-- Extension of motive for occurrences of nested inductives
abbrev OpRegion.mRecMotive (motive: OR' → Type): OR → Type
  | .O => motive .O
  | .Os => List (motive .O)
  | .R => motive .R
  | .Rs => List (motive .R)

/- Case types. This repeats OpRegion constructors somewhat -/
inductive OpRegion.mRec_O_type (motive: OR' → Type) {α σ ε} {δ: Dialect α σ ε}
  | op (name: String)
    (res args: List (TypedSSAVal δ))
    (regions: Regions δ)
    (attrs: AttrDict δ) (regions_rec: List (motive .R))
inductive OpRegion.mRec_R_type (motive: OR' → Type) {α σ ε} {δ: Dialect α σ ε}
  | region (name: String) (args: List (TypedSSAVal δ)) (ops: Ops δ) (ops_rec: List (motive .O))

-- Short notation for the types of the case functions
abbrev OpRegion.mRec_O (motive: OR' → Type) {α σ ε} {δ: Dialect α σ ε} :=
  OpRegion.mRec_O_type motive (δ := δ) → motive .O
abbrev OpRegion.mRec_R (motive: OR' → Type) {α σ ε} {δ: Dialect α σ ε} :=
  OpRegion.mRec_R_type motive (δ := δ) → motive .R

-- Dependent mutual recursor
def OpRegion.mRec (motive: OR' → Type) {α σ ε} {δ: Dialect α σ ε}
    (caseO: OpRegion.mRec_O motive (δ := δ))
    (caseR: OpRegion.mRec_R motive (δ := δ)):
    forall {tag}, OpRegion δ tag → mRecMotive motive tag := fun
  | .op name res args regions attrs =>
      caseO <| .op name res args regions attrs (mRec motive caseO caseR regions)
  | .opsnil => []
  | .opscons o os =>
      mRec motive caseO caseR o :: mRec motive caseO caseR os
  | .region name args ops =>
      caseR <| .region name args ops (mRec motive caseO caseR ops)
  | .regionsnil => []
  | .regionscons r rs =>
      mRec motive caseO caseR r :: mRec motive caseO caseR rs

#print OpRegion.mRec

/- Combined recursor, which we can use to get the convenience of repackaging
   nested inductives without splitting definitions. This can do a lot more type
   inference because we get the entire motive at once -/

-- Useful middle-man to keep pattern matching for cRec-based definitions
inductive OpRegion.cRec_type {δ: Dialect α σ ε} (τO τR: Type) :=
  | op: (name: String) → (res args: List (TypedSSAVal δ)) → List (Region δ) → AttrDict δ →
     List τR → cRec_type τO τR
  | region: String → (args: List (TypedSSAVal δ)) → (ops: List (Op δ)) → List τO → cRec_type τO τR

def OpRegion.cRec {δ: Dialect α σ ε} {τO τR: Type}
    (case: (t: cRec_type (δ := δ) τO τR) → (match t with | .op .. => τO | .region .. => τR)):
    forall ⦃tag⦄, OpRegion δ tag → mRecMotive (fun | .O => τO | .R => τR) tag :=
  fun _ o => match o with
  | .op name res args regions attrs =>
      case <| .op name res args (Regions.toList regions) attrs (cRec case regions)
  | .opsnil => []
  | .opscons o os =>
      cRec case o :: cRec case os
  | .region name args ops =>
      case <| .region name args (Ops.toList ops) (cRec case ops)
  | .regionsnil => []
  | .regionscons r rs =>
      cRec case r :: cRec case rs

#print OpRegion.cRec

/- Non dependent recursor, which we can use to use case functions individually
   when the motive is the same for both ops and regions -/

inductive OpRegion.mmRec_O_type (motive: Type) {δ: Dialect α σ ε}
  | op (name: String) (res args: List (TypedSSAVal δ)) (regions: Regions δ)
      (attrs: AttrDict δ) (regions_rec: List motive)
inductive OpRegion.mmRec_R_type (motive: Type) {δ: Dialect α σ ε}
  | region (name: String) (args: List (TypedSSAVal δ))(ops: Ops δ) (ops_rec: List motive)

abbrev OpRegion.mmRec_O (motive: Type) {α σ ε} {δ: Dialect α σ ε} :=
  OpRegion.mmRec_O_type motive (δ := δ) → motive
abbrev OpRegion.mmRec_R (motive: Type) {α σ ε} {δ: Dialect α σ ε} :=
  OpRegion.mmRec_R_type motive (δ := δ) → motive

def OpRegion.mmRec {δ: Dialect α σ ε} {motive: Type}
    (caseO: OpRegion.mmRec_O motive (δ := δ))
    (caseR: OpRegion.mmRec_R motive (δ := δ)):
    forall {tag}, OpRegion δ tag → mRecMotive (fun _ => motive) tag := fun
  | .op name res args regions attrs =>
      caseO <| .op name res args regions attrs (mmRec caseO caseR regions)
  | .opsnil => []
  | .opscons o os =>
      mmRec caseO caseR o :: mmRec caseO caseR os
  | .region name args ops =>
      caseR <| .region name args ops (mmRec caseO caseR ops)
  | .regionsnil => []
  | .regionscons r rs =>
      mmRec caseO caseR r :: mmRec caseO caseR rs

#print OpRegion.mmRec

/-=== Stuff that is defined once for each mutually-recursive function ===-/

abbrev CountSize4Motive: OR' → Type
  | .O => Int
  | .R => Int

def Op.countSize4 {δ: Dialect α σ ε}: OpRegion.mRec_O CountSize4Motive (δ := δ)
  | .op name res args regions attrs regions_rec => regions_rec |>.foldl (.+.) 1
def Region.countSize4 {δ: Dialect α σ ε}: OpRegion.mRec_R CountSize4Motive (δ := δ)
  | .region name args regions ops_rec => ops_rec.foldl (.+.) 1

def OpRegion.countSize4 {δ: Dialect α σ ε} (o: OpRegion δ tag) :=
  mRec _ Op.countSize4 Region.countSize4 o

example: OpRegion.countSize4 (δ := .empty) (.op "test" [] [] .regionsnil (AttrDict.mk [])) = 1 := rfl

-- Other version if we accept to use a single function in exchange for implicit
-- motives with type inference
def OpRegion.countSize5 {δ: Dialect α σ ε} := cRec (δ := δ) fun
  | .op name res args regions attrs regions_rec => regions_rec.foldl (.+.) 1
  | .region name args regions ops_rec => ops_rec.foldl (.+.) 1

example: OpRegion.countSize5 (δ := .empty) (.op "test" [] [] .regionsnil (AttrDict.mk [])) = 1 := rfl

-- Other version if we have a uniform motive but want case functions

def Op.countSize6 {δ: Dialect α σ ε}: OpRegion.mmRec_O Int (δ := δ)
  | .op name res args regions attrs regions_rec => regions_rec.foldl (.+.) 1
def Region.countSize6 {δ: Dialect α σ ε}: OpRegion.mmRec_R Int (δ := δ)
  | .region name args regions ops_rec => ops_rec.foldl (.+.) 1

def OpRegion.countSize6 {δ: Dialect α σ ε} (o: OpRegion δ tag) :=
  mmRec Op.countSize6 Region.countSize6 o

example: OpRegion.countSize6 (δ := .empty) (.op "test" [] [] .regionsnil (AttrDict.mk [])) = 1 := rfl

-- Better with 'where'

def OpRegion.countSize7 {δ: Dialect α σ ε} (o: OpRegion δ tag) :=
  mmRec countOp countRegion o where
countOp
  | .op  name res args regions attrs regions_rec => regions_rec.foldl (.+.) 1
countRegion
  | .region name args regions ops_rec => ops_rec.foldl (.+.) 1

example: OpRegion.countSize7 (δ := .empty) (.op "test" [] [] .regionsnil (AttrDict.mk [])) = 1 := rfl

/-===-/

-- Attribute definition on the form #<name> = <val>
inductive AttrDefn (δ: Dialect α σ ε) where
| mk: (name: String) -> (val: AttrValue δ) -> AttrDefn δ

-- | TODO: this seems like a weird exception. Is this really true?
inductive Module (δ: Dialect α σ ε) where
| mk: (functions: List (Op δ))
      -> (attrs: List (AttrDefn δ))
      ->  Module δ


def Op.name: Op δ -> String
| .op name .. => name

def Op.res: Op δ -> List (TypedSSAVal δ)
| .op _ res .. => res

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

-- | TODO: See if we want to return this, or we want to return 'Regions δ'
def Op.regions: Op δ -> List (Region δ)
| Op.mk name res args regions attrs => regions.toList

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

mutual
variable [δ₁: Dialect α₁ σ₁ ε₁] [δ₂: Dialect α₂ σ₂ ε₂] [c: CoeDialect δ₁ δ₂]

def coeMLIRType: MLIRType δ₁ → MLIRType δ₂
  | .int sgn n   => .int sgn n
  | .float n     => .float n
  | .index       => .index
  | .undefined n => .undefined n
  | .tensor1d => .tensor1d
  | .tensor2d => .tensor2d
  | .tensor4d => .tensor4d
  | .erased => .erased
  | .extended s  => .extended (c.coe_σ s)

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


def Region.name (region: Region δ): BBName :=
  match region with
  | Region.mk name args ops => BBName.mk name

-- TODO: see if we want to return this, or if we want to return 'Ops δ'
def Region.ops (region: Region δ): List (Op δ) :=
  match region with
  | Region.mk name args ops => ops.toList

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

/-
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
-/

def coeOpRegion [CoeDialect δ₁ δ₂]: OpRegion δ₁ k → OpRegion δ₂ k
| .op name res args regions attrs =>
    .op name res args (coeOpRegion regions) attrs
| .opsnil => .opsnil
| .opscons o os => .opscons (coeOpRegion o) (coeOpRegion os)
| .regionsnil => .regionsnil
| .regionscons r rs => .regionscons (coeOpRegion r) (coeOpRegion rs)
| .region name args ops => .region name args (coeOpRegion ops)

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (Op δ₁) (Op δ₂) where
  coe := coeOpRegion

-- | TODO: I should not need this
instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (List (Op δ₁)) (List (Op δ₂)) where
  coe := List.map coeOpRegion

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (Region δ₁) (Region δ₂) where
  coe := coeOpRegion

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (List (Region δ₁)) (List (Region δ₂)) where
  coe := List.map coeOpRegion

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (Region δ₁) (Region δ₂) where
  coe := coeOpRegion

instance {δ₁: Dialect α₁ σ₁ ε₁} {δ₂: Dialect α₂ σ₂ ε₂} [CoeDialect δ₁ δ₂]:
    Coe (List (Region δ₁)) (List (Region δ₂)) where
  coe := List.map coeOpRegion

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
  | .tensor1d => [doc| "tensor1d"]
  | .tensor2d => [doc| "tensor2d"]
  | .tensor4d => [doc| "tensor4d"]
  | .index => [doc| "index"]
  | .undefined name => [doc| "!" name]
  | .erased => [doc| "erased"]
  | .extended sig => DialectTypeIntf.typeStr ε sig

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
  | .extended a => DialectAttrIntf.str a
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

def list_op_to_doc: Ops δ → List Doc
  | .opsnil => []
  | .opscons op ops => op_to_doc op :: list_op_to_doc ops

-- | TODO: fix the dugly syntax
def rgn_to_doc: Region δ → Doc
  | (Region.mk name args ops) =>
    [doc| {
        (ifdoc args.isEmpty
         then  "^" name ":"
         else  "^" name "(" (args.map $ fun (v, t) => [doc| v ":" t]),* ")" ":");
        (nest list_op_to_doc ops);* ; } ]

def list_rgn_to_doc: (Regions δ) → List Doc
  | .regionsnil => []
  | .regionscons r rs => (rgn_to_doc r) :: (list_rgn_to_doc rs)
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

def Op.empty (name: String) : Op δ := Op.mk name [] [] .regionsnil AttrDict.empty

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
      Op.mk name res args (regions.snoc r) attrs


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

@[simp] theorem AttrDict.find_none {δ: Dialect α σ ε}:
    AttrDict.find (δ := δ) (AttrDict.mk []) n' = none := by
  simp [AttrDict.find, List.find?]

@[simp] theorem AttrDict.find_next {δ: Dialect α σ ε} (v: AttrValue δ)
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

def Region.empty (name: String): Region δ := Region.mk name [] .opsnil
def Region.appendOp (bb: Region δ) (op: Op δ): Region δ :=
  match bb with
  | Region.mk name args bbs => Region.mk name args (bbs.snoc op)

def Region.appendOps (bb: Region δ) (ops: List (Op δ)): Region δ :=
  match bb with
  | Region.mk name args bbs => Region.mk name args (bbs.append <| Ops.fromList ops)


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
  Region.mk name [] (Ops.fromList os)

def Region.setArgs (bb: Region δ) (args: List (SSAVal × MLIRType δ)) : Region δ :=
match bb with
  | (Region.mk name _ ops) => (Region.mk name args ops)


end MLIR.AST
