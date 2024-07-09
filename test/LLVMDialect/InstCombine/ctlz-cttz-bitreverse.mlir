module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @ctlz_true_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @ctlz_true_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.bitreverse(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = true}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @ctlz_false_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @cttz_true_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @cttz_true_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.bitreverse(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @cttz_false_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }
}
