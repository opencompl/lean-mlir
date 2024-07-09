module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @glob(0 : i32) {addr_space = 0 : i32} : i32
  llvm.func @test1(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.intr.stacksave : !llvm.ptr
    llvm.intr.stackrestore %0 : !llvm.ptr
    %1 = llvm.alloca %arg0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test2(%arg0: !llvm.ptr) {
    llvm.intr.stackrestore %arg0 : !llvm.ptr
    llvm.return
  }
  llvm.func @foo(%arg0: i32) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %4, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "slt" %arg0, %2 : i32
    %7 = llvm.select %6, %2, %arg0 : i1, i32
    llvm.br ^bb2(%0 : i32)
  ^bb2(%8: i32):  // 2 preds: ^bb1, ^bb2
    %9 = llvm.intr.stacksave : !llvm.ptr
    %10 = llvm.alloca %arg0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %11 = llvm.getelementptr %10[%5] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.store %3, %11 {alignment = 1 : i64} : i8, !llvm.ptr
    %12 = llvm.intr.stacksave : !llvm.ptr
    %13 = llvm.alloca %arg0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %14 = llvm.intr.stacksave : !llvm.ptr
    %15 = llvm.alloca %arg0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %16 = llvm.intr.stacksave : !llvm.ptr
    %17 = llvm.alloca %arg0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.call @bar(%8, %10, %13, %15, %17, %arg0) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.intr.stackrestore %16 : !llvm.ptr
    llvm.intr.stackrestore %14 : !llvm.ptr
    llvm.intr.stackrestore %12 : !llvm.ptr
    llvm.intr.stackrestore %9 : !llvm.ptr
    %18 = llvm.add %8, %2  : i32
    %19 = llvm.icmp "eq" %18, %7 : i32
    llvm.cond_br %19, ^bb3, ^bb2(%18 : i32)
  ^bb3:  // 2 preds: ^bb0, ^bb2
    llvm.return
  }
  llvm.func @bar(i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32)
  llvm.func @inalloca_callee(!llvm.ptr {llvm.inalloca = i32})
  llvm.func @test3(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.addressof @glob : !llvm.ptr
    llvm.br ^bb1(%0 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.intr.stacksave : !llvm.ptr
    %5 = llvm.alloca inalloca %1 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %0, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.call @inalloca_callee(%5) : (!llvm.ptr) -> ()
    llvm.intr.stackrestore %4 : !llvm.ptr
    %6 = llvm.intr.stacksave : !llvm.ptr
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.intr.stackrestore %6 : !llvm.ptr
    %7 = llvm.add %1, %3  : i32
    %8 = llvm.icmp "eq" %7, %arg0 : i32
    llvm.cond_br %8, ^bb1(%7 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @test4(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    llvm.br ^bb1(%0, %0 : i32, i32)
  ^bb1(%3: i32, %4: i32):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.intr.stacksave : !llvm.ptr
    %6 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %7 = llvm.mul %6, %arg0 overflow<nsw>  : i32
    %8 = llvm.add %7, %3 overflow<nsw>  : i32
    llvm.intr.stackrestore %5 : !llvm.ptr
    %9 = llvm.load %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.mul %9, %arg0 overflow<nsw>  : i32
    %11 = llvm.add %10, %8 overflow<nsw>  : i32
    llvm.intr.stackrestore %5 : !llvm.ptr
    %12 = llvm.add %4, %1 overflow<nsw, nuw>  : i32
    %13 = llvm.icmp "eq" %12, %2 : i32
    llvm.cond_br %13, ^bb2, ^bb1(%11, %12 : i32, i32)
  ^bb2:  // pred: ^bb1
    llvm.return %11 : i32
  }
}
