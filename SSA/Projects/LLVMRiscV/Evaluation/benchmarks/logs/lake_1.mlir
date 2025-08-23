⚠ [1090/1131] Replayed SSA.Projects.LLVMRiscV.PeepholeRefine
warning: SSA/Projects/LLVMRiscV/PeepholeRefine.lean:57:4: declaration uses 'sorry'
ℹ [1093/1131] Replayed SSA.Projects.LLVMRiscV.Pipeline.sext
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
ℹ [1095/1131] Replayed SSA.Projects.LLVMRiscV.Pipeline.urem
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
ℹ [1096/1131] Replayed SSA.Projects.LLVMRiscV.Pipeline.xor
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
✖ [1110/1137] Building SSA.Projects.LLVMRiscV.Pipeline.ashr (193ms)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/ashr.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/ashr.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/ashr.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/ashr.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/ashr.setup.json --json
info: stderr:
failed to load header from /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/ashr.setup.json: offset 0: unexpected end of input
error: Lean exited with code 1
✖ [1111/1137] Building SSA.Projects.LLVMRiscV.Pipeline.and (211ms)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/and.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/and.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/and.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/and.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/and.setup.json --json
info: stderr:
failed to load header from /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/and.setup.json: offset 147456: unexpected end of input
error: Lean exited with code 1
✖ [1112/1137] Building SSA.Projects.LLVMRiscV.Pipeline.mul (210ms)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/mul.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/mul.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/mul.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/mul.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/mul.setup.json --json
info: stderr:
failed to load header from /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/mul.setup.json: offset 0: unexpected end of input
error: Lean exited with code 1
✖ [1113/1137] Building SSA.Projects.LLVMRiscV.Pipeline.sub (191ms)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/sub.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/sub.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/sub.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/sub.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/sub.setup.json --json
info: stderr:
failed to load header from /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/sub.setup.json: offset 0: unexpected end of input
error: Lean exited with code 1
✖ [1114/1137] Building SSA.Projects.LLVMRiscV.Pipeline.udiv (279ms)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/udiv.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/udiv.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/udiv.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/udiv.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/udiv.setup.json --json
info: stderr:
failed to load header from /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/udiv.setup.json: offset 0: unexpected end of input
error: Lean exited with code 1
✖ [1509/2061] Building SSA.Projects.LLVMRiscV.Pipeline.shl (420ms)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/shl.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/shl.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/shl.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/shl.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/shl.setup.json --json
info: stderr:
failed to load header from /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/shl.setup.json: offset 0: unexpected end of input
error: Lean exited with code 1
✖ [1510/2061] Building SSA.Projects.LLVMRiscV.Pipeline.select (446ms)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/select.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/select.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/select.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/select.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/select.setup.json --json
info: stderr:
failed to load header from /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/select.setup.json: offset 131072: unexpected end of input
error: Lean exited with code 1
✔ [2230/2256] Built SSA.Projects.LLVMRiscV.Pipeline.ReconcileCast (8.5s)
ℹ [2232/2256] Built SSA.Projects.LLVMRiscV.Pipeline.rem (10s)
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
✖ [2233/2256] Building SSA.Projects.LLVMRiscV.Pipeline.rem:c.o (532ms)
trace: .> /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang -c -o /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/rem.c.o.export /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/rem.c -I /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include -fstack-clash-protection -fwrapv -fPIC -fvisibility=hidden -Wno-unused-command-line-argument --sysroot /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06 -nostdinc -isystem /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include/clang -O3 -DNDEBUG -DLEAN_EXPORTING
info: stderr:
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace, preprocessed source, and associated run script.
Stack dump:
0.	Program arguments: /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang -c -o /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/rem.c.o.export /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/rem.c -I /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include -fstack-clash-protection -fwrapv -fPIC -fvisibility=hidden -Wno-unused-command-line-argument --sysroot /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06 -nostdinc -isystem /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include/clang -O3 -DNDEBUG -DLEAN_EXPORTING
1.	<unknown> parser at unknown location
2.	Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  libLLVM.so.19.1      0x00007d10555ae468 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 40
1  libLLVM.so.19.1      0x00007d10555ac0de llvm::sys::RunSignalHandlers() + 238
2  libLLVM.so.19.1      0x00007d10555aeb3f
3  libc.so.6            0x00007d1054645330
4  libclang-cpp.so.19.1 0x00007d1059bf7d0d clang::SrcMgr::LineOffsetMapping::get(llvm::MemoryBufferRef, llvm::BumpPtrAllocatorImpl<llvm::MallocAllocator, 4096ul, 4096ul, 128ul>&) + 173
5  libclang-cpp.so.19.1 0x00007d1059bf809e clang::SourceManager::getLineNumber(clang::FileID, unsigned int, bool*) const + 350
6  libclang-cpp.so.19.1 0x00007d1059bf7b4d clang::SourceManager::getPresumedLoc(clang::SourceLocation, bool) const + 301
7  libclang-cpp.so.19.1 0x00007d1059bf0e7c clang::SourceLocation::print(llvm::raw_ostream&, clang::SourceManager const&) const + 44
8  libclang-cpp.so.19.1 0x00007d105a01d482 clang::PrettyDeclStackTraceEntry::print(llvm::raw_ostream&) const + 50
9  libLLVM.so.19.1      0x00007d10555338e4
10 libLLVM.so.19.1      0x00007d10555ac0ac llvm::sys::RunSignalHandlers() + 188
11 libLLVM.so.19.1      0x00007d10555ad8ef llvm::sys::CleanupOnSignal(unsigned long) + 255
12 libLLVM.so.19.1      0x00007d10554fa8f9
13 libc.so.6            0x00007d1054645330
14 libclang-cpp.so.19.1 0x00007d1059cd3088 clang::Lexer::LexTokenInternal(clang::Token&, bool) + 104
15 libclang-cpp.so.19.1 0x00007d1059d3ff0d clang::Preprocessor::Lex(clang::Token&) + 45
16 libclang-cpp.so.19.1 0x00007d1059d50a7f
17 libclang-cpp.so.19.1 0x00007d1059d48e38
18 libclang-cpp.so.19.1 0x00007d1059da4bd0 clang::Parser::ParsePostfixExpressionSuffix(clang::ActionResult<clang::Expr*, true>) + 6640
19 libclang-cpp.so.19.1 0x00007d1059da62c6 clang::Parser::ParseCastExpression(clang::Parser::CastParseKind, bool, bool&, clang::Parser::TypeCastState, bool, bool*) + 2518
20 libclang-cpp.so.19.1 0x00007d1059da1edf clang::Parser::ParseRHSOfBinaryExpression(clang::ActionResult<clang::Expr*, true>, clang::prec::Level) + 3583
21 libclang-cpp.so.19.1 0x00007d1059da10c2 clang::Parser::ParseAssignmentExpression(clang::Parser::TypeCastState) + 386
22 libclang-cpp.so.19.1 0x00007d1059da0f29 clang::Parser::ParseExpression(clang::Parser::TypeCastState) + 9
23 libclang-cpp.so.19.1 0x00007d1059e12331 clang::Parser::ParseExprStatement(clang::Parser::ParsedStmtContext) + 49
24 libclang-cpp.so.19.1 0x00007d1059e10021 clang::Parser::ParseStatementOrDeclarationAfterAttributes(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*, clang::ParsedAttributes&, clang::ParsedAttributes&) + 1505
25 libclang-cpp.so.19.1 0x00007d1059e0f7fa clang::Parser::ParseStatementOrDeclaration(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*) + 330
26 libclang-cpp.so.19.1 0x00007d1059e1a001 clang::Parser::ParseCompoundStatementBody(bool) + 2209
27 libclang-cpp.so.19.1 0x00007d1059e11167 clang::Parser::ParseStatementOrDeclarationAfterAttributes(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*, clang::ParsedAttributes&, clang::ParsedAttributes&) + 5927
28 libclang-cpp.so.19.1 0x00007d1059e0f7fa clang::Parser::ParseStatementOrDeclaration(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*) + 330
29 libclang-cpp.so.19.1 0x00007d1059e12210 clang::Parser::ParseLabeledStatement(clang::ParsedAttributes&, clang::Parser::ParsedStmtContext) + 768
30 libclang-cpp.so.19.1 0x00007d1059e1013e clang::Parser::ParseStatementOrDeclarationAfterAttributes(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*, clang::ParsedAttributes&, clang::ParsedAttributes&) + 1790
31 libclang-cpp.so.19.1 0x00007d1059e0f7fa clang::Parser::ParseStatementOrDeclaration(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*) + 330
32 libclang-cpp.so.19.1 0x00007d1059e1a001 clang::Parser::ParseCompoundStatementBody(bool) + 2209
33 libclang-cpp.so.19.1 0x00007d1059e1af87 clang::Parser::ParseFunctionStatementBody(clang::Decl*, clang::Parser::ParseScope&) + 167
34 libclang-cpp.so.19.1 0x00007d1059e36a8e clang::Parser::ParseFunctionDefinition(clang::ParsingDeclarator&, clang::Parser::ParsedTemplateInfo const&, clang::Parser::LateParsedAttrList*) + 4030
35 libclang-cpp.so.19.1 0x00007d1059d629fc clang::Parser::ParseDeclGroup(clang::ParsingDeclSpec&, clang::DeclaratorContext, clang::ParsedAttributes&, clang::Parser::ParsedTemplateInfo&, clang::SourceLocation*, clang::Parser::ForRangeInit*) + 6764
36 libclang-cpp.so.19.1 0x00007d1059e358d7 clang::Parser::ParseDeclOrFunctionDefInternal(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec&, clang::AccessSpecifier) + 983
37 libclang-cpp.so.19.1 0x00007d1059e35300 clang::Parser::ParseDeclarationOrFunctionDefinition(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec*, clang::AccessSpecifier) + 576
38 libclang-cpp.so.19.1 0x00007d1059e344ed clang::Parser::ParseExternalDeclaration(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec*) + 1997
39 libclang-cpp.so.19.1 0x00007d1059e326b3 clang::Parser::ParseTopLevelDecl(clang::OpaquePtr<clang::DeclGroupRef>&, clang::Sema::ModuleImportState&) + 1459
40 libclang-cpp.so.19.1 0x00007d1059d4846e clang::ParseAST(clang::Sema&, bool, bool) + 830
41 libclang-cpp.so.19.1 0x00007d105c0b9b96 clang::FrontendAction::Execute() + 86
42 libclang-cpp.so.19.1 0x00007d105c030614 clang::CompilerInstance::ExecuteAction(clang::FrontendAction&) + 996
43 libclang-cpp.so.19.1 0x00007d105c1358fe clang::ExecuteCompilerInvocation(clang::CompilerInstance*) + 894
44 clang                0x00005b166ff6f1ef cc1_main(llvm::ArrayRef<char const*>, char const*, void*) + 5759
45 clang                0x00005b166ff6c080
46 libclang-cpp.so.19.1 0x00007d105bc9afd9
47 libLLVM.so.19.1      0x00007d10554fa6d8 llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>) + 136
48 libclang-cpp.so.19.1 0x00007d105bc9a855 clang::driver::CC1Command::Execute(llvm::ArrayRef<std::__1::optional<llvm::StringRef>>, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char>>*, bool*) const + 325
49 libclang-cpp.so.19.1 0x00007d105bc5ee98 clang::driver::Compilation::ExecuteCommand(clang::driver::Command const&, clang::driver::Command const*&, bool) const + 1000
50 libclang-cpp.so.19.1 0x00007d105bc5f11e clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&, llvm::SmallVectorImpl<std::__1::pair<int, clang::driver::Command const*>>&, bool) const + 126
51 libclang-cpp.so.19.1 0x00007d105bc7c78c clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&, llvm::SmallVectorImpl<std::__1::pair<int, clang::driver::Command const*>>&) + 348
52 clang                0x00005b166ff6b623 clang_main(int, char**, llvm::ToolContext const&) + 5971
53 clang                0x00005b166ff78a77 main + 87
54 libc.so.6            0x00007d105462a1ca
55 libc.so.6            0x00007d105462a28b __libc_start_main + 139
56 clang                0x00005b166ff69b9e _start + 46
/home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/rem.c:342:54: parsing function body '_init_l_rem__riscv___closed__2'
3.	/home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/rem.c:342:54: in compound statement ('{}')
4.	/home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/rem.c:344:1: in compound statement ('{}')
clang: error: clang frontend command failed with exit code 135 (use -v to see invocation)
clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin
clang: note: diagnostic msg: 
********************

