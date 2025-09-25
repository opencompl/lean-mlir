/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Lean
import Lean.Elab
import Lean.Meta
import Lean.Parser
import Lean.PrettyPrinter
import Lean.PrettyPrinter.Formatter
import Lean.Parser
import Lean.Parser.Extra
import SSA.Core.MLIRSyntax.AST

/-!
# MLIR Syntax Parsing
This file uses Lean's parser extensions to parse generic MLIR syntax into datastructures defined
in `MLIRSyntax.AST`.

Key definitions are the `[mlir_op| ...]` and `[mlir_region| ...]` term elaborators

-/

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
      else s.mkError $ "| found Opened `" ++ toString b ++ "` expected to close at `" ++
      toString c ++ "`"
    | _ => s.mkError $ "| found Closed `" ++ toString c ++ "`, but have no opened brackets on stack"


partial def balancedBracketsFnAux (startPos: String.Pos)
  (i: String.Pos)
  (input: String)
  (bs: List Bracket) (ctx: ParserContext) (s: ParserState): ParserState :=
  if input.atEnd i
  then s.mkError "found EOF"
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
  | _c => balancedBracketsFnAux startPos (input.next i) input bs ctx s

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

-- Code stolen from test/WebServer/lean
@[combinator_formatter MLIR.EDSL.balancedBrackets]
def MLIR.EDSL.balancedBrackets.formatter : Formatter := pure ()

@[combinator_parenthesizer MLIR.EDSL.balancedBrackets]
def MLIR.EDSL.balancedBracketsParenthesizer : Parenthesizer := pure ()


