module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 32 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @G("%s\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str("foog\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global internal constant @str1("blahhh!\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global internal constant @str2("Ponk\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global external constant @_2E_str() {addr_space = 0 : i32} : !llvm.array<5 x i8>
  llvm.mlir.global external constant @".str13"() {addr_space = 0 : i32} : !llvm.array<2 x i8>
  llvm.mlir.global external constant @".str14"() {addr_space = 0 : i32} : !llvm.array<2 x i8>
  llvm.mlir.global external constant @h("h\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @hel("hel\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @hello_u("hello_u\00") {addr_space = 0 : i32}
  llvm.mlir.global external @a("123\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global external @b(dense<0> : tensor<5xi8>) {addr_space = 0 : i32, dso_local} : !llvm.array<5 x i8>
  llvm.func @sprintf(!llvm.ptr, !llvm.ptr, ...) -> i16
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @G : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1, %arg1) vararg(!llvm.func<i16 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i16
    llvm.return
  }
  llvm.func @test1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("foog\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @str : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i16) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.mlir.constant(103 : i16) : i16
    %6 = llvm.call @strchr(%4, %5) : (!llvm.ptr, i16) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @strchr(!llvm.ptr, i16) -> !llvm.ptr
  llvm.func @test2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("blahhh!\00") : !llvm.array<8 x i8>
    %3 = llvm.mlir.addressof @str1 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<8 x i8>
    %5 = llvm.mlir.constant(0 : i16) : i16
    %6 = llvm.call @strchr(%4, %5) : (!llvm.ptr, i16) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @test3() -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("Ponk\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @str2 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.mlir.constant(80 : i16) : i16
    %6 = llvm.call @strchr(%4, %5) : (!llvm.ptr, i16) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @memcmp(!llvm.ptr, !llvm.ptr, i16) -> i16 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]}
  llvm.func @PR2341(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @_2E_str : !llvm.ptr
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %4 = llvm.call @memcmp(%3, %0, %1) : (!llvm.ptr, !llvm.ptr, i16) -> i16
    %5 = llvm.icmp "eq" %4, %2 : i16
    llvm.return %5 : i1
  }
  llvm.func @PR4284() -> i16 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.mlir.constant(-127 : i8) : i8
    %3 = llvm.mlir.constant(1 : i16) : i16
    %4 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %4 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %2, %5 {alignment = 1 : i64} : i8, !llvm.ptr
    %6 = llvm.call @memcmp(%4, %5, %3) : (!llvm.ptr, !llvm.ptr, i16) -> i16
    llvm.return %6 : i16
  }
  llvm.func @PR4641(%arg0: i32, %arg1: !llvm.ptr, %arg2: i1, %arg3: !llvm.ptr) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.addressof @".str13" : !llvm.ptr
    %2 = llvm.mlir.addressof @".str14" : !llvm.ptr
    llvm.call @exit(%0) : (i16) -> ()
    %3 = llvm.select %arg2, %1, %2 : i1, !llvm.ptr
    %4 = llvm.call @fopen(%arg3, %3) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.unreachable
  }
  llvm.func @fopen(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @exit(i16)
  llvm.func @PR4645(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @exit(%0) : (i16) -> ()
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // pred: ^bb1
    llvm.unreachable
  }
  llvm.func @MemCpy() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("h\00") : !llvm.array<2 x i8>
    %2 = llvm.mlir.addressof @h : !llvm.ptr
    %3 = llvm.mlir.constant(2 : i16) : i16
    %4 = llvm.mlir.constant("hel\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @hel : !llvm.ptr
    %6 = llvm.mlir.constant(4 : i16) : i16
    %7 = llvm.mlir.constant("hello_u\00") : !llvm.array<8 x i8>
    %8 = llvm.mlir.addressof @hello_u : !llvm.ptr
    %9 = llvm.mlir.constant(8 : i16) : i16
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.alloca %0 x !llvm.array<1024 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%11, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i16) -> ()
    "llvm.intr.memcpy"(%11, %5, %6) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i16) -> ()
    "llvm.intr.memcpy"(%11, %8, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i16) -> ()
    llvm.return %10 : i32
  }
  llvm.func @strcmp(!llvm.ptr, !llvm.ptr) -> i16 attributes {passthrough = ["nobuiltin"]}
  llvm.func @test9(%arg0: !llvm.ptr) {
    %0 = llvm.call @strcmp(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> i16
    llvm.return
  }
  llvm.func @isdigit(i8) -> i32
  llvm.func @isascii(i8) -> i32
  llvm.func @toascii(i8) -> i32
  llvm.func @fake_isdigit(%arg0: i8) -> i32 {
    %0 = llvm.call @isdigit(%arg0) : (i8) -> i32
    llvm.return %0 : i32
  }
  llvm.func @fake_isascii(%arg0: i8) -> i32 {
    %0 = llvm.call @isascii(%arg0) : (i8) -> i32
    llvm.return %0 : i32
  }
  llvm.func @fake_toascii(%arg0: i8) -> i32 {
    %0 = llvm.call @toascii(%arg0) : (i8) -> i32
    llvm.return %0 : i32
  }
  llvm.func @pow(f64, f64) -> f64
  llvm.func @exp2(f64) -> f64
  llvm.func @fake_exp2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @fake_ldexp(%arg0: i32) -> f64 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @fake_ldexp_16(%arg0: i16) -> f64 {
    %0 = llvm.sitofp %arg0 : i16 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @snprintf(!llvm.ptr, f64, !llvm.ptr) -> i16
  llvm.func @fake_snprintf(%arg0: i32, %arg1: f64, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i16 {
    %0 = llvm.call @snprintf(%arg3, %arg1, %arg2) : (!llvm.ptr, f64, !llvm.ptr) -> i16
    llvm.return %0 : i16
  }
  llvm.func @strlen(%arg0: !llvm.ptr) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i4
    llvm.return %0 : i4
  }
  llvm.func @__stpncpy_chk(!llvm.ptr {llvm.noundef}, !llvm.ptr {llvm.noundef}, i32 {llvm.noundef}, i32 {llvm.noundef}) -> !llvm.ptr
  llvm.func @emit_stpncpy() -> (i32 {llvm.signext}) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<5xi8>) : !llvm.array<5 x i8>
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(5 : i32) : i32
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.call @__stpncpy_chk(%2, %4, %5, %6) : (!llvm.ptr, !llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %7 : i32
  }
}
