import SSA.Core.Framework

/-!
# Core Datastructures Printing

This file defines `Repr` and `ToString` instances for the core data-structures
(`Expr`, `Com`, etc.)
-/

open Ctxt (Var)

/-! ### Repr instance -/
section Repr
open Std (Format)
variable {d} [DialectSignature d] [Repr d.Op] [Repr d.Ty]

/-- Parenthesize and separate with 'separator' if the list is nonempty, and return
the empty string otherwise. -/
private def Format.parenIfNonempty (l : String) (r : String) (separator : Format)
    (xs : List Format) : Format :=
  match xs with
  | [] => ""
  | _  =>  l ++ (Format.joinSep xs separator) ++ r

/-- Format a sequence of types as `(t₁, ..., tₙ)`. Will always display parentheses. -/
private def formatTypeTuple [Repr Ty] (xs : List Ty) : Format :=
  "("  ++ Format.joinSep (xs.map (fun t => Repr.reprPrec t 0)) ", " ++ ")"

/-- Format a tuple of arguments as `a₁, ..., aₙ`. -/
private def formatArgTuple [Repr Ty] {Γ : List Ty}
    (args : HVector (fun t => Var Γ₂ t) Γ) : Format :=
  Format.parenIfNonempty "(" ")" ", " (formatArgTupleAux args) where
  formatArgTupleAux [Repr Ty] {Γ : List Ty} (args : HVector (fun t => Var Γ₂ t) Γ) : List Format :=
    match Γ with
    | .nil => []
    | .cons .. =>
      match args with
      | .cons a as => (repr a) :: (formatArgTupleAux as)

/-- Format a list of formal arguments as `(%0 : tₙ , ... %n : t₀)` -/
private def formatFormalArgListTuple [Repr Ty] (ts : List Ty) : Format :=
  Format.paren <| Format.joinSep ((List.range ts.length).zip ts.reverse |>.map
    (fun it => f!"%{it.fst} : {repr it.snd}")) ", "

private def Expr.formatBoundVariables : Expr d Γ eff ts → String
  | ⟨op, _, _, _, _⟩ =>
    (DialectSignature.returnTypes op).length
    |> List.range
    |>.map (s!"%{· + Γ.length}")
    |> ", ".intercalate

mutual
  /-- Convert a HVector of region arguments into a List of format strings. -/
  partial def reprRegArgsAux [Repr d.Ty] {ts : RegionSignature d.Ty}
    (regArgs : HVector (fun t => Com d t.1 EffectKind.impure t.2) ts) : List Format :=
    match ts with
    | [] => []
    | _ :: _ =>
      match regArgs with
      | .cons regArg regArgs =>
        let regFmt := Com.repr 0 regArg
        let restFmt := reprRegArgsAux regArgs
        (regFmt :: restFmt)

  partial def Expr.repr (_ : Nat) : Expr d Γ eff t → Format
    | ⟨op, _, _, args, regArgs⟩ =>
        let returnTypes := DialectSignature.returnTypes op
        let argTys := DialectSignature.sig op
        let regArgs := Format.parenIfNonempty " (" ")" Format.line (reprRegArgsAux regArgs)
        f!"{repr op}{formatArgTuple args}{regArgs} : {formatTypeTuple argTys} → {formatTypeTuple returnTypes}"

  /-- Format string for a Com, with the region parentheses and formal argument list. -/
  partial def Com.repr (prec : Nat) (com : Com d Γ eff t) : Format :=
    f!"\{" ++ Format.nest 2
    (Format.line ++
    "^entry" ++ Format.nest 2 ((formatFormalArgListTuple Γ.toList) ++ f!":" ++ Format.line ++
    (comReprAux prec com))) ++ Format.line ++
    f!"}"

  /-- Format string for sequence of assignments and return in a Com. -/
  partial def comReprAux (prec : Nat) : Com d Γ eff t → Format
    | .rets vs =>
      let vs := (vs.map fun _ v => s!"{_root_.repr v}").toListOf String
      let vs := ", ".intercalate vs
      f!"return {vs} : {formatTypeTuple t} → ()"
    | .var e body =>
      let vs := e.formatBoundVariables
      f!"{vs} = {e.repr prec}" ++ Format.line ++
      comReprAux prec body
end

def Lets.repr (prec : Nat) : Lets d eff Γ t → Format
    | .nil => .align false ++ f!";"
    | .var body e => body.repr prec ++ (.align false ++ f!"{e.repr prec}")

instance : Repr (Expr d Γ eff t) := ⟨flip Expr.repr⟩
instance : Repr (Com d Γ eff t) := ⟨flip Com.repr⟩
instance : Repr (Lets d Γ eff t) := ⟨flip Lets.repr⟩

end Repr


/-!
## DialectPrint infrastructure
-/

/--
`DialectPrint d` tells us how to print programs in dialect `d`.

An instance of `DialectPrint d` implies instances of `Repr` for the
core LeanMLIR datastructures (e.g., `Com` and `Expr`)
instantiated to dialect `d`.
Additionally, we generate an instance of `ToString d.Ty`

