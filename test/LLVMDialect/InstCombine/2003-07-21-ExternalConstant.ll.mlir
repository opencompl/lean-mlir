module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @silly() {addr_space = 0 : i32} : i32
  llvm.func @bzero(!llvm.ptr, i32)
  llvm.func @bcopy(!llvm.ptr, !llvm.ptr, i32)
  llvm.func @bcmp(!llvm.ptr, !llvm.ptr, i32) -> i32
  llvm.func @fputs(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @fputs_unlocked(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @function(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @silly : !llvm.ptr
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %5 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %6 = llvm.add %4, %5  : i32
    llvm.store %6, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %7 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %7 : i32
  }
}
