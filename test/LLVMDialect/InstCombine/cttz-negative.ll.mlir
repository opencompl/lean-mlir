module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @cttz_neg_value(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_neg_value_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_neg_value_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %0, %arg0  : i64
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @cttz_neg_value2_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %0, %arg0  : i64
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @cttz_neg_value_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %1, %arg0  : vector<2xi64>
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @cttz_nonneg_value(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_nonneg_value_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.sub %0, %arg0  : vector<2xi64>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @use(i32)
}
