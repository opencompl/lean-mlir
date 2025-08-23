⚠ [1090/1102] Replayed SSA.Projects.LLVMRiscV.PeepholeRefine
warning: SSA/Projects/LLVMRiscV/PeepholeRefine.lean:57:4: declaration uses 'sorry'
✖ [1093/1110] Building SSA.Projects.LLVMRiscV.Pipeline.ReconcileCast (200ms)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/ReconcileCast.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/ReconcileCast.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/ReconcileCast.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/ReconcileCast.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/ReconcileCast.setup.json --json
info: stderr:
failed to load header from /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/ReconcileCast.setup.json: offset 0: unexpected end of input
error: Lean exited with code 1
ℹ [1094/1110] Replayed SSA.Projects.LLVMRiscV.Pipeline.sext
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
ℹ [1096/1110] Replayed SSA.Projects.LLVMRiscV.Pipeline.urem
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    urem_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    urem_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, urem_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, urem_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          urem_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        urem_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: final right-hand-side of equality is: Γv
    ⟨1,
      urem_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
ℹ [1097/1110] Replayed SSA.Projects.LLVMRiscV.Pipeline.xor
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    xor_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    xor_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, xor_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, xor_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          xor_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        xor_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: final right-hand-side of equality is: Γv
    ⟨1,
      xor_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
ℹ [2218/2256] Built SSA.Projects.LLVMRiscV.Pipeline.rem (10s)
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    rem_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    rem_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, rem_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, rem_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          rem_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        rem_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: final right-hand-side of equality is: Γv
    ⟨1,
      rem_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
✔ [2219/2256] Built SSA.Projects.LLVMRiscV.Pipeline.rem:c.o (1.2s)
ℹ [2220/2256] Built SSA.Projects.LLVMRiscV.Pipeline.srl (14s)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    srl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    srl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, srl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, srl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          srl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        srl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: final right-hand-side of equality is: Γv
    ⟨1,
      srl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    srl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    srl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, srl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, srl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          srl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        srl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: final right-hand-side of equality is: Γv
    ⟨1,
      srl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
⚠ [2222/2256] Built SSA.Projects.LLVMRiscV.Pipeline.udiv (14s)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    udiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    udiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          udiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: final right-hand-side of equality is: Γv
    ⟨1,
      udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    udiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    udiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          udiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: final right-hand-side of equality is: Γv
    ⟨1,
      udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    udiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    udiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          udiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: final right-hand-side of equality is: Γv
    ⟨1,
      udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
warning: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:67:4: declaration uses 'sorry'
warning: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:85:4: declaration uses 'sorry'
⚠ [2224/2256] Built SSA.Projects.LLVMRiscV.Pipeline.sdiv (15s)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sdiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sdiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sdiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: final right-hand-side of equality is: Γv
    ⟨1,
      sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sdiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sdiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sdiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: final right-hand-side of equality is: Γv
    ⟨1,
      sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sdiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sdiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sdiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: final right-hand-side of equality is: Γv
    ⟨1,
      sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
warning: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:67:4: declaration uses 'sorry'
ℹ [2225/2256] Built SSA.Projects.LLVMRiscV.Pipeline.and (16s)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    and_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    and_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          and_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: final right-hand-side of equality is: Γv
    ⟨1,
      and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    and_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    and_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          and_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: final right-hand-side of equality is: Γv
    ⟨1,
      and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    and_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    and_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          and_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: final right-hand-side of equality is: Γv
    ⟨1,
      and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    and_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    and_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          and_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: final right-hand-side of equality is: Γv
    ⟨1,
      and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    and_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    and_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          and_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: final right-hand-side of equality is: Γv
    ⟨1,
      and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
