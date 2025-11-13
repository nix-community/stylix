{ mkTarget, ... }:
mkTarget {
  name = "hyprpanel";
  humanName = "HyprPanel";

  configElements = [
    (
      { fonts }:
      {
        programs.hyprpanel.settings.theme.fonts = {
          inherit (fonts.monospace) name;
          size = fonts.sizes.desktop;
        };
      }
    )
    (
      { colors }:
      {
        programs.hyprpanel.settings.theme = with colors.withHashtag; {
          bar = {
            menus = {
              menu = {
                notifications = {
                  background = base00;
                  border = base01;
                  card = base00;
                  clear = base0D;
                  label = base0D;
                  scrollbar.color = base0D;
                  no_notifications_label = base01;

                  pager = {
                    background = base00;
                    button = base0D;
                    label = base04;
                  };

                  switch = {
                    disabled = base01;
                    enabled = base0D;
                    puck = base02;
                    switch_divider = base02;
                  };
                };

                media.timestamp = base06;

                network = {
                  scroller.color = base0E;
                  switch = {
                    disabled = base01;
                    enabled = base0E;
                    puck = base02;
                  };
                };

                power = {
                  buttons = {
                    sleep = {
                      icon = base01;
                      text = base0D;
                      icon_background = base0D;
                      background = base00;
                    };

                    logout = {
                      icon = base01;
                      text = base0B;
                      icon_background = base0B;
                      background = base00;
                    };

                    restart = {
                      icon = base01;
                      text = base09;
                      icon_background = base09;
                      background = base00;
                    };

                    shutdown = {
                      icon = base01;
                      text = base08;
                      icon_background = base08;
                      background = base00;
                    };
                  };

                  border.color = base01;
                  background.color = base00;
                };

                dashboard = {
                  monitors = {
                    disk = {
                      label = base0E;
                      bar = base0E;
                      icon = base0E;
                    };

                    gpu = {
                      label = base0B;
                      bar = base0B;
                      icon = base0B;
                    };

                    ram = {
                      label = base0A;
                      bar = base0A;
                      icon = base0A;
                    };

                    cpu = {
                      label = base08;
                      bar = base08;
                      icon = base08;
                    };

                    bar_background = base02;
                  };

                  directories = {
                    right = {
                      bottom.color = base0D;
                      middle.color = base0E;
                      top.color = base0C;
                    };

                    left = {
                      bottom.color = base08;
                      middle.color = base0A;
                      top.color = base0E;
                    };
                  };

                  controls = {
                    input = {
                      text = base01;
                      background = base0E;
                    };

                    volume = {
                      text = base01;
                      background = base08;
                    };

                    notifications = {
                      text = base01;
                      background = base0A;
                    };

                    bluetooth = {
                      text = base01;
                      background = base0D;
                    };

                    wifi = {
                      text = base01;
                      background = base0E;
                    };

                    disabled = base03;
                  };

                  shortcuts = {
                    recording = base0B;
                    text = base01;
                    background = base0D;
                  };

                  powermenu = {
                    confirmation = {
                      button_text = base00;
                      deny = base0E;
                      confirm = base0C;
                      body = base06;
                      label = base0D;
                      border = base01;
                      background = base00;
                      card = base00;
                    };

                    sleep = base0D;
                    logout = base0B;
                    restart = base09;
                    shutdown = base08;
                  };

                  profile.name = base0E;
                  border.color = base01;
                  background.color = base00;
                  card.color = base00;
                };

                clock = {
                  weather = {
                    hourly = {
                      temperature = base0E;
                      icon = base0E;
                      time = base0E;
                    };

                    thermometer = {
                      extremelycold = base0D;
                      cold = base0D;
                      moderate = base0D;
                      hot = base09;
                      extremelyhot = base08;
                    };

                    stats = base0E;
                    status = base0C;
                    temperature = base06;
                    icon = base0E;
                  };

                  calendar = {
                    contextdays = base03;
                    days = base06;
                    currentday = base0E;
                    paginator = base0E;
                    weekdays = base0E;
                    yearmonth = base0C;
                  };

                  time = {
                    timeperiod = base0C;
                    time = base0E;
                  };

                  text = base06;
                  border.color = base01;
                  background.color = base00;
                  card.color = base00;
                };

                battery = {
                  slider = {
                    puck = base03;
                    backgroundhover = base02;
                    background = base03;
                    primary = base0A;
                  };

                  icons = {
                    active = base0A;
                    passive = base04;
                  };

                  listitems = {
                    active = base0A;
                    passive = base06;
                  };

                  text = base06;
                  label.color = base0A;
                  border.color = base01;
                  background.color = base00;
                  card.color = base00;
                };

                systray = {
                  dropdownmenu = {
                    divider = base00;
                    text = base06;
                    background = base00;
                  };
                };

                bluetooth = {
                  iconbutton = {
                    iconbutton.active = base0D;
                    iconbutton.passive = base06;
                  };

                  icons = {
                    icons.active = base0D;
                    icons.passive = base04;
                  };

                  listitems = {
                    active = base0D;
                    passive = base06;
                  };

                  switch = {
                    puck = base02;
                    disabled = base01;
                    enabled = base0D;
                    switch_divider = base02;
                  };

                  status = base03;
                  text = base06;
                  label.color = base0D;
                  border.color = base01;
                  background.color = base00;
                  card.color = base00;
                  scroller.color = base0D;
                };

                network = {
                  iconbuttons = {
                    active = base0E;
                    passive = base06;
                  };

                  icons = {
                    active = base0E;
                    passive = base04;
                  };

                  listitems = {
                    active = base0E;
                    passive = base06;
                  };

                  status.color = base03;
                  text = base06;
                  label.color = base0E;
                  border.color = base01;
                  background.color = base00;
                  card.color = base00;
                };

                volume = {
                  input_slider = {
                    puck = base03;
                    backgroundhover = base02;
                    background = base03;
                    primary = base09;
                  };

                  audio_slider = {
                    puck = base03;
                    backgroundhover = base02;
                    background = base03;
                    primary = base09;
                  };

                  icons = {
                    active = base09;
                    passive = base04;
                  };

                  iconbutton = {
                    active = base09;
                    passive = base06;
                  };

                  listitems = {
                    active = base09;
                    passive = base06;
                  };

                  text = base06;
                  label.color = base09;
                  border.color = base01;
                  background.color = base00;
                  card.color = base00;
                };

                media = {
                  slider = {
                    puck = base03;
                    backgroundhover = base02;
                    background = base03;
                    primary = base0E;
                  };

                  buttons = {
                    text = base00;
                    background = base0D;
                    enabled = base0C;
                    inactive = base03;
                  };

                  border.color = base01;
                  card.color = base00;
                  background.color = base00;
                  album = base0E;
                  artist = base0C;
                  song = base0D;
                };
              };

              background = base00;
              border.color = base01;

              buttons = {
                active = base0E;
                default = base0D;
                disabled = base03;
                text = base01;
              };

              cards = base00;

              check_radio_button = {
                active = base0D;
                background = base01;
              };

              dimtext = base03;

              dropdownmenu = {
                background = base00;
                divider = base00;
                text = base06;
              };

              feinttext = base01;

              iconbuttons = {
                active = base0D;
                passive = base06;
              };

              icons = {
                active = base0D;
                passive = base03;
              };

              label = base0D;

              listitems = {
                active = base0D;
                passive = base06;
              };

              popover = {
                background = base01;
                border = base01;
                text = base0D;
              };

              progressbar = {
                background = base02;
                foreground = base0D;
              };

              slider = {
                background = base03;
                backgroundhover = base02;
                primary = base0D;
                puck = base03;
              };

              switch = {
                disabled = base01;
                enabled = base0D;
                puck = base02;
              };

              text = base06;

              tooltip = {
                background = base00;
                text = base06;
              };
            };

            background = base00;
            border.color = base0D;
            buttons = {
              background = base00;
              borderColor = base0D;
              hover = base02;
              icon = base0D;
              icon_background = base00;
              text = base0D;

              battery = {
                background = base00;
                border = base0A;
                icon = base0A;
                icon_background = base0A;
                text = base0A;
              };

              bluetooth = {
                background = base00;
                border = base0D;
                icon = base0D;
                icon_background = base0D;
                text = base0D;
              };

              clock = {
                background = base00;
                border = base0E;
                icon = base0E;
                icon_background = base0E;
                text = base0E;
              };

              dashboard = {
                background = base00;
                border = base0A;
                icon = base0A;
              };

              media = {
                background = base00;
                border = base0D;
                icon = base0D;
                icon_background = base0D;
                text = base0D;
              };

              modules = {
                cava = {
                  background = base00;
                  border = base0C;
                  icon = base0C;
                  icon_background = base00;
                  text = base0C;
                };
                cpu = {
                  background = base00;
                  border = base0E;
                  icon = base0E;
                  icon_background = base00;
                  text = base0E;
                };
                hypridle = {
                  background = base00;
                  border = base0D;
                  icon = base0D;
                  icon_background = base00;
                  text = base0D;
                };
                hyprsunset = {
                  background = base00;
                  border = base0A;
                  icon = base0A;
                  icon_background = base00;
                  text = base0A;
                };
                kbLayout = {
                  background = base00;
                  border = base0D;
                  icon = base0D;
                  icon_background = base00;
                  text = base0D;
                };
                microphone = {
                  background = base00;
                  border = base0B;
                  icon = base0B;
                  icon_background = base00;
                  text = base0B;
                };
                netstat = {
                  background = base00;
                  border = base0B;
                  icon = base0B;
                  icon_background = base00;
                  text = base0B;
                };
                power = {
                  background = base00;
                  border = base00;
                  icon = base08;
                  icon_background = base00;
                };
                ram = {
                  background = base00;
                  border = base0A;
                  icon = base0A;
                  icon_background = base00;
                  text = base0A;
                };
                storage = {
                  background = base00;
                  border = base0D;
                  icon = base0D;
                  icon_background = base00;
                  text = base0D;
                };
                submap = {
                  background = base00;
                  border = base0C;
                  icon = base0C;
                  icon_background = base00;
                  text = base0C;
                };
                updates = {
                  background = base00;
                  border = base0E;
                  icon = base0E;
                  icon_background = base00;
                  text = base0E;
                };
                weather = {
                  background = base00;
                  border = base09;
                  icon = base09;
                  icon_background = base00;
                  text = base09;
                };
                worldclock = {
                  background = base00;
                  border = base0E;
                  icon = base0E;
                  icon_background = base0E;
                  text = base0E;
                };
              };

              network = {
                background = base00;
                border = base0E;
                icon = base0E;
                icon_background = base0E;
                text = base0E;
              };

              notifications = {
                background = base00;
                border = base0D;
                icon = base0D;
                icon_background = base0D;
                total = base0D;
              };

              systray = {
                background = base00;
                border = base02;
                customIcon = base06;
              };

              volume = {
                background = base00;
                border = base09;
                icon = base09;
                icon_background = base09;
                text = base09;
              };

              windowtitle = {
                background = base00;
                border = base0E;
                icon = base0E;
                icon_background = base0E;
                text = base0E;
              };

              workspaces = {
                active = base0E;
                available = base0D;
                background = base00;
                border = base07;
                hover = base02;
                numbered_active_highlighted_text_color = base00;
                numbered_active_underline_color = base07;
                occupied = base08;
              };
            };
          };

          notification = {
            actions.background = base0D;
            actions.text = base01;
            background = base01;
            border = base01;
            close_button.background = base0D;
            close_button.label = base00;
            label = base0D;
            labelicon = base0D;
            text = base06;
            time = base04;
          };

          osd = {
            icon = base00;
            icon_container = base0D;
            label = base0D;
            theme = {
              color = base0D;
              container = base00;
              empty_color = base01;
              overflow_color = base08;
            };
          };
        };
      }
    )
  ];
}
