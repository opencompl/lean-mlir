module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @g0() {addr_space = 0 : i32} : !llvm.struct<"t0", (ptr, i64)>
  llvm.mlir.global external constant @g1() {addr_space = 0 : i32} : !llvm.struct<"t0", (ptr, i64)>
  llvm.func @test(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @g0 : !llvm.ptr
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.mlir.constant(16 : i64) : i64
    %4 = llvm.alloca %0 x !llvm.struct<"t0", (ptr, i64)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.call @get_cond() : () -> i1
    %6 = llvm.select %5, %1, %2 : i1, !llvm.ptr
    "llvm.intr.memcpy"(%4, %6, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%arg0, %4, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @test2() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    %2 = llvm.mlir.constant(2503 : i32) : i32
    %3 = llvm.mlir.addressof @g0 : !llvm.ptr
    %4 = llvm.mlir.addressof @g1 : !llvm.ptr
    %5 = llvm.mlir.constant(16 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.struct<"t0", (ptr, i64)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.call @func(%1) : (!llvm.ptr) -> i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    %9 = llvm.select %8, %3, %4 : i1, !llvm.ptr
    "llvm.intr.memcpy"(%6, %9, %5) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %10 = llvm.call @func(%6) : (!llvm.ptr) -> i32
    llvm.unreachable
  }
  llvm.func @func(!llvm.ptr) -> i32
  llvm.func @get_cond() -> i1
}
