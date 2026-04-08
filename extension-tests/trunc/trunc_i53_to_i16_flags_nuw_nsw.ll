
define i16 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i16
  ret i16 %2
}
