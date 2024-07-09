module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fu1(%arg0: i32) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(2048 : i32) : i32
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %7 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.shl %9, %3 overflow<nuw>  : i32
    %11 = llvm.add %10, %4 overflow<nuw>  : i32
    %12 = llvm.alloca %11 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.store %12, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %13 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @bar(!llvm.ptr)
  llvm.func @fu2(%arg0: i32) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(2048 : i32) : i32
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %7 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.mul %9, %3 overflow<nuw>  : i32
    %11 = llvm.add %10, %4  : i32
    %12 = llvm.alloca %11 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.store %12, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %13 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }
}
