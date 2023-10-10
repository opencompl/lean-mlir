import SSA.Core.Framework
import SSA.Projects.InstCombine.LLVM.Transform

namespace MLIR

/-!
  ## Instantiation
  Finally, we show how to instantiate a family of programs to a concrete program
-/

class TransformDialectInstantiate (Op : Type) (φ : Nat) (Ty MOp MTy : outParam Type)
    [OpSignature Op Ty] [AST.TransformDialect MOp MTy φ] where
  morphism : Vector Nat φ → DialectMorphism MOp Op


set_option linter.unusedVariables false -- linter gives a false positive for `φ` in `[∀ φ, ...]`

variable (Op) (φ) {Ty} {MOp MTy} [OpSignature Op Ty]
  [AST.TransformDialect MOp MTy φ]
  [inst : TransformDialectInstantiate Op φ Ty MOp MTy] 
  [DecidableEq MTy]

-- def _root_.InstCombine.MTy.instantiate (vals : Vector Nat φ) : Ty → InstCombine.Ty
--   | .bitvec w => .bitvec <| .concrete <| w.instantiate vals

-- def _root_.InstCombine.MOp.instantiate (vals : Vector Nat φ) : MOp φ → InstCombine.Op
--   | .and w => .and (w.instantiate vals)
--   | .or w => .or (w.instantiate vals)
--   | .not w => .not (w.instantiate vals)
--   | .xor w => .xor (w.instantiate vals)
--   | .shl w => .shl (w.instantiate vals)
--   | .lshr w => .lshr (w.instantiate vals)
--   | .ashr w => .ashr (w.instantiate vals)
--   | .urem w => .urem (w.instantiate vals)
--   | .srem w => .srem (w.instantiate vals)
--   | .select w => .select (w.instantiate vals)
--   | .add w => .add (w.instantiate vals)
--   | .mul w => .mul (w.instantiate vals)
--   | .sub w => .sub (w.instantiate vals)
--   | .neg w => .neg (w.instantiate vals)
--   | .copy w => .copy (w.instantiate vals)
--   | .sdiv w => .sdiv (w.instantiate vals)
--   | .udiv w => .udiv (w.instantiate vals)
--   | .icmp c w => .icmp c (w.instantiate vals)
--   | .const w val => .const (w.instantiate vals) val

-- def MOp.instantiateCom (vals : Vector Nat φ) : DialectMorphism (MOp φ) (InstCombine.Op) where
--   mapOp := MOp.instantiate vals
--   mapTy := MTy.instantiate vals
--   preserves_signature op := by
--     simp only [MTy.instantiate, MOp.instantiate, ConcreteOrMVar.instantiate, (· <$> ·), signature, 
--       InstCombine.MOp.sig, InstCombine.MOp.outTy, Function.comp_apply, List.map, Signature.mk.injEq, 
--       true_and]
--     cases op <;> simp only [List.map, and_self, List.cons.injEq]

def AST.mkComInstantiate (reg : AST.Region φ) : 
    AST.ExceptM MOp (Vector Nat φ → Σ (Γ : Ctxt Ty) (ty : Ty), ICom Op Γ ty) := do
  let ⟨Γ, ty, icom⟩ ← AST.mkCom MOp reg  
  return fun vals =>
    let f := inst.morphism vals
    ⟨Γ.map f.mapTy, f.mapTy ty, icom.map f⟩

end MLIR