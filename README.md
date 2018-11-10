# esx_animations
En edit på [esx_animations](https://github.com/ESX-Org/esx_animations), man kan välja favorit animation (Z) och det finns även synkade animationer. 

## Installation

 - Ladda ner [pnotify](https://forum.fivem.net/t/release-pnotify-in-game-js-notifications-using-noty/20659)

 - Ladda ner scriptet
 
 - Kör sql filen
 
 - Lägg in scriptet i /resources/[esx]/
 
 - Lägg till ```start esx_animations``` i server.cfg
 
 - För att öppna menyn, om du använder [esx_personmeny](https://github.com/xBlueSI/esx_personmeny/) lägg in ```{label = ('Animationer'), value = 'animations'},``` efter rad 160 i client.lua lägg sedan till detta efter rad 165
 ```
 if data.current.value == 'animations' then
      	TriggerEvent("esx_animations")
end
