part of heroes;

class Heroes {
  List<Hero> _heroes = new List();
  Hero _selected;
  Element _tabs;
  Element _content;
  String _selectedTabId = "heroWidgetOverview";
  Heroes() {
    _tabs = new Element.div()..classes.add("tabs");
    _content = new Element.div()..classes.add("content");
    querySelector("#heroes")..append(_tabs)..append(_content);
    renderTabs();
  }
  void add(Hero h) {
    _heroes.add(h);
    selected = h;
  }

  set selectedTabId(String id) {
    _selectedTabId = id;
    _content
        .querySelectorAll(".selectedTabButton")
        .classes
        .remove("selectedTabButton");
    _content.querySelectorAll(".selectedTab").classes.remove("selectedTab");
    _content.querySelector("#" + id).classes.add("selectedTabButton");
    _content.querySelector("#" + id + "Tab").classes.add("selectedTab");
  }

  set selected(Hero h) {
    _selected = h;
    renderTabs();
    paint();
  }

  get selected => _selected;

  void paint() {
    _content.innerHtml = templateHero(_selected);
    selectedTabId = _selectedTabId;
    addSources();
    reduceSources();
    _content
        .querySelectorAll(".heroWidgetTabs ul li")
        .onClick
        .capture((Event e) {
      Element target = e.target;
      selectedTabId = target.id;
    });
    if (NumberInputElement.supported) {
      _content
          .querySelector("._heroExperience")
          .replaceWith(new NumberInputElement()
            ..value = _selected.data.experience.toString()
            ..classes.add("_heroExperience")
            ..min = "1"
            ..onChange.capture((e) {
              experienceChanged();
            }));
    } else {
      InputElement exp = _content.querySelector("._heroExperience")
        ..onKeyUp.capture((e) {
          experienceChanged();
        });
      exp.onChange.capture((e) {
        experienceChanged();
      });
      Element plus = new Element.tag("button")
        ..innerHtml = "+"
        ..onClick.capture((e) {
          exp.value = (int.parse(exp.value) + 1).toString();
          experienceChanged();
        });
      Element minus = new Element.tag("button")
        ..innerHtml = "-"
        ..onClick.capture((e) {
          exp.value = (int.parse(exp.value) - 1).toString();
          experienceChanged();
        });

      _content.querySelector(".heroLevel")..append(plus)..append(minus);
      exp.nextElementSibling.insertBefore(plus, exp.nextElementSibling);
    }
  }

  void experienceChanged() {
    InputElement ne = _content.querySelector("._heroExperience");
    _selected.data.experience = int.parse(ne.value);
    _selected.recalc();
    _content.querySelector("._heroLevel").innerHtml =
        _selected.calculated.level.toString();
  }

  void addSources() {
    ElementList addSources = _content.querySelectorAll(".addSource");
    addSources.onClick.capture((Event event) {
      Element e = event.target;
      if (e.classes.contains("str")) {
        _selected.data.addStrength(1);
      }
      if (e.classes.contains("agil")) {
        _selected.data.addAgility(1);
      }
      if (e.classes.contains("int")) {
        _selected.data.addIntelligence(1);
      }
      if (e.classes.contains("energy")) {
        _selected.data.addEnergy(e.classes.contains("ten") ? 10 : 1);
      }
      if (e.classes.contains("darkness")) {
        _selected.data.addDarkness(e.classes.contains("ten") ? 10 : 1);
      }
      if (e.classes.contains("precision")) {
        _selected.data.addPrecision(e.classes.contains("ten") ? 10 : 1);
      }
      _selected.recalc();
      paint();
    });
  }

  void reduceSources() {
    ElementList reduceSources = _content.querySelectorAll(".reduceSource");
    reduceSources.onClick.capture((Event event) {
      Element e = event.target;
      if (e.classes.contains("str")) {
        _selected.data.reduceStrength();
      }
      if (e.classes.contains("agil")) {
        _selected.data.reduceAgility();
      }
      if (e.classes.contains("int")) {
        _selected.data.reduceIntelligence();
      }
      if (e.classes.contains("energy")) {
        _selected.data.reduceEnergy();
      }
      if (e.classes.contains("darkness")) {
        _selected.data.reduceDarkness();
      }
      if (e.classes.contains("precision")) {
        _selected.data.reducePrecision();
      }
      _selected.recalc();
      paint();
    });
  }

  Hero getById(num id) {
    for (Hero i in _heroes) {
      if (i.id == id) {
        return i;
      }
    }
  }

  renderTabs() {
    _tabs.innerHtml = '';
    for (Hero hero in _heroes) {
      Element heroTab = new Element.div()
        ..classes.add("herotab")
        ..text = hero.data.name
        ..onMouseDown.capture((e) {
          selectHero(hero);
        })
        ..onMouseMove.capture((e) {
          e.preventDefault();
          return false;
        });
      hero.tab = heroTab;
      _tabs.append(heroTab);
    }
    _tabs.append(new Element.div()
      ..innerHtml = "+"
      ..id = "createHero"
      ..onMouseDown.capture((event) => _createHero(event))
      ..onMouseUp.capture((event) {
        event.preventDefault();
        return false;
      }));
  }

  selectHero(Hero hero) {
    ElementList heroes = querySelectorAll(".herotab");
    if (heroes != null) {
      heroes.classes.remove("selected");
    }
    hero.tab.classes.add("selected");
    hero.content = _content;
    selected = hero;
    return false;
  }

  _createHero(Event e) {
    Element invoker = e.target;
    Element cont = new Element.div()..style.width = "300px";
    InputElement input = new InputElement()
      ..type = "text"
      ..style.float = "left";
    cont.append(new Element.span()
      ..innerHtml = "Jméno:"
      ..style.float = "left");
    cont.append(input);
    cont.append(new ButtonElement()
      ..style.float = "left"
      ..innerHtml = "vytvořit"
      ..onClick.capture((Event e) {
        createHero(input.value);
      }));
    input.onKeyDown.capture((KeyboardEvent e) {
      if (e.keyCode == 13) {
        createHero(input.value);
      }
    });
    new Future.delayed(const Duration(milliseconds: 10), () {
      input.focus();
    });
    invoker.replaceWith(cont);
  }

  createHero(name) {
    Hero hero = new Hero();
    hero.data.name = name;
    add(hero);
    renderTabs();
  }
}
