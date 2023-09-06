module  {
  llvm.func @fabsl(f80) -> f80
  llvm.func @replace_fabs_call_f80(%arg0: f80) -> f80 {
    %0 = llvm.call @fabsl(%arg0) : (f80) -> f80
    llvm.return %0 : f80
  }
  llvm.func @fmf_replace_fabs_call_f80(%arg0: f80) -> f80 {
    %0 = llvm.call @fabsl(%arg0) : (f80) -> f80
    llvm.return %0 : f80
  }
}
