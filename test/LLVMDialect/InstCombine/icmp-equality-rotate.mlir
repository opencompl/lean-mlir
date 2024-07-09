module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i8(i8)
  llvm.func @cmpeq_rorr_to_rorl(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @cmpeq_rorr_to_rorl_non_equality_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @cmpeq_rorr_to_rorl_cmp_against_wrong_val_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "ult" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @cmpeq_rorr_to_rorl_non_ror_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg1, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @cmpeq_rorr_to_rorl_multiuse_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @cmpne_rorr_rorr(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @cmpne_rorrX_rorrY(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshr(%arg1, %arg1, %arg3)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @cmpne_rorr_rorr_non_equality_fail(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "sge" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @cmpne_rorr_rorl_todo_mismatch_C(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @cmpne_rorl_rorl_multiuse1_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @cmpeq_rorlXC_rorlYC_multiuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.intr.fshl(%arg1, %arg1, %1)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @cmpeq_rorlC_rorlC_multiuse2_fail(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.intr.fshl(%arg0, %arg0, %1)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }
}
