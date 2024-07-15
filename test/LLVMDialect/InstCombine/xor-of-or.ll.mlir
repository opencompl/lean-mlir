module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @G() {addr_space = 0 : i32} : i32
  llvm.mlir.global external @G2() {addr_space = 0 : i32} : i32
  llvm.func @t0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.or %arg0, %arg1  : i4
    %1 = llvm.xor %0, %arg2  : i4
    llvm.return %1 : i4
  }
  llvm.func @t1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.or %arg0, %0  : i4
    %3 = llvm.xor %2, %1  : i4
    llvm.return %3 : i4
  }
  llvm.func @t2(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.or %arg0, %0  : i4
    llvm.call @use(%2) : (i4) -> ()
    %3 = llvm.xor %2, %1  : i4
    llvm.return %3 : i4
  }
  llvm.func @t3(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.constant(dense<-4> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(-6 : i4) : i4
    %3 = llvm.mlir.constant(dense<-6> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.or %arg0, %1  : vector<2xi4>
    %5 = llvm.xor %4, %3  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @t4(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-4, -6]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(dense<[-6, -4]> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.or %arg0, %2  : vector<2xi4>
    %5 = llvm.xor %4, %3  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @t5(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.constant(dense<-4> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.undef : i4
    %3 = llvm.mlir.constant(-6 : i4) : i4
    %4 = llvm.mlir.undef : vector<2xi4>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi4>
    %9 = llvm.or %arg0, %1  : vector<2xi4>
    %10 = llvm.xor %9, %8  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }
  llvm.func @t6(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.undef : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(-6 : i4) : i4
    %8 = llvm.mlir.constant(dense<-6> : vector<2xi4>) : vector<2xi4>
    %9 = llvm.or %arg0, %6  : vector<2xi4>
    %10 = llvm.xor %9, %8  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }
  llvm.func @t7(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.undef : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(-6 : i4) : i4
    %8 = llvm.mlir.undef : vector<2xi4>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi4>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi4>
    %13 = llvm.or %arg0, %6  : vector<2xi4>
    %14 = llvm.xor %13, %12  : vector<2xi4>
    llvm.return %14 : vector<2xi4>
  }
  llvm.func @t8(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.constant(dense<-4> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.poison : i4
    %3 = llvm.mlir.constant(-6 : i4) : i4
    %4 = llvm.mlir.undef : vector<2xi4>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi4>
    %9 = llvm.or %arg0, %1  : vector<2xi4>
    %10 = llvm.xor %9, %8  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }
  llvm.func @t9(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.poison : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(-6 : i4) : i4
    %8 = llvm.mlir.constant(dense<-6> : vector<2xi4>) : vector<2xi4>
    %9 = llvm.or %arg0, %6  : vector<2xi4>
    %10 = llvm.xor %9, %8  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }
  llvm.func @t10(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.poison : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(-6 : i4) : i4
    %8 = llvm.mlir.undef : vector<2xi4>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi4>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi4>
    %13 = llvm.or %arg0, %6  : vector<2xi4>
    %14 = llvm.xor %13, %12  : vector<2xi4>
    llvm.return %14 : vector<2xi4>
  }
  llvm.func @t11(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.mlir.addressof @G2 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i4
    %3 = llvm.or %arg0, %0  : i4
    %4 = llvm.xor %3, %2  : i4
    llvm.return %4 : i4
  }
  llvm.func @t12(%arg0: i4) -> i4 {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i4
    %2 = llvm.mlir.constant(-6 : i4) : i4
    %3 = llvm.or %arg0, %1  : i4
    %4 = llvm.xor %3, %2  : i4
    llvm.return %4 : i4
  }
  llvm.func @t13(%arg0: i4) -> i4 {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i4
    %2 = llvm.mlir.addressof @G2 : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i4
    %4 = llvm.or %arg0, %1  : i4
    %5 = llvm.xor %4, %3  : i4
    llvm.return %5 : i4
  }
  llvm.func @use(i4)
}
