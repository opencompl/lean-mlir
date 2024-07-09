module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @shl_cttz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @shl_ctlz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.ctlz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @lshr_cttz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @ashr_cttz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @shl_cttz_false_multiuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @shl_cttz_as_lhs(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32
    %1 = llvm.shl %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @use(i32)
}
