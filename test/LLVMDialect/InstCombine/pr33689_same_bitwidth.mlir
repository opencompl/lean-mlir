module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<16> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @a() {addr_space = 0 : i32} : i16
  llvm.mlir.global external @b() {addr_space = 0 : i32} : !llvm.ptr
  llvm.func @f(%arg0: i1) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : i16
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @a : !llvm.ptr
    %7 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%1] : (!llvm.ptr, i16) -> !llvm.ptr, i16
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.insertvalue %7, %4[0] : !llvm.array<1 x ptr> 
    %10 = llvm.insertvalue %5, %9[0] : !llvm.array<1 x ptr> 
    %11 = llvm.ptrtoint %7 : !llvm.ptr to i16
    llvm.store %11, %6 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    %12 = llvm.load %2 {alignment = 2 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %3, %12 {alignment = 2 : i64} : i16, !llvm.ptr
    %13 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %14 = llvm.sub %13, %0  : i32
    llvm.store %14, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
