module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<2>, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<1>, dense<64> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "big">>} {
  llvm.mlir.global external @x() {addr_space = 0 : i32, alignment = 16 : i64} : vector<2xi64>
  llvm.mlir.global external @xx() {addr_space = 0 : i32, alignment = 16 : i64} : !llvm.array<13 x vector<2xi64>>
  llvm.mlir.global external @x.as2() {addr_space = 2 : i32, alignment = 16 : i64} : vector<2xi64>
  llvm.func @static_hem() -> vector<2xi64> {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr, i32) -> !llvm.ptr, vector<2xi64>
    %3 = llvm.load %2 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @hem(%arg0: i32) -> vector<2xi64> {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, vector<2xi64>
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @hem_2d(%arg0: i32, %arg1: i32) -> vector<2xi64> {
    %0 = llvm.mlir.addressof @xx : !llvm.ptr
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x vector<2xi64>>
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @foo() -> vector<2xi64> {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @bar() -> vector<2xi64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x vector<2xi64> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.call @kip(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @static_hem_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr, i32) -> !llvm.ptr, vector<2xi64>
    llvm.store %arg0, %2 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr
    llvm.return
  }
  llvm.func @hem_store(%arg0: i32, %arg1: vector<2xi64>) {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, vector<2xi64>
    llvm.store %arg1, %1 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr
    llvm.return
  }
  llvm.func @hem_2d_store(%arg0: i32, %arg1: i32, %arg2: vector<2xi64>) {
    %0 = llvm.mlir.addressof @xx : !llvm.ptr
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x vector<2xi64>>
    llvm.store %arg2, %1 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr
    llvm.return
  }
  llvm.func @foo_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.addressof @x : !llvm.ptr
    llvm.store %arg0, %0 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr
    llvm.return
  }
  llvm.func @bar_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x vector<2xi64> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.call @kip(%1) : (!llvm.ptr) -> ()
    llvm.store %arg0, %1 {alignment = 1 : i64} : vector<2xi64>, !llvm.ptr
    llvm.return
  }
  llvm.func @kip(!llvm.ptr)
}
