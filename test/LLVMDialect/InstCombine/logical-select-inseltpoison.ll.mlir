module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.sext %1 : i1 to i32
    %3 = llvm.and %arg2, %2  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %arg3, %4  : i32
    %6 = llvm.or %3, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @bar(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.sext %1 : i1 to i32
    %3 = llvm.and %arg2, %2  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %arg3, %4  : i32
    %6 = llvm.or %5, %3  : i32
    llvm.return %6 : i32
  }
  llvm.func @goo(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.xor %3, %0  : i32
    %6 = llvm.and %5, %arg3  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @poo(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.select %2, %1, %0 : i1, i32
    %6 = llvm.and %5, %arg3  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @fold_inverted_icmp_preds(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.select %1, %arg2, %0 : i1, i32
    %3 = llvm.icmp "sge" %arg0, %arg1 : i32
    %4 = llvm.select %3, %arg3, %0 : i1, i32
    %5 = llvm.or %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @fold_inverted_icmp_preds_reverse(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.select %1, %0, %arg2 : i1, i32
    %3 = llvm.icmp "sge" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %arg3 : i1, i32
    %5 = llvm.or %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @fold_inverted_fcmp_preds(%arg0: f32, %arg1: f32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f32
    %2 = llvm.select %1, %arg2, %0 : i1, i32
    %3 = llvm.fcmp "uge" %arg0, %arg1 : f32
    %4 = llvm.select %3, %arg3, %0 : i1, i32
    %5 = llvm.or %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @fold_inverted_icmp_vector_preds(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg2, %1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "eq" %arg0, %arg1 : vector<2xi32>
    %5 = llvm.select %4, %arg3, %1 : vector<2xi1>, vector<2xi32>
    %6 = llvm.or %3, %5  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @par(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.xor %3, %0  : i32
    %6 = llvm.and %5, %arg3  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @bitcast_select_swap0(%arg0: vector<4xi1>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.fptosi %arg1 : vector<2xf64> to vector<2xi64>
    %2 = llvm.fptosi %arg2 : vector<2xf64> to vector<2xi64>
    %3 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %4 = llvm.bitcast %3 : vector<4xi32> to vector<2xi64>
    %5 = llvm.and %4, %1  : vector<2xi64>
    %6 = llvm.xor %3, %0  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    %8 = llvm.and %7, %2  : vector<2xi64>
    %9 = llvm.or %5, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @bitcast_select_swap1(%arg0: vector<4xi1>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.fptosi %arg1 : vector<2xf64> to vector<2xi64>
    %2 = llvm.fptosi %arg2 : vector<2xf64> to vector<2xi64>
    %3 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %4 = llvm.bitcast %3 : vector<4xi32> to vector<2xi64>
    %5 = llvm.and %4, %1  : vector<2xi64>
    %6 = llvm.xor %3, %0  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    %8 = llvm.and %7, %2  : vector<2xi64>
    %9 = llvm.or %8, %5  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @bitcast_select_swap2(%arg0: vector<4xi1>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.fptosi %arg1 : vector<2xf64> to vector<2xi64>
    %2 = llvm.fptosi %arg2 : vector<2xf64> to vector<2xi64>
    %3 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %4 = llvm.bitcast %3 : vector<4xi32> to vector<2xi64>
    %5 = llvm.and %4, %1  : vector<2xi64>
    %6 = llvm.xor %3, %0  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    %8 = llvm.and %2, %7  : vector<2xi64>
    %9 = llvm.or %5, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @bitcast_select_swap3(%arg0: vector<4xi1>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.fptosi %arg1 : vector<2xf64> to vector<2xi64>
    %2 = llvm.fptosi %arg2 : vector<2xf64> to vector<2xi64>
    %3 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %4 = llvm.bitcast %3 : vector<4xi32> to vector<2xi64>
    %5 = llvm.and %4, %1  : vector<2xi64>
    %6 = llvm.xor %3, %0  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    %8 = llvm.and %2, %7  : vector<2xi64>
    %9 = llvm.or %8, %5  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @bitcast_select_swap4(%arg0: vector<4xi1>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.fptosi %arg1 : vector<2xf64> to vector<2xi64>
    %2 = llvm.fptosi %arg2 : vector<2xf64> to vector<2xi64>
    %3 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %4 = llvm.bitcast %3 : vector<4xi32> to vector<2xi64>
    %5 = llvm.and %1, %4  : vector<2xi64>
    %6 = llvm.xor %3, %0  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    %8 = llvm.and %7, %2  : vector<2xi64>
    %9 = llvm.or %5, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @bitcast_select_swap5(%arg0: vector<4xi1>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.fptosi %arg1 : vector<2xf64> to vector<2xi64>
    %2 = llvm.fptosi %arg2 : vector<2xf64> to vector<2xi64>
    %3 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %4 = llvm.bitcast %3 : vector<4xi32> to vector<2xi64>
    %5 = llvm.and %1, %4  : vector<2xi64>
    %6 = llvm.xor %3, %0  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    %8 = llvm.and %7, %2  : vector<2xi64>
    %9 = llvm.or %8, %5  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @bitcast_select_swap6(%arg0: vector<4xi1>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.fptosi %arg1 : vector<2xf64> to vector<2xi64>
    %2 = llvm.fptosi %arg2 : vector<2xf64> to vector<2xi64>
    %3 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %4 = llvm.bitcast %3 : vector<4xi32> to vector<2xi64>
    %5 = llvm.and %1, %4  : vector<2xi64>
    %6 = llvm.xor %3, %0  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    %8 = llvm.and %2, %7  : vector<2xi64>
    %9 = llvm.or %5, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @bitcast_select_swap7(%arg0: vector<4xi1>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.fptosi %arg1 : vector<2xf64> to vector<2xi64>
    %2 = llvm.fptosi %arg2 : vector<2xf64> to vector<2xi64>
    %3 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %4 = llvm.bitcast %3 : vector<4xi32> to vector<2xi64>
    %5 = llvm.and %1, %4  : vector<2xi64>
    %6 = llvm.xor %3, %0  : vector<4xi32>
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    %8 = llvm.and %2, %7  : vector<2xi64>
    %9 = llvm.or %8, %5  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @bitcast_select_multi_uses(%arg0: vector<4xi1>, %arg1: vector<2xi64>, %arg2: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<2xi64>
    %3 = llvm.and %arg1, %2  : vector<2xi64>
    %4 = llvm.xor %1, %0  : vector<4xi32>
    %5 = llvm.bitcast %4 : vector<4xi32> to vector<2xi64>
    %6 = llvm.and %arg2, %5  : vector<2xi64>
    %7 = llvm.or %6, %3  : vector<2xi64>
    %8 = llvm.add %6, %5  : vector<2xi64>
    %9 = llvm.sub %7, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @bools(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg0  : i1
    %3 = llvm.and %arg2, %arg1  : i1
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @bools_logical(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    %4 = llvm.select %arg2, %arg1, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools_multi_uses1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg0  : i1
    %3 = llvm.and %arg2, %arg1  : i1
    %4 = llvm.or %2, %3  : i1
    %5 = llvm.xor %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @bools_multi_uses1_logical(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    %4 = llvm.select %arg2, %arg1, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    %6 = llvm.xor %5, %3  : i1
    llvm.return %6 : i1
  }
  llvm.func @bools_multi_uses2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg0  : i1
    %3 = llvm.and %arg2, %arg1  : i1
    %4 = llvm.or %2, %3  : i1
    %5 = llvm.add %2, %3  : i1
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @bools_multi_uses2_logical(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    %4 = llvm.select %arg2, %arg1, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    %6 = llvm.add %3, %4  : i1
    %7 = llvm.select %5, %6, %1 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @vec_of_bools(%arg0: vector<4xi1>, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.xor %arg2, %1  : vector<4xi1>
    %3 = llvm.and %2, %arg0  : vector<4xi1>
    %4 = llvm.and %arg1, %arg2  : vector<4xi1>
    %5 = llvm.or %4, %3  : vector<4xi1>
    llvm.return %5 : vector<4xi1>
  }
  llvm.func @vec_of_casted_bools(%arg0: i4, %arg1: i4, %arg2: vector<4xi1>) -> i4 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.xor %arg2, %1  : vector<4xi1>
    %3 = llvm.bitcast %2 : vector<4xi1> to i4
    %4 = llvm.bitcast %arg2 : vector<4xi1> to i4
    %5 = llvm.and %arg0, %3  : i4
    %6 = llvm.and %4, %arg1  : i4
    %7 = llvm.or %5, %6  : i4
    llvm.return %7 : i4
  }
  llvm.func @vec_sel_consts(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[-1, 0, 0, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, -1, -1, 0]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.and %arg0, %0  : vector<4xi32>
    %3 = llvm.and %arg1, %1  : vector<4xi32>
    %4 = llvm.or %2, %3  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @vec_sel_consts_weird(%arg0: vector<3xi129>, %arg1: vector<3xi129>) -> vector<3xi129> {
    %0 = llvm.mlir.constant(-1 : i129) : i129
    %1 = llvm.mlir.constant(0 : i129) : i129
    %2 = llvm.mlir.constant(dense<[-1, 0, -1]> : vector<3xi129>) : vector<3xi129>
    %3 = llvm.mlir.constant(dense<[0, -1, 0]> : vector<3xi129>) : vector<3xi129>
    %4 = llvm.and %arg0, %2  : vector<3xi129>
    %5 = llvm.and %arg1, %3  : vector<3xi129>
    %6 = llvm.or %5, %4  : vector<3xi129>
    llvm.return %6 : vector<3xi129>
  }
  llvm.func @vec_not_sel_consts(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[-1, 0, 0, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, -1, 0, -1]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.and %arg0, %0  : vector<4xi32>
    %3 = llvm.and %arg1, %1  : vector<4xi32>
    %4 = llvm.or %2, %3  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @vec_not_sel_consts_undef_elts(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %2, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.and %arg0, %11  : vector<4xi32>
    %22 = llvm.and %arg1, %20  : vector<4xi32>
    %23 = llvm.or %21, %22  : vector<4xi32>
    llvm.return %23 : vector<4xi32>
  }
  llvm.func @vec_sel_xor(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[-1, 0, 0, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, -1, -1, -1]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sext %arg2 : vector<4xi1> to vector<4xi32>
    %3 = llvm.xor %2, %0  : vector<4xi32>
    %4 = llvm.xor %2, %1  : vector<4xi32>
    %5 = llvm.and %4, %arg0  : vector<4xi32>
    %6 = llvm.and %3, %arg1  : vector<4xi32>
    %7 = llvm.or %5, %6  : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
  llvm.func @vec_sel_xor_multi_use(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[-1, 0, 0, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, -1, -1, -1]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sext %arg2 : vector<4xi1> to vector<4xi32>
    %3 = llvm.xor %2, %0  : vector<4xi32>
    %4 = llvm.xor %2, %1  : vector<4xi32>
    %5 = llvm.and %4, %arg0  : vector<4xi32>
    %6 = llvm.and %3, %arg1  : vector<4xi32>
    %7 = llvm.or %5, %6  : vector<4xi32>
    %8 = llvm.add %7, %3  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }
  llvm.func @allSignBits(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.and %arg1, %2  : i32
    %5 = llvm.and %3, %arg2  : i32
    %6 = llvm.or %4, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @allSignBits_vec(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.ashr %arg0, %0  : vector<4xi8>
    %3 = llvm.xor %2, %1  : vector<4xi8>
    %4 = llvm.and %arg1, %2  : vector<4xi8>
    %5 = llvm.and %arg2, %3  : vector<4xi8>
    %6 = llvm.or %5, %4  : vector<4xi8>
    llvm.return %6 : vector<4xi8>
  }
  llvm.func @fp_bitcast(%arg0: vector<4xi1>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.fptosi %arg1 : vector<2xf64> to vector<2xi64>
    %1 = llvm.fptosi %arg2 : vector<2xf64> to vector<2xi64>
    %2 = llvm.bitcast %arg1 : vector<2xf64> to vector<2xi64>
    %3 = llvm.and %0, %2  : vector<2xi64>
    %4 = llvm.bitcast %arg2 : vector<2xf64> to vector<2xi64>
    %5 = llvm.and %1, %4  : vector<2xi64>
    %6 = llvm.or %5, %3  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
  llvm.func @computesignbits_through_shuffles(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.fcmp "ole" %arg0, %arg1 : vector<4xf32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 1, 1] : vector<4xi32> 
    %5 = llvm.shufflevector %3, %0 [2, 2, 3, 3] : vector<4xi32> 
    %6 = llvm.or %4, %5  : vector<4xi32>
    %7 = llvm.shufflevector %6, %0 [0, 0, 1, 1] : vector<4xi32> 
    %8 = llvm.shufflevector %6, %0 [2, 2, 3, 3] : vector<4xi32> 
    %9 = llvm.or %7, %8  : vector<4xi32>
    %10 = llvm.xor %9, %1  : vector<4xi32>
    %11 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %12 = llvm.bitcast %arg2 : vector<4xf32> to vector<4xi32>
    %13 = llvm.and %10, %11  : vector<4xi32>
    %14 = llvm.and %9, %12  : vector<4xi32>
    %15 = llvm.or %13, %14  : vector<4xi32>
    llvm.return %15 : vector<4xi32>
  }
  llvm.func @computesignbits_through_two_input_shuffle(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>, %arg3: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sext %arg2 : vector<4xi1> to vector<4xi32>
    %2 = llvm.sext %arg3 : vector<4xi1> to vector<4xi32>
    %3 = llvm.shufflevector %1, %2 [0, 2, 4, 6] : vector<4xi32> 
    %4 = llvm.xor %3, %0  : vector<4xi32>
    %5 = llvm.and %4, %arg0  : vector<4xi32>
    %6 = llvm.and %3, %arg1  : vector<4xi32>
    %7 = llvm.or %5, %6  : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
}
