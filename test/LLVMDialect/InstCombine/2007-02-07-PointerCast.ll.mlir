module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal constant @str("%llx\0A\00") {addr_space = 0 : i32, dso_local}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @main(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("%llx\0A\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %5 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.call @printf(%4, %7) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64) -> i32
    llvm.return %2 : i32
  }
}