macro "[balanced_brackets|" xs:balancedBrackets "]" : term => do
  match xs.raw[0] with
  | .atom _ val => return (Lean.quote val: TSyntax `str)
  | _  => Macro.throwErrorAt xs "expected balanced bracts to have atom"

section Test

private def testBalancedBrackets : String := [balanced_brackets| < { xxasdasd } > ]
/--
info: private def MLIR.EDSL.testBalancedBrackets : String := "< { xxasdasd } >"
-/
#guard_msgs in #print testBalancedBrackets

end Test


-- | positive and negative numbers, hex, octal
declare_syntax_cat mlir_int
syntax numLit: mlir_int

def IntToString (i: Int): String := i.repr

instance : Quote Int := ⟨fun n => Syntax.mkNumLit <| n.repr⟩

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
declare_syntax_cat mlir_region
declare_syntax_cat mlir_op
declare_syntax_cat mlir_op_args
declare_syntax_cat mlir_op_successor_args
declare_syntax_cat mlir_op_type
declare_syntax_cat mlir_op_operand
declare_syntax_cat mlir_ops
declare_syntax_cat mlir_type



-- EDSL OPERANDS
-- ==============

syntax "%" numLit : mlir_op_operand

syntax "%" ident : mlir_op_operand

syntax "[mlir_op_operand|" mlir_op_operand "]" : term
macro_rules
  | `([mlir_op_operand| $$($q)]) => return q
  | `([mlir_op_operand| % $x:ident]) => `(SSAVal.name $(Lean.quote (x.getId.toString)))
  | `([mlir_op_operand| % $n:num]) => `(SSAVal.name (IntToString $n))

section Test

private def operand0 := [mlir_op_operand| %x]
/--
info: private def MLIR.EDSL.operand0 : SSAVal :=
SSAVal.name "x"
-/
#guard_msgs in #print operand0

private def operand1 := [mlir_op_operand| %x]
/--
info: private def MLIR.EDSL.operand1 : SSAVal :=
SSAVal.name "x"
-/
#guard_msgs in #print operand1

private def operand2 := [mlir_op_operand| %0]
/--
info: private def MLIR.EDSL.operand2 : SSAVal :=
SSAVal.name (IntToString 0)
-/
#guard_msgs in #print operand2

end Test


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

section Test

private def succ0 : BBName := ([mlir_op_successor_arg| ^bb])
/--
info: private def MLIR.EDSL.succ0 : BBName :=
BBName.mk "bb"
-/
#guard_msgs in #print succ0

end Test


-- EDSL MLIR TYPES
-- ===============


syntax "[mlir_type|" mlir_type "]" : term

syntax "!" str : mlir_type
syntax "!" ident : mlir_type
syntax ident: mlir_type
syntax "_" : mlir_type

macro_rules
  | `([mlir_type| $x:ident ]) => do
        let (.ident _ xstr _ _) := x.raw | Macro.throwUnsupported
        -- ^^ We use `rawVal` rather than `val`, so that we're not affected by hygiene
        if xstr == "index"
        then
          `(MLIRType.index)
        else if xstr.front == 'i' || xstr.front == 'f'
        then do
          let xstr' := (xstr.drop 1).toString
          match xstr'.toInt? with
          | some _ =>
            let lit := Lean.Syntax.mkNumLit xstr'
            if xstr.front == 'i'
            then `(MLIRType.int .Signless $lit)
            else `(MLIRType.float $lit)
          | none =>
              Macro.throwErrorAt x $ "cannot convert suffix of i/f to int: " ++ xstr.toString
        else Macro.throwErrorAt x $ "expected i<int> or f<int>, found: " ++ xstr.toString
  | `([mlir_type| ! $x:str ]) => `(MLIRType.undefined $x)
  | `([mlir_type| ! $x:ident ]) => `(MLIRType.undefined $(Lean.quote x.getId.toString))
  -- Hardcoded meta-variable
  | `([mlir_type| _ ]) => `(MLIRType.int (φ := 1) Signedness.Signless (Width.mvar ⟨0, by simp⟩))

section Test

private def tyIndex : MLIRTy := [mlir_type| index]
/--
info: MLIR.AST.MLIRType.index
-/
#guard_msgs in #eval tyIndex

private def tyUser : MLIRTy := [mlir_type| !"lz.int"]
/--
info: MLIR.AST.MLIRType.undefined "lz.int"
-/
#guard_msgs in #eval tyUser

private def tyUserIdent : MLIRTy := [mlir_type| !shape.value]
/--
info: MLIR.AST.MLIRType.undefined "shape.value"
-/
#guard_msgs in #eval tyUserIdent

private def tyi32NoGap : MLIRTy := [mlir_type| i32]
/--
info: MLIR.AST.MLIRType.int (MLIR.AST.Signedness.Signless) (ConcreteOrMVar.concrete 32)
-/
#guard_msgs in #eval tyi32NoGap

private def tyf32NoGap : MLIRTy := [mlir_type| f32]
/--
info: MLIR.AST.MLIRType.float 32
-/
#guard_msgs in #eval tyf32NoGap

-- Uses dialect coercion empty → builtin
--example : MLIRType builtin := [mlir_type| i32]

-- Uses dialect coercion empty → empty + builtin
--example : MLIRType (Dialect.empty + builtin) := [mlir_type| i32]
-- More tricky: pushes coercion into the whole construction

end Test

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
| `([mlir_type| vector < $[$fixed?:static_dim_list ×
      $[ [ $scaled?:static_dim_list ] × ]? ]? $t:mlir_type  >]) => do
      let fixedDims <- match fixed? with
        | some s =>  `([static_dim_list| $s])
        | none => `((@List.nil Nat))
      let scaledDims <- match scaled? with
        | some (some s) => `([static_dim_list| $s])
        | _ => `((@List.nil Nat))
      `(builtin.vector $fixedDims $scaledDims [mlir_type| $t])

syntax "tensor1d" : mlir_type
macro_rules
| `([mlir_type| tensor1d ]) => do
    `(MLIRType.tensor1d)

syntax "tensor2d" : mlir_type
macro_rules
| `([mlir_type| tensor2d ]) => do
    `(MLIRType.tensor2d)

section Test

private def staticDimList0 : List Nat := [static_dim_list| 1]
/-- info: [1] -/
#guard_msgs in #reduce staticDimList0

private def staticDimList1 : List Nat := [static_dim_list| 1 × 2]
/-- info: [1, 2] -/
#guard_msgs in #reduce staticDimList1


--def vectorTy0 := [mlir_type| vector<i32>]
--#print vectorTy0
--
--def vectorTy1 := [mlir_type| vector<2 × i32>]
--#print vectorTy1
--
--def vectorTy2 := [mlir_type| vector<2 × 3 × [ 4 ] × i32>]
--#print vectorTy2

private def tensor1dTest : MLIRTy := [mlir_type| tensor1d]

private def tensor2dTest : MLIRTy := [mlir_type| tensor2d]

end Test



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

/--
Reference from the MLIR standard
https://mlir.llvm.org/docs/LangRef/#identifiers-and-keywords
// Identifiers
bare-id ::= (letter|[_]) (letter|digit|[_$.])*
bare-id-list ::= bare-id (`,` bare-id)*
value-id ::= `%` suffix-id
alias-name :: = bare-id
suffix-id ::= (digit+ | ((letter|id-punct) (letter|id-punct|digit)*))

symbol-ref-id ::= `@` (suffix-id | string-literal) (`::` symbol-ref-id)?
value-id-list ::= value-id (`,` value-id)*

// Uses of value, e.g. in an operand list to an operation.
value-use ::= value-id (`#` decimal-literal)?
value-use-list ::= value-use (`,` value-use)*
-/


syntax mlir_suffix_id := num <|> ident
syntax  "{" ("^" mlir_suffix_id ("(" sepBy(mlir_bb_operand, ",") ")")?
    ":")? mlir_ops "}" : mlir_region
syntax "[mlir_region|" mlir_region "]": term

/--
`getSuffixId` converts the syntax object of a `suffix id` to a string.
A `suffix id` is a notion from the MLIR standard defined as
```bnf
suffix-id ::= (digit+ | ((letter|id-punct) (letter|id-punct|digit)*))
```
See more at
https://mlir.llvm.org/docs/LangRef/#identifiers-and-keywords
If the suffix id is a number (the left choice), we convert that number to a string
If the suffix id is an identifier (the right choice), we convert that identifier to a string

`getSuffixId` is used in parsing the syntax of MLIR to a Lean AST
-/
def getSuffixId : TSyntax ``mlir_suffix_id → String
  | `(mlir_suffix_id| $x:ident) => x.getId.toString
  | `(mlir_suffix_id| $x:num) => toString (x.getNat)
  | _ => "" -- Should never happen, since `mlir_suffix_id` is a closed syntax definition

macro_rules
| `(mlir_region| { ^ $name:mlir_suffix_id ( $operands,* ) : $ops }) => do
   let initList <- `(@List.nil (MLIR.AST.SSAVal × MLIR.AST.MLIRType _))
   let argsList <- operands.getElems.foldrM (init := initList) fun x xs =>
       `([mlir_bb_operand| $x] :: $xs)
   let opsList <- `([mlir_ops| $ops])
   `(Region.mk $(Lean.quote (getSuffixId name)) $argsList $opsList)
| `(mlir_region| {  ^ $name:mlir_suffix_id : $ops } ) => do
   let opsList <- `([mlir_ops| $ops])
   `(Region.mk $(Lean.quote (getSuffixId name)) [] $opsList)
| `(mlir_region| { $ops:mlir_ops }) => do
   let opsList <- `([mlir_ops| $ops])
   `(Region.mk "entry" [] $opsList)

macro_rules
| `([mlir_region| $q:mlir_region ]) => `(mlir_region| $q)

macro_rules
| `([mlir_region| $$($q) ]) => return q

-- MLIR ATTRIBUTE VALUE
-- ====================

-- | TODO: consider renaming this to mlir_attr
declare_syntax_cat mlir_attr_val
declare_syntax_cat mlir_attr_val_symbol
syntax "@" ident : mlir_attr_val_symbol
syntax "@" str : mlir_attr_val_symbol
syntax "#" ident : mlir_attr_val -- alias
syntax "#" strLit : mlir_attr_val -- alias

declare_syntax_cat dialect_attribute_contents
syntax mlir_attr_val : dialect_attribute_contents
/--
Following https://mlir.llvm.org/docs/LangRef/, we define a `dialect-attribute`,
which is a particular case of an `mlir-attr-val` that is namespaced to a particular dialect

```bnf
dialect-namespace ::= bare-id

dialect-attribute ::= `#` (opaque-dialect-attribute | pretty-dialect-attribute)
opaque-dialect-attribute ::= dialect-namespace dialect-attribute-body
pretty-dialect-attribute ::= dialect-namespace `.` pretty-dialect-attribute-lead-ident
                                              dialect-attribute-body?
pretty-dialect-attribute-lead-ident ::= `[A-Za-z][A-Za-z0-9._]*`

dialect-attribute-body ::= `<` dialect-attribute-contents+ `>`
dialect-attribute-contents ::= dialect-attribute-body
                            | `(` dialect-attribute-contents+ `)`
                            | `[` dialect-attribute-contents+ `]`
                            | `{` dialect-attribute-contents+ `}`
                            | [^\[<({\]>)}\0]+
```
-/
syntax "(" dialect_attribute_contents + ")" : dialect_attribute_contents
syntax "[" dialect_attribute_contents + "]": dialect_attribute_contents
syntax "{" dialect_attribute_contents + "}": dialect_attribute_contents
syntax "#" ident "<" mlir_attr_val,*  ">" : mlir_attr_val
-- If I un-comment this line, it causes an error. I don't know why. Oh well.
-- syntax "#" ident "<" ident ">" : mlir_attr_val
-- syntax "#" ident "<" strLit ">" : mlir_attr_val
syntax "#opaque<" ident "," strLit ">" ":" mlir_type : mlir_attr_val -- opaqueElementsAttr
syntax mlir_attr_val_symbol "::" mlir_attr_val_symbol : mlir_attr_val_symbol


-- syntax "#" ident "." ident "<" balanced_parens ">" : mlir_attr_val -- generic user attributes
declare_syntax_cat balanced_parens

/-- `neg_num` is a possibly negated numeric literal -/
syntax neg_num := "-"? num

syntax str : mlir_attr_val
syntax mlir_type : mlir_attr_val
syntax affine_map : mlir_attr_val
syntax mlir_attr_val_symbol : mlir_attr_val
syntax neg_num (":" mlir_type)? : mlir_attr_val
syntax scientificLit (":" mlir_type)? : mlir_attr_val
syntax ident : mlir_attr_val

syntax "[" sepBy(mlir_attr_val, ",") "]" : mlir_attr_val
syntax "[mlir_attr_val|" mlir_attr_val "]" : term
syntax "[mlir_attr_val_symbol|" mlir_attr_val_symbol "]" : term

macro_rules
| `([mlir_attr_val| $$($x) ]) => `($x)

/-- Convert a possibly negated numeral into a term representing the same value -/
def negNumToTerm : TSyntax ``neg_num → MacroM Term
  | `(neg_num| $x:num) => `($x:num)
  | `(neg_num| -$x:num) => `(-$x:num)
  | _ => Macro.throwUnsupported

macro_rules
| `([mlir_attr_val| $x:neg_num ]) => `([mlir_attr_val| $x:neg_num : i64 ])
| `([mlir_attr_val| $x:neg_num : $t:mlir_type]) => do
    let x ← negNumToTerm x
    `(AttrValue.int $x [mlir_type| $t])

macro_rules
| `([mlir_attr_val| true ]) => `(AttrValue.bool True)
| `([mlir_attr_val| false ]) => `(AttrValue.bool False)


macro_rules
| `([mlir_attr_val| # $dialect:ident <$xs ,* > ]) => do
  let initList : TSyntax `term  <- `([])
  let vals : TSyntax `term <- xs.getElems.foldlM (init := initList) fun (xs : TSyntax `term) (x : TSyntax `mlir_attr_val) =>
    `([mlir_attr_val| #$dialect<$x>] :: $xs)
  `(AttrValue.list $vals)

macro_rules
| `([mlir_attr_val| # $dialect:ident < $opaqueData:str > ]) => do
  let dialect := Lean.quote dialect.getId.eraseMacroScopes.toString
  `(AttrValue.opaque_ $dialect $opaqueData)
| `([mlir_attr_val| # $dialect:ident < $opaqueData:ident > ]) => do
  let d := Lean.quote dialect.getId.eraseMacroScopes.toString
  let g : TSyntax `str := Lean.Syntax.mkStrLit (toString opaqueData.getId)
  `(AttrValue.opaque_ $d $g)
macro_rules
| `([mlir_attr_val| #opaque< $dialect:ident, $opaqueData:str> : $t:mlir_type ]) => do
  let dialect := Lean.quote dialect.getId.eraseMacroScopes.toString
  `(AttrValue.opaqueElementsAttr $dialect $opaqueData $(⟨t⟩))

macro_rules
  | `([mlir_attr_val| $s:str]) => `(AttrValue.str $s)
  | `([mlir_attr_val| [ $xs,* ] ]) => do
        let initList <- `([])
        let vals <- xs.getElems.foldlM (init := initList) fun xs x =>
            `($xs ++ [[mlir_attr_val| $x]])
        `(AttrValue.list $vals)
  | `([mlir_attr_val| $i:ident]) => `(AttrValue.type [mlir_type| $i:ident])
  | `([mlir_attr_val| $ty:mlir_type]) => `(AttrValue.type [mlir_type| $ty])

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
  | `([mlir_attr_val| $x:mlir_attr_val_symbol ]) => `([mlir_attr_val_symbol| $x])
  | `([mlir_attr_val| # $a:str]) => `(AttrValue.alias $a)
  | `([mlir_attr_val| $x:scientific ]) => `(AttrValue.float $(⟨x⟩) (MLIRType.float 64))
  | `([mlir_attr_val| $x:scientific : $t:mlir_type]) => `(AttrValue.float $(⟨x⟩) [mlir_type| $t])

macro_rules
  | `([mlir_attr_val| # $a:ident]) =>
      `(AttrValue.alias $(Lean.quote a.getId.toString))

section Test

private def attrVal0Str : AttrVal := [mlir_attr_val| "foo"]
/-- info: AttrValue.str "foo" -/
#guard_msgs in #reduce attrVal0Str

-- Uses dialect coercion: empty → builtin
example : AttrVal := [mlir_attr_val| "foo"]
-- Uses dialect coercion: empty → empty + builtin
--example : AttrValue (Dialect.empty + builtin) := [mlir_attr_val| "foo"]
-- Uses dialect coercion after building an AttrValue Dialect.empty

private def attrVal1bTy : AttrVal := [mlir_attr_val| i32]
/-- info: AttrValue.type (MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 32)) -/
#guard_msgs in #reduce attrVal1bTy

private def attrVal2List : AttrVal := [mlir_attr_val| ["foo", "foo"] ]
/-- info: AttrValue.list [AttrValue.str "foo", AttrValue.str "foo"] -/
#guard_msgs in #reduce attrVal2List

private def attrVal3AffineMap : AttrVal := [mlir_attr_val| affine_map<(x, y) -> (y)>]
/--
info: AttrValue.affine
  (AffineMap.mk (AffineTuple.mk [AffineExpr.Var "x", AffineExpr.Var "y"]) (AffineTuple.mk [AffineExpr.Var "y"]))
-/
#guard_msgs in #reduce attrVal3AffineMap

private def attrVal4Symbol : AttrVal := [mlir_attr_val| @"foo" ]
/-- info: AttrValue.symbol "foo" -/
#guard_msgs in #reduce attrVal4Symbol

private def attrVal5int: AttrVal := [mlir_attr_val| 42 ]
/-- info: AttrValue.int (Int.ofNat 42) (MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 64)) -/
#guard_msgs in #reduce attrVal5int

private def attrVal5bint: AttrVal := [mlir_attr_val| -42 ]
/-- info: AttrValue.int (Int.negSucc 41) (MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 64)) -/
#guard_msgs in #reduce attrVal5bint

private def attrVal6Symbol : AttrVal := [mlir_attr_val| @func_foo ]
/-- info: AttrValue.symbol "func_foo" -/
#guard_msgs in #reduce attrVal6Symbol

private def attrVal7NestedSymbol : AttrVal := [mlir_attr_val| @func_foo::@"func_bar" ]
/-- info: (AttrValue.symbol "func_foo").nestedsymbol (AttrValue.symbol "func_bar") -/
#guard_msgs in #reduce attrVal7NestedSymbol

private def attrVal8Alias : AttrVal := [mlir_attr_val| #"A" ]
/-- info: AttrValue.alias "A" -/
#guard_msgs in #reduce attrVal8Alias

private def attrVal9Alias : AttrVal := [mlir_attr_val| #a ]
/-- info: AttrValue.alias "a" -/
#guard_msgs in #reduce attrVal9Alias

private def attrVal10Float : AttrVal := [mlir_attr_val| 0.0023 ]
/--
info: private def MLIR.EDSL.attrVal10Float : AttrVal :=
AttrValue.float 23e-4 (MLIRType.float 64)
-/
#guard_msgs in #print attrVal10Float

private def attrVal11Escape : AttrVal := [mlir_attr_val| $(attrVal10Float) ]
/--
info: private def MLIR.EDSL.attrVal11Escape : AttrVal :=
attrVal10Float
-/
#guard_msgs in #print attrVal11Escape

end Test

/-!
# MLIR ATTRIBUTE
-/

syntax mlir_attr_key := ident <|> strLit
syntax mlir_attr_entry := mlir_attr_key (" = " mlir_attr_val)?

macro "[mlir_attr_entry|" entry:mlir_attr_entry "]" : term => do
  let `(mlir_attr_entry| $key $[= $val]?) := entry | Macro.throwUnsupported
  let key ← match key.raw[0] with
    | .ident _ key _ _ => pure key.toString
    --         ^^^ Notice we don't use the `val`, since the name might have been hygiene'd
    --             Instead, we use `rawVal`, which is documented as being
    --               "the literal substring from the input file" thus safe from hygiene
    | .node _ `str ⟨(.atom _ val)::[]⟩ => pure val
    -- ^^^ The `strLit` case
    | _ => Macro.throwUnsupported
  let value ← match val with
    | none      => `(AttrValue.unit)
    | some val  => `([mlir_attr_val| $val])
  `(AttrEntry.mk $(Lean.quote key) $value)

declare_syntax_cat mlir_attr_dict
syntax  "<" ? "{" sepBy(mlir_attr_entry, ",") "}" ">" ?  : mlir_attr_dict
syntax "[mlir_attr_dict|" mlir_attr_dict "]" : term

macro_rules
| `([mlir_attr_dict| $[<%$caretLeft]? {  $attrEntries,* } $[>%$caretRight]? ]) => do
        match caretLeft, caretRight with
        | none, some y => Macro.throwErrorAt y "Caret closed without being opened"
        | some x, none => Macro.throwErrorAt x "Caret opened without being closed"
        | _ , _ =>
          let attrsList <- attrEntries.getElems.toList.mapM (fun x => `([mlir_attr_entry| $x]))
          let attrsList <- quoteMList attrsList (<- `(MLIR.AST.AttrEntry _))
          `(AttrDict.mk $attrsList)
-- dict attribute val
syntax mlir_attr_dict : mlir_attr_val

macro_rules
| `([mlir_attr_val| $v:mlir_attr_dict]) => `(AttrValue.dict [mlir_attr_dict| $v])

section Test

def attr0Str : AttrEntry 0 := [mlir_attr_entry| sym_name = "add"]
/--
info: def MLIR.EDSL.attr0Str : AttrEntry 0 :=
AttrEntry.mk "sym_name" (AttrValue.str "add")
-/
#guard_msgs in #print attr0Str

def attr3Unit : AttrEntry 0 := [mlir_attr_entry| sym_name]
/--
info: def MLIR.EDSL.attr3Unit : AttrEntry 0 :=
AttrEntry.mk "sym_name" AttrValue.unit
-/
#guard_msgs in #print attr3Unit

def attr4Negative : AttrEntry 0 := [mlir_attr_entry| value = -1: i32]
/--
info: AttrEntry.mk "value" (AttrValue.int (Int.negSucc 0) (MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 32)))
-/
#guard_msgs in #reduce attr4Negative

def attrDict0 : AttrDict 0 := [mlir_attr_dict| {}]
def attrDict1 : AttrDict 0 := [mlir_attr_dict| {foo = "bar" }]
def attrDict2 : AttrDict 0 := [mlir_attr_dict| {foo = "bar", baz = "quux" }]

def propDict2 : AttrDict 0 := [mlir_attr_dict| <{foo = "bar", baz = "quux" }>]

def nestedAttrDict0 : AttrDict 0 := [mlir_attr_dict| {foo = {bar = "baz"} }]
/--
info: def MLIR.EDSL.nestedAttrDict0 : AttrDict 0 :=
AttrDict.mk [AttrEntry.mk "foo" (AttrValue.dict (AttrDict.mk [AttrEntry.mk "bar" (AttrValue.str "baz")]))]
-/
#guard_msgs in #print nestedAttrDict0

end Test

/-!
# MLIR OPS WITH REGIONS AND ATTRIBUTES AND BASIC BLOCK ARGS
-/

-- Op with potential result
syntax
  (mlir_op_operand,* "=")?
  str "(" mlir_op_operand,* ")"
         ( "(" mlir_region,* ")" )?
         (mlir_attr_dict)?
  ":" "(" mlir_type,* ")" "->" "("mlir_type,*")" : mlir_op

macro_rules
  | `([mlir_op| $x]) => `(mlir_op| $x)

macro_rules
  | `([mlir_op| $$($x)]) => return x

macro_rules
  | `(mlir_op|
        $[ $resNamesStx,* = ]?
        $name:str
        ( $operandsNames,* )
        $[ ( $rgns,* ) ]?
        $[ $attrDict ]?
        : ( $operandsTypes,* ) -> ( $resTypesStx,* ) ) => do
      let resNames := resNamesStx.map Syntax.TSepArray.getElems |>.getD #[]
      let resTypes := resTypesStx.getElems
      if resTypes.size != resNames.size then
        Macro.throwError s!"expected {resNames.size} return types,
          based on the results list, but found {resTypes.size}"
      let res ←
        Array.zipWithM (fun v t => `(([mlir_op_operand| $v], [mlir_type| $t])))
          resNames resTypes
      let res ← quoteMList res.toList (← `(MLIR.AST.TypedSSAVal _))

      -- TODO: Needs a consistency check that `operandsNames.length = operandsTypes.length`
      let operands: List (MacroM <| TSyntax `term) :=
        List.zipWith (fun x y => `(([mlir_op_operand| $x], [mlir_type| $y])))
        operandsNames.getElems.toList operandsTypes.getElems.toList
      let operands ← quoteMList (← operands.mapM id) (← `(MLIR.AST.TypedSSAVal _))
      let attrDict <- match attrDict with
                        | none => `(AttrDict.mk [])
                        | some dict => `([mlir_attr_dict| $dict])
      let rgnsList <- match rgns with
                | none => `(@List.nil (MLIR.AST.Region _))
                | some rgns => do
                  let rngs <- rgns.getElems.mapM (fun x => `([mlir_region| $x]))
                  quoteMList rngs.toList (<- `(MLIR.AST.Region _))

      `(Op.mk $name -- name
              $res -- results
              $operands -- operands
              $rgnsList -- regions
              $attrDict) -- attrs

-- Op with definite result
syntax mlir_op_operand "="
  strLit "(" mlir_op_operand,* ")"
         ( "(" mlir_region,* ")" )?
         (mlir_attr_dict)? ":" "(" mlir_type,* ")" "->" mlir_type : mlir_op

macro_rules
  | `(mlir_op|
        $resName:mlir_op_operand = $name:str ( $operandsNames,* ) $[ ( $rgns,* ) ]? $[ $attrDict ]?
        : ( $operandsTypes,* ) -> $resType:mlir_type
      ) => do
        let results ← `([([mlir_op_operand| $resName], [mlir_type| $resType])])
        -- TODO: Needs a consistency check that `operandsNames.length = operandsTypes.length`
        let operands: List (MacroM <| TSyntax `term) :=
          List.zipWith (fun x y => `(([mlir_op_operand| $x], [mlir_type| $y])))
          operandsNames.getElems.toList operandsTypes.getElems.toList
        let operands ← quoteMList (← operands.mapM id) (← `(MLIR.AST.TypedSSAVal _))
        let attributes <- match attrDict with
                          | none => `(AttrDict.mk [])
                          | some dict => `([mlir_attr_dict| $dict])
        let regions <- match rgns with
                  | none => `(@List.nil (MLIR.AST.Region _))
                  | some rgns => do
                    let rngs <- rgns.getElems.mapM (fun x => `([mlir_region| $x]))
                    quoteMList rngs.toList (<- `(MLIR.AST.Region _))
        `(Op.mk $name $results $operands $regions $attributes)

section Test

private def op1 : Op φ :=
  [mlir_op| "foo"(%x, %y) : (i32, i32) -> () ]
/--
info: private def MLIR.EDSL.op1 : {φ : ℕ} → Op φ :=
fun {φ} =>
  { name := "foo", res := [],
    args :=
      [(SSAVal.name "x", MLIRType.int Signedness.Signless 32), (SSAVal.name "y", MLIRType.int Signedness.Signless 32)],
    regions := [], attrs := AttrDict.mk [] }
-/
#guard_msgs in #print op1

private def op2 : Op φ :=
  [mlir_op| %z = "foo"(%x, %y) : (i32, i32) -> (i32)]
/--
info: private def MLIR.EDSL.op2 : {φ : ℕ} → Op φ :=
fun {φ} =>
  { name := "foo", res := [(SSAVal.name "z", MLIRType.int Signedness.Signless 32)],
    args :=
      [(SSAVal.name "x", MLIRType.int Signedness.Signless 32), (SSAVal.name "y", MLIRType.int Signedness.Signless 32)],
    regions := [], attrs := AttrDict.mk [] }
-/
#guard_msgs in #print op2

/--
TODO: we've attempted to support anti-quotations, but it doesn't actually work, as seen in the
following example:
-/
-- def op2' : Op φ := [mlir_op| $op2]

private def bbop1 : SSAVal × MLIRTy φ := [mlir_bb_operand| %x : i32 ]
/--
info: private def MLIR.EDSL.bbop1 : {φ : ℕ} → SSAVal × MLIRTy φ :=
fun {φ} => (SSAVal.name "x", MLIRType.int Signedness.Signless 32)
-/
#guard_msgs in #print bbop1

private def bb1NoArgs : Region φ :=
  [mlir_region| {
     ^entry:
     "foo"(%x, %y) : (i32, i32) -> ()
      %z = "bar"(%x) : (i32) -> (i32)
      "std.return"(%x0) : (i42) -> ()
  }]
/--
info: private def MLIR.EDSL.bb1NoArgs : {φ : ℕ} → Region φ :=
fun {φ} =>
  { name := "entry", args := [],
    ops :=
      [{ name := "foo", res := [],
          args :=
            [(SSAVal.name "x", MLIRType.int Signedness.Signless 32),
              (SSAVal.name "y", MLIRType.int Signedness.Signless 32)],
          regions := [], attrs := AttrDict.mk [] },
        { name := "bar", res := [(SSAVal.name "z", MLIRType.int Signedness.Signless 32)],
          args := [(SSAVal.name "x", MLIRType.int Signedness.Signless 32)], regions := [], attrs := AttrDict.mk [] },
        { name := "std.return", res := [], args := [(SSAVal.name "x0", MLIRType.int Signedness.Signless 42)],
          regions := [], attrs := AttrDict.mk [] }] }
-/
#guard_msgs in #print bb1NoArgs

/-
TODO: antiquotations for regions don't seem to work, the following fails to compile with error:
`elaboration function for 'mlir_region.pseudo.antiquot' has not been implemented`
```lean
private def bb1NoArgsAntiQuot : Region φ := [mlir_region| $bb1NoArgs]
``` -/

private def bb2SingleArg : Region φ :=
  [mlir_region| {
     ^entry(%argp : i32):
     "foo"(%x, %y) : (i32, i32) -> ()
      %z = "bar"(%x) : (i32) -> (i32)
      "std.return"(%x0) : (i42) -> ()
  }]
/--
info: private def MLIR.EDSL.bb2SingleArg : {φ : ℕ} → Region φ :=
fun {φ} =>
  { name := "entry", args := [(SSAVal.name "argp", MLIRType.int Signedness.Signless 32)],
    ops :=
      [{ name := "foo", res := [],
          args :=
            [(SSAVal.name "x", MLIRType.int Signedness.Signless 32),
              (SSAVal.name "y", MLIRType.int Signedness.Signless 32)],
          regions := [], attrs := AttrDict.mk [] },
        { name := "bar", res := [(SSAVal.name "z", MLIRType.int Signedness.Signless 32)],
          args := [(SSAVal.name "x", MLIRType.int Signedness.Signless 32)], regions := [], attrs := AttrDict.mk [] },
        { name := "std.return", res := [], args := [(SSAVal.name "x0", MLIRType.int Signedness.Signless 42)],
          regions := [], attrs := AttrDict.mk [] }] }
-/
#guard_msgs in #print bb2SingleArg


private def bb3MultipleArgs : Region φ :=
  [mlir_region| {
     ^entry(%argp : i32, %argq : i64):
     "foo"(%x, %y) : (i32, i32) -> ()
      %z = "bar"(%x) : (i32) -> (i32)
      "std.return"(%x0) : (i42) -> ()
  }]
/--
info: { name := "entry",
  args :=
    [(SSAVal.name "argp", MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 32)),
      (SSAVal.name "argq", MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 64))],
  ops :=
    [{ name := "foo", res := [],
        args :=
          [(SSAVal.name "x", MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 32)),
            (SSAVal.name "y", MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 32))],
        regions := [], attrs := AttrDict.mk [] },
      { name := "bar", res := [(SSAVal.name "z", MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 32))],
        args := [(SSAVal.name "x", MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 32))], regions := [],
        attrs := AttrDict.mk [] },
      { name := "std.return", res := [],
        args := [(SSAVal.name "x0", MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 42))], regions := [],
        attrs := AttrDict.mk [] }] }
-/
#guard_msgs in #reduce bb3MultipleArgs


private def rgn0 : Region φ := ([mlir_region|  { }])
/--
info: private def MLIR.EDSL.rgn0 : {φ : ℕ} → Region φ :=
fun {φ} => { name := "entry", args := [], ops := [] }
-/
#guard_msgs in #print rgn0

private def rgn1 : Region φ :=
  [mlir_region|  {
    ^entry:
      "std.return"(%x0) : (i42) -> ()
  }]
/--
info: private def MLIR.EDSL.rgn1 : {φ : ℕ} → Region φ :=
fun {φ} =>
  { name := "entry", args := [],
    ops :=
      [{ name := "std.return", res := [], args := [(SSAVal.name "x0", MLIRType.int Signedness.Signless 42)],
          regions := [], attrs := AttrDict.mk [] }] }
-/
#guard_msgs in #print rgn1

private def rgn2 : Region φ :=
  [mlir_region|  {
    ^entry:
      "std.return"(%x0) : (i42) -> ()
  }]
/--
info: private def MLIR.EDSL.rgn2 : {φ : ℕ} → Region φ :=
fun {φ} =>
  { name := "entry", args := [],
    ops :=
      [{ name := "std.return", res := [], args := [(SSAVal.name "x0", MLIRType.int Signedness.Signless 42)],
          regions := [], attrs := AttrDict.mk [] }] }
-/
#guard_msgs in #print rgn2

-- | test what happens if we try to use an entry block with no explicit bb name
private def rgn3 : Region φ :=
  [mlir_region|  {
      "std.return"(%x0) : (i42) -> ()
  }]

/--
info: private def MLIR.EDSL.rgn1 : {φ : ℕ} → Region φ :=
fun {φ} =>
  { name := "entry", args := [],
    ops :=
      [{ name := "std.return", res := [], args := [(SSAVal.name "x0", MLIRType.int Signedness.Signless 42)],
          regions := [], attrs := AttrDict.mk [] }] }
-/
#guard_msgs in #print rgn1


/-! ## test simple ops (no regions) -/

private def opcall1 : Op φ := [mlir_op| "foo" (%x, %y) : (i32, i32) -> () ]
/--
info: private def MLIR.EDSL.opcall1 : {φ : ℕ} → Op φ :=
fun {φ} =>
  { name := "foo", res := [],
    args :=
      [(SSAVal.name "x", MLIRType.int Signedness.Signless 32), (SSAVal.name "y", MLIRType.int Signedness.Signless 32)],
    regions := [], attrs := AttrDict.mk [] }
-/
#guard_msgs in #print opcall1



private def oprgn0 : Op φ := [mlir_op|
 "func"() ({ ^entry: %x = "foo.add"() : () -> (i64) } ) : () -> ()
]
/--
info: { name := "func", res := [], args := [],
  regions :=
    [{ name := "entry", args := [],
        ops :=
          [{ name := "foo.add",
              res := [(SSAVal.name "x", MLIRType.int Signedness.Signless (ConcreteOrMVar.concrete 64))], args := [],
              regions := [], attrs := AttrDict.mk [] }] }],
  attrs := AttrDict.mk [] }
-/
#guard_msgs in #reduce oprgn0

-- | note that this is a "full stack" example!
private def opRgnAttr0 : Op φ := [mlir_op|
 "module"() ({
  ^entry:
   "func"() ({
     ^bb0(%arg0:i32, %arg1:i32):
      %zero = "std.addi"(%arg0 , %arg1) : (i32, i16) -> (i64)
      "std.return"(%zero) : (i32) -> ()
    }){sym_name = "add"} : () -> ()
   "module_terminator"() : () -> ()
 }) : () -> ()
]
/--
info: private def MLIR.EDSL.opRgnAttr0 : {φ : ℕ} → Op φ :=
fun {φ} =>
  { name := "module", res := [], args := [],
    regions :=
      [{ name := "entry", args := [],
          ops :=
            [{ name := "func", res := [], args := [],
                regions :=
                  [{ name := "bb0",
                      args :=
                        [(SSAVal.name "arg0", MLIRType.int Signedness.Signless 32),
                          (SSAVal.name "arg1", MLIRType.int Signedness.Signless 32)],
                      ops :=
                        [{ name := "std.addi", res := [(SSAVal.name "zero", MLIRType.int Signedness.Signless 64)],
                            args :=
                              [(SSAVal.name "arg0", MLIRType.int Signedness.Signless 32),
                                (SSAVal.name "arg1", MLIRType.int Signedness.Signless 16)],
                            regions := [], attrs := AttrDict.mk [] },
                          { name := "std.return", res := [],
                            args := [(SSAVal.name "zero", MLIRType.int Signedness.Signless 32)], regions := [],
                            attrs := AttrDict.mk [] }] }],
                attrs := AttrDict.mk [AttrEntry.mk "sym_name" (AttrValue.str "add")] },
              { name := "module_terminator", res := [], args := [], regions := [], attrs := AttrDict.mk [] }] }],
    attrs := AttrDict.mk [] }
-/
#guard_msgs in #print opRgnAttr0

end Test


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
     let rgn ← `(Region.mk "entry" $bbargs [mlir_ops| $ops])

     -- Make the function signature
     let argTypes ← args.getElems.mapM (fun x => `(Prod.snd [mlir_bb_operand| $x]))
     let argTypes ← quoteMList argTypes.toList (← `(MLIR.AST.MLIRType))
     let retType ← match ret with
       | none => `(MLIRType.tuple [])
       | some τ => `([mlir_type| $τ])
     let signature ← `(MLIRType.fn (MLIRType.tuple $argTypes) $retType)

     -- Make the entire operation
     let attrs ← `(AttrDict.mk [
        AttrEntry.mk "function_type" (AttrValue.type $signature),
        AttrEntry.mk "sym_name" [mlir_attr_val_symbol| $name]
      ])
     `(Op.mk "func" [] [] [$rgn] $attrs)



syntax "module" "{" mlir_op* "}" : mlir_op

macro_rules
| `([mlir_op| module { $ops* } ]) => do
     let initList <- `([Op.empty "module_terminator"])
     let ops <- ops.foldrM (init := initList) fun x xs => `([mlir_op| $x] :: $xs)
     let rgn <- `(Region.fromOps $ops)
     `(Op.mk "module" [] [] [$rgn] AttrDict.empty)

section Test

private def mod1 : Op φ := [mlir_op| module { }]
/--
info: private def MLIR.EDSL.mod1 : {φ : ℕ} → Op φ :=
fun {φ} =>
  { name := "module", res := [], args := [], regions := [Region.fromOps [Op.empty "module_terminator"]],
    attrs := AttrDict.empty }
-/
#guard_msgs in #print mod1

private def mod2 : Op φ := [mlir_op| module { "dummy.dummy"(): () -> () }]
/--
info: private def MLIR.EDSL.mod2 : {φ : ℕ} → Op φ :=
fun {φ} =>
  { name := "module", res := [], args := [],
    regions :=
      [Region.fromOps
          [{ name := "dummy.dummy", res := [], args := [], regions := [], attrs := AttrDict.mk [] },
            Op.empty "module_terminator"]],
    attrs := AttrDict.empty }
-/
#guard_msgs in #print mod2

end Test

end MLIR.EDSL
