
define i24 @main(i32 %0) {
  %2 = trunc nuw nsw i32 %0 to i24
  ret i24 %2
}
