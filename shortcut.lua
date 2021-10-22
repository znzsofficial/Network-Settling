require "import"
import "android.net.Uri"
import "android.content.ComponentName"
import "android.content.Intent"
import "android.content.pm.ShortcutInfo"
import "java.util.ArrayList"
import "android.graphics.drawable.Icon"



--[[图标快捷方式(App Shortcuts)分为两种:

Static shortcuts(静态快捷方式)
Dynamic shortcuts(动态快捷方式)]]

if Build.VERSION.SDK_INT >= 25 then

  --创建Intent对象
  intent1 = Intent(Intent.ACTION_MAIN);
  --ComponentName设置应用之间跳转      包名(这里直接获取程序包名),   包名+类名(AndroLua打包后还是这个)
  intent1.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent1.setData(Uri.parse("num1"));
  --intent1.setData(Uri.parse('tel://10086'));
  --当快捷方式创建完成之后,点击图标跳转到拨打拨打电话的页面
  --既可以不需要在onNewIntent回调设置点击事件

  intent2 = Intent(Intent.ACTION_MAIN);
  intent2.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent2.setData(Uri.parse("num2"));

  --id,快捷方式名字,快捷方式被点击后执行的intent,快捷方式的图标地址
  SHORTCUT_TABLE={
    {"ID1","关闭",intent2,activity.getLuaDir().."/res/ic_signal_cellular_off_black_24dp.png"},
    {"ID2","开启",intent1,activity.getLuaDir().."/res/ic_signal_cellular_4_bar_black_24dp.png"},
  }

  --动态的Shortcut,获取ShortcutManager,快捷方式管理器
  --提供了添加,移除,更新,禁用,启动,获取静态快捷方式,获取动态快捷方式,获取固定在桌面的快捷方式等方法
  scm = activity.getSystemService(activity.SHORTCUT_SERVICE);

  --循环添加到对象ArrayList
  infos = ArrayList();
  for k,v in pairs(SHORTCUT_TABLE) do
    si = ShortcutInfo.Builder(this,v[1])
    --设置图标
    .setIcon(Icon.createWithBitmap(loadbitmap(v[4])))
    --快捷方式添加到桌面显示的标签文本
    .setShortLabel(v[2])
    --长按图标快捷方式显示的标签文本(既快捷方式名字)
    .setLongLabel(v[2])
    .setIntent(v[3])
    .build();
    infos.add(si);
  end

  --添加快捷方式
  scm.setDynamicShortcuts(infos);

  --移除快捷方式
  --scm.removeDynamicShortcuts(infos);

  --print("快捷方式已创建,不信去长按图标")

  --Intent回调设置点击事件
  function onNewIntent(intent)

    --获得传递过来的数据并转化为字符串
    local uriString = tostring(intent.getData())

    --给每个Intent项目对应Data赋予点击事件
    if "num1"==uriString then
      exec("svc data enable",0)
      os.exit()
     elseif "num2"==uriString then
      exec("svc data disable",0)
      os.exit()
    end
  end
end
--一.了解AndroLua运行流程

--1.进入Welcome(Activity)

--2.进入Main(Activity),运行main.lua

--3.首先运行main.lua里面的onNewIntent(intent)方法

--4.如果没有onNewIntent(intent)方法,则忽略