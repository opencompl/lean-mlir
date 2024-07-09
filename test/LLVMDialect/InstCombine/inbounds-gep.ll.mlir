module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @g() -> !llvm.ptr
  llvm.func @use(!llvm.ptr) -> !llvm.ptr
  llvm.func @call1() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.call @g() : () -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @call2() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.call @g() : () -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @call3() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.call @g() : () -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @alloca() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.addressof @use : !llvm.ptr
    %3 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %2(%4) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @arg1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @arg2(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @arg3(%arg0: !llvm.ptr {llvm.dereferenceable_or_null = 8 : i64}) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }
}
