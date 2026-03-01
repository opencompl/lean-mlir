/-
Blasewuzla: Parametric bitvector SMT2 parser that builds MultiWidth.Nondep.Term values.
Authors: Siddharth Bhat
-/
import Blasewuzla.Sexp.Basic
import Blase.MultiWidth.Defs

namespace Blasewuzla

open MultiWidth

/-- A parsed term, tracking whether it is a bitvector, predicate, or boolean. -/
inductive ParsedTerm
| bv (t : Nondep.Term) (w : Nondep.WidthExpr)   -- bitvector value with its width
| pred (t : Nondep.Term)                          -- proposition/predicate
deriving Repr

/-- Result of parsing an SMT2 file. -/
structure ParseResult where
  predicate : Nondep.Term     -- negated conjunction of assertions
  wcard : Nat                 -- number of width variables
  tcard : Nat                 -- number of term variables
  bcard : Nat := 0            -- number of bool variables
  pcard : Nat := 0            -- number of predicate variables
deriving Repr

/-- Parser state. -/
structure ParserState where
  widthVars : Std.HashMap String Nat := {}               -- "k" → 0 (width var index)
  termVars : Std.HashMap String (Nat × Nondep.WidthExpr) := {} -- "%A" → (idx, width)
  letBindings : Std.HashMap String ParsedTerm := {}       -- let variable → parsed term
  nextWidthIdx : Nat := 0
  nextTermIdx : Nat := 0

abbrev ParserM := EStateM String ParserState

def ParserM.throwError (msg : String) : ParserM α :=
  EStateM.throw msg

/-- Register a width variable and return its index. -/
def registerWidthVar (name : String) : ParserM Nat := do
  let s ← get
  let idx := s.nextWidthIdx
  set { s with widthVars := s.widthVars.insert name idx, nextWidthIdx := idx + 1 }
  return idx

/-- Register a term variable and return its index. -/
def registerTermVar (name : String) (w : Nondep.WidthExpr) : ParserM Nat := do
  let s ← get
  let idx := s.nextTermIdx
  set { s with termVars := s.termVars.insert name (idx, w), nextTermIdx := idx + 1 }
  return idx

/-- Parse a width expression from an S-expression. -/
def parseWidthExpr (s : Sexp) : ParserM Nondep.WidthExpr := do
  match s with
  | .atom name =>
    -- Check if it's a registered width variable
    let st ← get
    match st.widthVars[name]? with
    | some idx => return .var idx
    | none =>
      -- Try parsing as a numeric literal
      match name.toNat? with
      | some n => return .const n
      | none => ParserM.throwError s!"unknown width expression: '{name}'"
  | .expr [.atom "+", a, b] =>
    let wa ← parseWidthExpr a
    match b with
    | .atom nStr =>
      match nStr.toNat? with
      | some k => return .addK wa k
      | none =>
        let _wb ← parseWidthExpr b
        -- a + b where b is a variable: use addK with 0 as a workaround isn't right.
        -- For now, only support constant offsets.
        ParserM.throwError s!"width expression '+': second operand must be a constant, got '{b}'"
    | _ => ParserM.throwError s!"width expression '+': second operand must be a constant, got '{b}'"
  | .expr _ => ParserM.throwError s!"unsupported compound width expression: '{s}'"

/-- Parse a sort to extract a width expression. Handles `(_ BitVec w)`. -/
def parseSortWidth (s : Sexp) : ParserM Nondep.WidthExpr := do
  match s with
  | .expr [.atom "_", .atom "BitVec", w] => parseWidthExpr w
  | _ => ParserM.throwError s!"expected (_ BitVec w), got: '{s}'"

/-- Get width from a parsed bitvector term, or error if it's a predicate. -/
def ParsedTerm.getWidth : ParsedTerm → ParserM Nondep.WidthExpr
  | .bv _ w => return w
  | .pred _ => ParserM.throwError "expected bitvector term, got predicate"

/-- Get the underlying Nondep.Term from a ParsedTerm. -/
def ParsedTerm.getTerm : ParsedTerm → Nondep.Term
  | .bv t _ => t
  | .pred t => t

/-- Expect a bitvector ParsedTerm, return (term, width). -/
def expectBV (pt : ParsedTerm) (ctx : String := "") : ParserM (Nondep.Term × Nondep.WidthExpr) := do
  match pt with
  | .bv t w => return (t, w)
  | .pred _ => ParserM.throwError s!"expected bitvector term but got predicate{if ctx.isEmpty then "" else s!" in {ctx}"}"

