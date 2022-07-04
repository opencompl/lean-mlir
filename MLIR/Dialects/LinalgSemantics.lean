/-
## `linalg` dialect

This file formalises part of the `linalg` dialect. 
The key concepts we model are that of parallel loops with lower
and upper bounds as described by linalg.

-/

import MLIR.Semantics.Fitree
import MLIR.Semantics.Semantics
import MLIR.Semantics.SSAEnv
import MLIR.Semantics.UB
import MLIR.Dialects.BuiltinModel
import MLIR.Util.Metagen
import MLIR.AST
import MLIR.EDSL
open MLIR.AST

/-
### Dialect extensions

`linalg` has no extended types or attributes.
-/

instance linalg: Dialect Void Void (fun x => Unit) where
  iα := inferInstance
  iε := inferInstance

/-
### Dialect operations
-/

inductive LinalgE: Type → Type :=
| GenericParallel: LinalgE (RankedTensor D τ) 
  

def List.tailList (xs: List α): List α :=
  match xs with 
  | [] => []
  | (x::xs') => xs'

-- snoc is 'cons' at the end / 'cons' on the reverse of the list.
def List.snoc (xs: List α) (a: α): List α := 
  match xs with 
  | [] => [a]
  | (x::xs') => x::(xs'.snoc a)

def zip_same_size (xs: List α) (ys: List β): Option (List (α × β)) :=
 match xs with 
 | [] => match ys with 
         | [] => .some []
         | _ => .none
 | (x::xs') => match ys with 
         | [] => .none
         | (y::ys') => (zip_same_size xs' ys').map (fun zipped => (x,y)::zipped)

def List.sum (xs: List Nat): Nat := 
  xs.foldl (fun x y => x + y) 0

def List.pointwiseMul (xys: List (Nat × Nat)): List Nat := 
  xys.map (fun xy => xy.fst * xy.snd) 

-- xs[α] for xs of shape 10: α
-- xs[α][β] for xs of shape 40x50: α*50 + β * 1 ~= [50, 1] *+ [α, β]
def index (shape: List Nat) (ix: List Nat): Option Nat := 
  let zippedOption := zip_same_size (shape.tailList.snoc 1) ix
  zippedOption.map (List.sum ∘ List.pointwiseMul)

def listTensorToTypedArgs [δ: Dialect α σ ε] [CoeDialect builtin δ]:
  List (Tensor τ) → List ((τ: MLIRType δ) × τ.eval)
| [] => []
| t::ts => ⟨builtin.tensor_unranked τ, sorry⟩ :: listTensorToTypedArgs ts


-- TODO: how do I write the semantics for this in a way that 
-- I can get access to the `tensor` type?
def linalg_parallel_iter [CoeDialect builtin Δ]
   (ts: List (Tensor τ))
   (iter_vec: List Nat):
     Fitree ((RegionE Δ) +' UBE +' LinalgE)
            (BlockResult Δ) := do
 let ts' := ts.mapM (fun t => 
   (index t.shape iter_vec).map (fun ix => t.data.get? ix)
 )
 let result <- Fitree.trigger (RegionE.RunRegion (Δ := Δ) (ix := 0) 
   (args := listTensorToTypedArgs ts))
 return BlockResult.Ret []

def linalg_parallel (ts: List (Tensor τ)):
   Fitree (RegionE Δ +' UBE +' LinalgE) (BlockResult Δ) :=  sorry
  
  

-- def toy_semantics_op (ret_name: Option SSAVal) (op: Op builtin):
-- | TODO: we need a way to say that `builtin` is a member of Gδ
def linalg_semantics_op: IOp Δ →
      Option (Fitree (RegionE Δ +' UBE +' LinalgE) (BlockResult Δ))
  | IOp.mk "linalg.generic" [⟨.i32, lo⟩, ⟨.i32, hi⟩, ⟨.i32, step⟩] [] 1 _ _ => some do
    let nsteps : Int := ((FinInt.toSint'  hi) - (FinInt.toSint' lo)) / FinInt.toSint' step
    pure $ BlockResult.Next ⟨MLIRType.unit, ()⟩
  | _ => none
/-
Hook to provide a custom AffineMap used to construct the
hyperrectangular loop iteration space given all the operand subshapes.
This is used to answer the question:
"Given a list of operand ranges, what is the subportion of the iteration
space involved in the computation".
This is the inverse problem of `getLoopsToShapesMap`.
Return the empty AffineMap when such an AffineMap cannot be constructed.
The default behavior is based on a very simple inference procedure that
only works with permutation affine maps.
A more advanced Tensor-Comprehension like inference is possible but has
proven to be ambiguous in unfavorable case.
A safer and more robust alternative is to allow each op to define
its own AffineMap.
-/

#check RankedTensor
def LinalgE.handle [δ: Dialect α σ ε] {E}: LinalgE ~> Fitree E := fun T e =>
   match e with 
    | .GenericParallel => sorry
/-
def ArithE.handle {E}: ArithE ~> Fitree E := fun _ e =>
  match e with
  | AddI sz lhs rhs =>
      return (lhs + rhs)
  | AddT sz D lhs rhs =>
      -- TODO: Implementation of ArithE.AddT (tensor addition)
      return default
  | AddV sz sc fx lhs rhs =>
      -- TODO: Implementation of ArithE.AddV (vector addition)
      return default
  | CmpI sz pred lhs rhs =>
      let b: Bool :=
        match pred with
        | .eq  => lhs = rhs
        | .ne  => lhs != rhs
        | .slt => lhs.toSint <  rhs.toSint
        | .sle => lhs.toSint <= rhs.toSint
        | .sgt => lhs.toSint >  rhs.toSint
        | .sge => lhs.toSint >= rhs.toSint
        | .ult => lhs.toUint <  rhs.toUint
        | .ule => lhs.toUint <= rhs.toUint
        | .ugt => lhs.toUint >  rhs.toUint
        | .uge => lhs.toUint >= rhs.toUint
      return FinInt.ofInt .Signless 1 (if b then 1 else 0)

instance: Semantics arith where
  E := ArithE
  semantics_op := arith_semantics_op
  handle := ArithE.handle

/-
### Basic examples
-/

private def cst1: BasicBlock arith := [mlir_bb|
  ^bb:
    %true = "arith.constant" () {value = 1: i1}: () -> i1
    %false = "arith.constant" () {value = 0: i1}: () -> i1
    %r1 = "arith.constant" () {value = 25: i32}: () -> i32
    %r2 = "arith.constant" () {value = 17: i32}: () -> i32
    %r = "arith.addi" (%r1, %r2): (i32, i32) -> i32
    %b1 = "arith.cmpi" (%r, %r1) {predicate = 5 /- sge -/}: (i32, i32) -> i1
    %b2 = "arith.cmpi" (%r2, %r) {predicate = 8 /- ugt -/}: (i32, i32) -> i1
]

#eval run ⟦cst1⟧ (SSAEnv.empty (δ := arith))


/-
### Theorems
-/

private def add1: BasicBlockStmt arith := [mlir_bb_stmt|
  %r = "arith.addi"(%n, %m): (i32, i32) -> i32
]
private def add2: BasicBlockStmt arith := [mlir_bb_stmt|
  %r = "arith.addi"(%m, %n): (i32, i32) -> i32
]

theorem add_commutative:
  forall (n m: FinInt 32),
    run ⟦add1⟧ [[ ("n", ⟨.i32, n⟩), ("m", ⟨.i32, m⟩) ]] =
    run ⟦add2⟧ [[ ("n", ⟨.i32, n⟩), ("m", ⟨.i32, m⟩) ]] := by
  intros n m
  simp [Denote.denote]
  simp [run, semantics_bbstmt, semantics_op!, Semantics.semantics_op]
  simp [arith_semantics_op, Semantics.handle, add1, add2]
  simp [interp_ub!]; simp_itree
  simp [interp_ssa]; simp_itree
  rw [FinInt.add_comm]
-/
