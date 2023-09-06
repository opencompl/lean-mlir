import Lean.Parser
import Lean.Parser.Extra
import Init.Data.String
import Init.Data.String.Basic
import Init.Data.Char.Basic
import Init.System.IO
import Lean.Parser
import Lean.Parser.Extra
import Init.System.Platform
import Init.Data.String.Basic
import Init.Data.Repr
import Init.Data.ToString.Basic

-- | TODO: Consider adopting flutter rendering model:
-- linear time, flexbox, one walk up and one walk down tree.
-- https://www.youtube.com/watch?v=UUfXWzp0-DU

namespace MLIR.Doc

inductive Doc : Type where
  | Concat : Doc -> Doc -> Doc
  | Nest : Doc -> Doc
  | VGroup : List Doc -> Doc
  | Text: String -> Doc


class Pretty (a : Type u) where
  doc : a -> Doc

open Pretty

def vgroup [Pretty a] (as: List a): Doc :=
  Doc.VGroup (as.map doc)

def nest_vgroup [Pretty a] (as: List a): Doc :=
  Doc.Nest (vgroup as)


instance : Pretty Doc where
  doc (d: Doc) := d

instance : Pretty String where
  doc := Doc.Text

instance : Pretty Nat where
  doc := Doc.Text ∘ toString

instance : Pretty Int where
  doc := Doc.Text ∘ toString

instance : Pretty Bool where
  doc := Doc.Text ∘ toString


instance : Pretty Float where
  doc f := Doc.Text (toString (repr f))

instance : Pretty Char where
  doc := Doc.Text ∘ toString

instance : Inhabited Doc where
  default := Doc.Text ""


instance : Coe String Doc where
  coe := Doc.Text

instance : Append Doc where
  append := Doc.Concat


instance : HAppend Doc String Doc where
  hAppend d s := Doc.Concat d (Doc.Text s)

instance : HAppend String Doc Doc where
  hAppend s d:= Doc.Concat (Doc.Text s) d


def doc_dbl_quot : Doc :=  doc '"'

def doc_surround_dbl_quot [Pretty a] (v: a): Doc :=
    doc_dbl_quot ++ doc v ++ doc_dbl_quot


def doc_concat (ds: List Doc): Doc := ds.foldl Doc.Concat (Doc.Text "")

partial def intercalate_doc_rec_ [Pretty d] (ds: List d) (i: Doc): Doc :=
  match ds with
  | [] => Doc.Text ""
  | (d::ds) => i ++ (doc d) ++ intercalate_doc_rec_ ds i

partial def  intercalate_doc [Pretty d] (ds: List d) (i: Doc): Doc := match ds with
 | [] => Doc.Text ""
 | [d] => doc d
 | (d::ds) => (doc d) ++ intercalate_doc_rec_ ds i


partial def vintercalate_doc_rec_ [Pretty d] (ds: List d) (i: String): List Doc :=
  match ds with
  | [] => [Doc.Text ""]
  | (d::ds) => (i ++ (doc d)) :: vintercalate_doc_rec_ ds i

partial def  vintercalate_doc [Pretty d] (ds: List d) (i: String): Doc := match ds with
 | [] => Doc.Text ""
 | [d] => doc d
 | (d::ds) => Doc.VGroup $ (doc d)::vintercalate_doc_rec_ ds i



partial def layout
  (d: Doc)
  (indent: Int) -- indent
  (width: Int) -- width
  (leftover: Int) -- characters left
  (newline: Bool) -- create newline?
  : String :=
  match d with
    | (Doc.Text s)  => (if newline then "\n".pushn ' ' indent.toNat else "") ++ s
    | (Doc.Concat d1 d2) =>
         let s := layout d1 indent width leftover newline
         s ++ layout d2 indent width (leftover - (s.length + 1)) false
    | (Doc.Nest d) => layout d (indent+1) width leftover newline
    | (Doc.VGroup ds) =>
       let ssInline := layout (doc_concat ds) indent width leftover newline
       if false then ssInline -- ssInline.length <= leftover then ssInline
       else
         let width' := width - indent
         -- TODO: don't make
         String.join (ds.map (fun d => layout d indent width width True))


def layout80col (d: Doc) : String := layout d 0 80 0 false

instance : Coe Doc String where
   coe := layout80col

-- EDSL for documents
open Lean.Parser

declare_syntax_cat docLeaf
declare_syntax_cat docstx
syntax str : docLeaf
syntax ident : docLeaf

-- | conditionals
-- | can I make this syntax only work within docLeaf??
syntax "(ifdoc" term "then" docstx "else" docstx ")": docLeaf

syntax "[docLeaf|" docLeaf "]" : term -- translator
syntax docLeaf : docstx
syntax "(" term ")" : docLeaf -- escape
syntax "(" term "),*" : docLeaf -- spread
syntax "(" term ");*" : docLeaf -- spread
syntax "(nest" docstx ")" : docLeaf -- nest
syntax "(nest" term ");*" : docLeaf -- nest

