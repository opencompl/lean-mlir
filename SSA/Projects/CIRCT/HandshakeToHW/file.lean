

inductive HVectorNormal : List (Type u) -> (Type (u + 1))
| nil : HVectorNormal []
| cons (t : Type u) (x : t) (rest : HVectorNormal ts) : HVectorNormal (t :: ts)

#check HVectorNormal
def foo : HVectorNormal [String, Int] := .cons String "foo" <| .cons Int 42 <| .nil

-- mlitty : Type
-- mlirty.denote : mlirty -> Type

inductive HVectorLeanMLIR (denote : mlirty → Type u) : List mlirty → Type u
| nil : HVectorLeanMLIR denote []
| cons (t : mlirty) (x : denote t) (rest : HVectorLeanMLIR denote ts) : HVectorLeanMLIR denote (t :: ts)