✔ [2226/2256] Built SSA.Projects.LLVMRiscV.Pipeline.sdiv:c.o (789ms)
✔ [2227/2256] Built SSA.Projects.LLVMRiscV.Pipeline.and:c.o (1.3s)
ℹ [2228/2256] Built SSA.Projects.LLVMRiscV.Pipeline.zext (18s)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
✖ [2229/2256] Building SSA.Projects.LLVMRiscV.Pipeline.zext:c.o (278ms)
trace: .> /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang -c -o /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/zext.c.o.export /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/zext.c -I /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include -fstack-clash-protection -fwrapv -fPIC -fvisibility=hidden -Wno-unused-command-line-argument --sysroot /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06 -nostdinc -isystem /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include/clang -O3 -DNDEBUG -DLEAN_EXPORTING
info: stderr:
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace, preprocessed source, and associated run script.
Stack dump:
0.	Program arguments: /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang -c -o /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/zext.c.o.export /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/zext.c -I /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include -fstack-clash-protection -fwrapv -fPIC -fvisibility=hidden -Wno-unused-command-line-argument --sysroot /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06 -nostdinc -isystem /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include/clang -O3 -DNDEBUG -DLEAN_EXPORTING
1.	<unknown> parser at unknown location
2.	Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  libLLVM.so.19.1      0x00007fe04fbae468 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 40
1  libLLVM.so.19.1      0x00007fe04fbac0de llvm::sys::RunSignalHandlers() + 238
2  libLLVM.so.19.1      0x00007fe04fbaeb3f
3  libc.so.6            0x00007fe04ec45330
4  libclang-cpp.so.19.1 0x00007fe0541f7d0d clang::SrcMgr::LineOffsetMapping::get(llvm::MemoryBufferRef, llvm::BumpPtrAllocatorImpl<llvm::MallocAllocator, 4096ul, 4096ul, 128ul>&) + 173
5  libclang-cpp.so.19.1 0x00007fe0541f809e clang::SourceManager::getLineNumber(clang::FileID, unsigned int, bool*) const + 350
6  libclang-cpp.so.19.1 0x00007fe0541f7b4d clang::SourceManager::getPresumedLoc(clang::SourceLocation, bool) const + 301
7  libclang-cpp.so.19.1 0x00007fe0541f0e7c clang::SourceLocation::print(llvm::raw_ostream&, clang::SourceManager const&) const + 44
8  libclang-cpp.so.19.1 0x00007fe05461d482 clang::PrettyDeclStackTraceEntry::print(llvm::raw_ostream&) const + 50
9  libLLVM.so.19.1      0x00007fe04fb338e4
10 libLLVM.so.19.1      0x00007fe04fbac0ac llvm::sys::RunSignalHandlers() + 188
11 libLLVM.so.19.1      0x00007fe04fbad8ef llvm::sys::CleanupOnSignal(unsigned long) + 255
12 libLLVM.so.19.1      0x00007fe04fafa8f9
13 libc.so.6            0x00007fe04ec45330
14 libclang-cpp.so.19.1 0x00007fe0542d3088 clang::Lexer::LexTokenInternal(clang::Token&, bool) + 104
15 libclang-cpp.so.19.1 0x00007fe05433ff0d clang::Preprocessor::Lex(clang::Token&) + 45
16 libclang-cpp.so.19.1 0x00007fe0543ae7ae clang::Parser::ParseExpressionList(llvm::SmallVectorImpl<clang::Expr*>&, llvm::function_ref<void ()>, bool, bool) + 638
17 libclang-cpp.so.19.1 0x00007fe0543a4826 clang::Parser::ParsePostfixExpressionSuffix(clang::ActionResult<clang::Expr*, true>) + 5702
18 libclang-cpp.so.19.1 0x00007fe0543a62c6 clang::Parser::ParseCastExpression(clang::Parser::CastParseKind, bool, bool&, clang::Parser::TypeCastState, bool, bool*) + 2518
19 libclang-cpp.so.19.1 0x00007fe0543a1003 clang::Parser::ParseAssignmentExpression(clang::Parser::TypeCastState) + 195
20 libclang-cpp.so.19.1 0x00007fe0543a0f29 clang::Parser::ParseExpression(clang::Parser::TypeCastState) + 9
21 libclang-cpp.so.19.1 0x00007fe054412331 clang::Parser::ParseExprStatement(clang::Parser::ParsedStmtContext) + 49
22 libclang-cpp.so.19.1 0x00007fe054410021 clang::Parser::ParseStatementOrDeclarationAfterAttributes(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*, clang::ParsedAttributes&, clang::ParsedAttributes&) + 1505
23 libclang-cpp.so.19.1 0x00007fe05440f7fa clang::Parser::ParseStatementOrDeclaration(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*) + 330
24 libclang-cpp.so.19.1 0x00007fe05441a001 clang::Parser::ParseCompoundStatementBody(bool) + 2209
25 libclang-cpp.so.19.1 0x00007fe054411167 clang::Parser::ParseStatementOrDeclarationAfterAttributes(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*, clang::ParsedAttributes&, clang::ParsedAttributes&) + 5927
26 libclang-cpp.so.19.1 0x00007fe05440f7fa clang::Parser::ParseStatementOrDeclaration(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*) + 330
27 libclang-cpp.so.19.1 0x00007fe054412210 clang::Parser::ParseLabeledStatement(clang::ParsedAttributes&, clang::Parser::ParsedStmtContext) + 768
28 libclang-cpp.so.19.1 0x00007fe05441013e clang::Parser::ParseStatementOrDeclarationAfterAttributes(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*, clang::ParsedAttributes&, clang::ParsedAttributes&) + 1790
29 libclang-cpp.so.19.1 0x00007fe05440f7fa clang::Parser::ParseStatementOrDeclaration(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*) + 330
30 libclang-cpp.so.19.1 0x00007fe05441a001 clang::Parser::ParseCompoundStatementBody(bool) + 2209
31 libclang-cpp.so.19.1 0x00007fe05441af87 clang::Parser::ParseFunctionStatementBody(clang::Decl*, clang::Parser::ParseScope&) + 167
32 libclang-cpp.so.19.1 0x00007fe054436a8e clang::Parser::ParseFunctionDefinition(clang::ParsingDeclarator&, clang::Parser::ParsedTemplateInfo const&, clang::Parser::LateParsedAttrList*) + 4030
33 libclang-cpp.so.19.1 0x00007fe0543629fc clang::Parser::ParseDeclGroup(clang::ParsingDeclSpec&, clang::DeclaratorContext, clang::ParsedAttributes&, clang::Parser::ParsedTemplateInfo&, clang::SourceLocation*, clang::Parser::ForRangeInit*) + 6764
34 libclang-cpp.so.19.1 0x00007fe0544358d7 clang::Parser::ParseDeclOrFunctionDefInternal(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec&, clang::AccessSpecifier) + 983
35 libclang-cpp.so.19.1 0x00007fe054435300 clang::Parser::ParseDeclarationOrFunctionDefinition(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec*, clang::AccessSpecifier) + 576
36 libclang-cpp.so.19.1 0x00007fe0544344ed clang::Parser::ParseExternalDeclaration(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec*) + 1997
37 libclang-cpp.so.19.1 0x00007fe0544326b3 clang::Parser::ParseTopLevelDecl(clang::OpaquePtr<clang::DeclGroupRef>&, clang::Sema::ModuleImportState&) + 1459
38 libclang-cpp.so.19.1 0x00007fe05434846e clang::ParseAST(clang::Sema&, bool, bool) + 830
39 libclang-cpp.so.19.1 0x00007fe0566b9b96 clang::FrontendAction::Execute() + 86
40 libclang-cpp.so.19.1 0x00007fe056630614 clang::CompilerInstance::ExecuteAction(clang::FrontendAction&) + 996
41 libclang-cpp.so.19.1 0x00007fe0567358fe clang::ExecuteCompilerInvocation(clang::CompilerInstance*) + 894
42 clang                0x000063e9dad3c1ef cc1_main(llvm::ArrayRef<char const*>, char const*, void*) + 5759
43 clang                0x000063e9dad39080
44 libclang-cpp.so.19.1 0x00007fe05629afd9
45 libLLVM.so.19.1      0x00007fe04fafa6d8 llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>) + 136
46 libclang-cpp.so.19.1 0x00007fe05629a855 clang::driver::CC1Command::Execute(llvm::ArrayRef<std::__1::optional<llvm::StringRef>>, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char>>*, bool*) const + 325
47 libclang-cpp.so.19.1 0x00007fe05625ee98 clang::driver::Compilation::ExecuteCommand(clang::driver::Command const&, clang::driver::Command const*&, bool) const + 1000
48 libclang-cpp.so.19.1 0x00007fe05625f11e clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&, llvm::SmallVectorImpl<std::__1::pair<int, clang::driver::Command const*>>&, bool) const + 126
49 libclang-cpp.so.19.1 0x00007fe05627c78c clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&, llvm::SmallVectorImpl<std::__1::pair<int, clang::driver::Command const*>>&) + 348
50 clang                0x000063e9dad38623 clang_main(int, char**, llvm::ToolContext const&) + 5971
51 clang                0x000063e9dad45a77 main + 87
52 libc.so.6            0x00007fe04ec2a1ca
53 libc.so.6            0x00007fe04ec2a28b __libc_start_main + 139
54 clang                0x000063e9dad36b9e _start + 46
/home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/zext.c:3535:96: parsing function body '_init_l_llvm__zext__lower__riscv__i8__to__i16___expr__def__1___closed__9'
3.	/home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/zext.c:3535:96: in compound statement ('{}')
4.	/home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/zext.c:3537:1: in compound statement ('{}')
clang: error: clang frontend command failed with exit code 135 (use -v to see invocation)
clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin
clang: note: diagnostic msg: 
********************

