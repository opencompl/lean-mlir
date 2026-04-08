
define i8 @main(i24 %0) {
  %2 = trunc nuw nsw i24 %0 to i8
  ret i8 %2
}
