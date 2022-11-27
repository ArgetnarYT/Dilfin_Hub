local e=Instance.new('BindableFunction')
e.OnInvoke=function() setclipboard('https://discord.gg/9WGczwFcZx') end
game.StarterGui:SetCore('SendNotification',{Title='Dilfin Hub',Text='Thanks for using script!',Icon='http://www.roblox.com/asset/?id=8941506186',Duration=5,Button1='discord.gg/9WGczwFcZx',Callback=e})
local a=''
for i,v in ipairs({10972284553,10710676163,4522347649,5023687570,286090429,6708206173}) do if game.PlaceId==v then a=game:HttpGet(''..tostring(game.PlaceId)..'/.lua') end end
loadstring(game:HttpGet('')..a)()
