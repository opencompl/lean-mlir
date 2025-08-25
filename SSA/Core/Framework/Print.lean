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

/-- Format a list of formal arguments as `(%0 : t₀, %1 : t₁, ... %n : tₙ)` -/
private def formatFormalArgListTuple [Repr Ty] (ts : List Ty) : Format :=
  Format.paren <| Format.joinSep ((List.range ts.length).zip ts |>.map
    (fun it => f!"%{it.fst} : {repr it.snd}")) ", "

mutual
  /-- Convert a HVector of region arguments into a List of format strings. -/
  partial def reprRegArgsAux [Repr d.Ty] {ts : List (Ctxt d.Ty × d.Ty)}
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
        let outTy := DialectSignature.outTy op
        let argTys := DialectSignature.sig op
        let regArgs := Format.parenIfNonempty " (" ")" Format.line (reprRegArgsAux regArgs)
        f!"{repr op}{formatArgTuple args}{regArgs} : {formatTypeTuple argTys} → ({repr outTy})"

  /-- Format string for a Com, with the region parentheses and formal argument list. -/
  partial def Com.repr (prec : Nat) (com : Com d Γ eff t) : Format :=
    f!"\{" ++ Format.nest 2
    (Format.line ++
    "^entry" ++ Format.nest 2 ((formatFormalArgListTuple Γ.toList) ++ f!":" ++ Format.line ++
    (comReprAux prec com))) ++ Format.line ++
    f!"}"

  /-- Format string for sequence of assignments and return in a Com. -/
  partial def comReprAux (prec : Nat) : Com d Γ eff t → Format
    | .ret v => f!"return {reprPrec v prec} : ({repr t}) → ()"
    | .var e body =>
      f!"%{repr <| Γ.length} = {e.repr prec}" ++ Format.line ++
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

/-- Format a list of formal arguments as `(%0 : t₀, %1 : t₁, ... %n : tₙ)` -/
partial def formatFormalArgListTupleStr [ToString Ty] (ts : List Ty) : String :=
  let args := (List.range ts.length).zip ts |>.map
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
    let outTy : d.Ty := DialectSignature.outTy op
    let argTys := DialectSignature.sig op
    s!"{ToString.toString op}{formatArgTuple args} : {formatTypeTupleToString argTys} -> ({ToString.toString outTy})"

/-- This function recursivly converts the body of a `Com` into its string representation.
Each bound variable is printed with its index and corresponding expression. -/
partial def Com.ToStringBody : Com d Γ eff t → String
  | .ret v => s!"  \"return\"({_root_.repr v }) : ({toString t}) -> ()"
  | .var e body =>
    s!"  %{_root_.repr <|(Γ.length)} = {Expr.toString e }" ++ "\n" ++
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

/- # ToPrint instances for Com and Expr  -/
section ToPrint

open Std (Format)
variable {d} [ToPrint d][DialectSignature d] [Repr d.Op] [Repr d.Ty] [ToString d.Ty] [ToString d.Op]

/-- Format a list of formal arguments as `(%0 : t₀, %1 : t₁, ... %n : tₙ)` -/
partial def formatFormalArgListTuplePrint [ToString d.Ty] (ts : List d.Ty) : String :=
  let args := (List.range ts.length).zip ts |>.map
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
    let outTy : d.Ty := DialectSignature.outTy op
    let argTys := DialectSignature.sig op
    s!"\"{ToPrint.printOpName op}\"{formatArgTupleForPrint args}{ToPrint.printAttributes op} : {formatTypeTuplePrint argTys} -> ({ToPrint.printTy outTy})"

/--
  This function recursively converts the body of a `Com` into its string representation.
  Each bound variable is printed with its index and corresponding expression.
-/
partial def Com.toPrintBody : Com d Γ eff t → String
  | .ret v => s!"  \"{ToPrint.printReturn t}\"({_root_.repr v }) : ({ToPrint.printTy t}) -> ()"
  | .var e body =>
    s!"  %{_root_.repr <|(Γ.length)} = {Expr.toPrint e }" ++ "\n" ++
    Com.toPrintBody body

/--
  `Com.toPrint` implements a `ToPrint` instance for the type `Com`.
  This has a more general behaviour than `toString` and allows customizing the
  printing of dialect objects.
-/
partial def Com.toPrint (com : Com d Γ eff t) : String :=
   "builtin.module { \n"
  ++ ToPrint.printFunc t ++ ((formatFormalArgListTuplePrint Γ.toList)) ++ ":" ++ "\n"
  ++ (Com.toPrintBody com) ++
   "\n }"

end ToPrint
