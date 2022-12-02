''
  * {
    font-family: Material Design Icons, Iosevka Nerd Font;
  }

  button:hover {
    background-color: rgba(80,100,100,0.4);
  }

  window#waybar {
    background-color: #303446;
    border-radius: 0px;
    color: #c6d0f5;
    font-size: 20px;
    /* transition-property: background-color; */
    transition-duration: 0.5s;

    font-size: 18px;
    transition-property: background-color;
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  #workspaces {
    font-size: 15px;
    background-color: #414559;
  }

  #workspaces button {
    padding: 0px 5px;
    min-width: 5px;
    color: rgba(255,255,255,0.8);
  }

  #workspaces button:hover {
    background-color: rgba(0,0,0,0.2);
  }

  /*#workspaces button.focused {*/
  #workspaces button.active {
    color: rgba(255,255,255,0.8);
    background-color: rgba(80,100,100,0.4);
  }

  #workspaces button.visible {
    color: #ccffff;
  }

  #workspaces button.hidden {
    color: #999999;
  }

  #workspace,
  #mode,
  #clock,
  #pulseaudio,
  #custom-sink,
  #mpd,
  #memory,
  #network,
  #window,
  #cpu,
  #disk,
  #battery,
  #tray {
    color: #999999;
    background-clip: padding-box;
  }

  #custom-menu {
    color: #A7C7E7;
    padding: 0px 5px 0px 5px;
  }

  #custom-power {
    color: #e78284;
  }

  #clock {
    font-weight: 700;
    font-size: 20px;
    padding: 5px 0px 5px 0px;
    font-family: "Iosevka Term";
  }
  #battery.warning {
    color: #ff5d17;
  }

  #battery.critical {
    color: #ff200c;
  }

  #battery.charging {
    color: #9ece6a;
  }

  tooltip {
    font-family: 'Lato', sans-serif;
    border-radius: 15px;
    padding: 20px;
    margin: 30px;
  }

  tooltip label {
    font-family: 'Lato', sans-serif;
    padding: 20px;
  }
''
