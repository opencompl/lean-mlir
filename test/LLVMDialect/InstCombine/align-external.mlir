module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<[8, 32]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @A() {addr_space = 0 : i32} : i32
  llvm.mlir.global weak_odr @B(0 : i32) {addr_space = 0 : i32} : i32
  llvm.mlir.global available_externally @C(dense<0> : vector<4xi32>) {addr_space = 0 : i32, alignment = 4 : i64} : vector<4xi32>
  llvm.func @foo(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @A : !llvm.ptr
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %4 = llvm.shl %arg0, %1  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.add %5, %2  : i64
    llvm.return %6 : i64
  }
  llvm.func @bar() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @B : !llvm.ptr
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
  llvm.func @vec_store() {
    %0 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.addressof @C : !llvm.ptr
    llvm.store %0, %3 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr
    llvm.return
  }
}
