import Lean
import Lean.Elab
import Lean.Meta
import Lean.Parser
import Lean.PrettyPrinter
import Lean.PrettyPrinter.Formatter
import MLIR.AST
import MLIR.Dialects.BuiltinModel
import Lean.Parser
import Lean.Parser.Extra

open Lean
open Lean.Parser
open Lean.Elab
open Lean.Meta
open Lean.Parser
open Lean.Parser.ParserState
open Lean.PrettyPrinter
open Lean.PrettyPrinter.Formatter

open MLIR.AST

namespace MLIR.EDSL


-- | Custom parsers for balanced brackets
inductive Bracket
| Square -- []
| Round -- ()
| Curly -- {}
| Angle -- <>
deriving Inhabited, DecidableEq

instance : ToString Bracket where
   toString :=
    fun b =>
     match b with
     | .Square => "["
     | .Round => "("
     | .Curly => "{"
     | .Angle => "<"


-- TODO: remove <Tab> from quail
def isOpenBracket(c: Char): Option Bracket :=
match c with
| '(' => some .Round
| '[' => some .Square
| '{' => some .Curly
| '<' => some .Angle
| _ => none

def isCloseBracket(c: Char):Option Bracket :=
match c with
| ')' => some .Round
| ']' => some .Square
| '{' => some .Curly
| '<' => some .Angle
| _ => none

mutual

#check ParserState

#check Format

-- 'a -> symbol
-- `a -> antiquotation `(... ,(...))
partial def consumeCloseBracket(c: Bracket)
  (startPos: String.Pos)
  (i: String.Pos)
  (input: String)
  (brackets: List Bracket)
  (ctx: ParserContext)
  (s: ParserState): ParserState := Id.run do
    match brackets with
    | b::bs =>
      if b == c
      then
        if bs == []
        then
          let parser_fn := Lean.Parser.mkNodeToken `balanced_brackets startPos
          parser_fn ctx (s.setPos (input.next i)) -- consume the input here.
        else balancedBracketsFnAux startPos (input.next i) input bs ctx s
      else s.mkError $ "| found Opened `" ++ toString b ++ "` expected to close at `" ++ toString c ++ "`"
    | _ => s.mkError $ "| found Closed `" ++ toString c ++ "`, but have no opened brackets on stack"


partial def balancedBracketsFnAux (startPos: String.Pos)
  (i: String.Pos)
  (input: String)
  (bs: List Bracket) (ctx: ParserContext) (s: ParserState): ParserState :=
  if input.atEnd i
  then s.mkError "fonud EOF"
  else
  match input.get i with
  -- opening parens
  | '(' => balancedBracketsFnAux startPos (input.next i) input (Bracket.Round::bs) ctx s
  | '[' => balancedBracketsFnAux startPos (input.next i) input (Bracket.Square::bs) ctx s
  | '<' => balancedBracketsFnAux startPos (input.next i) input (Bracket.Angle::bs) ctx s
  | '{' => balancedBracketsFnAux startPos (input.next i) input (Bracket.Curly::bs) ctx s
  -- closing parens
  | ')' => consumeCloseBracket Bracket.Round startPos i input bs ctx s
  | ']' => consumeCloseBracket Bracket.Square startPos i input bs ctx s
  | '>' => consumeCloseBracket Bracket.Angle startPos i input bs ctx s
  | '}' => consumeCloseBracket Bracket.Curly startPos i input bs ctx s
  | c => balancedBracketsFnAux startPos (input.next i) input bs ctx s

end

-- | TODO: filter tab complete by type?
def balancedBracketsFnEntry (ctx: ParserContext) (s: ParserState): ParserState :=
  if ctx.input.get s.pos == '<'
  then balancedBracketsFnAux
   (startPos := s.pos)
   (i := s.pos)
   (input := ctx.input)
   (bs := [])
   ctx s
  else s.mkError "Expected '<'"


@[inline]
def balancedBrackets : Parser :=
   withAntiquot (mkAntiquot "balancedBrackets" `balancedBrackets) {
       fn := balancedBracketsFnEntry,
       info := mkAtomicInfo "balancedBrackets" : Parser
    }

#check balancedBrackets


-- Code stolen from test/WebServer/lean
@[combinatorFormatter MLIR.EDSL.balancedBrackets]
def MLIR.EDSL.balancedBrackets.formatter : Formatter := pure ()

@[combinatorParenthesizer MLIR.EDSL.balancedBrackets]
def MLIR.EDSL.balancedBracketsParenthesizer : Parenthesizer := pure ()


macro "[balanced_brackets|" xs:balancedBrackets "]" : term => do
  match xs.raw[0] with
  | .atom _ val => return (Lean.quote val: TSyntax `str)
  | _  => Macro.throwError "expected balanced bracts to have atom"


def testBalancedBrackets : String := [balanced_brackets| < { xxasdasd } > ]
#print testBalancedBrackets



-- | positive and negative numbers, hex, octal
declare_syntax_cat mlir_int
syntax numLit: mlir_int

def IntToString (i: Int): String := i.repr

instance : Quote Int := ⟨fun n => Syntax.mkNumLit <| n.repr⟩

def quoteMDimension (d: Dimension): MacroM Syntax :=
  match d with
  | Dimension.Known n => do
    `(Dimension.Known $(quote n))
  | Dimension.Unknown => `(Dimension.Unknown)


def quoteMList (k: List (TSyntax `term)) (ty: TSyntax `term): MacroM (TSyntax `term) :=
  match k with
  | [] => `(@List.nil $ty)
  | (k::ks) => do
      let sks <- quoteMList ks ty
      `($k :: $sks)


-- AFFINE SYTAX
-- ============

declare_syntax_cat affine_expr
declare_syntax_cat affine_tuple
declare_syntax_cat affine_map


syntax ident : affine_expr
syntax "(" sepBy(affine_expr, ",") ")" : affine_tuple
syntax "affine_map<" affine_tuple "->" affine_tuple ">" : affine_map

syntax "[affine_expr|" affine_expr "]" : term
syntax "[affine_tuple|" affine_tuple "]" : term
syntax "[affine_map|" affine_map "]" : term
-- syntax "[affine_map|" affine_map "]" : term

