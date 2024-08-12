module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<5>, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.alloca_memory_space", 5 : ui64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @g1(dense<0> : tensor<32xi8>) {addr_space = 0 : i32} : !llvm.array<32 x i8>
  llvm.mlir.global external constant @g2(dense<0> : tensor<32xi8>) {addr_space = 1 : i32} : !llvm.array<32 x i8>
  llvm.func @remove_alloca_use_arg(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>
    "llvm.intr.memcpy"(%7, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %8 = llvm.getelementptr inbounds %7[%5, %6] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%8 : !llvm.ptr<1>)
  ^bb2:  // pred: ^bb0
    %9 = llvm.getelementptr inbounds %7[%5, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%9 : !llvm.ptr<1>)
  ^bb3(%10: !llvm.ptr<1>):  // 2 preds: ^bb1, ^bb2
    %11 = llvm.load %10 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
    llvm.return %11 : i8
  }
  llvm.func @volatile_load_keep_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>
    "llvm.intr.memcpy"(%7, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %8 = llvm.getelementptr inbounds %7[%5, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%8 : !llvm.ptr<1>)
  ^bb2:  // pred: ^bb0
    %9 = llvm.getelementptr inbounds %7[%5, %6] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%9 : !llvm.ptr<1>)
  ^bb3(%10: !llvm.ptr<1>):  // 2 preds: ^bb1, ^bb2
    %11 = llvm.load volatile %10 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
    llvm.return %11 : i8
  }
  llvm.func @no_memcpy_keep_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%4 : !llvm.ptr<1>)
  ^bb2:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %3[%1, %2] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%5 : !llvm.ptr<1>)
  ^bb3(%6: !llvm.ptr<1>):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.load volatile %6 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
    llvm.return %7 : i8
  }
  llvm.func @loop_phi_remove_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>
    "llvm.intr.memcpy"(%7, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()
    %8 = llvm.getelementptr inbounds %7[%5, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb1(%8 : !llvm.ptr<1>)
  ^bb1(%9: !llvm.ptr<1>):  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %10 = llvm.getelementptr inbounds %7[%5, %6] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb1(%10 : !llvm.ptr<1>)
  ^bb3:  // pred: ^bb1
    %11 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
    llvm.return %11 : i8
  }
  llvm.func @remove_alloca_ptr_arg(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%5 : !llvm.ptr)
  ^bb2(%6: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %7 : i32
  }
  llvm.func @loop_phi_late_memtransfer_remove_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %5 = llvm.mlir.addressof @g1 : !llvm.ptr
    %6 = llvm.mlir.constant(32 : i64) : i64
    %7 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>
    %8 = llvm.getelementptr inbounds %7[%1, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb1(%8 : !llvm.ptr<1>)
  ^bb1(%9: !llvm.ptr<1>):  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %10 = llvm.getelementptr inbounds %7[%1, %2] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    "llvm.intr.memcpy"(%7, %5, %6) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()
    llvm.br ^bb1(%10 : !llvm.ptr<1>)
  ^bb3:  // pred: ^bb1
    %11 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
    llvm.return %11 : i8
  }
  llvm.func @test_memcpy_after_phi(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%5 : !llvm.ptr)
  ^bb2(%6: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %7 : i32
  }
  llvm.func @addrspace_diff_keep_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%5 : !llvm.ptr)
  ^bb2(%6: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %7 : i32
  }
  llvm.func @addrspace_diff_keep_alloca_extra_gep(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    %7 = llvm.getelementptr %6[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%7 : !llvm.ptr)
  ^bb2(%8: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %9 : i32
  }
  llvm.func @addrspace_diff_remove_alloca(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%7, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    %8 = llvm.getelementptr inbounds %7[%5, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<32 x i8>
    llvm.cond_br %arg0, ^bb1, ^bb2(%8 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%7 : !llvm.ptr)
  ^bb2(%9: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %10 : i32
  }
  llvm.func @phi_loop(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.br ^bb1(%6 : !llvm.ptr)
  ^bb1(%7: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.getelementptr %7[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.cond_br %arg0, ^bb2, ^bb1(%8 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %9 : i32
  }
  llvm.func @phi_loop_different_addrspace(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    llvm.br ^bb1(%6 : !llvm.ptr)
  ^bb1(%7: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.getelementptr %7[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.cond_br %arg0, ^bb2, ^bb1(%8 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %9 : i32
  }
  llvm.func @select_same_addrspace_remove_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %6 = llvm.select %arg0, %5, %arg1 : i1, !llvm.ptr
    %7 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %7 : i8
  }
  llvm.func @select_after_memcpy_keep_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.select %arg0, %5, %arg1 : i1, !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %7 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %7 : i8
  }
  llvm.func @select_diff_addrspace_keep_alloca(%arg0: i1, %arg1: !llvm.ptr<1>) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr<1>
    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()
    %6 = llvm.select %arg0, %5, %arg1 : i1, !llvm.ptr<1>
    %7 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
    llvm.return %7 : i8
  }
  llvm.func @select_diff_addrspace_remove_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.constant(4 : i64) : i64
    %8 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%8, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    %9 = llvm.getelementptr inbounds %8[%5, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<32 x i8>
    %10 = llvm.select %arg0, %8, %9 : i1, !llvm.ptr
    %11 = llvm.getelementptr inbounds %10[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %12 = llvm.load %11 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %12 : i8
  }
  llvm.func @readonly_callee(!llvm.ptr {llvm.nocapture, llvm.readonly}) -> i8
  llvm.func @call_readonly_remove_alloca() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr<1>
    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()
    %6 = llvm.addrspacecast %5 : !llvm.ptr<1> to !llvm.ptr
    %7 = llvm.call @readonly_callee(%6) : (!llvm.ptr) -> i8
    llvm.return %7 : i8
  }
  llvm.func @call_readonly_keep_alloca2() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(16 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(16 : i32) : i32
    %7 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %8 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr<1>
    "llvm.intr.memcpy"(%8, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()
    %9 = llvm.getelementptr inbounds %8[%5, %6] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    "llvm.intr.memcpy"(%9, %7, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> ()
    %10 = llvm.addrspacecast %8 : !llvm.ptr<1> to !llvm.ptr
    %11 = llvm.call @readonly_callee(%10) : (!llvm.ptr) -> i8
    llvm.return %11 : i8
  }
}
