module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @bar() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @f : !llvm.ptr
    %2 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.call %1(%2) vararg(!llvm.func<i32 (...)>) : !llvm.ptr, (f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %5 : i32
  }
  llvm.func @f(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}