PLEASE ATTACH THE FOLLOWING FILES TO THE BUG REPORT:
Preprocessed source(s) and associated run script(s) are located at:
clang: note: diagnostic msg: /tmp/zext-08ca21.c
clang: note: diagnostic msg: /tmp/zext-08ca21.sh
clang: note: diagnostic msg: 

********************
error: external command '/home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang' exited with code 1
ℹ [2230/2256] Built SSA.Projects.LLVMRiscV.Pipeline.or (22s)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
ℹ [2232/2256] Built SSA.Projects.LLVMRiscV.Pipeline.ashr (25s)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
✔ [2233/2256] Built SSA.Projects.LLVMRiscV.Pipeline.ashr:c.o (70ms)
ℹ [2234/2256] Built SSA.Projects.LLVMRiscV.Pipeline.select (27s)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨4,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨4,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨4,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨4,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    ⟨4,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨3,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨3,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨3,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨3,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    ⟨3,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨4,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨4,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨4,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨4,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    ⟨4,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨3,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨3,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨3,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨3,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    ⟨3,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨4,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨4,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨4,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨4,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    ⟨4,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨3,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨3,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨3,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨3,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    ⟨3,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨4,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨4,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨4,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨4,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    ⟨4,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨3,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨3,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨3,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨3,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    ⟨3,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
✔ [2235/2256] Built SSA.Projects.LLVMRiscV.Pipeline.select:c.o (1.0s)
ℹ [2236/2256] Built SSA.Projects.LLVMRiscV.Pipeline.mul (29s)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
✔ [2237/2256] Built SSA.Projects.LLVMRiscV.Pipeline.mul:c.o (425ms)
ℹ [2238/2256] Built SSA.Projects.LLVMRiscV.Pipeline.sub (30s)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv
      RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv
      RISCV64.Ty.bv)), Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))]) (Ty.riscv RISCV64.Ty.bv)))
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))]) (Ty.riscv RISCV64.Ty.bv)))
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv
            RISCV64.Ty.bv))::ₕΓv
          (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv
          RISCV64.Ty.bv))::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv
        RISCV64.Ty.bv))::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
