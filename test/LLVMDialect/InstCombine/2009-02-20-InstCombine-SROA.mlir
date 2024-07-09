module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @_Z3fooRSt6vectorIiSaIiEE(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.alloca %0 x !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.alloca %0 x !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %9 = llvm.alloca %0 x !llvm.struct<"struct.std::bidirectional_iterator_tag", packed (i8)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %10 = llvm.alloca %0 x !llvm.struct<"struct.std::bidirectional_iterator_tag", packed (i8)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %11 = llvm.alloca %0 x !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %12 = llvm.alloca %0 x !llvm.struct<"struct.std::bidirectional_iterator_tag", packed (i8)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %13 = llvm.alloca %0 x !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %14 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %15 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %14 {alignment = 4 : i64} : i32, !llvm.ptr
    %16 = llvm.getelementptr %arg0[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.std::vector<int,std::allocator<int> >", (struct<"struct.std::_Vector_base<int,std::allocator<int> >", (struct<"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl", (ptr, ptr, ptr)>)>)>
    %17 = llvm.getelementptr %16[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.std::_Vector_base<int,std::allocator<int> >", (struct<"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl", (ptr, ptr, ptr)>)>
    %18 = llvm.getelementptr %17[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl", (ptr, ptr, ptr)>
    %19 = llvm.load %18 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %20 = llvm.getelementptr %13[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %19, %20 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %21 = llvm.getelementptr %13[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %22 = llvm.load %21 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %23 = llvm.ptrtoint %22 : !llvm.ptr to i32
    %24 = llvm.inttoptr %23 : i32 to !llvm.ptr
    %25 = llvm.ptrtoint %24 : !llvm.ptr to i32
    %26 = llvm.inttoptr %25 : i32 to !llvm.ptr
    %27 = llvm.getelementptr %arg0[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.std::vector<int,std::allocator<int> >", (struct<"struct.std::_Vector_base<int,std::allocator<int> >", (struct<"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl", (ptr, ptr, ptr)>)>)>
    %28 = llvm.getelementptr %27[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.std::_Vector_base<int,std::allocator<int> >", (struct<"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl", (ptr, ptr, ptr)>)>
    %29 = llvm.getelementptr %28[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl", (ptr, ptr, ptr)>
    %30 = llvm.load %29 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %31 = llvm.getelementptr %6[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %30, %31 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %32 = llvm.getelementptr %6[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %33 = llvm.load %32 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %34 = llvm.ptrtoint %33 : !llvm.ptr to i32
    %35 = llvm.inttoptr %34 : i32 to !llvm.ptr
    %36 = llvm.ptrtoint %35 : !llvm.ptr to i32
    %37 = llvm.inttoptr %36 : i32 to !llvm.ptr
    %38 = llvm.getelementptr %11[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %37, %38 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %39 = llvm.load %10 {alignment = 1 : i64} : !llvm.ptr -> i8
    %40 = llvm.or %39, %3  : i8
    %41 = llvm.or %40, %3  : i8
    %42 = llvm.or %41, %3  : i8
    llvm.store %3, %12 {alignment = 1 : i64} : i8, !llvm.ptr
    %43 = llvm.getelementptr %11[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %44 = llvm.load %43 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    "llvm.intr.memcpy"(%9, %12, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %45 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %44, %45 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %46 = llvm.getelementptr %8[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %26, %46 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %47 = llvm.getelementptr %8[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %48 = llvm.load %47 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %49 = llvm.ptrtoint %48 : !llvm.ptr to i32
    %50 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %51 = llvm.load %50 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %52 = llvm.ptrtoint %51 : !llvm.ptr to i32
    %53 = llvm.sub %49, %52  : i32
    %54 = llvm.ashr %53, %5  : i32
    %55 = llvm.ashr %54, %5  : i32
    llvm.br ^bb10(%55 : i32)
  ^bb1:  // pred: ^bb10
    %56 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %57 = llvm.load %56 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %58 = llvm.load %57 {alignment = 4 : i64} : !llvm.ptr -> i32
    %59 = llvm.load %14 {alignment = 4 : i64} : !llvm.ptr -> i32
    %60 = llvm.icmp "eq" %58, %59 : i32
    %61 = llvm.zext %60 : i1 to i8
    %62 = llvm.icmp "ne" %61, %3 : i8
    llvm.cond_br %62, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %63 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %64 = llvm.load %63 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb22(%64 : !llvm.ptr)
  ^bb3:  // pred: ^bb1
    %65 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %66 = llvm.load %65 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %67 = llvm.getelementptr %66[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %68 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %67, %68 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %69 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %70 = llvm.load %69 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %71 = llvm.load %70 {alignment = 4 : i64} : !llvm.ptr -> i32
    %72 = llvm.load %14 {alignment = 4 : i64} : !llvm.ptr -> i32
    %73 = llvm.icmp "eq" %71, %72 : i32
    %74 = llvm.zext %73 : i1 to i8
    %75 = llvm.icmp "ne" %74, %3 : i8
    llvm.cond_br %75, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %76 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %77 = llvm.load %76 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb22(%77 : !llvm.ptr)
  ^bb5:  // pred: ^bb3
    %78 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %79 = llvm.load %78 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %80 = llvm.getelementptr %79[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %81 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %80, %81 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %82 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %83 = llvm.load %82 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %84 = llvm.load %83 {alignment = 4 : i64} : !llvm.ptr -> i32
    %85 = llvm.load %14 {alignment = 4 : i64} : !llvm.ptr -> i32
    %86 = llvm.icmp "eq" %84, %85 : i32
    %87 = llvm.zext %86 : i1 to i8
    %88 = llvm.icmp "ne" %87, %3 : i8
    llvm.cond_br %88, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %89 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %90 = llvm.load %89 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb22(%90 : !llvm.ptr)
  ^bb7:  // pred: ^bb5
    %91 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %92 = llvm.load %91 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %93 = llvm.getelementptr %92[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %94 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %93, %94 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %95 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %96 = llvm.load %95 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %97 = llvm.load %96 {alignment = 4 : i64} : !llvm.ptr -> i32
    %98 = llvm.load %14 {alignment = 4 : i64} : !llvm.ptr -> i32
    %99 = llvm.icmp "eq" %97, %98 : i32
    %100 = llvm.zext %99 : i1 to i8
    %101 = llvm.icmp "ne" %100, %3 : i8
    llvm.cond_br %101, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %102 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %103 = llvm.load %102 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb22(%103 : !llvm.ptr)
  ^bb9:  // pred: ^bb7
    %104 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %105 = llvm.load %104 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %106 = llvm.getelementptr %105[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %107 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %106, %107 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %108 = llvm.sub %109, %0  : i32
    llvm.br ^bb10(%108 : i32)
  ^bb10(%109: i32):  // 2 preds: ^bb0, ^bb9
    %110 = llvm.icmp "sgt" %109, %1 : i32
    llvm.cond_br %110, ^bb1, ^bb11
  ^bb11:  // pred: ^bb10
    %111 = llvm.getelementptr %8[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %112 = llvm.load %111 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %113 = llvm.ptrtoint %112 : !llvm.ptr to i32
    %114 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %115 = llvm.load %114 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %116 = llvm.ptrtoint %115 : !llvm.ptr to i32
    %117 = llvm.sub %113, %116  : i32
    %118 = llvm.ashr %117, %5  : i32
    llvm.switch %118 : i32, ^bb21 [
      1: ^bb18,
      2: ^bb15,
      3: ^bb12
    ]
  ^bb12:  // pred: ^bb11
    %119 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %120 = llvm.load %119 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %121 = llvm.load %120 {alignment = 4 : i64} : !llvm.ptr -> i32
    %122 = llvm.load %14 {alignment = 4 : i64} : !llvm.ptr -> i32
    %123 = llvm.icmp "eq" %121, %122 : i32
    %124 = llvm.zext %123 : i1 to i8
    %125 = llvm.icmp "ne" %124, %3 : i8
    llvm.cond_br %125, ^bb13, ^bb14
  ^bb13:  // pred: ^bb12
    %126 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %127 = llvm.load %126 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb22(%127 : !llvm.ptr)
  ^bb14:  // pred: ^bb12
    %128 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %129 = llvm.load %128 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %130 = llvm.getelementptr %129[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %131 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %130, %131 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.br ^bb15
  ^bb15:  // 2 preds: ^bb11, ^bb14
    %132 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %133 = llvm.load %132 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %134 = llvm.load %133 {alignment = 4 : i64} : !llvm.ptr -> i32
    %135 = llvm.load %14 {alignment = 4 : i64} : !llvm.ptr -> i32
    %136 = llvm.icmp "eq" %134, %135 : i32
    %137 = llvm.zext %136 : i1 to i8
    %138 = llvm.icmp "ne" %137, %3 : i8
    llvm.cond_br %138, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    %139 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %140 = llvm.load %139 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb22(%140 : !llvm.ptr)
  ^bb17:  // pred: ^bb15
    %141 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %142 = llvm.load %141 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %143 = llvm.getelementptr %142[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %144 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %143, %144 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.br ^bb18
  ^bb18:  // 2 preds: ^bb11, ^bb17
    %145 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %146 = llvm.load %145 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %147 = llvm.load %146 {alignment = 4 : i64} : !llvm.ptr -> i32
    %148 = llvm.load %14 {alignment = 4 : i64} : !llvm.ptr -> i32
    %149 = llvm.icmp "eq" %147, %148 : i32
    %150 = llvm.zext %149 : i1 to i8
    %151 = llvm.icmp "ne" %150, %3 : i8
    llvm.cond_br %151, ^bb19, ^bb20
  ^bb19:  // pred: ^bb18
    %152 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %153 = llvm.load %152 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb22(%153 : !llvm.ptr)
  ^bb20:  // pred: ^bb18
    %154 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %155 = llvm.load %154 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %156 = llvm.getelementptr %155[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %157 = llvm.getelementptr %7[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    llvm.store %156, %157 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.br ^bb21
  ^bb21:  // 2 preds: ^bb11, ^bb20
    %158 = llvm.getelementptr %8[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", (ptr)>
    %159 = llvm.load %158 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb22(%159 : !llvm.ptr)
  ^bb22(%160: !llvm.ptr):  // 8 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb13, ^bb16, ^bb19, ^bb21
    %161 = llvm.ptrtoint %160 : !llvm.ptr to i32
    %162 = llvm.inttoptr %161 : i32 to !llvm.ptr
    %163 = llvm.ptrtoint %162 : !llvm.ptr to i32
    %164 = llvm.inttoptr %163 : i32 to !llvm.ptr
    %165 = llvm.ptrtoint %164 : !llvm.ptr to i32
    %166 = llvm.inttoptr %165 : i32 to !llvm.ptr
    %167 = llvm.ptrtoint %166 : !llvm.ptr to i32
    %168 = llvm.inttoptr %167 : i32 to !llvm.ptr
    %169 = llvm.ptrtoint %168 : !llvm.ptr to i32
    llvm.br ^bb23
  ^bb23:  // pred: ^bb22
    %170 = llvm.inttoptr %169 : i32 to !llvm.ptr
    llvm.return %170 : !llvm.ptr
  }
}
