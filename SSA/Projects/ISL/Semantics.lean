import Lean

/-!
## Basic Semantics of a dialect with register read/writes
-/

namespace LeanMLIR.ISL

/-- The number of registers we have -/
def RegFile.numRegisters := 32

/-- The width of the value at each register -/
def RegFile.registerWidth := 64

/-
TODO: in reality different types of registers may have different widths, but
for now we simplify by just modelling regular registers and ignoring any
vector shenanigans.
-/

def RegIndex := Fin RegFile.numRegisters

structure RegFile where
  regs : Vector (BitVec RegFile.registerWidth) RegFile.numRegisters

-- -----------------------------------------------------------------------------

namespace RegFile

/-! ## Register Read & Write -/

def read (self : RegFile) (r : RegIndex) : BitVec registerWidth :=
  self.regs[r.val]

def write (self : RegFile) (r : RegIndex) (v : BitVec registerWidth) : RegFile :=
  RegFile.mk <| self.regs.set r.val v

end RegFile

namespace RegIndex

local macro "inherit" : term => `(by unfold RegIndex; infer_instance)
instance : DecidableEq RegIndex := inherit
instance : Repr RegIndex := inherit
instance : Lean.ToExpr RegIndex := inherit

end RegIndex