✔ [2239/2256] Built SSA.Projects.LLVMRiscV.Pipeline.sub:c.o (562ms)
✖ [2240/2256] Building SSA.Projects.LLVMRiscV.Pipeline.add (31s)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/add.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/add.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/add.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/add.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/add.setup.json --json
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
warning: SSA/Projects/LLVMRiscV/Pipeline/add.lean:364:4: declaration uses 'sorry'
error: SSA/Projects/LLVMRiscV/Pipeline/add.lean:393:38: INTERNAL ERROR : While trying to transform from MLIR AST to dialect specific AST
         the transformation failed. The errors thrown are:
          s!Unsupported type and s!Unsupported type
error: SSA/Projects/LLVMRiscV/Pipeline/add.lean:408:13: INTERNAL ERROR : While trying to transform from MLIR AST to dialect specific AST
         the transformation failed. The errors thrown are:
          s!Unsupported type and s!Unsupported type
error: SSA/Projects/LLVMRiscV/Pipeline/add.lean:401:70: could not synthesize default value for field 'correct' of 'LLVMPeepholeRewriteRefine' using tactics
error: SSA/Projects/LLVMRiscV/Pipeline/add.lean:401:70: None of the hypotheses are in the supported BitVec fragment after applying preprocessing.
There are three potential reasons for this:
1. If you are using custom BitVec constructs simplify them to built-in ones.
2. If your problem is using only built-in ones it might currently be out of reach.
   Consider expressing it in terms of different operations that are better supported.
3. The original goal was reduced to False and is thus invalid.
error: Lean exited with code 1
ℹ [2242/2256] Built SSA.Projects.LLVMRiscV.Pipeline.shl (31s)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
✔ [2243/2256] Built SSA.Projects.LLVMRiscV.Pipeline.shl:c.o (28ms)
ℹ [2244/2256] Built SSA.Projects.LLVMRiscV.Pipeline.icmp (32s)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
✔ [2245/2256] Built SSA.Projects.LLVMRiscV.Pipeline.icmp:c.o (522ms)
✖ [2246/2256] Building SSA.Projects.LLVMRiscV.Pipeline.pseudo (1.6s)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/pseudo.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/pseudo.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/pseudo.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/pseudo.setup.json --json
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:22:8: unexpected identifier; expected 'const', 'li', 'llvm.icmp', 'llvm.mlir.constant', 'llvm.select', InstCombine.cmp_op_name, InstCombine.int_cast_op, MLIR.Pretty.RV.opWithImmediate, MLIR.Pretty.RV.opWithShamt, MLIR.Pretty.disjoint_op, MLIR.Pretty.exact_op, MLIR.Pretty.nneg_op, MLIR.Pretty.overflow_int_cast_op, MLIR.Pretty.overflow_op, MLIR.Pretty.uniform_op or string literal
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:28:33: Unknown identifier `icmp_eq_riscv_i64_pseudo`
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:28:2: could not synthesize default value for field 'correct' of 'LLVMPeepholeRewriteRefine' using tactics
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:28:2: None of the hypotheses are in the supported BitVec fragment after applying preprocessing.
There are three potential reasons for this:
1. If you are using custom BitVec constructs simplify them to built-in ones.
2. If your problem is using only built-in ones it might currently be out of reach.
   Consider expressing it in terms of different operations that are better supported.
