require "import"
import "android.content.DialogInterface"
import "android.app.AlertDialog"
import "android.view.View$OnFocusChangeListener"
import "android.app.AlertDialog$Builder"
import "android.content.DialogInterface"


function 弹窗圆角(控件,背景色,上角度,下角度)
  if not 上角度 then
    上角度=25
  end
  if not 下角度 then
    下角度=上角度
  end
  控件.setBackgroundDrawable(GradientDrawable()
  .setShape(GradientDrawable.RECTANGLE)
  .setColor(背景色)
  .setCornerRadii({上角度,上角度,上角度,上角度,下角度,下角度,下角度,下角度}))
end

