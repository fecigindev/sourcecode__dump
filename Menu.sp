#include <sourcemod>
#include <sdktools>

public Plugin myinfo =
{
  name = "Plugin Pertama",
  author = "neo mark",
  description = "plugin pertama saya",
  version = "1.0.0.0",
  url = ""
}

public void OnPluginStart()
{
  RegConsoleCmd("menu_test1", Menu_Test1);
}

public int MenuHandler1(Menu menu, MenuAction action, int param1, int param2)
{
  /* Jika opsi dipilih, beri tahu klien tentang item tersebut. */
  if (action == MenuAction_Select)
  {
    char info[32];
    bool found = menu.GetItem(param2, info, sizeof(info));
    PrintToConsole(param1, "You selected item: %d (found? %d info: %s)", param2, found, info);
  }
  /* Jika menu dibatalkan, cetak pesan ke server tentang itu. */
  else if (action == MenuAction_Cancel)
  {
    PrintToServer("Client %d's menu was cancelled. Reason: %d", param1, param2);
  }
  /* Jika menu telah berakhir, hancurkan */
  else if (action == MenuAction_End)
  {
    delete menu;
  }
}

public Action Menu_Test1(int client, int args)
{
  Menu menu = new Menu(MenuHandler1);
  menu.SetTitle("ini pilihannya?");
  menu.AddItem("iya", "iya");
  menu.AddItem("tidak", "tidak");
  menu.ExitButton = false;
  menu.Display(client, 20);

  return Plugin_Handled;
}
