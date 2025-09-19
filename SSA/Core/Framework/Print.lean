import SSA.Core.Framework

/-!
# Core Datastructures Printing

This file defines `Repr` and `ToString` instances for the core data-structures
(`Expr`, `Com`, etc.)
-/

open Ctxt (Var)


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
  printFunc : List d.Ty → String := fun _ => "^entry"
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

mutual

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
  let regions :=
    match h : e.regArgs.length with
    | 0 => f!""
    | 1 =>
      let reg := e.regArgs.getN 0 (by grind)
      f!" ({reg.print})"
    | _ =>
      let regs :=
        e.regArgs.mapToList (Format.align true ++ Com.print ·)
        |> f!", ".joinSep
        |> Format.nest 2
      f!" ({regs})"
  let rhs := f!"\"{printOpName e.op}\"{e.printArgs}{printAttributes e.op}{regions} : {e.printType}"
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

end


/--
Print a `Com` in generic MLIR syntax, wrapped in an implicit `builtin.module`.
-/
partial def Com.printModule (com : Com d Γ eff ts) : Format :=
  f!"builtin.module {com.print}"

/-! ### ToString -/

instance : ToString (Com d Γ eff t)  where toString com  := s!"{com.print}"
instance : ToString (Expr d Γ eff t) where toString expr := s!"{expr.print}"

/-! ### Repr -/

instance : Repr (Com d Γ eff t)  where reprPrec com _  := com.print
instance : Repr (Expr d Γ eff t) where reprPrec expr _ := expr.print

def Lets.repr (prec : Nat) : Lets d eff Γ t → Format
    | .nil => .align false ++ f!";"
    | .var body e => body.repr prec ++ (.align false ++ f!"{e.print}")

instance : Repr (Lets d Γ eff t) where
  reprPrec lets prec := lets.repr prec

end DialectPrint
