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

/- # ToString instances for Com and Expr  -/
section ToString
variable {d} [DialectSignature d] [Repr d.Op] [Repr d.Ty] [ToString d.Ty] [ToString d.Op]

/-- Format a list of formal arguments as `(%0 : tₙ , ... %n : t₀)` -/
partial def formatFormalArgListTupleStr [ToString Ty] (ts : List Ty) : String :=
  let args := (List.range ts.length).zip ts.reverse |>.map
    (fun (i, t) => s!"%{i} : {toString t}")
  "(" ++ String.intercalate ", " args ++ ")"

-- Format a sequence of types as `(t₁, ..., tₙ)` using toString instances -/
private def formatTypeTupleToString [ToString Ty] (xs : List Ty) : String :=
  "(" ++ String.intercalate ", " (xs.map toString) ++ ")"

/--
Converts an expression to its string representation.
Assumes that `toString` instances exist for both the dialect's operations (`d.Op`)
and types (`d.Ty`). The output includes the operation name, argument list,
their types, and the resulting output type.
-/
partial def Expr.toString [ToString d.Op] : Expr d Γ eff t → String
  | Expr.mk (op : d.Op) _ _ args _regArgs =>
    let returnTypes := DialectSignature.returnTypes op
    let returnTypes := ", ".intercalate <| returnTypes.map ToString.toString
    let argTys := DialectSignature.sig op
    s!"{ToString.toString op}{formatArgTuple args} : {formatTypeTupleToString argTys} -> ({returnTypes})"

/-- This function recursivly converts the body of a `Com` into its string representation.
Each bound variable is printed with its index and corresponding expression. -/
partial def Com.ToStringBody : Com d Γ eff ts → String
  | .rets vs =>
    let vs := (vs.map fun _ v => s!"{_root_.repr v}").toListOf String (by intros; rfl)
    let vs := ", ".intercalate vs
    let ts := ", ".intercalate <| ts.map ToString.toString
    s!"  \"return\"({vs}) : ({ts}) -> ()"
  | .var e@⟨op, _ , _,_ , _⟩ body =>
    let vs := e.formatBoundVariables
    s!"  {vs} = {Expr.toString e}" ++ "\n" ++
    Com.ToStringBody body

/- `Com.toString` implements a toString instance for the type `Com`.  -/
partial def Com.toString (com : Com d Γ eff t) : String :=
   "{ \n"
  ++ "^entry" ++  ((formatFormalArgListTupleStr Γ.toList)) ++ ":" ++ "\n"
  ++ (Com.ToStringBody com) ++
   "\n }"

instance : ToString (Com d Γ eff t)  where toString := Com.toString
instance : ToString (Expr d Γ eff t) where toString := Expr.toString

end ToString

/-!
## DialectPrint infrastructure
-/

/--
ToPrint includes the functions to print the components of a dialect.
-/
class ToPrint (d : Dialect) where
  /-- Prints the operation in the dialect. -/
  printOpName : d.Op → String
  /-- Prints the type in the dialect. -/
  printTy : d.Ty → String
  /-- Prints the attributes of the operation. -/
  printAttributes : d.Op → String
  /-- Prints the name of the dialect. -/
  printDialect : String
  /-- Prints the return instruction of the dialect. -/
  printReturn : List d.Ty → String
  /-- Prints the function header of the dialect. -/
  printFunc : List d.Ty → String

section ToPrint

open Std (Format)
variable {d} [ToPrint d] [DialectSignature d] [Repr d.Op] [Repr d.Ty] [ToString d.Ty] [ToString d.Op]

/-- Format a list of formal arguments as `(%0 : tₙ , ... %n : t₀)` -/
partial def formatFormalArgListTuplePrint [ToString d.Ty] (ts : List d.Ty) : String :=
  let args := (List.range ts.length).zip ts.reverse |>.map
    (fun (i, t) => s!"%{i} : {ToPrint.printTy t}")
  "(" ++ String.intercalate ", " args ++ ")"

-- Format a sequence of types as `(t₁, ..., tₙ)` using toString instances -/
private def formatTypeTuplePrint [ToString d.Ty] (xs : List d.Ty) : String :=
  "(" ++ String.intercalate ", " (xs.map ToPrint.printTy) ++ ")"

/-- Parenthesize and separate with 'separator' if the list is nonempty, and return
the "()" if the list is empty. -/
private def Format.parenIfNonemptyForPrint (l : String) (r : String) (separator : Format)
    (xs : List Format) : Format :=
  match xs with
  | [] => "() "
  | _  =>  l ++ (Format.joinSep xs separator) ++ r

/-- Format a tuple of arguments as `a₁, ..., aₙ`. -/
private def formatArgTupleForPrint [Repr Ty] {Γ : List Ty}
    (args : HVector (fun t => Var Γ₂ t) Γ) : Format :=
  Format.parenIfNonemptyForPrint "(" ")" ", " (formatArgTupleAux args)
where
  formatArgTupleAux [Repr Ty] {Γ : List Ty} (args : HVector (fun t => Var Γ₂ t) Γ) : List Format :=
    match Γ with
    | .nil => []
    | .cons .. =>
      match args with
      | .cons a as => (repr a) :: (formatArgTupleAux as)

/--
Converts an expression within a dialect to its MLIR string representation.
Since MLIR generic syntax uses double quotes (`"..."`) to print operations, this function uses
the ToPrint typeclass of each dialect to print the various parts of an expressiom such as
operation and types. Lastly, it arranges the expression printing according to MLIR syntax.
-/
partial def Expr.toPrint [ToString d.Op] : Expr d Γ eff t → String
  | Expr.mk (op : d.Op) _ _ args _regArgs =>
    let returnTypes := DialectSignature.returnTypes op
    let returnTypes := ", ".intercalate <| returnTypes.map ToPrint.printTy
    let argTys := DialectSignature.sig op
    s!"\"{ToPrint.printOpName op}\"{formatArgTupleForPrint args}{ToPrint.printAttributes op} : {formatTypeTuplePrint argTys} -> ({returnTypes})"

/--
  This function recursively converts the body of a `Com` into its string representation.
  Each bound variable is printed with its index and corresponding expression.
-/
partial def Com.toPrintBody : Com d Γ eff ts → String
  | .rets vs =>
      let vs := (vs.map fun _ v => s!"{_root_.repr v}").toListOf String (by intros; rfl)
      let vs := ", ".intercalate vs
      let ret := ToPrint.printReturn ts
      let ts := ", ".intercalate <| ts.map ToPrint.printTy
      s!"  \"{ret}\"({vs}) : ({ts}) -> ()"
  | .var e body =>
    s!"  %{_root_.repr <|(Γ.length)} = {Expr.toPrint e }" ++ "\n" ++
    Com.toPrintBody body

/--
  `Com.toPrint` implements a `ToPrint` instance for the type `Com`.
  This has a more general behaviour than `toString` and allows customizing the
  printing of dialect objects.
-/
partial def Com.toPrint (com : Com d Γ eff ts) : String :=
   "builtin.module { \n"
  ++ ToPrint.printFunc ts ++ ((formatFormalArgListTuplePrint Γ.toList)) ++ ":" ++ "\n"
  ++ (Com.toPrintBody com) ++
   "\n }"

end ToPrint