3. The original goal was reduced to False and is thus invalid.
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:36:8: unexpected identifier; expected 'const', 'li', 'llvm.icmp', 'llvm.mlir.constant', 'llvm.select', InstCombine.cmp_op_name, InstCombine.int_cast_op, MLIR.Pretty.RV.opWithImmediate, MLIR.Pretty.RV.opWithShamt, MLIR.Pretty.disjoint_op, MLIR.Pretty.exact_op, MLIR.Pretty.nneg_op, MLIR.Pretty.overflow_int_cast_op, MLIR.Pretty.overflow_op, MLIR.Pretty.uniform_op or string literal
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:42:33: Unknown identifier `icmp_eq_riscv_i32_pseudo`
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:42:2: could not synthesize default value for field 'correct' of 'LLVMPeepholeRewriteRefine' using tactics
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:42:2: None of the hypotheses are in the supported BitVec fragment after applying preprocessing.
There are three potential reasons for this:
1. If you are using custom BitVec constructs simplify them to built-in ones.
2. If your problem is using only built-in ones it might currently be out of reach.
   Consider expressing it in terms of different operations that are better supported.
3. The original goal was reduced to False and is thus invalid.
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:51:8: unexpected identifier; expected 'const', 'li', 'llvm.icmp', 'llvm.mlir.constant', 'llvm.select', InstCombine.cmp_op_name, InstCombine.int_cast_op, MLIR.Pretty.RV.opWithImmediate, MLIR.Pretty.RV.opWithShamt, MLIR.Pretty.disjoint_op, MLIR.Pretty.exact_op, MLIR.Pretty.nneg_op, MLIR.Pretty.overflow_int_cast_op, MLIR.Pretty.overflow_op, MLIR.Pretty.uniform_op or string literal
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:57:34: Unknown identifier `icmp_ne_riscv_i64_pseudo`
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:57:2: could not synthesize default value for field 'correct' of 'LLVMPeepholeRewriteRefine' using tactics
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:57:2: None of the hypotheses are in the supported BitVec fragment after applying preprocessing.
There are three potential reasons for this:
1. If you are using custom BitVec constructs simplify them to built-in ones.
2. If your problem is using only built-in ones it might currently be out of reach.
   Consider expressing it in terms of different operations that are better supported.
3. The original goal was reduced to False and is thus invalid.
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:65:8: unexpected identifier; expected 'const', 'li', 'llvm.icmp', 'llvm.mlir.constant', 'llvm.select', InstCombine.cmp_op_name, InstCombine.int_cast_op, MLIR.Pretty.RV.opWithImmediate, MLIR.Pretty.RV.opWithShamt, MLIR.Pretty.disjoint_op, MLIR.Pretty.exact_op, MLIR.Pretty.nneg_op, MLIR.Pretty.overflow_int_cast_op, MLIR.Pretty.overflow_op, MLIR.Pretty.uniform_op or string literal
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:71:34: Unknown identifier `icmp_ne_riscv_i32_pseudo`
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:71:2: could not synthesize default value for field 'correct' of 'LLVMPeepholeRewriteRefine' using tactics
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:71:2: None of the hypotheses are in the supported BitVec fragment after applying preprocessing.
There are three potential reasons for this:
1. If you are using custom BitVec constructs simplify them to built-in ones.
2. If your problem is using only built-in ones it might currently be out of reach.
   Consider expressing it in terms of different operations that are better supported.
3. The original goal was reduced to False and is thus invalid.
error: Lean exited with code 1
Some required targets logged failures:
- SSA.Projects.LLVMRiscV.Pipeline.ReconcileCast
- SSA.Projects.LLVMRiscV.Pipeline.zext:c.o
- SSA.Projects.LLVMRiscV.Pipeline.add
- SSA.Projects.LLVMRiscV.Pipeline.pseudo
error: build failed
