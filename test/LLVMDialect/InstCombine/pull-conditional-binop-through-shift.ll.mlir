module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @and_signbit_select_shl(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_nosignbit_select_shl(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_signbit_select_shl(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_nosignbit_select_shl(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @xor_signbit_select_shl(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @xor_nosignbit_select_shl(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_signbit_select_shl(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_nosignbit_select_shl(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_signbit_select_lshr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_nosignbit_select_lshr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_signbit_select_lshr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_nosignbit_select_lshr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @xor_signbit_select_lshr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @xor_nosignbit_select_lshr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_signbit_select_lshr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_nosignbit_select_lshr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_signbit_select_ashr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_nosignbit_select_ashr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_signbit_select_ashr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_nosignbit_select_ashr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @xor_signbit_select_ashr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @xor_nosignbit_select_ashr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_signbit_select_ashr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_nosignbit_select_ashr(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2147418112 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %arg0 : i1, i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }
}
