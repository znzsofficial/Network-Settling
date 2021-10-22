require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.Context"
import "java.io.File"
import "android.net.ConnectivityManager"
import "android.graphics.Typeface"
import "android.graphics.drawable.GradientDrawable"
import "layout"
import "author"
import "modules"
activity.setTheme(android.R.style.Theme_Material_Light_NoActionBar)
import "pages"
import "android.content.Intent"
import "android.net.Uri"


--状态栏沉浸透明
import "android.graphics.Color"
local window=this.getWindow()
window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE)
window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
window.setStatusBarColor(Color.TRANSPARENT)--程序启动时会执行的事件

this.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)


title.getPaint().setFakeBoldText(true)

wifi.getPaint().setTypeface(Typeface.MONOSPACE)
data.getPaint().setTypeface(Typeface.MONOSPACE)

function exec(cmd,sh,su)
  cmd=tostring(cmd)
  if sh==true then
    cmd=io.open(cmd):read("*a")
  end
  if su==0 then
    p=io.popen(string.format('%s',cmd))
   else
    p=io.popen(string.format('%s',"su -c "..cmd))
  end
  local s=p:read("*a")
  p:close()
  return s
end

import"shortcut"


function 缓冲旋转(控件,频率)
  import "android.view.animation.Animation"
  import "android.view.animation.RotateAnimation"
  rotate = RotateAnimation(0,360,Animation.RELATIVE_TO_SELF,0.5,Animation.RELATIVE_TO_SELF,0.5)
  rotate.setDuration(频率)
  rotate.setRepeatCount(频率)
  控件.startAnimation(rotate)
end

function 水珠动画(控件,时间)
  import "android.animation.ObjectAnimator"
  ObjectAnimator().ofFloat(控件,"scaleX",{1,.8,1.3,.9,1}).setDuration(时间).start()
  ObjectAnimator().ofFloat(控件,"scaleY",{1,.8,1.3,.9,1}).setDuration(时间).start()
end


function 缩放动画(控件)
  import "android.view.animation.*"
  控件.startAnimation(ScaleAnimation(0.0,1.0,0.0,1.0,1,0.5,1,0.5).setDuration(200))
end

function 波纹特效v2(颜色)
  import"android.content.res.ColorStateList"
  return activity.Resources.getDrawable(activity.obtainStyledAttributes({android.R.attr.selectableItemBackground--[[Borderless]]}).getResourceId(0,0))
  .setColor(ColorStateList(int[0]
  .class{int{}},int{颜色 or 0x20000000}))
end
--调用方法
c0.foreground=波纹特效v2(0x22000000)
c1.foreground=波纹特效v2(0x22000000)
c2.foreground=波纹特效v2(0x22000000)
c3o.foreground=波纹特效v2(0x22000000)
c3n.foreground=波纹特效v2(0x22000000)


img.onClick=function()
  url="http://znzsofficial.github.io"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end

view=backc
color1 = 0xffFF8080;
color2 = 0xff8080FF;
color3 = 0xFFFF90DA;
color4 = 0xFFFF8D8F;
import "android.animation.ObjectAnimator"
import "android.animation.ArgbEvaluator"
import "android.animation.ValueAnimator"
import "android.graphics.Color"
colorAnim = ObjectAnimator.ofInt(view,"backgroundColor",{color1, color2, color3,color4})
colorAnim.setDuration(3000)
colorAnim.setEvaluator(ArgbEvaluator())
colorAnim.setRepeatCount(ValueAnimator.INFINITE)
colorAnim.setRepeatMode(ValueAnimator.REVERSE)
colorAnim.start()


view2=c0
color1 = 0xFFFF5151;
color2 = 0xFF39BF10;
color3 = 0xFF8870FF;
color4 = 0xFFFF9FE0;
colorAnim = ObjectAnimator.ofInt(view2,"backgroundColor",{color1, color2, color3,color4})
colorAnim.setDuration(3000)
colorAnim.setEvaluator(ArgbEvaluator())
colorAnim.setRepeatCount(ValueAnimator.INFINITE)
colorAnim.setRepeatMode(ValueAnimator.REVERSE)
colorAnim.start()





c0.onClick=function()
  wct = activity.Context.getSystemService(Context.WIFI_SERVICE)
  wct.setWifiEnabled(false)
  wct.disconnect()
  manager = activity.getSystemService(Context.CONNECTIVITY_SERVICE);
  gprs = manager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE).getState();
  if tostring(gprs)== "CONNECTED" then
    exec("svc data disable")
    exec("svc wifi enable")
   else
    exec("svc data enable")
  end

end




c1.onClick=function()
  dialog=AlertDialog.Builder(this)
  .setTitle("WIFI开关")
  .setCancelable(true)
  --.setMessage([[]])
  .setPositiveButton("开启",{onClick=function(v)
      exec("svc wifi enable")
    end})
  .setNegativeButton("关闭",{onClick=function(v)
      exec("svc wifi disable")
    end})
  .setNeutralButton("取消",{onClick=function(v)
    end})
  .show()
  dialog.create()
  dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xFFFF3F5F)
  dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xFF5F99FF)
  弹窗圆角(dialog.getWindow(),0xffffffff)
end


c2.onClick=function()
  dialog=AlertDialog.Builder(this)
  .setTitle("数据开关")
  .setCancelable(true)
  --.setMessage([[]])
  .setPositiveButton("开启",{onClick=function(v)
      exec("svc data enable")
    end})
  .setNegativeButton("关闭",{onClick=function(v)
      exec("svc data disable")
    end})
  .setNeutralButton("取消",{onClick=function(v)
    end})
  .show()
  dialog.create()
  dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xFFFF3F5F)
  dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xFF5F99FF)
  弹窗圆角(dialog.getWindow(),0xffffffff)
end


c3o.onClick=function()
  exec("svc power stayon true")
  File("/data/data/"..activity.getPackageName().."/on").mkdirs()
  os.execute("rm -r /data/data/"..activity.getPackageName().."/off")
  activity.recreate()
end

c3n.onClick=function()
  exec("svc power stayon false")
  File("/data/data/"..activity.getPackageName().."/off").mkdirs()
  os.execute("rm -r /data/data/"..activity.getPackageName().."/on")
  activity.recreate()
end

if File("/data/data/"..activity.getPackageName().."/on").exists() then
  c3o.setVisibility(View.GONE)
end


if File("/data/data/"..activity.getPackageName().."/off").exists() then
  c3n.setVisibility(View.GONE)
end
