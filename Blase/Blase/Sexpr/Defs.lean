/-- Type of S-expressions -/

inductive Sexpr 
| atom (a : Format)
| array (ss : Array Sexpr)


/-- Convert an s-expression into a format string. -/
def Sexpr.toFormat : Sexpr → Format
| .atom a => a
| .array as => as.map Sexpr.toFormat |>.sepWith " " |>.delimit "(" ")"

instance : ToFormat Sexpr where
  toFormat := Sexpr.toFormat
