module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @f_0() -> !llvm.ptr<4> {
    %0 = llvm.mlir.zero : !llvm.ptr<4>
    %1 = llvm.mlir.constant(50 : i64) : i64
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, i8
    llvm.return %2 : !llvm.ptr<4>
  }
  llvm.func @f_1() -> !llvm.ptr<3> {
    %0 = llvm.mlir.zero : !llvm.ptr<3>
    %1 = llvm.mlir.constant(50 : i64) : i64
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i8
    llvm.return %2 : !llvm.ptr<3>
  }
  llvm.func @f_2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr<4>
    llvm.store %0, %arg1 {alignment = 8 : i64} : !llvm.ptr<4>, !llvm.ptr
    llvm.return
  }
  llvm.func @f_3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr<3>
    llvm.store %0, %arg1 {alignment = 8 : i64} : !llvm.ptr<3>, !llvm.ptr
    llvm.return
  }
  llvm.func @g(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr<4>
    %2 = llvm.call @alloc() : () -> !llvm.ptr<4>
    %3 = llvm.addrspacecast %2 : !llvm.ptr<4> to !llvm.ptr
    %4 = llvm.getelementptr %3[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr<4>
    llvm.store %1, %4 {alignment = 8 : i64} : !llvm.ptr<4>, !llvm.ptr
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> i64
    llvm.return %5 : i64
  }
  llvm.func @g2(%arg0: !llvm.ptr<4>) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr<4> -> !llvm.ptr
    %2 = llvm.call @alloc() : () -> !llvm.ptr<4>
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, !llvm.ptr
    llvm.store %1, %3 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr<4>
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr<4> -> i64
    llvm.return %4 : i64
  }
  llvm.func @alloc() -> !llvm.ptr<4>
  llvm.func @f_4(%arg0: !llvm.ptr<4>) -> i64 {
    %0 = llvm.mlir.addressof @f_5 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr<4>) -> i64
    llvm.return %1 : i64
  }
  llvm.func @f_5(i64) -> i64
}
