module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @shl_nuw_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @shl_nsw_ne_0(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @shl_eq_0_fail_missing_flags(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.shl %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @shl_ne_1_fail_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @shl_nsw_slt_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @shl_vec_nsw_slt_1_0_todo_non_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %2 = llvm.icmp "slt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @shl_nsw_sle_n1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %2 = llvm.icmp "sle" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @shl_nsw_sge_1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %2 = llvm.icmp "sge" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @shl_nsw_sgt_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @shl_nuw_sgt_n1_fail_wrong_flag(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @shl_nsw_nuw_ult_Csle0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-19 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @shl_nsw_ule_Csle0_fail_missing_flag(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-19 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.icmp "ule" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @shl_nsw_nuw_uge_Csle0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-120 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i8
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @shl_nuw_ugt_Csle0_fail_missing_flag(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-19 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @shl_nsw_nuw_sgt_Csle0(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi8>
    %2 = llvm.icmp "sgt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @shl_nsw_nuw_sge_Csle0_todo_non_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-10, -65]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi8>
    %2 = llvm.icmp "sge" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @shl_nsw_nuw_sle_Csle0(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi8>
    %2 = llvm.icmp "sle" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @shl_nsw_nuw_slt_Csle0_fail_positive(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi8>
    %2 = llvm.icmp "slt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
}
