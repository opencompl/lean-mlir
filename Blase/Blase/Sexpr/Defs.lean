import Lean

open Lean

/-- Type of S-expressions -/
inductive Sexpr
| atom (a : Format)
| array (ss : Array Sexpr)

def Sexpr.ofString (s : String) : Sexpr :=
  Sexpr.atom (format s)

def Sexpr.atomOf {α : Type} [ToFormat α] (x : α) : Sexpr :=
  Sexpr.atom (format x)

/-- Convert an s-expression into a format string. -/
def Sexpr.toFormat : Sexpr → Format
| .atom a => a
| .array as => (as.map Sexpr.toFormat) |>.toList |> fun l => Format.joinSep l " "  |>.paren

instance : ToFormat Sexpr where
  format := Sexpr.toFormat

class ToSexpr (α : Type _) where
  toSexpr : α → Sexpr

instance : ToSexpr Sexpr where
  toSexpr s := s