syntax docLeaf docstx : docstx -- horizontal
syntax "{" (docstx ";")* "}" : docstx
syntax "{nest" (docstx ";")* "}" : docstx
syntax "[doc|" docstx "]" : term -- translator
syntax "[escape|" term "]" : docLeaf

--- | string
macro_rules
| `([docLeaf| $x:str ]) => do
    `(Doc.Text $x)

def testDocStr : Doc := [docLeaf|"x"]
#reduce testDocStr

-- | identifier
macro_rules
| `([docLeaf| $x:ident ]) => do
  `(Pretty.doc $x)

def testDocIdent : Doc := let x := "foo"; [docLeaf| x ]
#reduce testDocIdent

-- | doc of doclean
macro_rules
| `([doc|  $x:docLeaf ]) => `([docLeaf| $x])

-- | concat
macro_rules
| `([doc|  $x:docLeaf $xs:docstx ]) => do
    let initDoc <- `([docLeaf| $x])
    let restDoc <- `([doc| $xs])
    `(Doc.Concat $initDoc $restDoc)

def testDocConcat : Doc := let x := "foo"; [doc| "^" x ":" ]
#reduce testDocConcat

-- | escape
macro_rules
| `([docLeaf| [escape| $x ] ]) => return x

-- | escape
macro_rules
| `([docLeaf| ( $x ) ]) => return x

-- | if
macro_rules
| `([docLeaf| (ifdoc  $x:term then  $t:docstx else $e: docstx ) ]) =>
    `(if $x then [doc| $t] else [doc| $e])


-- | vertical
macro_rules
-- | `([doc|  { $[| $xs ]* } ]) => do
| `([doc|  { $[ $xs ;]* } ]) => do
  let initDoc <- `([])
  let docs <- xs.foldlM (init := initDoc) (fun accum doc => `($accum ++ [ [doc| $doc] ]))
  `(Doc.VGroup $docs)
macro_rules
| `([doc|  {nest $[ $xs ;]* } ]) => do
  let initDoc <- `([])
  let docs <- xs.foldlM (init := initDoc) (fun accum doc => `($accum ++ [ [doc| $doc] ]))
  `(Doc.Nest (Doc.VGroup $docs))


-- | vertical spread
macro_rules
| `([docLeaf| ( $x:term );*]) => do
    `(Doc.VGroup (($x).map doc))

def testDocVSpread0 : Doc :=
    let xs := ["foo", "bar", "baz"]
    [doc| (xs);*]
#reduce testDocVSpread0



-- | vertical spread with nesting
macro_rules
| `([docLeaf| (nest $x:term );*]) => do
    `(Doc.Nest (Doc.VGroup (($x).map doc)))

def testDocVSpreadNest0 : Doc :=
    let xs := ["nest0-foo", "nest0-bar", "baz"]
    [doc| (nest xs);*]
#reduce testDocVSpreadNest0


def testDocEscape0 : Doc := [docLeaf| [escape| Doc.Text "foo"] ]
#reduce testDocEscape0

def testDocEscape1 : Doc := [doc| [escape| Doc.Text "foo"] "bar"]
#reduce testDocEscape1

-- | comma intercalate
macro_rules
| `([docLeaf| ( $x:term ),*]) => do
    `(intercalate_doc (($x).map doc) ",")

def testDocIntercalate0 : Doc :=
    let xs := ["foo", "bar", "baz"]
    [docLeaf| (xs),*]
#reduce testDocIntercalate0


macro_rules
| `([docLeaf| (nest $x:docstx )]) => `(Doc.Nest [doc| $x])


def testDocNest0 : Doc :=
    [doc| (nest "foo")]

def testDocNest1 : Doc :=
    [doc| (nest "foo" "bar")]

def testDocNest2 : Doc :=
    [doc| {nest
            "foo" "bar";
            {
            "baz" "foo";
            "quux";
            };
    }]

#reduce testDocNest0
#reduce testDocNest1
#reduce testDocNest2

end MLIR.Doc



---- Crazy line syntax
---- | This actually seems to work...?
--- TODO: finish this.

declare_syntax_cat pipes
syntax "|" : pipes
syntax "|" pipes: pipes

declare_syntax_cat docline
syntax pipes docstx : docline

declare_syntax_cat doclines
syntax (ws docline ws)* : doclines

syntax "[docLine|" docline "]" : term

macro_rules
| `([docLine| $p:pipes  $x:docstx]) => do
      let str := p.raw.reprint
      match str with
      | some str => do
          let x := (Lean.quote str: Lean.TSyntax Lean.strLitKind).raw
          `([doc| "SUCCESS"])
      | none => `([doc| "ERROR"])

def testDocLine0 := [docLine| |   "foo"]
#reduce testDocLine0
