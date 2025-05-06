import SSA.Core.Framework
import SSA.Core.Util
import SSA.Core.Util.ConcreteOrMVar

variable (sum : Dialect) [TyDenote (Dialect.Ty sum)] [DialectSignature sum][DialectDenote sum]

inductive Op where
  | builtin.unrealized_conversion_cast : Op
  | op :  (Dialect.Op sum) -> Op

inductive Ty where
  |ty : (Dialect.Ty sum) -> Ty

abbrev WCDialect (sum : Dialect) : Dialect where
  Ty := Ty sum
  Op := Op sum  -- I don't know how to add them

instance : TyDenote (Dialect.Ty (WCDialect sum)) where
  toType := fun
    | .ty sumty => TyDenote.toType (sumty)

instance WCSignature : DialectSignature (WCDialect sum) where
  signature
  | .op sumop => .ty <$> DialectSignature.signature sumop
  | .builtin.unrealized_conversion_cast => sorry  -- unsure about the case signature

instance : DialectDenote (WCDialect sum) where
  denote
  | .op (sumop) => sorry
  | .builtin.unrealized_conversion_cast  => sorry
