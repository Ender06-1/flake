{ inputs, ... }:

{
  flake-file.inputs.caelestia-shell.url = "github:caelestia-dots/shell?ref=v2.5.0";

  den.aspects.hyprland-caelestia = {
    nixos = {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };
    };

    homeManager =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        imports = [
          inputs.caelestia-shell.homeManagerModules.default
        ];

        wayland.windowManager.hyprland = {
          enable = true;
          systemd.enable = false;
          package = null;
          portalPackage = null;
          settings = {
            env = [
              {
                _args = [
                  "QT_QPA_PLATFORMTHEME"
                  "qt6ct"
                ];
              }
            ];

            on = {
              _args = [
                "hyprland.start"
                (lib.generators.mkLuaInline ''
                  		function()
                  		    hl.exec_cmd("hyprsunset")
                  		end
                  		'')
              ];
            };

            monitor = [
              {
                output = "desc:AOC 24G2W1G3- 1J4QBHA003151";
                mode = "1920x1080@165.00Hz";
                position = "auto-left";
                scale = 1;
                cm = "auto";
              }

              {
                output = "desc:Samsung Electric Company S24D330 0x5A5A5131";
                mode = "1920x1080@60.00Hz";
                position = "auto-right";
                scale = 1;
                icc = "${./S24D330.icm}";
              }

              {
                output = "";
                mode = "preferred";
                position = "auto";
                scale = "auto";
              }
            ];

            config = [
              ###################
              ## LOOK AND FEEL ##
              ###################
              {
                general = {
                  gaps_in = 2;
                  gaps_out = 10;

                  border_size = 2;

                  col = {
                    active_border = "rgb(c6b569)";
                    inactive_border = "rgb(333231)";
                  };

                  layout = "scrolling";
                };

                decoration = {
                  rounding = 20;

                  shadow.enabled = false;
                  blur.enabled = false;
                };

                animations.enabled = true;

                cursor.no_hardware_cursors = 1;

                misc = {
                  force_default_wallpaper = 0;
                  disable_hyprland_logo = true;
                  disable_splash_rendering = true;
                };

                input = {
                  kb_layout = "us";
                  numlock_by_default = true;
                  repeat_delay = 200;
                  repeat_rate = 40;
                  kb_options = "compose:ralt";
                };

              }
            ];

            workspace_rule = [
              {
                _args = [
                  {
                    workspace = "w[v1]";
                    gaps_out = 20;
                  }
                ];
              }
            ];

            device = [
              {
                _args = [
                  {
                    name = "razer-razer-basilisk-v3";
                    accel_profile = "flat";
                  }
                ];
              }
            ];

            bind =
              let
                mod = "SUPER";
              in
              builtins.concatLists [
                [
                  {
                    _args = [
                      "${mod} + SUPER_L"
                      (lib.generators.mkLuaInline "hl.dsp.global(\"caelestia:launcher\")")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + SHIFT + M"
                      (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"uwsm stop\")")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + SHIFT + Q"
                      (lib.generators.mkLuaInline "hl.dsp.window.close()")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + RETURN"
                      (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"uwsm app -- kitty\")")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + I"
                      (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"uwsm app -- firefox\")")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + L"
                      (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"r\" })")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + H"
                      (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"l\" })")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + J"
                      (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"d\" })")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + K"
                      (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"u\" })")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + SHIFT + L"
                      (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"r\" })")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + SHIFT + H"
                      (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"l\" })")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + SHIFT + J"
                      (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"d\" })")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + SHIFT + K"
                      (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"u\" })")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + F"
                      (lib.generators.mkLuaInline "hl.dsp.window.fullscreen()")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + SHIFT + F"
                      (lib.generators.mkLuaInline "hl.dsp.window.float()")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + P"
                      (lib.generators.mkLuaInline "hl.dsp.global(\"caelestia:lock\")")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + SHIFT + P"
                      (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"systemctl suspend-then-hibernate\")")
                    ];
                  }

                  {
                    _args = [
                      "${mod} + mouse:272"
                      (lib.generators.mkLuaInline "hl.dsp.window.drag()")
                      { mouse = true; }
                    ];
                  }

                  {
                    _args = [
                      "${mod} + mouse:273"
                      (lib.generators.mkLuaInline "hl.dsp.window.resize()")
                      { mouse = true; }
                    ];
                  }

                  {
                    _args = [
                      "XF86AudioMute"
                      (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")")
                      { locked = true; }
                    ];
                  }

                  {
                    _args = [
                      "XF86AudioMicMute"
                      (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle\")")
                      { locked = true; }
                    ];
                  }

                  {
                    _args = [
                      "XF86AudioRaiseVolume"
                      (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+\")")
                      {
                        repeating = true;
                        locked = true;
                      }
                    ];
                  }

                  {
                    _args = [
                      "XF86AudioLowerVolume"
                      (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")")
                      {
                        repeating = true;
                        locked = true;
                      }
                    ];
                  }

                  {
                    _args = [
                      "XF86AudioPlay"
                      (lib.generators.mkLuaInline "hl.dsp.global(\"caelestia:mediaToggle\")")
                      { locked = true; }
                    ];
                  }

                  {
                    _args = [
                      "XF86AudioNext"
                      (lib.generators.mkLuaInline "hl.dsp.global(\"caelestia:mediaNext\")")
                      { locked = true; }
                    ];
                  }

                  {
                    _args = [
                      "XF86AudioPrev"
                      (lib.generators.mkLuaInline "hl.dsp.global(\"caelestia:mediaPrev\")")
                      { locked = true; }
                    ];
                  }

                  {
                    _args = [
                      "XF86AudioStop"
                      (lib.generators.mkLuaInline "hl.dsp.global(\"caelestia:mediaStop\")")
                      { locked = true; }
                    ];
                  }

                ]

                (builtins.genList (i: {
                  _args = [
                    "${mod} + ${toString i}"
                    (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = ${toString i}})")
                  ];
                }) 10)

                (builtins.genList (i: {
                  _args = [
                    "${mod} + SHIFT + ${toString i}"
                    (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = ${toString i}, follow = true })")
                  ];
                }) 10)
              ];

            curve = [
              {
                _args = [
                  "specialWorkSwitch"
                  {
                    type = "bezier";
                    points = [
                      [
                        0.05
                        0.7
                      ]
                      [
                        0.1
                        1
                      ]
                    ];
                  }
                ];
              }
              {
                _args = [
                  "emphasizedAccel"
                  {
                    type = "bezier";
                    points = [
                      [
                        0.3
                        0
                      ]
                      [
                        0.8
                        0.15
                      ]
                    ];
                  }
                ];
              }
              {
                _args = [
                  "emphasizedDecel"
                  {
                    type = "bezier";
                    points = [
                      [
                        0.05
                        0.7
                      ]
                      [
                        0.1
                        1
                      ]
                    ];
                  }
                ];
              }
              {
                _args = [
                  "standard"
                  {
                    type = "bezier";
                    points = [
                      [
                        0.2
                        0
                      ]
                      [
                        0
                        1
                      ]
                    ];
                  }
                ];
              }
            ];

            animation = [
              {
                _args = [
                  {
                    leaf = "layersIn";
                    enabled = true;
                    speed = 5;
                    bezier = "emphasizedDecel";
                    style = "slide";
                  }
                ];
              }
              {
                _args = [
                  {
                    leaf = "layersOut";
                    enabled = true;
                    speed = 4;
                    bezier = "emphasizedAccel";
                    style = "slide";
                  }
                ];
              }
              {
                _args = [
                  {
                    leaf = "fadeLayers";
                    enabled = true;
                    speed = 5;
                    bezier = "standard";
                  }
                ];
              }

              {
                _args = [
                  {
                    leaf = "windowsIn";
                    enabled = true;
                    speed = 5;
                    bezier = "emphasizedDecel";
                  }
                ];
              }
              {
                _args = [
                  {
                    leaf = "windowsOut";
                    enabled = true;
                    speed = 3;
                    bezier = "emphasizedAccel";
                  }
                ];
              }
              {
                _args = [
                  {
                    leaf = "windowsMove";
                    enabled = true;
                    speed = 6;
                    bezier = "standard";
                  }
                ];
              }
              {
                _args = [
                  {
                    leaf = "workspaces";
                    enabled = true;
                    speed = 5;
                    bezier = "standard";
                  }
                ];
              }

              {
                _args = [
                  {
                    leaf = "specialWorkspace";
                    enabled = true;
                    speed = 4;
                    bezier = "specialWorkSwitch";
                    style = "slidefadevert 15%";
                  }
                ];
              }
              {
                _args = [
                  {
                    leaf = "fade";
                    enabled = true;
                    speed = 6;
                    bezier = "standard";
                  }
                ];
              }
              {
                _args = [
                  {
                    leaf = "fadeDim";
                    enabled = true;
                    speed = 6;
                    bezier = "standard";
                  }
                ];
              }
              {
                _args = [
                  {
                    leaf = "border";
                    enabled = true;
                    speed = 6;
                    bezier = "standard";
                  }
                ];
              }
            ];
          };
        };

        programs.caelestia = {
          enable = true;
          cli.enable = true;
          settings = {
            bar = {
              activeWindow = {
                compact = true;
                inverted = false;
              };
              clock = {
                background = true;
                showDate = true;
              };
              statusIcons = [
                {
                  enabled = true;
                  id = "lockStatus";
                }
                {
                  enabled = true;
                  id = "network";
                }
                {
                  enabled = true;
                  id = "bluetooth";
                }
                {
                  enabled = true;
                  id = "microphone";
                }
                {
                  enabled = true;
                  id = "audio";
                }
              ];
              tray.background = true;
              workspaces = {
                activeTrail = true;
                perMonitor = false;
              };
            };
            dashboard = {
              performance.showBattery = false;
              showClockSeconds = true;
            };
            general.apps = {
              terminal = [
                "kitty"
              ];
            };
            launcher = {
              showOnHover = true;
              vimKeybinds = true;
            };
            services = {
              clockFormat = "TwentyFourHour";
              weatherUnits = "Celsius";
            };
            utilities = {
              quickToggles = [
                {
                  enabled = true;
                  id = "wifi";
                }
                {
                  enabled = true;
                  id = "bluetooth";
                }
                {
                  enabled = true;
                  id = "mic";
                }
                {
                  enabled = true;
                  id = "settings";
                }
                {
                  enabled = true;
                  id = "gameMode";
                }
                {
                  enabled = true;
                  id = "dnd";
                }
                {
                  enabled = true;
                  id = "vpn";
                }
              ];
              toasts.chargingChanged = false;
              vpn = {
                enabled = true;
                provider = [
                  {
                    connectCmd = [
                      "tailscale"
                      "up"
                    ];
                    disconnectCmd = [
                      "tailscale"
                      "down"
                    ];
                    displayName = "Tailscale";
                    id = "vpn-mvw7l0ww-2s5xn";
                    interface = "tailscale0";
                    name = "tailscale";
                  }
                ];
                selectedProvider = "vpn-mvw7l0ww-2s5xn";
              };
            };
          };
        };

        home.pointerCursor = {
          enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;

          hyprcursor.enable = true;
        };

        home.packages = with pkgs; [
          hyprpicker
          hyprsunset

          wl-clipboard
          cliphist

          kdePackages.qt6ct
          kdePackages.qt5compat

          papirus-icon-theme
        ];

        xdg = {
          configFile = {
            "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
            "qt6ct/qt6ct.conf".text = ''
              [Appearance]
              icon_theme=Papirus-Dark
            '';
          };
        };
      };
  };
}