macro_rules
| `([affine_expr| $xraw:ident ]) => do
  let xstr := xraw.getId.toString
  `(AffineExpr.Var $(Lean.quote xstr))

macro_rules
| `([affine_tuple| ( $xs,* ) ]) => do
   let initList  <- `(@List.nil MLIR.AST.AffineExpr)
   let argsList <- xs.getElems.foldrM
    (init := initList)
    (fun x xs => `([affine_expr| $x] :: $xs))
   `(AffineTuple.mk $argsList)


macro_rules
| `([affine_map| affine_map< $xs:affine_tuple -> $ys:affine_tuple >]) => do
  let xs' <- `([affine_tuple| $xs])
  let ys' <- `([affine_tuple| $ys])
  `(AffineMap.mk $xs' $ys' )


-- EDSL
-- ====

declare_syntax_cat mlir_bb
declare_syntax_cat mlir_entry_bb
declare_syntax_cat mlir_region
declare_syntax_cat mlir_op
declare_syntax_cat mlir_op_args
declare_syntax_cat mlir_op_successor_args
declare_syntax_cat mlir_op_type
declare_syntax_cat mlir_op_operand
declare_syntax_cat mlir_ops
declare_syntax_cat mlir_type

-- syntax strLit mlir_op_args ":" mlir_op_type : mlir_op -- no region
--


-- EDSL OPERANDS
-- ==============

syntax "%" numLit : mlir_op_operand

syntax "%" ident : mlir_op_operand

syntax "[mlir_op_operand|" mlir_op_operand "]" : term
macro_rules
  | `([mlir_op_operand| $$($q)]) => return q
  | `([mlir_op_operand| % $x:ident]) => `(SSAVal.SSAVal $(Lean.quote (x.getId.toString)))
  | `([mlir_op_operand| % $n:num]) => `(SSAVal.SSAVal (IntToString $n))

def operand0 := [mlir_op_operand| %x]
#print operand0

def operand1 := [mlir_op_operand| %x]
#print operand1

def operand2 := [mlir_op_operand| %0]
#print operand2


-- EDSL OP-SUCCESSOR-ARGS
-- =================

-- successor-list       ::= `[` successor (`,` successor)* `]`
-- successor            ::= caret-id (`:` bb-arg-list)?

declare_syntax_cat mlir_op_successor_arg -- bb argument
syntax "^" ident : mlir_op_successor_arg -- bb argument with no operands
-- syntax "^" ident ":" "(" mlir_op_operand","* ")" : mlir_op_successor_arg

syntax "[mlir_op_successor_arg|" mlir_op_successor_arg "]" : term

macro_rules
  | `([mlir_op_successor_arg| ^ $x:ident  ]) =>
      `(BBName.mk $(Lean.quote (x.getId.toString)))

def succ0 :  BBName := ([mlir_op_successor_arg| ^bb])
#print succ0


-- EDSL MLIR TYPES
-- ===============


syntax "[mlir_type|" mlir_type "]" : term

-- TODO: Tuple and function types don't really exists (hardcoded Op notation)

syntax "(" mlir_type,* ")" : mlir_type
macro_rules
| `([mlir_type| ( $xs,* )]) => do
      let xs <- xs.getElems.mapM (fun x => `([mlir_type| $x]))
      let x <- quoteMList xs.toList (<- `(MLIRType _))
      `(MLIRType.tuple $x)

-- syntax "(" mlir_type ")" : mlir_type
-- syntax "(" mlir_type "," mlir_type ")" : mlir_type
-- | HACK: just switch to real parsing of lists
-- syntax "(" mlir_type "," mlir_type "," mlir_type ")" : mlir_type
syntax mlir_type "->" mlir_type : mlir_type
syntax "{{" term "}}" : mlir_type
syntax "!" str : mlir_type
syntax "!" ident : mlir_type
syntax ident: mlir_type


set_option hygiene false in -- allow i to expand
macro_rules
  | `([mlir_type| $x:ident ]) => do
        let xstr := x.getId.toString
        if xstr == "index"
        then
          `(MLIRType.index)
        else if xstr.front == 'i' || xstr.front == 'f'
        then do
          let xstr' := xstr.drop 1
          match xstr'.toInt? with
          | some i =>
            let lit := Lean.Syntax.mkNumLit xstr'
            if xstr.front == 'i'
            then `(MLIRType.int .Signless $lit)
            else `(MLIRType.float $lit)
          | none =>
              Macro.throwError $ "cannot convert suffix of i/f to int: " ++ xstr
        else Macro.throwError $ "expected i<int> or f<int>, found: " ++ xstr

macro_rules
| `([mlir_type| ! $x:str ]) => `(MLIRType.undefined $x)

macro_rules
| `([mlir_type| ! $x:ident ]) => `(MLIRType.undefined $(Lean.quote x.getId.toString))

def tyIndex : MLIRTy := [mlir_type| index]
#eval tyIndex

def tyUser : MLIRTy := [mlir_type| !"lz.int"]
#eval tyUser

def tyUserIdent : MLIRTy := [mlir_type| !shape.value]
#eval tyUserIdent


def tyi32NoGap : MLIRTy := [mlir_type| i32]
#eval tyi32NoGap
def tyf32NoGap : MLIRTy := [mlir_type| f32]
#eval tyf32NoGap

macro_rules
| `([mlir_type| {{ $t }} ]) => return t -- antiquot type

-- macro_rules
--   | `([mlir_type| ( ) ]) => `(MLIRType.tuple [])
--   | `([mlir_type| ( $x:mlir_type )]) =>
--         `(MLIRType.tuple [ [mlir_type|$x] ])
--   | `([mlir_type| ( $x:mlir_type, $y:mlir_type )]) =>
--     `(MLIRType.tuple [ [mlir_type|$x], [mlir_type|$y] ] )
--   | `([mlir_type| ( $x:mlir_type, $y:mlir_type, $z:mlir_type )]) =>
--     `(MLIRType.tuple [ [mlir_type|$x], [mlir_type|$y], [mlir_type| $z ] ] )

macro_rules
  | `([mlir_type| $dom:mlir_type -> $codom:mlir_type]) =>
     `(MLIRType.fn [mlir_type|$dom] [mlir_type|$codom])

def ty0 : MLIRTy := [mlir_type| ( )]
def tyi32 : MLIRTy := [mlir_type| i32] -- TODO: how to keep no gap?
-- def tyi32' : MLIRTy := ([mlir_type| i32) -- TODO: how to keep no gap?
def tysingle : MLIRTy := [mlir_type| (i42)]
def typair : MLIRTy := [mlir_type| (i32, i64)]
def tyfn0 : MLIRTy := [mlir_type| () -> ()]
def tyfn1 : MLIRTy := [mlir_type| (i11) -> (i12)]
def tyfn2 : MLIRTy := [mlir_type| (i21, i22) -> (i23, i24)]
def tyfn3 : MLIRTy := [mlir_type| (i21, i22, i23) -> (i23, i24, i25)]
#print ty0
#print tyi32
#print typair
#print tyfn0
#print tyfn1
-- #print tyi32'

-- Uses dialect coercion empty → builtin
example : MLIRType builtin := [mlir_type| i32]
-- Uses MLIRType coercion on the sublist (MLIRType.coeList)
example : MLIRType builtin := [mlir_type| () -> ()]
-- Uses dialect coercion empty → empty + builtin
example : MLIRType (Dialect.empty + builtin) := [mlir_type| i32]
-- More tricky: pushes coercion into the whole construction
-- (used to fail with HAppend in quoteMList)
example : MLIRType (builtin + Dialect.empty) := [mlir_type| (i21, i22)]



declare_syntax_cat mlir_dimension

syntax "?" : mlir_dimension
syntax num : mlir_dimension

syntax "[mlir_dimension|" mlir_dimension "]" : term
macro_rules
| `([mlir_dimension| ?]) => `(Dimension.Unknown)
macro_rules
| `([mlir_dimension| $x:num ]) =>
    `(Dimension.Known $x)

def dim0 := [mlir_dimension| 30]
#print dim0

def dim1 := [mlir_dimension| ?]
#print dim1


-- | 1 x 2 x 3 x ..
declare_syntax_cat mlir_dimension_list
syntax (mlir_dimension "×")* mlir_type : mlir_dimension_list

def string_to_dimension (s: String): MacroM Dimension := do
  if s == "?"
  then return Dimension.Unknown
  else if s.isNat
  then return Dimension.Known s.toNat!
  else Macro.throwError ("unknown dimension: | " ++ s ++ "  |")


-- (MLIR.EDSL.«mlir_dimension_list_×_»
--  [
--    [(MLIR.EDSL.mlir_dimension_ (numLit "3")) "×"]
--    [(MLIR.EDSL.mlir_dimension_ (numLit "3")) "×"]]
 -- (MLIR.EDSL.mlir_type__ `i32))| )