/-- Expect a predicate ParsedTerm. -/
def expectPred (pt : ParsedTerm) (ctx : String := "") : ParserM Nondep.Term := do
  match pt with
  | .pred t => return t
  | .bv _ _ => ParserM.throwError s!"expected predicate but got bitvector{if ctx.isEmpty then "" else s!" in {ctx}"}"

/-- Negate a predicate term, throwing a parser error if negation is not supported. -/
private def negateTerm (t : Nondep.Term) : ParserM Nondep.Term :=
  match t.pnegate with
  | (t', true) => return t'
  | _ => ParserM.throwError s!"cannot negate term: {repr t}"

/-- Parse a term from an S-expression. -/
partial def parseTerm (s : Sexp) : ParserM ParsedTerm := do
  match s with
  | .atom name =>
    -- Check let bindings first
    let st ← get
    match st.letBindings[name]? with
    | some pt => return pt
    | none =>
      -- Check term variables
      match st.termVars[name]? with
      | some (idx, w) => return .bv (.var idx w) w
      | none =>
        -- Check for "true" / "false"
        match name with
        | "true" => return .pred .pTrue
        | "false" => return .pred (← negateTerm .pTrue)
        | _ => ParserM.throwError s!"unknown term variable: '{name}'"

  | .expr [.atom "int_to_pbv", wAtom, nAtom] =>
    let w ← parseWidthExpr wAtom
    match nAtom with
    | .atom nStr =>
      match nStr.toInt? with
      | some n =>
        -- Handle negative numbers: -n mod 2^w in bitvector is the same as
        -- just using the natural number representation since the FSM handles modular arithmetic.
        -- For int_to_pbv, we pass the natural number and let the bitvector modular arithmetic handle it.
        return .bv (.ofNat w n.toNat) w
      | none => ParserM.throwError s!"expected integer literal in int_to_pbv, got: '{nStr}'"
    | _ => ParserM.throwError s!"expected atom in int_to_pbv, got: '{nAtom}'"

  | .expr [.atom "bvadd", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvadd")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvadd")
    return .bv (.add aw at_ bt) aw

  | .expr [.atom "bvsub", a, b] =>
    -- bvsub a b = a + (not b + 1) = a + (-b)
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvsub")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvsub")
    let negB := Nondep.Term.add aw (.bnot aw bt) (.ofNat aw 1)
    return .bv (.add aw at_ negB) aw

  | .expr [.atom "bvneg", a] =>
    -- bvneg a = not a + 1
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvneg")
    return .bv (.add aw (.bnot aw at_) (.ofNat aw 1)) aw

  | .expr [.atom "bvmul", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvmul")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvmul")
    return .bv (.mul aw at_ bt) aw

  | .expr [.atom "bvand", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvand")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvand")
    return .bv (.band aw at_ bt) aw

  | .expr [.atom "bvor", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvor")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvor")
    return .bv (.bor aw at_ bt) aw

  | .expr [.atom "bvxor", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvxor")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvxor")
    return .bv (.bxor aw at_ bt) aw

  | .expr [.atom "bvnot", a] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvnot")
    return .bv (.bnot aw at_) aw

  | .expr [.atom "bvnand", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvnand")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvnand")
    return .bv (.bnot aw (.band aw at_ bt)) aw

  | .expr [.atom "bvnor", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvor")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvnor")
    return .bv (.bnot aw (.bor aw at_ bt)) aw

  | .expr [.atom "bvxnor", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvxnor")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvxnor")
    return .bv (.bnot aw (.bxor aw at_ bt)) aw

  | .expr [.atom "bvshl", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvshl")
    -- Try constant shift first, fall back to variable shift
    match b with
    | .expr [.atom "int_to_pbv", _, .atom nStr] =>
      match nStr.toNat? with
      | some n => return .bv (.shiftl aw at_ n) aw
      | none => ParserM.throwError s!"bvshl: expected constant shift amount, got '{nStr}'"
    | _ =>
      let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvshl")
      return .bv (.vshl aw at_ bt) aw

  | .expr [.atom "bvlshr", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvlshr")
    -- Try constant shift first, fall back to variable shift
    match b with
    | .expr [.atom "int_to_pbv", _, .atom nStr] =>
      match nStr.toNat? with
      | some n => return .bv (.shiftr aw at_ n) aw
      | none => ParserM.throwError s!"bvlshr: expected constant shift amount, got '{nStr}'"
    | _ =>
      let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvlshr")
      return .bv (.vlshr aw at_ bt) aw

  | .expr [.atom "bvashr", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvashr")
    -- Try constant shift first, fall back to variable shift
    match b with
    | .expr [.atom "int_to_pbv", _, .atom nStr] =>
      match nStr.toNat? with
      | some n => return .bv (.shiftr aw at_ n) aw -- TODO: encode constant ashr properly
      | none => ParserM.throwError s!"bvashr: expected constant shift amount, got '{nStr}'"
    | _ =>
      let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvashr")
      return .bv (.vashr aw at_ bt) aw

  | .expr [.atom "bvudiv", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvudiv")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvudiv")
    return .bv (.udiv aw at_ bt) aw

  | .expr [.atom "bvurem", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvurem")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvurem")
    return .bv (.urem aw at_ bt) aw

  -- zero_extend: ((_ zero_extend wnew) a)
  | .expr [.expr [.atom "_", .atom "zero_extend", wnew], a] =>
    let w ← parseWidthExpr wnew
    let (at_, _aw) ← (← parseTerm a) |> expectBV (ctx := "zero_extend")
    return .bv (.zext at_ w) w

  -- sign_extend: ((_ sign_extend wnew) a)
  | .expr [.expr [.atom "_", .atom "sign_extend", wnew], a] =>
    let w ← parseWidthExpr wnew
    let (at_, _aw) ← (← parseTerm a) |> expectBV (ctx := "sign_extend")
    return .bv (.sext at_ w) w

  -- pzero_extend: alias for zero_extend
  | .expr [.expr [.atom "_", .atom "pzero_extend", wnew], a] =>
    let w ← parseWidthExpr wnew
    let (at_, _aw) ← (← parseTerm a) |> expectBV (ctx := "pzero_extend")
    return .bv (.zext at_ w) w

  -- psign_extend: alias for sign_extend
  | .expr [.expr [.atom "_", .atom "psign_extend", wnew], a] =>
    let w ← parseWidthExpr wnew
    let (at_, _aw) ← (← parseTerm a) |> expectBV (ctx := "psign_extend")
    return .bv (.sext at_ w) w

  -- Width relation predicates
  | .expr [.atom "width_le", a, b] =>
    let wa ← parseWidthExpr a
    let wb ← parseWidthExpr b
    return .pred (.binWidthRel .le wa wb)

  | .expr [.atom "width_eq", a, b] =>
    let wa ← parseWidthExpr a
    let wb ← parseWidthExpr b
    return .pred (.binWidthRel .eq wa wb)

  -- Comparisons (produce predicates)
  | .expr [.atom "=", a, b] =>
    let pa ← parseTerm a
    let pb ← parseTerm b
    match pa, pb with
    | .bv at_ aw, .bv bt _bw =>
      return .pred (.binRel .eq aw at_ bt)
    | .pred at_, .pred bt =>
      -- (a ↔ b) = (a → b) ∧ (b → a) = (¬a ∨ b) ∧ (¬b ∨ a)
      let nat_ ← negateTerm at_
      let nbt ← negateTerm bt
      return .pred (.and (.or nat_ bt) (.or nbt at_))
    | _, _ => ParserM.throwError s!"= : mismatched types between arguments"

  -- distinct is just (not (= a b))
  | .expr [.atom "distinct", a, b] =>
    let pa ← parseTerm a
    let pb ← parseTerm b
    match pa, pb with
    | .bv at_ aw, .bv bt _bw =>
      return .pred (.binRel .ne aw at_ bt)
    | .pred at_, .pred bt =>
      -- distinct a b ↔ ¬(a ↔ b) ↔ (a ∧ ¬b) ∨ (¬a ∧ b)
      let nat_ ← negateTerm at_
      let nbt ← negateTerm bt
      return .pred (.or (.and at_ nbt) (.and nat_ bt))
    | _, _ => ParserM.throwError s!"distinct: mismatched types between arguments"

  | .expr [.atom "bvult", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvult")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvult")
    return .pred (.binRel .ult aw at_ bt)

  | .expr [.atom "bvule", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvule")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvule")
    return .pred (.binRel .ule aw at_ bt)

  | .expr [.atom "bvugt", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvugt")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvugt")
    return .pred (.binRel .ult aw bt at_)  -- swap

  | .expr [.atom "bvuge", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvuge")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvuge")
    return .pred (.binRel .ule aw bt at_)  -- swap

  | .expr [.atom "bvslt", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvslt")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvslt")
    return .pred (.binRel .slt aw at_ bt)

  | .expr [.atom "bvsle", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvsle")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvsle")
    return .pred (.binRel .sle aw at_ bt)

  | .expr [.atom "bvsgt", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvsgt")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvsgt")
    return .pred (.binRel .slt aw bt at_)  -- swap

  | .expr [.atom "bvsge", a, b] =>
    let (at_, aw) ← (← parseTerm a) |> expectBV (ctx := "bvsge")
    let (bt, _bw) ← (← parseTerm b) |> expectBV (ctx := "bvsge")
    return .pred (.binRel .sle aw bt at_)  -- swap

  -- Propositional connectives
  | .expr (.atom "and" :: args) =>
    if args.length < 2 then
      ParserM.throwError "and: expected at least 2 arguments"
    else
      let mut result ← expectPred (← parseTerm args.head!) (ctx := "and")
      for arg in args.tail! do
        let p ← expectPred (← parseTerm arg) (ctx := "and")
        result := .and result p
      return .pred result

  | .expr (.atom "or" :: args) =>
    if args.length < 2 then
      ParserM.throwError "or: expected at least 2 arguments"
    else
      let mut result ← expectPred (← parseTerm args.head!) (ctx := "or")
      for arg in args.tail! do
        let p ← expectPred (← parseTerm arg) (ctx := "or")
        result := .or result p
      return .pred result

  | .expr [.atom "not", a] =>
    let pa ← parseTerm a
    match pa with
    | .pred t => return .pred (← negateTerm t)
    | .bv _ _ => ParserM.throwError "'not' applied to bitvector term"

  | .expr [.atom "=>", a, b] =>
    -- a => b is equivalent to (not a) or b
    let pa ← expectPred (← parseTerm a) (ctx := "=>")
    let pb ← expectPred (← parseTerm b) (ctx := "=>")
    return .pred (.or (← negateTerm pa) pb)

  -- let bindings
  | .expr [.atom "let", .expr bindings, body] =>
    let st ← get
    let savedBindings := st.letBindings
    for binding in bindings do
      match binding with
      | .expr [.atom name, value] =>
        let pt ← parseTerm value
        modify fun s => { s with letBindings := s.letBindings.insert name pt }
      | _ => ParserM.throwError s!"malformed let binding: '{binding}'"
    let result ← parseTerm body
    -- Restore let bindings
    modify fun s => { s with letBindings := savedBindings }
    return result

  | other => ParserM.throwError s!"unsupported term: '{other}'"

/-- Process a single SMT2 command. Returns an optional assertion. -/
def processCommand (cmd : Sexp) : ParserM (Option Nondep.Term) := do
  match cmd with
  | .expr [.atom "set-logic", _] => return none
  | .expr [.atom "check-sat"] => return none
  | .expr [.atom "exit"] => return none

  -- (declare-const k Int) → register width variable
  | .expr [.atom "declare-const", .atom name, .atom "Int"] =>
    let _ ← registerWidthVar name
    return none

  -- (declare-const x (_ BitVec k)) → register term variable
  | .expr [.atom "declare-const", .atom name, sort] =>
    let w ← parseSortWidth sort
    let _ ← registerTermVar name w
    return none

  -- (declare-fun x () (_ BitVec k)) → register term variable
  | .expr [.atom "declare-fun", .atom name, .expr [], sort] =>
    let w ← parseSortWidth sort
    let _ ← registerTermVar name w
    return none

  -- (assert P) → parse and return assertion
  | .expr [.atom "assert", body] =>
    let pt ← parseTerm body
    let p ← expectPred pt (ctx := "assert")
    return some p

  | other => ParserM.throwError s!"unsupported command: '{other}'"

/-- Parse an SMT2 query string into a ParseResult. -/
def parseSmt2Query (input : String) : Except String ParseResult := do
  -- Parse S-expressions
  let sexps ← match Sexp.Parser.manySexps!.run input.trimAscii.toString with
    | .ok sexps => .ok sexps
    | .error e => .error s!"S-expression parse error: {e}"
  -- Process commands
  let initState : ParserState := {}
  match go sexps |>.run initState with
  | .ok assertions st =>
    if assertions.isEmpty then
      .error "no assertions found"
    else
      let conjoined := match assertions with
        | [] => Nondep.Term.pTrue  -- unreachable given the isEmpty check
        | [p] => p
        | p :: ps => ps.foldl (init := p) fun acc q => .and acc q
      -- Negate to match UNSAT semantics
      match conjoined.pnegate with
      | (negated, true) =>
        .ok {
          predicate := negated
          wcard := st.nextWidthIdx
          tcard := st.nextTermIdx
        }
      | _ => .error s!"cannot negate conjoined term: {repr conjoined}"
  | .error e _ => .error e
where
  go (cmds : List Sexp) : ParserM (List Nondep.Term) := do
    let mut assertions : List Nondep.Term := []
    for cmd in cmds do
      match ← processCommand cmd with
      | some p => assertions := assertions ++ [p]
      | none => pure ()
    return assertions

end Blasewuzla