PLEASE ATTACH THE FOLLOWING FILES TO THE BUG REPORT:
Preprocessed source(s) and associated run script(s) are located at:
clang: note: diagnostic msg: /tmp/rem-18d053.c
clang: note: diagnostic msg: /tmp/rem-18d053.sh
clang: note: diagnostic msg: 

********************
error: external command '/home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang' exited with code 1
ℹ [2234/2256] Built SSA.Projects.LLVMRiscV.Pipeline.srl (13s)
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
⚠ [2236/2256] Built SSA.Projects.LLVMRiscV.Pipeline.sdiv (15s)
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
✖ [2237/2256] Building SSA.Projects.LLVMRiscV.Pipeline.sdiv:c.o (412ms)
trace: .> /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang -c -o /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/sdiv.c.o.export /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/sdiv.c -I /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include -fstack-clash-protection -fwrapv -fPIC -fvisibility=hidden -Wno-unused-command-line-argument --sysroot /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06 -nostdinc -isystem /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include/clang -O3 -DNDEBUG -DLEAN_EXPORTING
info: stderr:
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace, preprocessed source, and associated run script.
Stack dump:
0.	Program arguments: /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang -c -o /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/sdiv.c.o.export /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/sdiv.c -I /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include -fstack-clash-protection -fwrapv -fPIC -fvisibility=hidden -Wno-unused-command-line-argument --sysroot /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06 -nostdinc -isystem /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include/clang -O3 -DNDEBUG -DLEAN_EXPORTING
1.	<unknown> parser at unknown location
2.	Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  libLLVM.so.19.1      0x00007799b97ae468 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 40
1  libLLVM.so.19.1      0x00007799b97ac0de llvm::sys::RunSignalHandlers() + 238
2  libLLVM.so.19.1      0x00007799b97aeb3f
3  libc.so.6            0x00007799b8845330
4  libclang-cpp.so.19.1 0x00007799bddf7d0d clang::SrcMgr::LineOffsetMapping::get(llvm::MemoryBufferRef, llvm::BumpPtrAllocatorImpl<llvm::MallocAllocator, 4096ul, 4096ul, 128ul>&) + 173
5  libclang-cpp.so.19.1 0x00007799bddf809e clang::SourceManager::getLineNumber(clang::FileID, unsigned int, bool*) const + 350
6  libclang-cpp.so.19.1 0x00007799bddf7b4d clang::SourceManager::getPresumedLoc(clang::SourceLocation, bool) const + 301
7  libclang-cpp.so.19.1 0x00007799bddf0e7c clang::SourceLocation::print(llvm::raw_ostream&, clang::SourceManager const&) const + 44
8  libclang-cpp.so.19.1 0x00007799be21d482 clang::PrettyDeclStackTraceEntry::print(llvm::raw_ostream&) const + 50
9  libLLVM.so.19.1      0x00007799b97338e4
10 libLLVM.so.19.1      0x00007799b97ac0ac llvm::sys::RunSignalHandlers() + 188
11 libLLVM.so.19.1      0x00007799b97ad8ef llvm::sys::CleanupOnSignal(unsigned long) + 255
12 libLLVM.so.19.1      0x00007799b96fa8f9
13 libc.so.6            0x00007799b8845330
14 libclang-cpp.so.19.1 0x00007799bded3088 clang::Lexer::LexTokenInternal(clang::Token&, bool) + 104
15 libclang-cpp.so.19.1 0x00007799bdf3ff0d clang::Preprocessor::Lex(clang::Token&) + 45
16 libclang-cpp.so.19.1 0x00007799bdf50a7f
17 libclang-cpp.so.19.1 0x00007799bdf48e38
18 libclang-cpp.so.19.1 0x00007799bdfa4bd0 clang::Parser::ParsePostfixExpressionSuffix(clang::ActionResult<clang::Expr*, true>) + 6640
19 libclang-cpp.so.19.1 0x00007799bdfa62c6 clang::Parser::ParseCastExpression(clang::Parser::CastParseKind, bool, bool&, clang::Parser::TypeCastState, bool, bool*) + 2518
20 libclang-cpp.so.19.1 0x00007799bdfa1003 clang::Parser::ParseAssignmentExpression(clang::Parser::TypeCastState) + 195
21 libclang-cpp.so.19.1 0x00007799bdfa0f29 clang::Parser::ParseExpression(clang::Parser::TypeCastState) + 9
22 libclang-cpp.so.19.1 0x00007799be012331 clang::Parser::ParseExprStatement(clang::Parser::ParsedStmtContext) + 49
23 libclang-cpp.so.19.1 0x00007799be010021 clang::Parser::ParseStatementOrDeclarationAfterAttributes(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*, clang::ParsedAttributes&, clang::ParsedAttributes&) + 1505
24 libclang-cpp.so.19.1 0x00007799be00f7fa clang::Parser::ParseStatementOrDeclaration(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*) + 330
25 libclang-cpp.so.19.1 0x00007799be01a001 clang::Parser::ParseCompoundStatementBody(bool) + 2209
26 libclang-cpp.so.19.1 0x00007799be01af87 clang::Parser::ParseFunctionStatementBody(clang::Decl*, clang::Parser::ParseScope&) + 167
27 libclang-cpp.so.19.1 0x00007799be036a8e clang::Parser::ParseFunctionDefinition(clang::ParsingDeclarator&, clang::Parser::ParsedTemplateInfo const&, clang::Parser::LateParsedAttrList*) + 4030
28 libclang-cpp.so.19.1 0x00007799bdf629fc clang::Parser::ParseDeclGroup(clang::ParsingDeclSpec&, clang::DeclaratorContext, clang::ParsedAttributes&, clang::Parser::ParsedTemplateInfo&, clang::SourceLocation*, clang::Parser::ForRangeInit*) + 6764
29 libclang-cpp.so.19.1 0x00007799be0358d7 clang::Parser::ParseDeclOrFunctionDefInternal(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec&, clang::AccessSpecifier) + 983
30 libclang-cpp.so.19.1 0x00007799be035300 clang::Parser::ParseDeclarationOrFunctionDefinition(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec*, clang::AccessSpecifier) + 576
31 libclang-cpp.so.19.1 0x00007799be0344ed clang::Parser::ParseExternalDeclaration(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec*) + 1997
32 libclang-cpp.so.19.1 0x00007799be0326b3 clang::Parser::ParseTopLevelDecl(clang::OpaquePtr<clang::DeclGroupRef>&, clang::Sema::ModuleImportState&) + 1459
33 libclang-cpp.so.19.1 0x00007799bdf4846e clang::ParseAST(clang::Sema&, bool, bool) + 830
34 libclang-cpp.so.19.1 0x00007799c02b9b96 clang::FrontendAction::Execute() + 86
35 libclang-cpp.so.19.1 0x00007799c0230614 clang::CompilerInstance::ExecuteAction(clang::FrontendAction&) + 996
36 libclang-cpp.so.19.1 0x00007799c03358fe clang::ExecuteCompilerInvocation(clang::CompilerInstance*) + 894
37 clang                0x0000646a7c1a41ef cc1_main(llvm::ArrayRef<char const*>, char const*, void*) + 5759
38 clang                0x0000646a7c1a1080
39 libclang-cpp.so.19.1 0x00007799bfe9afd9
40 libLLVM.so.19.1      0x00007799b96fa6d8 llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>) + 136
41 libclang-cpp.so.19.1 0x00007799bfe9a855 clang::driver::CC1Command::Execute(llvm::ArrayRef<std::__1::optional<llvm::StringRef>>, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char>>*, bool*) const + 325
42 libclang-cpp.so.19.1 0x00007799bfe5ee98 clang::driver::Compilation::ExecuteCommand(clang::driver::Command const&, clang::driver::Command const*&, bool) const + 1000
43 libclang-cpp.so.19.1 0x00007799bfe5f11e clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&, llvm::SmallVectorImpl<std::__1::pair<int, clang::driver::Command const*>>&, bool) const + 126
44 libclang-cpp.so.19.1 0x00007799bfe7c78c clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&, llvm::SmallVectorImpl<std::__1::pair<int, clang::driver::Command const*>>&) + 348
45 clang                0x0000646a7c1a0623 clang_main(int, char**, llvm::ToolContext const&) + 5971
46 clang                0x0000646a7c1ada77 main + 87
47 libc.so.6            0x00007799b882a1ca
48 libc.so.6            0x00007799b882a28b __libc_start_main + 139
49 clang                0x0000646a7c19eb9e _start + 46
/home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/sdiv.c:1362:107: parsing function body 'initialize_SSA_Projects_LLVMRiscV_Pipeline_sdiv'
3.	/home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/sdiv.c:1362:107: in compound statement ('{}')
clang: error: clang frontend command failed with exit code 135 (use -v to see invocation)
clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin
clang: note: diagnostic msg: 
********************

