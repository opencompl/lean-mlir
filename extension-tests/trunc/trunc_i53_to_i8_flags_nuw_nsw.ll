
define i8 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i8
  ret i8 %2
}
