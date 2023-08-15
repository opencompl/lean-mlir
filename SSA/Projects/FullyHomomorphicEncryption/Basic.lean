import Mathlib.RingTheory.Polynomial.Quotient
import SSA.Core.WellTypedFramework
import SSA.Projects.FullyHomomorphicEncryption.RNS

open Polynomial -- for R[X] notation

-- Basics from Junfeng Fan and Frederik Vercauteren, Somewhat Practical Fully Homomorphic Encryption
-- https://eprint.iacr.org/2012/144

variable (q t : Nat) [Fact (q > 1)] (n : Nat)

-- TODO: can we make this computable?
-- failed to compile definition, consider marking it as 'noncomputable' because it depends on 'Polynomial.add'', and it does not have executable code

-- Question: Can we make something like d := 2^n work as a macro?
noncomputable def f : (ZMod q)[X] := X^(2^n) + 1
abbrev R := (ZMod q)[X] ⧸ (Ideal.span {f q n})

-- Coefficients of `a : R' q n` are `a\_i : Zmod q`.
-- TODO: get this from mathlib
def R.coeff (a : R q n) (i : Nat) : ZMod q := sorry



-- TODO: get infinity norm from mathlib
--
--

namespace FV
namespace SH

def Delta : Nat := sorry -- (q.toFloat / t.toFloat).floor
def encrypt (pk : R q n) (m : Nat) : R q n := sorry -- ([p0 ·u+e1 +∆·m] ,[p1 ·u+e2])
def decrypt (sk : R q n) (ct : R q n) : Nat := sorry -- [ (t·[c0 +c1 ·s]q / q).ceil ]t
def add (ct1 ct2 : R q n) : R q n := sorry -- ([ct1 [0] + ct2 [0]]q , [ct1 [1] + ct2 [1]]q ) .

end SH
end FV

namespace NTT

-- should we use this instead?
-- https://github.com/madvorak/lean-fft/blob/main/NumberTheoreticTransform.lean

def baseFun {l : Nat} (T : Nat → Nat → Nat → Nat × Nat) (input : RNS (2^l)) : RNS (2^l) := Id.run do
  let w := 1
  let mut x := input
  for i in List.range l do
    let ζ := w^(2^i)
    let t := 2^(l-i-1)
    for j in List.range (2^i) do
      let n := 2*j*t
      for k in List.range t do
        let u := x.get (n + k)
        let v := x.get (n + k + t)
        let (u', v') := T u v ζ^k
        x := x.set (n + k) u'
        x := x.set (n + k + t) v'
  return x

def forward {l : Nat} : RNS (2^l) → RNS (2^l) := baseFun (fun x y u => (x + u*y, x - u*y))
def backward {l : Nat} : RNS (2^l) → RNS (2^l) := baseFun (fun x y u => (x + y, u*(x - y)))

end NTT
