import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-vector-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: !llvm.ptr, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: !llvm.ptr, %arg13: !llvm.ptr, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: !llvm.ptr, %arg17: !llvm.ptr, %arg18: !llvm.ptr, %arg19: !llvm.ptr, %arg20: !llvm.ptr, %arg21: !llvm.ptr, %arg22: !llvm.ptr, %arg23: !llvm.ptr, %arg24: !llvm.ptr, %arg25: !llvm.ptr, %arg26: !llvm.ptr, %arg27: !llvm.ptr, %arg28: !llvm.ptr, %arg29: !llvm.ptr, %arg30: !llvm.ptr, %arg31: !llvm.ptr, %arg32: !llvm.ptr, %arg33: !llvm.ptr, %arg34: !llvm.ptr, %arg35: !llvm.ptr, %arg36: !llvm.ptr, %arg37: !llvm.ptr, %arg38: !llvm.ptr, %arg39: !llvm.ptr, %arg40: !llvm.ptr, %arg41: !llvm.ptr, %arg42: !llvm.ptr, %arg43: !llvm.ptr, %arg44: !llvm.ptr, %arg45: !llvm.ptr, %arg46: !llvm.ptr, %arg47: !llvm.ptr, %arg48: !llvm.ptr, %arg49: !llvm.ptr, %arg50: !llvm.ptr, %arg51: !llvm.ptr, %arg52: !llvm.ptr, %arg53: !llvm.ptr, %arg54: !llvm.ptr, %arg55: !llvm.ptr, %arg56: !llvm.ptr, %arg57: !llvm.ptr, %arg58: !llvm.ptr, %arg59: !llvm.ptr, %arg60: !llvm.ptr, %arg61: !llvm.ptr, %arg62: !llvm.ptr, %arg63: !llvm.ptr) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.mlir.constant(dense<[9, 87, 57, 8]> : vector<4xi32>) : vector<4xi32>
    %5 = llvm.mlir.constant(true) : i1
    %6 = llvm.mlir.constant(dense<[true, false, false, false]> : vector<4xi1>) : vector<4xi1>
    %7 = llvm.mlir.constant(dense<[44, 99, 49, 29]> : vector<4xi32>) : vector<4xi32>
    %8 = llvm.mlir.constant(dense<[false, true, false, false]> : vector<4xi1>) : vector<4xi1>
    %9 = llvm.mlir.constant(dense<[15, 18, 53, 84]> : vector<4xi32>) : vector<4xi32>
    %10 = llvm.mlir.constant(dense<[true, true, false, false]> : vector<4xi1>) : vector<4xi1>
    %11 = llvm.mlir.constant(dense<[29, 82, 45, 16]> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.mlir.constant(dense<[false, false, true, false]> : vector<4xi1>) : vector<4xi1>
    %13 = llvm.mlir.constant(dense<[11, 15, 32, 99]> : vector<4xi32>) : vector<4xi32>
    %14 = llvm.mlir.constant(dense<[true, false, true, false]> : vector<4xi1>) : vector<4xi1>
    %15 = llvm.mlir.constant(dense<[19, 86, 29, 33]> : vector<4xi32>) : vector<4xi32>
    %16 = llvm.mlir.constant(dense<[false, true, true, false]> : vector<4xi1>) : vector<4xi1>
    %17 = llvm.mlir.constant(dense<[44, 10, 26, 45]> : vector<4xi32>) : vector<4xi32>
    %18 = llvm.mlir.constant(dense<[true, true, true, false]> : vector<4xi1>) : vector<4xi1>
    %19 = llvm.mlir.constant(dense<[88, 70, 90, 48]> : vector<4xi32>) : vector<4xi32>
    %20 = llvm.mlir.constant(dense<[false, false, false, true]> : vector<4xi1>) : vector<4xi1>
    %21 = llvm.mlir.constant(dense<[30, 53, 42, 12]> : vector<4xi32>) : vector<4xi32>
    %22 = llvm.mlir.constant(dense<[true, false, false, true]> : vector<4xi1>) : vector<4xi1>
    %23 = llvm.mlir.constant(dense<[46, 24, 93, 26]> : vector<4xi32>) : vector<4xi32>
    %24 = llvm.mlir.constant(dense<[false, true, false, true]> : vector<4xi1>) : vector<4xi1>
    %25 = llvm.mlir.constant(dense<[33, 99, 15, 57]> : vector<4xi32>) : vector<4xi32>
    %26 = llvm.mlir.constant(dense<[true, true, false, true]> : vector<4xi1>) : vector<4xi1>
    %27 = llvm.mlir.constant(dense<[51, 60, 60, 50]> : vector<4xi32>) : vector<4xi32>
    %28 = llvm.mlir.constant(dense<[false, false, true, true]> : vector<4xi1>) : vector<4xi1>
    %29 = llvm.mlir.constant(dense<[50, 12, 7, 45]> : vector<4xi32>) : vector<4xi32>
    %30 = llvm.mlir.constant(dense<[true, false, true, true]> : vector<4xi1>) : vector<4xi1>
    %31 = llvm.mlir.constant(dense<[15, 65, 36, 36]> : vector<4xi32>) : vector<4xi32>
    %32 = llvm.mlir.constant(dense<[false, true, true, true]> : vector<4xi1>) : vector<4xi1>
    %33 = llvm.mlir.constant(dense<[54, 0, 17, 78]> : vector<4xi32>) : vector<4xi32>
    %34 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %35 = llvm.mlir.constant(dense<[56, 13, 64, 48]> : vector<4xi32>) : vector<4xi32>
    %36 = llvm.mlir.constant(dense<[52, 69, 88, 11]> : vector<4xi32>) : vector<4xi32>
    %37 = llvm.mlir.constant(dense<[5, 87, 68, 14]> : vector<4xi32>) : vector<4xi32>
    %38 = llvm.mlir.constant(dense<[47, 17, 66, 63]> : vector<4xi32>) : vector<4xi32>
    %39 = llvm.mlir.constant(dense<[64, 25, 73, 81]> : vector<4xi32>) : vector<4xi32>
    %40 = llvm.mlir.constant(dense<[51, 41, 61, 63]> : vector<4xi32>) : vector<4xi32>
    %41 = llvm.mlir.constant(dense<[39, 59, 17, 0]> : vector<4xi32>) : vector<4xi32>
    %42 = llvm.mlir.constant(dense<[91, 99, 97, 29]> : vector<4xi32>) : vector<4xi32>
    %43 = llvm.mlir.constant(dense<[89, 45, 89, 10]> : vector<4xi32>) : vector<4xi32>
    %44 = llvm.mlir.constant(dense<[25, 70, 21, 27]> : vector<4xi32>) : vector<4xi32>
    %45 = llvm.mlir.constant(dense<[40, 12, 27, 88]> : vector<4xi32>) : vector<4xi32>
    %46 = llvm.mlir.constant(dense<[36, 35, 90, 23]> : vector<4xi32>) : vector<4xi32>
    %47 = llvm.mlir.constant(dense<[83, 3, 64, 82]> : vector<4xi32>) : vector<4xi32>
    %48 = llvm.mlir.constant(dense<[15, 72, 2, 54]> : vector<4xi32>) : vector<4xi32>
    %49 = llvm.mlir.constant(dense<[32, 47, 100, 84]> : vector<4xi32>) : vector<4xi32>
    %50 = llvm.mlir.constant(dense<[92, 57, 82, 1]> : vector<4xi32>) : vector<4xi32>
    %51 = llvm.mlir.constant(dense<[42, 14, 22, 89]> : vector<4xi32>) : vector<4xi32>
    %52 = llvm.mlir.constant(dense<[33, 10, 67, 66]> : vector<4xi32>) : vector<4xi32>
    %53 = llvm.mlir.constant(dense<[42, 91, 47, 40]> : vector<4xi32>) : vector<4xi32>
    %54 = llvm.mlir.constant(dense<[8, 13, 48, 0]> : vector<4xi32>) : vector<4xi32>
    %55 = llvm.mlir.constant(dense<[84, 66, 87, 84]> : vector<4xi32>) : vector<4xi32>
    %56 = llvm.mlir.constant(dense<[85, 96, 1, 94]> : vector<4xi32>) : vector<4xi32>
    %57 = llvm.mlir.constant(dense<[54, 57, 7, 92]> : vector<4xi32>) : vector<4xi32>
    %58 = llvm.mlir.constant(dense<[55, 21, 92, 68]> : vector<4xi32>) : vector<4xi32>
    %59 = llvm.mlir.constant(dense<[51, 61, 62, 39]> : vector<4xi32>) : vector<4xi32>
    %60 = llvm.mlir.constant(dense<[42, 18, 77, 74]> : vector<4xi32>) : vector<4xi32>
    %61 = llvm.mlir.constant(dense<[82, 33, 30, 7]> : vector<4xi32>) : vector<4xi32>
    %62 = llvm.mlir.constant(dense<[80, 92, 61, 84]> : vector<4xi32>) : vector<4xi32>
    %63 = llvm.mlir.constant(dense<[43, 89, 92, 6]> : vector<4xi32>) : vector<4xi32>
    %64 = llvm.mlir.constant(dense<[49, 14, 62, 62]> : vector<4xi32>) : vector<4xi32>
    %65 = llvm.mlir.constant(dense<[35, 33, 92, 59]> : vector<4xi32>) : vector<4xi32>
    %66 = llvm.mlir.constant(dense<[3, 97, 49, 18]> : vector<4xi32>) : vector<4xi32>
    %67 = llvm.mlir.constant(dense<[56, 64, 19, 75]> : vector<4xi32>) : vector<4xi32>
    %68 = llvm.mlir.constant(dense<[91, 57, 0, 1]> : vector<4xi32>) : vector<4xi32>
    %69 = llvm.mlir.constant(dense<[43, 63, 64, 11]> : vector<4xi32>) : vector<4xi32>
    %70 = llvm.mlir.constant(dense<[41, 65, 18, 11]> : vector<4xi32>) : vector<4xi32>
    %71 = llvm.mlir.constant(dense<[86, 26, 31, 3]> : vector<4xi32>) : vector<4xi32>
    %72 = llvm.mlir.constant(dense<[31, 46, 32, 68]> : vector<4xi32>) : vector<4xi32>
    %73 = llvm.mlir.constant(dense<[100, 59, 62, 6]> : vector<4xi32>) : vector<4xi32>
    %74 = llvm.mlir.constant(dense<[76, 67, 87, 7]> : vector<4xi32>) : vector<4xi32>
    %75 = llvm.mlir.constant(dense<[63, 48, 97, 24]> : vector<4xi32>) : vector<4xi32>
    %76 = llvm.mlir.constant(dense<[83, 89, 19, 4]> : vector<4xi32>) : vector<4xi32>
    %77 = llvm.mlir.constant(dense<[21, 2, 40, 21]> : vector<4xi32>) : vector<4xi32>
    %78 = llvm.mlir.constant(dense<[45, 76, 81, 100]> : vector<4xi32>) : vector<4xi32>
    %79 = llvm.mlir.constant(dense<[65, 26, 100, 46]> : vector<4xi32>) : vector<4xi32>
    %80 = llvm.mlir.constant(dense<[16, 75, 31, 17]> : vector<4xi32>) : vector<4xi32>
    %81 = llvm.mlir.constant(dense<[37, 66, 86, 65]> : vector<4xi32>) : vector<4xi32>
    %82 = llvm.mlir.constant(dense<[13, 25, 43, 59]> : vector<4xi32>) : vector<4xi32>
    %83 = llvm.mlir.constant(dense<[82, 78, 60, 52]> : vector<4xi32>) : vector<4xi32>
    %84 = llvm.select %1, %3, %4 : vector<4xi1>, vector<4xi32>
    %85 = llvm.select %6, %3, %7 : vector<4xi1>, vector<4xi32>
    %86 = llvm.select %8, %3, %9 : vector<4xi1>, vector<4xi32>
    %87 = llvm.select %10, %3, %11 : vector<4xi1>, vector<4xi32>
    %88 = llvm.select %12, %3, %13 : vector<4xi1>, vector<4xi32>
    %89 = llvm.select %14, %3, %15 : vector<4xi1>, vector<4xi32>
    %90 = llvm.select %16, %3, %17 : vector<4xi1>, vector<4xi32>
    %91 = llvm.select %18, %3, %19 : vector<4xi1>, vector<4xi32>
    %92 = llvm.select %20, %3, %21 : vector<4xi1>, vector<4xi32>
    %93 = llvm.select %22, %3, %23 : vector<4xi1>, vector<4xi32>
    %94 = llvm.select %24, %3, %25 : vector<4xi1>, vector<4xi32>
    %95 = llvm.select %26, %3, %27 : vector<4xi1>, vector<4xi32>
    %96 = llvm.select %28, %3, %29 : vector<4xi1>, vector<4xi32>
    %97 = llvm.select %30, %3, %31 : vector<4xi1>, vector<4xi32>
    %98 = llvm.select %32, %3, %33 : vector<4xi1>, vector<4xi32>
    %99 = llvm.select %34, %3, %35 : vector<4xi1>, vector<4xi32>
    %100 = llvm.select %1, %36, %3 : vector<4xi1>, vector<4xi32>
    %101 = llvm.select %6, %37, %3 : vector<4xi1>, vector<4xi32>
    %102 = llvm.select %8, %38, %3 : vector<4xi1>, vector<4xi32>
    %103 = llvm.select %10, %39, %3 : vector<4xi1>, vector<4xi32>
    %104 = llvm.select %12, %40, %3 : vector<4xi1>, vector<4xi32>
    %105 = llvm.select %14, %41, %3 : vector<4xi1>, vector<4xi32>
    %106 = llvm.select %16, %42, %3 : vector<4xi1>, vector<4xi32>
    %107 = llvm.select %18, %43, %3 : vector<4xi1>, vector<4xi32>
    %108 = llvm.select %20, %44, %3 : vector<4xi1>, vector<4xi32>
    %109 = llvm.select %22, %45, %3 : vector<4xi1>, vector<4xi32>
    %110 = llvm.select %24, %46, %3 : vector<4xi1>, vector<4xi32>
    %111 = llvm.select %26, %47, %3 : vector<4xi1>, vector<4xi32>
    %112 = llvm.select %28, %48, %3 : vector<4xi1>, vector<4xi32>
    %113 = llvm.select %30, %49, %3 : vector<4xi1>, vector<4xi32>
    %114 = llvm.select %32, %50, %3 : vector<4xi1>, vector<4xi32>
    %115 = llvm.select %34, %51, %3 : vector<4xi1>, vector<4xi32>
    %116 = llvm.select %1, %52, %53 : vector<4xi1>, vector<4xi32>
    %117 = llvm.select %6, %54, %55 : vector<4xi1>, vector<4xi32>
    %118 = llvm.select %8, %56, %57 : vector<4xi1>, vector<4xi32>
    %119 = llvm.select %10, %58, %59 : vector<4xi1>, vector<4xi32>
    %120 = llvm.select %12, %60, %61 : vector<4xi1>, vector<4xi32>
    %121 = llvm.select %14, %62, %63 : vector<4xi1>, vector<4xi32>
    %122 = llvm.select %16, %64, %65 : vector<4xi1>, vector<4xi32>
    %123 = llvm.select %18, %66, %67 : vector<4xi1>, vector<4xi32>
    %124 = llvm.select %20, %68, %69 : vector<4xi1>, vector<4xi32>
    %125 = llvm.select %22, %70, %71 : vector<4xi1>, vector<4xi32>
    %126 = llvm.select %24, %72, %73 : vector<4xi1>, vector<4xi32>
    %127 = llvm.select %26, %74, %75 : vector<4xi1>, vector<4xi32>
    %128 = llvm.select %28, %76, %77 : vector<4xi1>, vector<4xi32>
    %129 = llvm.select %30, %78, %79 : vector<4xi1>, vector<4xi32>
    %130 = llvm.select %32, %80, %81 : vector<4xi1>, vector<4xi32>
    %131 = llvm.select %34, %82, %83 : vector<4xi1>, vector<4xi32>
    %132 = llvm.select %1, %3, %3 : vector<4xi1>, vector<4xi32>
    %133 = llvm.select %6, %3, %3 : vector<4xi1>, vector<4xi32>
    %134 = llvm.select %8, %3, %3 : vector<4xi1>, vector<4xi32>
    %135 = llvm.select %10, %3, %3 : vector<4xi1>, vector<4xi32>
    %136 = llvm.select %12, %3, %3 : vector<4xi1>, vector<4xi32>
    %137 = llvm.select %14, %3, %3 : vector<4xi1>, vector<4xi32>
    %138 = llvm.select %16, %3, %3 : vector<4xi1>, vector<4xi32>
    %139 = llvm.select %18, %3, %3 : vector<4xi1>, vector<4xi32>
    %140 = llvm.select %20, %3, %3 : vector<4xi1>, vector<4xi32>
    %141 = llvm.select %22, %3, %3 : vector<4xi1>, vector<4xi32>
    %142 = llvm.select %24, %3, %3 : vector<4xi1>, vector<4xi32>
    %143 = llvm.select %26, %3, %3 : vector<4xi1>, vector<4xi32>
    %144 = llvm.select %28, %3, %3 : vector<4xi1>, vector<4xi32>
    %145 = llvm.select %30, %3, %3 : vector<4xi1>, vector<4xi32>
    %146 = llvm.select %32, %3, %3 : vector<4xi1>, vector<4xi32>
    %147 = llvm.select %34, %3, %3 : vector<4xi1>, vector<4xi32>
    llvm.store %84, %arg0 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %85, %arg1 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %86, %arg2 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %87, %arg3 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %88, %arg4 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %89, %arg5 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %90, %arg6 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %91, %arg7 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %92, %arg8 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %93, %arg9 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %94, %arg10 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %95, %arg11 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %96, %arg12 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %97, %arg13 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %98, %arg14 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %99, %arg15 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %100, %arg16 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %101, %arg17 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %102, %arg18 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %103, %arg19 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %104, %arg20 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %105, %arg21 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %106, %arg22 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %107, %arg23 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %108, %arg24 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %109, %arg25 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %110, %arg26 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %111, %arg27 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %112, %arg28 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %113, %arg29 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %114, %arg30 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %115, %arg31 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %116, %arg32 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %117, %arg33 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %118, %arg34 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %119, %arg35 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %120, %arg36 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %121, %arg37 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %122, %arg38 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %123, %arg39 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %124, %arg40 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %125, %arg41 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %126, %arg42 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %127, %arg43 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %128, %arg44 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %129, %arg45 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %130, %arg46 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %131, %arg47 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %132, %arg48 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %133, %arg49 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %134, %arg50 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %135, %arg51 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %136, %arg52 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %137, %arg53 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %138, %arg54 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %139, %arg55 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %140, %arg56 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %141, %arg57 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %142, %arg58 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %143, %arg59 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %144, %arg60 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %145, %arg61 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %146, %arg62 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %147, %arg63 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: !llvm.ptr, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: !llvm.ptr, %arg13: !llvm.ptr, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: !llvm.ptr, %arg17: !llvm.ptr, %arg18: !llvm.ptr, %arg19: !llvm.ptr, %arg20: !llvm.ptr, %arg21: !llvm.ptr, %arg22: !llvm.ptr, %arg23: !llvm.ptr, %arg24: !llvm.ptr, %arg25: !llvm.ptr, %arg26: !llvm.ptr, %arg27: !llvm.ptr, %arg28: !llvm.ptr, %arg29: !llvm.ptr, %arg30: !llvm.ptr, %arg31: !llvm.ptr, %arg32: !llvm.ptr, %arg33: !llvm.ptr, %arg34: !llvm.ptr, %arg35: !llvm.ptr, %arg36: !llvm.ptr, %arg37: !llvm.ptr, %arg38: !llvm.ptr, %arg39: !llvm.ptr, %arg40: !llvm.ptr, %arg41: !llvm.ptr, %arg42: !llvm.ptr, %arg43: !llvm.ptr, %arg44: !llvm.ptr, %arg45: !llvm.ptr, %arg46: !llvm.ptr, %arg47: !llvm.ptr, %arg48: !llvm.ptr, %arg49: !llvm.ptr, %arg50: !llvm.ptr, %arg51: !llvm.ptr, %arg52: !llvm.ptr, %arg53: !llvm.ptr, %arg54: !llvm.ptr, %arg55: !llvm.ptr, %arg56: !llvm.ptr, %arg57: !llvm.ptr, %arg58: !llvm.ptr, %arg59: !llvm.ptr, %arg60: !llvm.ptr, %arg61: !llvm.ptr, %arg62: !llvm.ptr, %arg63: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[9, 87, 57, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, 99, 49, 29]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[15, 0, 53, 84]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[0, 0, 45, 16]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.mlir.constant(dense<[11, 15, 0, 99]> : vector<4xi32>) : vector<4xi32>
    %5 = llvm.mlir.constant(dense<[0, 86, 0, 33]> : vector<4xi32>) : vector<4xi32>
    %6 = llvm.mlir.constant(dense<[44, 0, 0, 45]> : vector<4xi32>) : vector<4xi32>
    %7 = llvm.mlir.constant(dense<[0, 0, 0, 48]> : vector<4xi32>) : vector<4xi32>
    %8 = llvm.mlir.constant(dense<[30, 53, 42, 0]> : vector<4xi32>) : vector<4xi32>
    %9 = llvm.mlir.constant(dense<[0, 24, 93, 0]> : vector<4xi32>) : vector<4xi32>
    %10 = llvm.mlir.constant(dense<[33, 0, 15, 0]> : vector<4xi32>) : vector<4xi32>
    %11 = llvm.mlir.constant(dense<[0, 0, 60, 0]> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.mlir.constant(dense<[50, 12, 0, 0]> : vector<4xi32>) : vector<4xi32>
    %13 = llvm.mlir.constant(dense<[0, 65, 0, 0]> : vector<4xi32>) : vector<4xi32>
    %14 = llvm.mlir.constant(dense<[54, 0, 0, 0]> : vector<4xi32>) : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %17 = llvm.mlir.constant(dense<[5, 0, 0, 0]> : vector<4xi32>) : vector<4xi32>
    %18 = llvm.mlir.constant(dense<[0, 17, 0, 0]> : vector<4xi32>) : vector<4xi32>
    %19 = llvm.mlir.constant(dense<[64, 25, 0, 0]> : vector<4xi32>) : vector<4xi32>
    %20 = llvm.mlir.constant(dense<[0, 0, 61, 0]> : vector<4xi32>) : vector<4xi32>
    %21 = llvm.mlir.constant(dense<[39, 0, 17, 0]> : vector<4xi32>) : vector<4xi32>
    %22 = llvm.mlir.constant(dense<[0, 99, 97, 0]> : vector<4xi32>) : vector<4xi32>
    %23 = llvm.mlir.constant(dense<[89, 45, 89, 0]> : vector<4xi32>) : vector<4xi32>
    %24 = llvm.mlir.constant(dense<[0, 0, 0, 27]> : vector<4xi32>) : vector<4xi32>
    %25 = llvm.mlir.constant(dense<[40, 0, 0, 88]> : vector<4xi32>) : vector<4xi32>
    %26 = llvm.mlir.constant(dense<[0, 35, 0, 23]> : vector<4xi32>) : vector<4xi32>
    %27 = llvm.mlir.constant(dense<[83, 3, 0, 82]> : vector<4xi32>) : vector<4xi32>
    %28 = llvm.mlir.constant(dense<[0, 0, 2, 54]> : vector<4xi32>) : vector<4xi32>
    %29 = llvm.mlir.constant(dense<[32, 0, 100, 84]> : vector<4xi32>) : vector<4xi32>
    %30 = llvm.mlir.constant(dense<[0, 57, 82, 1]> : vector<4xi32>) : vector<4xi32>
    %31 = llvm.mlir.constant(dense<[42, 14, 22, 89]> : vector<4xi32>) : vector<4xi32>
    %32 = llvm.mlir.constant(dense<[42, 91, 47, 40]> : vector<4xi32>) : vector<4xi32>
    %33 = llvm.mlir.constant(dense<[8, 66, 87, 84]> : vector<4xi32>) : vector<4xi32>
    %34 = llvm.mlir.constant(dense<[54, 96, 7, 92]> : vector<4xi32>) : vector<4xi32>
    %35 = llvm.mlir.constant(dense<[55, 21, 62, 39]> : vector<4xi32>) : vector<4xi32>
    %36 = llvm.mlir.constant(dense<[82, 33, 77, 7]> : vector<4xi32>) : vector<4xi32>
    %37 = llvm.mlir.constant(dense<[80, 89, 61, 6]> : vector<4xi32>) : vector<4xi32>
    %38 = llvm.mlir.constant(dense<[35, 14, 62, 59]> : vector<4xi32>) : vector<4xi32>
    %39 = llvm.mlir.constant(dense<[3, 97, 49, 75]> : vector<4xi32>) : vector<4xi32>
    %40 = llvm.mlir.constant(dense<[43, 63, 64, 1]> : vector<4xi32>) : vector<4xi32>
    %41 = llvm.mlir.constant(dense<[41, 26, 31, 11]> : vector<4xi32>) : vector<4xi32>
    %42 = llvm.mlir.constant(dense<[100, 46, 62, 68]> : vector<4xi32>) : vector<4xi32>
    %43 = llvm.mlir.constant(dense<[76, 67, 97, 7]> : vector<4xi32>) : vector<4xi32>
    %44 = llvm.mlir.constant(dense<[21, 2, 19, 4]> : vector<4xi32>) : vector<4xi32>
    %45 = llvm.mlir.constant(dense<[45, 26, 81, 100]> : vector<4xi32>) : vector<4xi32>
    %46 = llvm.mlir.constant(dense<[37, 75, 31, 17]> : vector<4xi32>) : vector<4xi32>
    %47 = llvm.mlir.constant(dense<[13, 25, 43, 59]> : vector<4xi32>) : vector<4xi32>
    llvm.store %0, %arg0 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %1, %arg1 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %2, %arg2 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %3, %arg3 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %4, %arg4 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %5, %arg5 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %6, %arg6 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %7, %arg7 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %8, %arg8 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %9, %arg9 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %10, %arg10 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %11, %arg11 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %12, %arg12 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %13, %arg13 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %14, %arg14 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg15 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg16 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %17, %arg17 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %18, %arg18 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %19, %arg19 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %20, %arg20 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %21, %arg21 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %22, %arg22 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %23, %arg23 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %24, %arg24 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %25, %arg25 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %26, %arg26 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %27, %arg27 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %28, %arg28 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %29, %arg29 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %30, %arg30 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %31, %arg31 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %32, %arg32 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %33, %arg33 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %34, %arg34 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %35, %arg35 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %36, %arg36 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %37, %arg37 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %38, %arg38 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %39, %arg39 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %40, %arg40 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %41, %arg41 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %42, %arg42 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %43, %arg43 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %44, %arg44 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %45, %arg45 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %46, %arg46 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %47, %arg47 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg48 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg49 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg50 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg51 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg52 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg53 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg54 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg55 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg56 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg57 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg58 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg59 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg60 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg61 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg62 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %16, %arg63 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
