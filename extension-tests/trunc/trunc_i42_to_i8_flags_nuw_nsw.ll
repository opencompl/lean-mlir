
define i8 @main(i42 %0) {
  %2 = trunc nuw nsw i42 %0 to i8
  ret i8 %2
}