PLEASE ATTACH THE FOLLOWING FILES TO THE BUG REPORT:
Preprocessed source(s) and associated run script(s) are located at:
clang: note: diagnostic msg: /tmp/sdiv-d09f3c.c
clang: note: diagnostic msg: /tmp/sdiv-d09f3c.sh
clang: note: diagnostic msg: 

********************
error: external command '/home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang' exited with code 1
ℹ [2238/2256] Built SSA.Projects.LLVMRiscV.Pipeline.zext (20s)
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
ℹ [2240/2256] Built SSA.Projects.LLVMRiscV.Pipeline.or (22s)
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
✖ [2242/2256] Building SSA.Projects.LLVMRiscV.Pipeline.add (31s)
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
✖ [2245/2256] Building SSA.Projects.LLVMRiscV.Pipeline.icmp:c.o (90ms)
trace: .> /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang -c -o /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/icmp.c.o.export /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/icmp.c -I /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include -fstack-clash-protection -fwrapv -fPIC -fvisibility=hidden -Wno-unused-command-line-argument --sysroot /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06 -nostdinc -isystem /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include/clang -O3 -DNDEBUG -DLEAN_EXPORTING
info: stderr:
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace, preprocessed source, and associated run script.
Stack dump:
0.	Program arguments: /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang -c -o /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/icmp.c.o.export /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/icmp.c -I /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include -fstack-clash-protection -fwrapv -fPIC -fvisibility=hidden -Wno-unused-command-line-argument --sysroot /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06 -nostdinc -isystem /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/include/clang -O3 -DNDEBUG -DLEAN_EXPORTING
1.	<unknown> parser at unknown location
2.	Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  libLLVM.so.19.1      0x000075ed8bdae468 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 40
1  libLLVM.so.19.1      0x000075ed8bdac0de llvm::sys::RunSignalHandlers() + 238
2  libLLVM.so.19.1      0x000075ed8bdaeb3f
3  libc.so.6            0x000075ed8ae45330
4  libclang-cpp.so.19.1 0x000075ed903f7d0d clang::SrcMgr::LineOffsetMapping::get(llvm::MemoryBufferRef, llvm::BumpPtrAllocatorImpl<llvm::MallocAllocator, 4096ul, 4096ul, 128ul>&) + 173
5  libclang-cpp.so.19.1 0x000075ed903f809e clang::SourceManager::getLineNumber(clang::FileID, unsigned int, bool*) const + 350
6  libclang-cpp.so.19.1 0x000075ed903f7b4d clang::SourceManager::getPresumedLoc(clang::SourceLocation, bool) const + 301
7  libclang-cpp.so.19.1 0x000075ed903f0e7c clang::SourceLocation::print(llvm::raw_ostream&, clang::SourceManager const&) const + 44
8  libclang-cpp.so.19.1 0x000075ed9081d482 clang::PrettyDeclStackTraceEntry::print(llvm::raw_ostream&) const + 50
9  libLLVM.so.19.1      0x000075ed8bd338e4
10 libLLVM.so.19.1      0x000075ed8bdac0ac llvm::sys::RunSignalHandlers() + 188
11 libLLVM.so.19.1      0x000075ed8bdad8ef llvm::sys::CleanupOnSignal(unsigned long) + 255
12 libLLVM.so.19.1      0x000075ed8bcfa8f9
13 libc.so.6            0x000075ed8ae45330
14 libclang-cpp.so.19.1 0x000075ed904d3088 clang::Lexer::LexTokenInternal(clang::Token&, bool) + 104
15 libclang-cpp.so.19.1 0x000075ed9053ff0d clang::Preprocessor::Lex(clang::Token&) + 45
16 libclang-cpp.so.19.1 0x000075ed90550a7f
17 libclang-cpp.so.19.1 0x000075ed90548e38
18 libclang-cpp.so.19.1 0x000075ed905a4bd0 clang::Parser::ParsePostfixExpressionSuffix(clang::ActionResult<clang::Expr*, true>) + 6640
19 libclang-cpp.so.19.1 0x000075ed905a62c6 clang::Parser::ParseCastExpression(clang::Parser::CastParseKind, bool, bool&, clang::Parser::TypeCastState, bool, bool*) + 2518
20 libclang-cpp.so.19.1 0x000075ed905a1003 clang::Parser::ParseAssignmentExpression(clang::Parser::TypeCastState) + 195
21 libclang-cpp.so.19.1 0x000075ed905a0f29 clang::Parser::ParseExpression(clang::Parser::TypeCastState) + 9
22 libclang-cpp.so.19.1 0x000075ed90612331 clang::Parser::ParseExprStatement(clang::Parser::ParsedStmtContext) + 49
23 libclang-cpp.so.19.1 0x000075ed90610021 clang::Parser::ParseStatementOrDeclarationAfterAttributes(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*, clang::ParsedAttributes&, clang::ParsedAttributes&) + 1505
24 libclang-cpp.so.19.1 0x000075ed9060f7fa clang::Parser::ParseStatementOrDeclaration(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*) + 330
25 libclang-cpp.so.19.1 0x000075ed9061a001 clang::Parser::ParseCompoundStatementBody(bool) + 2209
26 libclang-cpp.so.19.1 0x000075ed9061af87 clang::Parser::ParseFunctionStatementBody(clang::Decl*, clang::Parser::ParseScope&) + 167
27 libclang-cpp.so.19.1 0x000075ed90636a8e clang::Parser::ParseFunctionDefinition(clang::ParsingDeclarator&, clang::Parser::ParsedTemplateInfo const&, clang::Parser::LateParsedAttrList*) + 4030
28 libclang-cpp.so.19.1 0x000075ed905629fc clang::Parser::ParseDeclGroup(clang::ParsingDeclSpec&, clang::DeclaratorContext, clang::ParsedAttributes&, clang::Parser::ParsedTemplateInfo&, clang::SourceLocation*, clang::Parser::ForRangeInit*) + 6764
29 libclang-cpp.so.19.1 0x000075ed906358d7 clang::Parser::ParseDeclOrFunctionDefInternal(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec&, clang::AccessSpecifier) + 983
30 libclang-cpp.so.19.1 0x000075ed90635300 clang::Parser::ParseDeclarationOrFunctionDefinition(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec*, clang::AccessSpecifier) + 576
31 libclang-cpp.so.19.1 0x000075ed906344ed clang::Parser::ParseExternalDeclaration(clang::ParsedAttributes&, clang::ParsedAttributes&, clang::ParsingDeclSpec*) + 1997
32 libclang-cpp.so.19.1 0x000075ed906326b3 clang::Parser::ParseTopLevelDecl(clang::OpaquePtr<clang::DeclGroupRef>&, clang::Sema::ModuleImportState&) + 1459
33 libclang-cpp.so.19.1 0x000075ed9054846e clang::ParseAST(clang::Sema&, bool, bool) + 830
34 libclang-cpp.so.19.1 0x000075ed928b9b96 clang::FrontendAction::Execute() + 86
35 libclang-cpp.so.19.1 0x000075ed92830614 clang::CompilerInstance::ExecuteAction(clang::FrontendAction&) + 996
36 libclang-cpp.so.19.1 0x000075ed929358fe clang::ExecuteCompilerInvocation(clang::CompilerInstance*) + 894
37 clang                0x0000606369e031ef cc1_main(llvm::ArrayRef<char const*>, char const*, void*) + 5759
38 clang                0x0000606369e00080
39 libclang-cpp.so.19.1 0x000075ed9249afd9
40 libLLVM.so.19.1      0x000075ed8bcfa6d8 llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>) + 136
41 libclang-cpp.so.19.1 0x000075ed9249a855 clang::driver::CC1Command::Execute(llvm::ArrayRef<std::__1::optional<llvm::StringRef>>, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char>>*, bool*) const + 325
42 libclang-cpp.so.19.1 0x000075ed9245ee98 clang::driver::Compilation::ExecuteCommand(clang::driver::Command const&, clang::driver::Command const*&, bool) const + 1000
43 libclang-cpp.so.19.1 0x000075ed9245f11e clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&, llvm::SmallVectorImpl<std::__1::pair<int, clang::driver::Command const*>>&, bool) const + 126
44 libclang-cpp.so.19.1 0x000075ed9247c78c clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&, llvm::SmallVectorImpl<std::__1::pair<int, clang::driver::Command const*>>&) + 348
45 clang                0x0000606369dff623 clang_main(int, char**, llvm::ToolContext const&) + 5971
46 clang                0x0000606369e0ca77 main + 87
47 libc.so.6            0x000075ed8ae2a1ca
48 libc.so.6            0x000075ed8ae2a28b __libc_start_main + 139
49 clang                0x0000606369dfdb9e _start + 46
/home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/icmp.c:10196:107: parsing function body 'initialize_SSA_Projects_LLVMRiscV_Pipeline_icmp'
3.	/home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/icmp.c:10196:107: in compound statement ('{}')
clang: error: clang frontend command failed with exit code 135 (use -v to see invocation)
clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin
clang: note: diagnostic msg: 
********************

PLEASE ATTACH THE FOLLOWING FILES TO THE BUG REPORT:
Preprocessed source(s) and associated run script(s) are located at:
clang: note: diagnostic msg: /tmp/icmp-583c8f.c
clang: note: diagnostic msg: /tmp/icmp-583c8f.sh
clang: note: diagnostic msg: 

********************
error: external command '/home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/clang' exited with code 1
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
- SSA.Projects.LLVMRiscV.Pipeline.ashr
- SSA.Projects.LLVMRiscV.Pipeline.and
- SSA.Projects.LLVMRiscV.Pipeline.mul
- SSA.Projects.LLVMRiscV.Pipeline.sub
- SSA.Projects.LLVMRiscV.Pipeline.udiv
- SSA.Projects.LLVMRiscV.Pipeline.shl
- SSA.Projects.LLVMRiscV.Pipeline.select
- SSA.Projects.LLVMRiscV.Pipeline.rem:c.o
- SSA.Projects.LLVMRiscV.Pipeline.sdiv:c.o
- SSA.Projects.LLVMRiscV.Pipeline.add
- SSA.Projects.LLVMRiscV.Pipeline.icmp:c.o
- SSA.Projects.LLVMRiscV.Pipeline.pseudo
error: build failed
