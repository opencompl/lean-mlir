module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global weak @x(0 : i32) {addr_space = 0 : i32} : i32
  llvm.func @self_assign_1() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @x : !llvm.ptr
    %2 = llvm.load volatile %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store volatile %2, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @volatile_store_before_unreachable(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store volatile %0, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.return
  }
}
