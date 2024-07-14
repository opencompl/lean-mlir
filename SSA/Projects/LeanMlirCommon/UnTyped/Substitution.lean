import SSA.Projects.LeanMlirCommon.UnTyped.Basic

namespace MLIR.UnTyped

def Substitution : Type := List (VarName × VarName)

/-- Remove all substitutions of variable `v` (i.e., where `v` is the variable being replaced) from
the substitution `σ` -/
def Substitution.removeMappingFor (σ : Substitution) (v : VarName) : Substitution :=
  List.filter (·.fst != v) σ

/-- Apply a substution `σ` to a variable `v`, returning the `v` unchanged if the `σ` does not define
a mapping for `v` -/
def Substitution.apply (σ : Substitution) (v : VarName) : VarName :=
  match σ.lookup v with
    | some w => w
    | none => v

class SubstituteableTerminator (T : Type u) where
  substituteTerminator (σ : VarName → VarName) : T → T

mutual

open SubstituteableTerminator (substituteTerminator)
variable {Op T} [SubstituteableTerminator T]

def Expr.substitute (σ : Substitution) : Expr Op T → Expr Op T
  | ⟨varName, op, args, regions⟩ =>
      let σ' := σ.removeMappingFor varName
      ⟨varName, op, σ'.apply <$> args, subRegions σ' regions⟩
  -- HACK: `subRegions` is a specialization of `List.map`, but it's needed for the terminator
  -- checker to be happy.
  where subRegions (σ' : Substitution) : List (Region Op T) → List (Region Op T)
    | []    => []
    | r::rs => r.substitute σ' :: subRegions σ' rs

def Lets.substitute (σ : Substitution) : Lets Op T → Lets Op T
  | ⟨ls⟩    => ⟨go ls⟩
  where go : List (Expr Op T) → List (Expr Op T)
    | [] => []
    | l::ls => l.substitute σ :: go ls

def Body.substitute (σ : Substitution) : Body Op T → Body Op T
  | ⟨lets, terminator⟩ => ⟨lets.substitute σ, substituteTerminator σ.apply terminator⟩

def BasicBlock.substitute (σ : Substitution) : BasicBlock Op T → BasicBlock Op T
  | ⟨label, args, program⟩ =>
      let σ' := args.foldl Substitution.removeMappingFor σ
      ⟨label, args, program.substitute σ'⟩

def Region.substitute (σ : Substitution) : Region Op T → Region Op T
  | ⟨entry, blocks⟩ => ⟨entry, subBlocks blocks⟩
  where subBlocks : List (BasicBlock Op T) → List (BasicBlock Op T)
    | []    => []
    | b::bs => b.substitute σ :: subBlocks bs

end