-- | TODO: assert that the string we get is of the form x3x4x?x2...
-- that is, interleaved x and other stuff.
def parseTensorDimensionList (k: Syntax) : MacroM (TSyntax `term × TSyntax `term) := do

  let ty <- `([mlir_type|  $(⟨k.getArgs.back⟩)])
  let dimensions := (k.getArg 0)
  let dimensions <- dimensions.getArgs.toList.mapM (fun x =>
    `([mlir_dimension| $(⟨x.getArg 0⟩)]))
  let dimensions <- quoteMList dimensions (<- `(MLIR.AST.Dimension))
  -- Macro.throwError $ ("unknown dimension list:\n|" ++ (toString k.getArgs) ++ "|" ++ "\nDIMS: " ++ (toString dimensions) ++ " |\nTYPE: " ++ (toString ty)++ "")
  return (dimensions, ty)


  --       let xstr := dims.getId.toString
  --       let xparts := (xstr.splitOn "x").tail!
  --       let ty := xparts.getLast!
  --       let xparts := xparts.dropLast
  --       let xparts := [] ++ xparts -- TODO: add k into this list.
  --       -- Macro.throwError $ ("unknown dimension list: |" ++ (toString xparts) ++ "| )")

  --       let tyIdent := Lean.mkIdent ty
  --       -- let tyStx <- `([mlir_type|  $(quote tyIdent)])
  --       let tyStx <-  `([mlir_type|  i32])
  --       let dims <- xparts.mapM string_to_dimension
  --       let dimsStx <- quoteMList ([k] ++ (<- dims.mapM quoteMDimension))
  --       return (dimsStx, tyStx)
  -- -- | err => Macro.throwError $  ("unknown dimension list: |" ++ err.reprint.getD "???" ++ "| )")

-- === VECTOR TYPE ===
-- TODO: where is vector type syntax defined?
-- | TODO: fix bug that does not allow a trailing times.

-- static-dim-list ::= decimal-literal (`x` decimal-literal)*
-- | Encoding lookahead with notFollowedBy
declare_syntax_cat static_dim_list
syntax sepBy(numLit, "×", "×" notFollowedBy(mlir_type <|> "[")) : static_dim_list


syntax "[static_dim_list|" static_dim_list "]" : term
macro_rules
| `([static_dim_list| $[ $ns:num ]×* ]) => do
      quoteMList (ns.toList.map (⟨·.raw⟩)) (<- `(Nat))

-- vector-dim-list := (static-dim-list `x`)? (`[` static-dim-list `]` `x`)?
declare_syntax_cat vector_dim_list
syntax (static_dim_list "×" ("[" static_dim_list "]" "×")? )? : vector_dim_list
-- vector-element-type ::= float-type | integer-type | index-type
-- vector-type ::= `vector` `<` vector-dim-list vector-element-type `>`
syntax "vector" "<" vector_dim_list mlir_type ">"  : mlir_type

set_option hygiene false in -- allow i to expand
macro_rules
| `([mlir_type| vector < $[$fixed?:static_dim_list × $[ [ $scaled?:static_dim_list ] × ]? ]? $t:mlir_type  >]) => do
      let fixedDims <- match fixed? with
        | some s =>  `([static_dim_list| $s])
        | none => `((@List.nil Nat))
      let scaledDims <- match scaled? with
        | some (some s) => `([static_dim_list| $s])
        | _ => `((@List.nil Nat))
      `(builtin.vector $fixedDims $scaledDims [mlir_type| $t])

def staticDimList0 : List Nat := [static_dim_list| 1]
#reduce staticDimList0

def staticDimList1 : List Nat := [static_dim_list| 1 × 2]
#reduce staticDimList1



def vectorTy0 := [mlir_type| vector<i32>]
#print vectorTy0

def vectorTy1 := [mlir_type| vector<2 × i32>]
#print vectorTy1

def vectorTy2 := [mlir_type| vector<2 × 3 × [ 4 ] × i32>]
#print vectorTy2


-- | TODO: is this actually necessary?
-- syntax  "<" mlir_dimension_list  ">"  : mlir_type
-- macro_rules
-- | `([mlir_type|  < $dims:mlir_dimension_list  >]) => do
--     let (dims, ty) <- parseTensorDimensionList dims
--     `(MLIRType.vector $dims $ty)


-- | TODO: fix bug that does not allow a trailing times.

syntax "tensor" "<"  mlir_dimension_list  ">"  : mlir_type
macro_rules
| `([mlir_type| tensor < $dims:mlir_dimension_list  >]) => do
    let (dims, ty) <- parseTensorDimensionList dims
    `(builtin.tensor $dims $ty)

-- | TODO: this is a huge hack.
-- | TODO: I should be able to use the lower level parser to parse this cleanly?
syntax "tensor" "<"  "*" "×" mlir_type ">"  : mlir_type
syntax "tensor" "<*" "×" mlir_type ">"  : mlir_type
syntax "tensor" "<*×" mlir_type ">"  : mlir_type

macro_rules
| `([mlir_type| tensor < *× $ty:mlir_type >]) => do
    `(builtin.tensor_unranked [mlir_type| $ty])

macro_rules
| `([mlir_type| tensor < * × $ty:mlir_type >]) => do
    `(builtin.tensor_unranked [mlir_type| $ty])

macro_rules
| `([mlir_type| tensor <* × $ty:mlir_type >]) => do
    `(builtin.tensor_unranked [mlir_type| $ty])

macro_rules
| `([mlir_type| tensor <*×$ty:mlir_type >]) => do
    `(builtin.tensor_unranked [mlir_type| $ty])

-- Automatically inferred as MLIRType builtin
def tensorTy0 := [mlir_type| tensor<3×3×i32>]
#print tensorTy0

def tensorTy1 := [mlir_type| tensor< * × i32>]
#print tensorTy1

def tensorTy2 := [mlir_type| tensor< * × f32>]
#print tensorTy2

def tensorTy3 := [mlir_type| tensor<*× f32>]
#print tensorTy3

def tensorTy4 := [mlir_type| tensor<* × f32>]
#print tensorTy4

-- Basic coercion builtin → builtin + empty
example : MLIRType (builtin + Dialect.empty) := [mlir_type| tensor<* × f32>]



-- EDSL MLIR USER ATTRIBUTES
-- =========================


-- EDSL MLIR BASIC BLOCK OPERANDS
-- ==============================

declare_syntax_cat mlir_bb_operand
syntax mlir_op_operand ":" mlir_type : mlir_bb_operand

syntax "[mlir_bb_operand|" mlir_bb_operand "]" : term

macro_rules
| `([mlir_bb_operand| $name:mlir_op_operand : $ty:mlir_type ]) =>
     `( ([mlir_op_operand| $name], [mlir_type|$ty]) )



-- EDSL MLIR BASIC BLOCKS
-- ======================



syntax "^" ident ":" mlir_ops : mlir_bb
syntax "^" ident "(" sepBy(mlir_bb_operand, ",") ")" ":" mlir_ops : mlir_bb

syntax (mlir_op)* : mlir_ops

syntax "[mlir_op|" mlir_op "]" : term
syntax "[mlir_ops|" mlir_ops "]" : term

macro_rules
| `([mlir_ops| $[ $ops ]*  ]) => do
      let initList: TSyntax `term <- `(@List.nil (MLIR.AST.Op _))
      let l ← ops.foldrM (init := initList)
        fun x (xs: TSyntax `term) => `([mlir_op|$x] :: $xs)
      return l

macro_rules
  | `([mlir_ops| $$($q)]) => `(coe $q)



syntax "[mlir_bb|" mlir_bb "]": term


macro_rules
| `([mlir_bb| ^ $name:ident ( $operands,* ) : $ops ]) => do
   let initList <- `(@List.nil (MLIR.AST.SSAVal × MLIR.AST.MLIRType _))
   let argsList <- operands.getElems.foldrM (init := initList) fun x xs => `([mlir_bb_operand| $x] :: $xs)
   let opsList <- `([mlir_ops| $ops])
   `(BasicBlock.mk $(Lean.quote (name.getId.toString)) $argsList $opsList)
| `([mlir_bb| ^ $name:ident : $ops ]) => do
   let opsList <- `([mlir_ops| $ops])
   `(BasicBlock.mk $(Lean.quote (name.getId.toString)) [] $opsList)


-- ENTRY BB
-- ========


syntax mlir_bb : mlir_entry_bb
syntax mlir_ops : mlir_entry_bb
syntax "[mlir_entry_bb|" mlir_entry_bb "]" : term


macro_rules
| `([mlir_entry_bb| $ops:mlir_ops ]) => do
   let opsList <- `([mlir_ops| $ops])
   `(BasicBlock.mk "entry" [] $opsList)

macro_rules
| `([mlir_entry_bb| $bb:mlir_bb ]) => `([mlir_bb| $bb])

-- EDSL MLIR REGIONS
-- =================

syntax "{" (ws mlir_entry_bb ws)? (ws mlir_bb ws)* "}": mlir_region
syntax "[mlir_region|" mlir_region "]" : term

-- | map a macro on a list

macro_rules
| `([mlir_region| { $[ $entrybb ]? $[ $bbs ]* } ]) => do
   let bbsList ← bbs.foldrM (fun x xs => `([mlir_bb|$x] :: $xs)) (← `([]))
   match entrybb with
   | some entry => `(Region.mk ([mlir_entry_bb| $entry] :: $bbsList))
   | none => `(Region.mk $bbsList)

macro_rules
| `([mlir_region| $$($q) ]) => return q


-- TENSOR LITERAL
-- ==============

declare_syntax_cat mlir_tensor
syntax numLit : mlir_tensor
syntax scientificLit : mlir_tensor

syntax "[" sepBy(mlir_tensor, ",") "]" : mlir_tensor

syntax ident: mlir_tensor
syntax "[mlir_tensor|" mlir_tensor "]" : term

macro_rules
| `([mlir_tensor| $x:num ]) => `(TensorElem.int $x)

macro_rules
| `([mlir_tensor| $x:scientific ]) => `(TensorElem.float $(⟨x⟩))

macro_rules
| `([mlir_tensor| $x:ident ]) => do
      let xstr := x.getId.toString
      if xstr == "true"
      then `(TensorElem.bool true)
      else if xstr == "false"
      then `(TensorElem.bool false)
      else Macro.throwError ("unknown tensor value: |" ++ xstr ++ "|")

macro_rules
| `([mlir_tensor| [ $xs,* ] ]) => do
    let initList <- `([])
    let vals <- xs.getElems.foldlM (init := initList) fun xs x => `($xs ++ [[mlir_tensor| $x]])
    `(TensorElem.nested $vals)


def tensorValNum := [mlir_tensor| 42]
def tensorValFloat := [mlir_tensor| 0.000000]
def tensorValTrue := [mlir_tensor| true]
def tensorValFalse := [mlir_tensor| false]

-- MLIR ATTRIBUTE VALUE
-- ====================

-- | TODO: consider renaming this to mlir_attr
declare_syntax_cat mlir_attr_val
declare_syntax_cat mlir_attr_val_symbol
syntax "@" ident : mlir_attr_val_symbol
syntax "@" str : mlir_attr_val_symbol
syntax "#" ident : mlir_attr_val -- alias
syntax "#" strLit : mlir_attr_val -- aliass

syntax "#" ident "<" strLit ">" : mlir_attr_val -- opaqueAttr
syntax "#opaque<" ident "," strLit ">" ":" mlir_type : mlir_attr_val -- opaqueElementsAttr
syntax mlir_attr_val_symbol "::" mlir_attr_val_symbol : mlir_attr_val_symbol


declare_syntax_cat balanced_parens  -- syntax "#" ident "." ident "<" balanced_parens ">" : mlir_attr_val -- generic user attributes


syntax str: mlir_attr_val
syntax mlir_type : mlir_attr_val
syntax affine_map : mlir_attr_val
syntax mlir_attr_val_symbol : mlir_attr_val
syntax "-"? num (":" mlir_type)? : mlir_attr_val
syntax scientificLit (":" mlir_type)? : mlir_attr_val
syntax ident: mlir_attr_val

syntax "[" sepBy(mlir_attr_val, ",") "]" : mlir_attr_val
syntax "[mlir_attr_val|" mlir_attr_val "]" : term
syntax "[mlir_attr_val_symbol|" mlir_attr_val_symbol "]" : term

macro_rules
| `([mlir_attr_val| $$($x) ]) => `($x)

macro_rules
| `([mlir_attr_val|  $x:num ]) => `(AttrValue.int $x (MLIRType.int .Signless 64))
| `([mlir_attr_val| $x:num : $t:mlir_type]) => `(AttrValue.int $x [mlir_type| $t])
| `([mlir_attr_val| - $x:num ]) => `(AttrValue.int (- $x) (MLIRType.int .Signed 64))
| `([mlir_attr_val| - $x:num : $t:mlir_type]) => `(AttrValue.int (- $x) [mlir_type| $t])

macro_rules
| `([mlir_attr_val| true ]) => `(AttrValue.bool True)
| `([mlir_attr_val| false ]) => `(AttrValue.bool False)


macro_rules
| `([mlir_attr_val| # $dialect:ident < $opaqueData:str > ]) => do
  let dialect := Lean.quote dialect.getId.toString
  `(AttrValue.opaque_ $dialect $opaqueData)

macro_rules
| `([mlir_attr_val| #opaque< $dialect:ident, $opaqueData:str> : $t:mlir_type ]) => do
  let dialect := Lean.quote dialect.getId.toString
  `(AttrValue.opaqueElementsAttr $dialect $opaqueData $(⟨t⟩))

macro_rules
  | `([mlir_attr_val| $s:str]) => `(AttrValue.str $s)
  | `([mlir_attr_val| [ $xs,* ] ]) => do
        let initList <- `([])
        let vals <- xs.getElems.foldlM (init := initList) fun xs x => `($xs ++ [[mlir_attr_val| $x]])
        `(AttrValue.list $vals)
  | `([mlir_attr_val| $i:ident]) => `(AttrValue.type [mlir_type| $i:ident])
  | `([mlir_attr_val| $ty:mlir_type]) => `(AttrValue.type [mlir_type| $ty])


syntax "dense<" mlir_tensor  ">" ":" mlir_type : mlir_attr_val
macro_rules
| `([mlir_attr_val| dense< $v:mlir_tensor > : $t:mlir_type]) =>
    `(builtin.denseWithType [mlir_tensor| $v] [mlir_type| $t])

syntax "dense<" ">" ":" mlir_type: mlir_attr_val
macro_rules
| `([mlir_attr_val| dense< > : $t:mlir_type]) =>
    `(builtin.denseWithType TensorElem.empty [mlir_type| $t])

macro_rules
  | `([mlir_attr_val| $a:affine_map]) =>
      `(AttrValue.affine [affine_map| $a])

macro_rules
| `([mlir_attr_val_symbol| @ $x:str ]) =>
      `(AttrValue.symbol $x)

macro_rules
| `([mlir_attr_val_symbol| @ $x:ident ]) =>
      `(AttrValue.symbol $(Lean.quote x.getId.toString))

macro_rules
| `([mlir_attr_val_symbol| $x:mlir_attr_val_symbol :: $y:mlir_attr_val_symbol ]) =>
      `(AttrValue.nestedsymbol [mlir_attr_val_symbol| $x] [mlir_attr_val_symbol| $y])


macro_rules
| `([mlir_attr_val| $x:mlir_attr_val_symbol ]) => `([mlir_attr_val_symbol| $x])


def attrVal0Str : AttrVal := [mlir_attr_val| "foo"]
#reduce attrVal0Str

-- Uses dialect coercion: empty → builtin
example : AttrValue builtin := [mlir_attr_val| "foo"]
-- Uses dialect coercion: empty → empty + builtin
example : AttrValue (Dialect.empty + builtin) := [mlir_attr_val| "foo"]
-- Uses dialect coercion after building an AttrValue Dialect.empty
#check (AttrValue.type [mlir_type| (i32, i64) -> i32]: AttrValue builtin)
-- Uses dialect coercion in MLIRType inside the tuple, then propagates
example : AttrValue builtin := AttrValue.type [mlir_type| (i32, i64) -> i32]

def attrVal1Ty : AttrValue (Dialect.empty + builtin) := [mlir_attr_val| (i32, i64) -> i32]
#reduce attrVal1Ty

def attrVal1bTy : AttrValue builtin := [mlir_attr_val| i32]
#reduce attrVal1bTy

def attrVal2List : AttrValue builtin := [mlir_attr_val| ["foo", "foo"] ]
#reduce attrVal2List

def attrVal3AffineMap : AttrValue builtin := [mlir_attr_val| affine_map<(x, y) -> (y)>]
#reduce attrVal3AffineMap

def attrVal4Symbol : AttrValue builtin := [mlir_attr_val| @"foo" ]
#reduce attrVal4Symbol

def attrVal5int: AttrValue builtin := [mlir_attr_val| 42 ]
#reduce attrVal5int

def attrVal5bint: AttrVal := [mlir_attr_val| -42 ]
#reduce attrVal5bint


def attrVal6Symbol : AttrVal := [mlir_attr_val| @func_foo ]
#reduce attrVal6Symbol

def attrVal7NestedSymbol : AttrVal := [mlir_attr_val| @func_foo::@"func_bar" ]
#reduce attrVal7NestedSymbol


macro_rules
  | `([mlir_attr_val| # $a:str]) =>
      `(AttrValue.alias $a)

def attrVal8Alias : AttrVal := [mlir_attr_val| #"A" ]
#reduce attrVal8Alias


macro_rules
  | `([mlir_attr_val| # $a:ident]) =>
      `(AttrValue.alias $(Lean.quote a.getId.toString))

def attrVal9Alias : AttrVal := [mlir_attr_val| #a ]
#reduce attrVal9Alias

macro_rules
| `([mlir_attr_val|  $x:scientific ]) => `(AttrValue.float $(⟨x⟩) (MLIRType.float 64))
| `([mlir_attr_val| $x:scientific : $t:mlir_type]) => `(AttrValue.float $(⟨x⟩) [mlir_type| $t])


-- def attrVal10Float : AttrVal := [mlir_attr_val| 0.000000e+00  ]
def attrVal10Float :  AttrVal := [mlir_attr_val| 0.0023 ]
#print attrVal10Float

def attrVal11Escape :  AttrVal := [mlir_attr_val| $(attrVal10Float) ]
#print attrVal11Escape

-- The dense<> attribute requires the builtin dialect for the tensor type
def attrVal12DenseEmpty: AttrValue builtin := [mlir_attr_val| dense<> : tensor<0 × i64>]
#print attrVal12DenseEmpty


-- MLIR ATTRIBUTE
-- ===============


declare_syntax_cat mlir_attr_entry

syntax ident "=" mlir_attr_val : mlir_attr_entry
syntax strLit "=" mlir_attr_val : mlir_attr_entry
syntax ident : mlir_attr_entry

syntax "[mlir_attr_entry|" mlir_attr_entry "]" : term

-- | TODO: don't actually write an elaborator for the `ident` case. This forces
-- us to declare predefined identifiers in a controlled fashion.
macro_rules
  | `([mlir_attr_entry| $name:ident  = $v:mlir_attr_val]) =>
     `(AttrEntry.mk $(Lean.quote (name.getId.toString))  [mlir_attr_val| $v])
  | `([mlir_attr_entry| $name:str  = $v:mlir_attr_val]) =>
     `(AttrEntry.mk $name [mlir_attr_val| $v])

macro_rules
  | `([mlir_attr_entry| $name:ident]) =>
     `(AttrEntry.mk $(Lean.quote (name.getId.toString))  AttrValue.unit)



def attr0Str : AttrEntry builtin := [mlir_attr_entry| sym_name = "add"]
#print attr0Str

def attr1Type : AttrEntry builtin := [mlir_attr_entry| type = (i32, i32) -> i32]
#print attr1Type

def attr2Escape : AttrEntry builtin :=
   let x : AttrVal := [mlir_attr_val| 42]
   [mlir_attr_entry| sym_name = $(x)]
#print attr0Str


def attr3Unit : AttrEntry builtin :=
   [mlir_attr_entry| sym_name]
#print attr3Unit

def attr4Negative : AttrEntry builtin :=
   [mlir_attr_entry| value = -1: i32]
#print attr4Negative


declare_syntax_cat mlir_attr_dict
syntax "{" sepBy(mlir_attr_entry, ",") "}" : mlir_attr_dict
syntax "[mlir_attr_dict|" mlir_attr_dict "]" : term

macro_rules
| `([mlir_attr_dict| {  $attrEntries,* } ]) => do
        let attrsList <- attrEntries.getElems.toList.mapM (fun x => `([mlir_attr_entry| $x]))
        let attrsList <- quoteMList attrsList (<- `(MLIR.AST.AttrEntry _))
        `(AttrDict.mk $attrsList)

def attrDict0 : AttrDict builtin := [mlir_attr_dict| {}]
def attrDict1 : AttrDict builtin := [mlir_attr_dict| {foo = "bar" }]
def attrDict2 : AttrDict builtin := [mlir_attr_dict| {foo = "bar", baz = "quux" }]

-- dict attribute val
syntax mlir_attr_dict : mlir_attr_val

macro_rules
| `([mlir_attr_val| $v:mlir_attr_dict]) => `(AttrValue.dict [mlir_attr_dict| $v])

def nestedAttrDict0 : AttrDict Dialect.empty := [mlir_attr_dict| {foo = {bar = "baz"} }]
#print nestedAttrDict0

-- MLIR OPS WITH REGIONS AND ATTRIBUTES AND BASIC BLOCK ARGS
-- =========================================================

-- TODO: Does not support %var:index = ...
syntax
  (mlir_op_operand "=")?
  strLit "(" mlir_op_operand,* ")"
         ("[" mlir_op_successor_arg,* "]")?
         ("(" mlir_region,* ")")?
         (mlir_attr_dict)?
  ":" "(" mlir_type,* ")" "->" mlir_type : mlir_op

macro_rules
  | `([mlir_op| $$($x) ]) => return x

macro_rules
  | `([mlir_op|
        $[ $resName = ]?
        $name:str
        ( $operandsNames,* )
        $[ [ $succ,* ] ]?
        $[ ( $rgns,* ) ]?
        $[ $attrDict ]?
        : ( $operandsTypes,* ) -> $resType ]) => do

        -- TODO: Needs a consistency check that `resName=none ↔ resType=.unit`
        let res ← match resName with
        | none => `(@List.nil (MLIR.AST.TypedSSAVal _))
        | some name => `([([mlir_op_operand| $name], [mlir_type| $resType])])

        -- TODO: Needs a consistency check that `operandsNames.length = operandsTypes.length`
        let operands: List (MacroM <| TSyntax `term) :=
          List.zipWith (fun x y => `(([mlir_op_operand| $x], [mlir_type| $y])))
          operandsNames.getElems.toList operandsTypes.getElems.toList
        let operands ← quoteMList (← operands.mapM id) (← `(MLIR.AST.TypedSSAVal _))

        let succList <- match succ with
                | none => `(@List.nil MLIR.AST.BBName)
                | some xs => do
                  let xs <- xs.getElems.mapM (fun x => `([mlir_op_successor_arg| $x]))
                  quoteMList xs.toList (<- `(MLIR.AST.BBName))
        let attrDict <- match attrDict with
                          | none => `(AttrDict.mk [])
                          | some dict => `([mlir_attr_dict| $dict])
        let rgnsList <- match rgns with
                  | none => `(@List.nil (MLIR.AST.Region _))
                  | some rgns => do
                    let rngs <- rgns.getElems.mapM (fun x => `([mlir_region| $x]))
                    quoteMList rngs.toList (<- `(MLIR.AST.Region _))

        `(Op.mk $name -- name
                $res
                $operands -- operands
                $succList -- bbs
                $rgnsList -- regions
                $attrDict) -- attrs



def op1 : Op Dialect.empty :=
  [mlir_op| "foo"(%x, %y) : (i32, i32) -> i32]
#print op1
def op2: Op builtin :=
  [mlir_op| %z = "foo"(%x, %y) : (i32, i32) -> i32]
#print op2

def bbop1 : SSAVal × MLIRTy := [mlir_bb_operand| %x : i32 ]
#print bbop1

def bb1NoArgs : BasicBlock builtin :=
  [mlir_bb|
     ^entry:
     "foo"(%x, %y) : (i32, i32) -> i32
      %z = "bar"(%x) : (i32) -> (i32)
      "std.return"(%x0) : (i42) -> ()
  ]
#print bb1NoArgs

def bb2SingleArg : BasicBlock builtin :=
  [mlir_bb|
     ^entry(%argp : i32):
     "foo"(%x, %y) : (i32, i32) -> i32
      %z = "bar"(%x) : (i32) -> (i32)
      "std.return"(%x0) : (i42) -> ()
  ]
#print bb2SingleArg


def bb3MultipleArgs : BasicBlock builtin :=
  [mlir_bb|
     ^entry(%argp : i32, %argq : i64):
     "foo"(%x, %y) : (i32, i32) -> i32
      %z = "bar"(%x) : (i32) -> (i32)
      "std.return"(%x0) : (i42) -> ()
  ]
#reduce bb3MultipleArgs


def rgn0 : Region Dialect.empty := ([mlir_region|  { }])
#print rgn0

def rgn1 : Region builtin :=
  [mlir_region|  {
    ^entry:
      "std.return"(%x0) : (i42) -> ()
  }]
#print rgn1

def rgn2 : Region builtin :=
  [mlir_region|  {
    ^entry:
      "std.return"(%x0) : (i42) -> ()

    ^loop:
      "std.return"(%x1) : (i42) -> ()
  }]
#print rgn2

-- | test what happens if we try to use an entry block with no explicit bb name
def rgn3 : Region builtin :=
  [mlir_region|  {
      "std.return"(%x0) : (i42) -> ()
  }]
#print rgn1


-- | test simple ops [no regions]
def opcall1 : Op Dialect.empty := [mlir_op| "foo" (%x, %y) : (i32, i32) -> i32 ]
#print opcall1


def opattr0 : Op Dialect.empty := [mlir_op|
 "foo"() { sym_name = "add", type = (i32, i32) -> i32 } : () -> ()
]
#print opattr0


def oprgn0 : Op Dialect.empty := [mlir_op|
 "func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):
    %x = "std.addi"(%arg0, %arg1) : (i32, i32) -> i32
    "std.return"(%x) : (i32) -> ()
  }) : () -> ()
]
#print oprgn0


-- | note that this is a "full stack" example!
def opRgnAttr0 : Op builtin := [mlir_op|
 "module"() (
 {
  ^entry:
   "func"() (
    {
     ^bb0(%arg0:i32, %arg1:i32):
      %zero = "std.addi"(%arg0 , %arg1) : (i32, i16) -> i64
      "std.return"(%zero) : (i32) -> ()
    }){sym_name = "add", type = (i32, i32) -> i32} : () -> ()
   "module_terminator"() : () -> ()
 }) : () -> ()
]
#print opRgnAttr0



-- | test simple ops [no regions, but with bb args]
def opcall2 : Op builtin := [mlir_op| "foo" (%x, %y) [^bb1, ^bb2] : (i32, i32) -> i32]
#print opcall2


-- | Builtins
-- =========

-- TODO: Move to `func` dialect
syntax
  "func" mlir_attr_val_symbol "(" mlir_bb_operand,* ")" ( "->" mlir_type )? "{"
    mlir_ops
  "}" : mlir_op

macro_rules
| `([mlir_op| func $name:mlir_attr_val_symbol ( $args,* ) $[ -> $ret:mlir_type ]? { $ops } ]) => do
     -- Make the arguments for the entry block
     let bbargs ← args.getElems.mapM (fun x => `([mlir_bb_operand| $x]))
     let bbargs ← quoteMList bbargs.toList (← `(MLIR.AST.SSAVal × MLIR.AST.MLIRType _))
     -- Make the entry block (the only block)
     let bb ← `(BasicBlock.mk "entry" $bbargs [mlir_ops| $ops])
     -- Make the region
     let rgn ← `(Region.mk [$bb])

     -- Make the function signature
     let argTypes ← args.getElems.mapM (fun x => `(Prod.snd [mlir_bb_operand| $x]))
     let argTypes ← quoteMList argTypes.toList (← `(MLIR.AST.MLIRType _))
     let retType ← match ret with
       | none => `(MLIRType.tuple [])
       | some τ => `([mlir_type| $τ])
     let signature ← `(MLIRType.fn (MLIRType.tuple $argTypes) $retType)

     -- Make the entire operation
     let attrs ← `(AttrDict.mk [
        AttrEntry.mk "function_type" (AttrValue.type $signature),
        AttrEntry.mk "sym_name" [mlir_attr_val_symbol| $name]
      ])
     `(Op.mk "func" [] [] [] [$rgn] $attrs)


def func1 : Op Dialect.empty := [mlir_op| func @"main"() {
  %x = "asm.int" () { "val" = 32 } : () -> (i32)
}]
#print func1

syntax "module" "{" mlir_op* "}" : mlir_op

macro_rules
| `([mlir_op| module { $ops* } ]) => do
     let initList <- `([Op.empty "module_terminator"])
     let ops <- ops.foldrM (init := initList) fun x xs => `([mlir_op| $x] :: $xs)
     let rgn <- `(Region.fromOps $ops)
     `(Op.mk "module" [] [] [] [$rgn] AttrDict.empty)

def mod1 : Op builtin := [mlir_op| module { }]
#print mod1

def mod2 : Op builtin := [mlir_op| module { "dummy.dummy"(): () -> () }]
#print mod2

--- MEMREF+TENSOR
--- =============
-- dimension-list ::= dimension-list-ranked | (`*` `x`)
-- dimension-list-ranked ::= (dimension `x`)*
-- dimension ::= `?` | decimal-literal
-- tensor-type ::= `tensor` `<` dimension-list tensor-memref-element-type `>`
-- tensor-memref-element-type ::= vector-element-type | vector-type | complex-type


-- https://mlir.llvm.org/docs/Dialects/Builtin/#memreftype
-- memref-type ::= ranked-memref-type | unranked-memref-type
-- ranked-memref-type ::= `memref` `<` dimension-list-ranked type
--                        (`,` layout-specification)? (`,` memory-space)? `>`
-- unranked-memref-type ::= `memref` `<*x` type (`,` memory-space)? `>`
-- stride-list ::= `[` (dimension (`,` dimension)*)? `]`
-- strided-layout ::= `offset:` dimension `,` `strides: ` stride-list
-- layout-specification ::= semi-affine-map | strided-layout | attribute-value
-- memory-space ::= attribute-value
-- | good example for paper.
declare_syntax_cat memref_type_stride_list
syntax "[" (mlir_dimension,*) "]" : memref_type_stride_list

declare_syntax_cat memref_type_strided_layout
syntax "offset:" mlir_dimension "," "strides:" memref_type_stride_list : memref_type_strided_layout

declare_syntax_cat memref_type_layout_specification
syntax memref_type_strided_layout : memref_type_layout_specification
syntax mlir_attr_val : memref_type_layout_specification
syntax "[memref_type_layout_specification|" memref_type_layout_specification "]" : term


macro_rules
| `([memref_type_layout_specification| $v:mlir_attr_val]) =>
    `(MemrefLayoutSpec.attr [mlir_attr_val| $v])
| `([memref_type_layout_specification| offset: $o:mlir_dimension , strides: [ $[ $ds:mlir_dimension ],* ]]) =>  do
    let ds <- ds.mapM (fun d => `([mlir_dimension| $d]))
    let ds <- quoteMList ds.toList (<- `(MLIR.AST.Dimension))
    `(MemrefLayoutSpec.stride [mlir_dimension| $o] $ds)

-- | ranked memref
syntax "memref" "<"  mlir_dimension_list ("," memref_type_layout_specification)? ("," mlir_attr_val)?  ">"  : mlir_type
macro_rules
| `([mlir_type| memref  < $dims:mlir_dimension_list $[, $layout ]? $[, $memspace]? >]) => do
    let (dims, ty) <- parseTensorDimensionList dims
    let memspace <- match memspace with
                    | some s => `(some [mlir_attr_val| $s])
                    | none => `(none)

    let layout <- match layout with
                  | some stx => `(some [memref_type_layout_specification| $stx])
                  | none => `(none)
    `(builtin.memref $dims $ty $layout $memspace)

def memrefTy0 := [mlir_type| memref<3×3×i32>]
#print memrefTy0

def memrefTy1 := [mlir_type| memref<i32>]
#print memrefTy1

def memrefTy2 := [mlir_type| memref<2 × 4 × i8, #map1>]
#print memrefTy2

def memrefTy3 := [mlir_type| memref<2 × 4 × i8, #map1, 1>]
#print memrefTy3


-- | unranked memref
-- unranked-memref-type ::= `memref` `<*x` type (`,` memory-space)? `>`
-- | TODO: Do I need two different parsers for these cases?
syntax "memref" "<"  "*" "×" mlir_type ("," mlir_attr_val)?  ">"  : mlir_type
syntax "memref" "<*" "×" mlir_type ("," mlir_attr_val)?  ">"  : mlir_type
macro_rules
| `([mlir_type| memref < * × $ty  $[, $memspace]? >]) => do
    let memspace <- match memspace with
                    | some s => `(some [mlir_attr_val| $s])
                    | none => `(none)
    `(builtin.memref_unranked [mlir_type| $ty] $memspace)

macro_rules
| `([mlir_type| memref <* × $ty  $[, $memspace]? >]) => do
    let memspace <- match memspace with
                    | some s => `(some [mlir_attr_val| $s])
                    | none => `(none)
    `(builtin.memref_unranked [mlir_type| $ty] $memspace)

def memrefTy4 := [mlir_type| memref<* × f32>]
#print memrefTy4

end MLIR.EDSL

