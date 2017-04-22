part of heroes;

String arrayTemplate (List list, [String wrap]){
  StringBuffer sb = new StringBuffer();
  if(wrap==null){
    list.forEach((item){
      sb.write(item);
    });
  }else{
    list.forEach((item){
      sb.write(wrap.replaceAll("{{.}}", item));
    });
  }
  return sb.toString();
}

String templateHero(Hero hero){
  return '''
    <div class="heroWidgetTabs">
    <ul>
        <li id="heroWidgetOverview" class="selectedTabButton">Přehled</li>
        <li id="heroWidgetItems">Předměty</li>
        <li id="heroWidgetAbilities">Schopnosti</li>
        <li id="heroWidgetSpeed">Rychlost</li>
        <li id="heroWidgetAttack">Útok</li>
        <li id="heroWidgetArmor">Zbroj</li>
        ${/*<li id="heroWidgetOthers">Ostatní</li>*/""}
    </ul>
</div>
<hr class="clearer" />
<div id="heroWidgetActions">
    <div id="itemTarget" class="sloupec">Sem položte předmět nebo schopnost...</div>
    <div class="sourceAbilities">
        <div class="physicalAbilities sloupec">
            Síla: ${hero.calculated.strength}
                <button class="addSource str" ${hero.data.canPhysical?"":"disabled"}>+</button>
                <button class="reduceSource str" ${hero.data.floatStrength>0?"":"disabled"}>-</button><br>
            Obratnost: ${hero.calculated.agility} 
                <button class="addSource agil" ${hero.data.canPhysical?"":"disabled"}>+</button>
                <button class="reduceSource agil" ${hero.data.floatAgility>0?"":"disabled"}>-</button> <br>
            Inteligence: ${hero.calculated.intelligence} 
                <button class="addSource int" ${hero.data.canPhysical?"":"disabled"}>+</button>
                <button class="reduceSource int" ${hero.data.floatIntelligence>0?"":"disabled"}>-</button> <br>
        </div>
        <div class="mysticalAbilities sloupec">
            Přesnost: ${hero.data.precision}
            <button class="addSource precision" ${hero.data.canMystical?"":"disabled"}>+</button>
            <button class="addSource precision ten" ${hero.data.canTenMystical?"":"disabled"}>+10</button>
            <button class="reduceSource precision" ${hero.data.floatPrecision>0?"":"disabled"}>-</button> <br>
            Energie: ${hero.data.energy}
            <button class="addSource energy" ${hero.data.canMystical?"":"disabled"}>+</button>
            <button class="addSource energy ten" ${hero.data.canTenMystical?"":"disabled"}>+10</button>
            <button class="reduceSource energy"  ${hero.data.floatEnergy>0?"":"disabled"}>-</button> <br>
            Temnota: ${hero.data.darkness}
            <button class="addSource darkness" ${hero.data.canMystical?"":"disabled"}>+</button>
            <button class="addSource darkness ten"  ${hero.data.canTenMystical?"":"disabled"}>+10</button>
            <button class="reduceSource darkness"  ${hero.data.floatDarkness>0?"":"disabled"}>-</button> <br>
        </div>
    </div>
    <hr class="clearer" />
</div>


<div id="heroWidgetOverviewTab" class="heroWidgetTab selectedTab">
    <h1>${hero.data.name}</h1>
    <div class="resultAbils inTab">
        Životy: ${hero.out.health}<br>
        Mana: ${hero.out.mana}<br>
        Dostřel: ${hero.out.range}<br>
        Rychlost: ${hero.out.speed}<br>
        Zbroj: ${hero.out.armor}<br>
        Útok: ${hero.out.attackString}<br>
    </div>
    <div class="heroLevel inTab">
        level: <span class="_heroLevel">${hero.calculated.level}</span><br>
        zkušenosti:  <input type="text" value="${hero.data.experience}" class="_heroExperience">
    </div>
    <div class="inTab">
        Síla s bonusy: ${hero.calculated.strength} <br>
        Obratnost s bonusy: ${hero.calculated.agility} <br>
        Inteligence s bonusy: ${hero.calculated.intelligence} <br>
    </div>

</div>

<div id="heroWidgetSpeedTab" class="heroWidgetTab">
    <strong>Výsledná rychlost: ${hero.out.speed}</strong><br><br>
    Síla s bonusy: ${hero.calculated.strength} <br>
    Obratnost s bonusy: ${hero.calculated.agility} <br>
    Hmotnost těla: ${hero.calculated.bodyWeight}<br>
    Hmotnost předmětů: ${hero.calculated.itemWeight}<br>
    Hmotnost: ${hero.calculated.weight}<br>
    Body rychlosti: ${hero.calculated.speedPoints.toStringAsPrecision(3)}<br>
    Nepoužité body rychlosti: ${hero.calculated.speedPrecisionPoints.toStringAsPrecision(3)}<br>
    <p>V nízkých rychlostech rozhoduje síla/hmotnost. Ve vyšších rychlostech hraje roli také obratnost.</p>
    <p>Chybí-li vám do dalšího bodu rychlosti malá část, zvýší se přesnost vašeho útoku.</p>
</div>

<div id="heroWidgetArmorTab" class="heroWidgetTab">
    <strong>Výsledná zbroj: ${hero.out.armor}</strong><br><br>
    Životy: ${hero.out.health}<br>
    
    Síla na hmotnost: ${hero.calculated.strengthOnHeightArmor.toStringAsPrecision(3)}<br>    
    Obratnost na hmotnost: ${hero.calculated.agilityOnHeightArmor.toStringAsPrecision(3)}<br>
    Nezaokrouhlené body zbroje: ${hero.calculated.unflooredArmorPoints.toStringAsPrecision(3)}<br>
    Hodnocení zbroje: ${hero.calculated.armorPoints}<br>
    Životy jako kompenzace nevyužité zbroje: ${hero.calculated.armorHealth}<br><br>
Před postupem na další bod zbroje lze jako mezibonus získat jeden život navíc. Tento život se ubere po přidání bodu zbroje.<br><br>
    <table>
                <tr>
                    <td>Hodnocení zbroje</td>
                    <td>zbroj</td>
                    <td>životy</td>
                </tr>
                <tr><td>0</td><td>0</td><td>0</td></tr>
                <tr><td>1</td><td>0</td><td>1</td></tr>
                <tr><td>2</td><td>1</td><td>0</td></tr>
                <tr><td>3</td><td>1</td><td>1</td></tr>
                <tr><td>4</td><td>2</td><td>0</td></tr>
                <tr><td>5</td><td>2</td><td>1</td></tr>
                <tr><td>6</td><td>3</td><td>0</td></tr>
                <tr><td>7</td><td>3</td><td>1</td></tr>
                <tr><td>8</td><td>4</td><td>0</td></tr>
                <tr><td>9</td><td>4</td><td>1</td></tr>
            </table>
</div>

<div id="heroWidgetAttackTab" class="heroWidgetTab">
    <strong>Výsledný útok: ${hero.out.attackString}</strong><br><br>
    Rychlost: ${hero.out.speed}<br>
    
    Součet zranění: ${hero.calculated.damage}<br>
    Přesnost: ${hero.calculated.precision}<br>
    Stylovost zbraně: ${hero.calculated.suitability}<br>
    Použitelnost zbraně: ${hero.calculated.usability}<br>
    
    Nepoužité body rychlosti: ${hero.calculated.speedPrecisionPoints.toStringAsPrecision(3)}<br>
    Body přesnosti: ${hero.calculated.precisionPoints.toStringAsPrecision(3)}<br>
    Nepoužité body do přesnosti: ${hero.calculated.unusedPrecisionPoints.toStringAsPrecision(3)}<br>
</div>

<div id="heroWidgetOthersTab" class="heroWidgetTab">

</div>
<div id="heroWidgetItemsTab" class="heroWidgetTab">

</div>
<div id="heroWidgetAbilitiesTab" class="heroWidgetTab">

</div>
</div>
  ''';
}