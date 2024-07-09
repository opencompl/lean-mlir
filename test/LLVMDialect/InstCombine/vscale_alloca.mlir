module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @alloca(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.vec<? x 4 x  i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {alignment = 16 : i64} : !llvm.vec<? x 4 x  i32>, !llvm.ptr
    %2 = llvm.load %1 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>
    llvm.return %2 : !llvm.vec<? x 4 x  i32>
  }
  llvm.func @alloca_dead_store(%arg0: !llvm.vec<? x 4 x  i32>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.vec<? x 4 x  i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {alignment = 16 : i64} : !llvm.vec<? x 4 x  i32>, !llvm.ptr
    llvm.return
  }
  llvm.func @use(...)
  llvm.func @alloca_zero_byte_move_first_inst() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.vec<? x 16 x  i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%1) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    %2 = llvm.alloca %0 x !llvm.struct<()> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%2) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }
}