Note: operations have different components which are printed differently (i.e.,
the operation name and the attributes), which is why `ToString d.Op` is not
granular enough.
-/
class DialectPrint (d : Dialect) where
  /--
  Print the name of an operation.

  NOTE: this should not contain any properties or attributes, those are
  printed separately.
  -/
  printOpName : d.Op → String
  /--
  Print the attributes of an operation.
  -/
  printAttributes : d.Op → String

  /--
  Prints the type in the dialect.
  -/
  printTy : d.Ty → String

  /-- The name of the dialect. -/
  dialectName : String
  -- ^^ TODO: `dialectName` seems unused

  /-- Prints the return instruction of the dialect. -/
  printReturn : List d.Ty → String
  /-- Prints the function header of the dialect. -/
  printFunc : List d.Ty → String
  -- TODO: ^^ `printFunc` seems to be used to print the name of the entry block,
  -- e.g., for LLVM, `printFunc` just returns `^bb0`. This doesn't feel like
  -- something which needs to be dialect-specific, rather, we should just
  -- hardcode this to be `^entry` or something like that.

section DialectPrint

open Std (Format)
open DialectPrint
variable {d} [DialectPrint d]

namespace DialectPrint

instance instToStringTy : ToString (Dialect.Ty d) where toString := printTy
instance instReprTy : Repr (Dialect.Ty d) where reprPrec t _ := printTy t

/--
Given the context `Γ` of a `Com`, print the arguments and their types of the
implicit entry block.

Note that argument names are not preserved by the parser, so simply number the
printed arguments according to their DeBruijn index.

For example, if the contex is `Γ := ⟨[i64, i32]⟩` then the expected output is:
  `(%0 : i32, %1 : i64)`
-/
partial def printBlockArgs (Γ : Ctxt d.Ty) : String :=
  let ts := Γ.toList
  let args := (List.range ts.length).zip ts.reverse |>.map
    (fun (i, t) => s!"%{i} : {printTy t}")
  "(" ++ String.intercalate ", " args ++ ")"

/--
Print a variable. Recall that variable names are *not* preserved by the parser.
Instead, while printing we implicitly number the variables in the order they are
defined in the program.

The number assigned to a variable is thus in a sense the *inverse* of its
DeBruijn index. This is by design, so that the variable number is constant
throughout the program, c.f. the DeBrijn index that refers to a specific
let-binding, which depends on where the reference occurs.
-/
def printVar {Γ : Ctxt d.Ty} (v : Γ.Var t) : Format :=
  f!"%{Γ.toList.length - v.val - 1}"

end DialectPrint


variable [DialectSignature d]

/--
Print the arguments to an expression as `($x, %y, %z, ...)`.

See `printVar` for details on how variables are printed.
-/
def Expr.printArgs (e : Expr d Γ eff t) : Format :=
  let args := e.args.mapToList printVar
  let args := Format.joinSep args ", "
  f!"({args})"

/--
Print the type of an expression, e.g., `(i64, i64) -> (i64)`.
-/
def Expr.printType (e : Expr d Γ eff ts) : Format :=
  let argTys := e.args.mapToList (@fun t _ => printTy t)
  let argTys := Format.group <| Format.joinSep argTys ", "
  let retTys := ts.map printTy
  let retTys := Format.group <| Format.joinSep retTys ", "
  f!"({argTys}) -> ({retTys})"

/--
Print the results of an expression, e.g., `%x =`.

Returns an empty string if the expression has no results.
-/
def Expr.printResultList (_e : Expr d Γ eff ts) : Format :=
  if ts.length = 0 then
    ""
  else
    let rs :=
      List.range ts.length
      |>.map (f!"%{· + Γ.length}")
      |> f!", ".joinSep
    f!"{rs} = "

/--
Print an `Expr` in generic MLIR syntax.

Note: this prints the entire let-binding, i.e.:
- The return variable binders
- The operation
- The arguments
- The attributes, and
- The type annotation
-/
partial def Expr.print (e : Expr d Γ eff t) : Format :=
  let rhs := f!"\"{printOpName e.op}\"{e.printArgs}{printAttributes e.op} : {e.printType}"
  Format.align true ++ f!"{e.printResultList}{rhs}"

/--
Recursively print a `Com` in generic MLIR syntax.
Each bound variable is printed with its index and corresponding expression.
-/
private partial def Com.printAux : Com d Γ eff ts → Format
  | .rets vs =>
      let vs :=
        vs.mapToList printVar
        |> (Format.joinSep · ", ") |> Format.group
      let ret := printReturn ts
      let ts :=
        ts.map printTy
        |> (Format.joinSep · ", ") |> Format.group
      Format.align true ++ f!"\"{ret}\"({vs}) : ({ts}) -> ()"
  | .var e body => e.print ++ Com.printAux body

/--
Print a `Com` in generic MLIR syntax.
-/
partial def Com.print (com : Com d Γ eff ts) : Format :=
  f!"\{\n"
  ++ (Format.nest 2 <|
    Format.align true ++ f!"{printFunc ts}{printBlockArgs Γ}:\n"
    ++ (Format.nest 2 com.printAux))
  ++ Format.align true ++ f!"}"

/--
Print a `Com` in generic MLIR syntax, wrapped in an implicit `builtin.module`.
-/
partial def Com.printModule (com : Com d Γ eff ts) : Format :=
  f!"builtin.module {com.print}"

instance : ToString (Com d Γ eff t)  where toString com  := s!"{com.print}"
instance : ToString (Expr d Γ eff t) where toString expr := s!"{expr.print}"

end DialectPrint
