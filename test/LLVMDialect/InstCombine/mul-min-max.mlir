module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @umul_min_max(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @umul_min_max_comm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @umul_min_max_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @smul_min_max(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @smul_min_max_comm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @smul_min_max_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }
}
