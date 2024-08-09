module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @bar(!llvm.ptr)
  llvm.func @foobar()
  llvm.func @test1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %6 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %7 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %9 = llvm.icmp "eq" %4, %6 : !llvm.ptr
    %10 = llvm.select %9, %arg0, %3 : i1, !llvm.ptr
    %11 = llvm.icmp "eq" %10, %3 : !llvm.ptr
    llvm.cond_br %11, ^bb3, ^bb2
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %12 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }
  llvm.func @test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %6 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %7 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %9 = llvm.icmp "eq" %4, %6 : !llvm.ptr
    %10 = llvm.select %9, %3, %arg0 : i1, !llvm.ptr
    %11 = llvm.icmp "eq" %10, %3 : !llvm.ptr
    llvm.cond_br %11, ^bb3, ^bb2
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %12 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }
  llvm.func @test3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %6 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %7 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %9 = llvm.icmp "eq" %4, %6 : !llvm.ptr
    %10 = llvm.select %9, %arg0, %3 : i1, !llvm.ptr
    %11 = llvm.icmp "ne" %10, %3 : !llvm.ptr
    llvm.cond_br %11, ^bb2, ^bb3
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %12 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }
  llvm.func @test4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %6 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %7 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %9 = llvm.icmp "eq" %4, %6 : !llvm.ptr
    %10 = llvm.select %9, %3, %arg0 : i1, !llvm.ptr
    %11 = llvm.icmp "ne" %10, %3 : !llvm.ptr
    llvm.cond_br %11, ^bb2, ^bb3
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %12 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }
  llvm.func @test5(%arg0: !llvm.ptr, %arg1: i1) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg1, %0, %arg0 : i1, !llvm.ptr
    %2 = llvm.icmp "ne" %1, %0 : !llvm.ptr
    llvm.cond_br %2, ^bb2, ^bb3
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    llvm.call @foobar() : () -> ()
    llvm.br ^bb1
  }
  llvm.func @test6(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.select %arg1, %arg0, %0 : i1, i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    llvm.return %1 : i32
  }
}
