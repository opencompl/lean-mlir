module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @some_global(777 : i32) {addr_space = 0 : i32} : i32
  llvm.func @simple_folding(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(123 : i64) : i64
    %1 = llvm.mlir.constant(777 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.getelementptr %arg1[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return
  }
  llvm.func @folds_removed_operands(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64) -> i64 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.add %arg2, %arg3  : i64
    %2 = llvm.add %1, %arg3  : i64
    %3 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    "llvm.intr.assume"(%0) : (i1) -> ()
    llvm.return %2 : i64
  }
  llvm.func @handles_globals(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(777 : i32) : i32
    %1 = llvm.mlir.addressof @some_global : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i65) : i65
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.getelementptr %1[%2] : (!llvm.ptr, i65) -> !llvm.ptr, i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    llvm.return
  }
}
