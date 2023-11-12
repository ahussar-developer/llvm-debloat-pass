; ModuleID = 'input_for_hello.c'
source_filename = "input_for_hello.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i32 @foo(i32 %0) local_unnamed_addr #0 {
  %2 = shl nsw i32 %0, 1
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i32 @bar(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = call i32 @foo(i32 %1)
  %4 = shl nsw i32 %3, 1
  %5 = add nsw i32 %4, %0
  ret i32 %5
}

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i32 @fez(i32 %0, i32 %1, i32 %2) local_unnamed_addr #0 {
  %4 = call i32 @bar(i32 %0, i32 %1)
  %5 = shl nsw i32 %4, 1
  %6 = mul nsw i32 %2, 3
  %7 = add i32 %6, %0
  %8 = add i32 %7, %5
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i32 @main(i32 %0, i8** nocapture readnone %1) local_unnamed_addr #0 {
  %3 = call i32 @foo(i32 123)
  %4 = call i32 @bar(i32 123, i32 %3)
  %5 = add nsw i32 %4, %3
  %6 = call i32 @fez(i32 123, i32 %5, i32 123)
  %7 = add nsw i32 %5, %6
  ret i32 %7
}

attributes #0 = { norecurse nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 11.1.0 (https://github.com/llvm/llvm-project 1fdec59bffc11ae37eb51a1b9869f0696bfd5312)"}
