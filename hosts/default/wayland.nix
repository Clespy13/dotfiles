{ config, lib, pkgs, ... }:
{
  imports = [
    (import ../../modules/environment/hypr-variables.nix)
    (import ../../modules/environment/common-variables.nix)
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-dark-gtk;
    };
  };

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  home.file.".config/hypr" = {
    source = ./config;
    recursive = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    extraConfig = ''
        '';
  };


#  wayland.windowManager.hyprland = {
#    enable = true;
#    systemd.enable = true;
##enableNvidiaPatches = true;
#    xwayland.enable = true;
#
#    extraConfig = ''
#      $mainMod = MOD4
#      $appMod = ALT SHIFT
#
#      $pictures = ~/Pictures
#
#      monitor = eDP-1,1920x1080@144Hz,0x0,1
#      monitor = DP-2,1920x1080@144Hz,1920x0,1
#      monitor = HDMI-A-1,2560x1440@165Hz,1920x1080,2
#
#      input {
#        kb_layout = fr,
#        kb_options = caps:swapescape
#        numlock_by_default = true
#        repeat_rate = 30
#
#        follow_mouse = 1
#        sensitivity = -0.3
#        accel_profile = "flat"
#
#        touchpad {
#          natural_scroll = true
#          middle_button_emulation = true
#          clickfinger_behavior = true # 1fg = LMB, 2fg = RMB, 3fg = MMB
#          disable_while_typing = false # Like bruh why is it even true by default
#        }
#      }
#
#      general {
#        border_size = 1
#        gaps_in = 5
#        gaps_out = 10
#
#        #cursor_inactive_timeout = 10
#
#        layout = dwindle
#      }
#
#      dwindle {
#        pseudotile = yes
#        preserve_split = yes
#      }
#
#      master {
#      }
#
#      decoration {
#        drop_shadow = yes
#        shadow_range = 4
#        shadow_render_power = 3
#	rounding = 10
#        shadow_offset = [5, 3]
#      }
#
#      animations {
#        enabled = yes
#
#	# Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
#
#	bezier = myBezier, 0.05, 0.9, 0.1, 1.05
#
#	animation = windows, 1, 7, myBezier
#	animation = windowsOut, 1, 7, default, popin 80%
#	animation = border, 1, 10, default
#	animation = borderangle, 1, 8, default
#	animation = fade, 1, 7, default
#	animation = workspaces, 1, 6, default
#      }
#
#      dwindle {
#	# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
#	pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
#	preserve_split = yes # you probably want this
#      }
#
#      gestures {
#        workspace_swipe = true
#        workspace_swipe_fingers = 4
#      }
#
#      misc {
#        disable_hyprland_logo = true
#        disable_splash_rendering = true
#        vrr = 2
#      }
#
#      bind = $mainMod SHIFT, E, exec, hyprctl dispatch exit
#      bind = $mainMod SHIFT, R, exec, hyprctl reload
#      bind = $mainMod, Return, exec, alacritty
#      bind = $mainMod SHIFT, Q, killactive,
#      bind = $mainMod SHIFT, L, exec, swaylock --screenshots --clock --indicator --effect-blur 7x5
#      bind = $mainMod, Print, exec, grimblast --notify --cursor save screen
#      bind = $mainMod SHIFT, S, exec, grimblast copy area
#
#      bind = $mainMod, E, exec, alacritty -e joshuto
#      bind = $mainMod, D, exec, rofi -show drun
#      bind = $appMod, B, exec, nvidia-offload firefox
#      bind = $appMod, S, exec, spotify
#      bind = $appMod, G, exec, steam
#
#      bind = $mainMod, Space, togglefloating,
#      bind = $mainMod, F, fullscreen,
#      bind = $mainMod, P, pseudo,
#      bind = $mainMod, J, togglesplit
#
#      bind = $mainMod, ampersand, workspace, 1
#      bind = $mainMod, eacute, workspace, 2
#      bind = $mainMod, quotedbl, workspace, 3
#      bind = $mainMod, apostrophe, workspace, 4
#      bind = $mainMod, parenleft, workspace, 5
#      bind = $mainMod, minus, workspace, 6
#      bind = $mainMod, egrave, workspace, 7
#      bind = $mainMod, underscore, workspace, 8
#      bind = $mainMod, ccedilla, workspace, 9
#      bind = $mainMod, agrave, workspace, ampersand0
#
#      bind = $mainMod SHIFT, ampersand, movetoworkspace, 1
#      bind = $mainMod SHIFT, eacute, movetoworkspace, 2
#      bind = $mainMod SHIFT, quotedbl, movetoworkspace, 3
#      bind = $mainMod SHIFT, apostrophe, movetoworkspace, 4
#      bind = $mainMod SHIFT, parenleft, movetoworkspace, 5
#      bind = $mainMod SHIFT, minus, movetoworkspace, 6
#      bind = $mainMod SHIFT, egrave, movetoworkspace, 7
#      bind = $mainMod SHIFT, underscore, movetoworkspace, 8
#      bind = $mainMod SHIFT, ccedilla, movetoworkspace, 9
#      bind = $mainMod SHIFT, agrave, movetoworkspace, 0
#
#      bind = $mainMod SHIFT, Left, movewindow, l
#      bind = $mainMod SHIFT, Right, movewindow, r
#      bind = $mainMod SHIFT, Up, movewindow, u
#      bind = $mainMod SHIFT, Down, movewindow, d
#
#      # Move focus with mainMod + arrow keys
#      bind = $mainMod, left, movefocus, l
#      bind = $mainMod, right, movefocus, r
#      bind = $mainMod, up, movefocus, u
#      bind = $mainMod, down, movefocus, d
#
#      # Volume, Brightness, Media
#      bind = , XF86MonBrightnessDown, exec, light -U 5
#      bind = , XF86MonBrightnessUp, exec, light -A 5
#      bind = , XF86AudioMute, exec, pamixer -t 
#      bind = , XF86AudioLowerVolume, exec, pamixer -d 5
#      bind = , XF86AudioRaiseVolume, exec, pamixer -i 5
#      bind = , XF86AudioPrev, exec, playerctl previous
#      bind = , XF86AudioPlay, exec, playerctl play-pause
#      bind = , XF86AudioNext, exec, playerctl next
#
#      # Move/resize windows with mainMod + LMB/RMB and dragging
#      bindm = $mainMod, mouse:272, movewindow
#      bindm = $mainMod, mouse:273, resizewindow
#
#      binde = ,XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +10%
#      binde = ,XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -10% 
#      binde = ,XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
#      binde = ,XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle
#
#      # Brightness
#      binde = ,XF86MonBrightnessUp, exec, light -A 5
#      binde = ,XF86MonBrightnessDown, exec, light -U 5
#
#
#      ### RESIZE/MOVE MODE ###
#      bind = $mainMod, r, submap, resize
#      submap = resize
#      binde = , Left, resizeactive, -40 0
#      binde = , Right, resizeactive, 40 0
#      binde = , Up, resizeactive, 0 -40
#      binde = , Down, resizeactive, 0 40
#      binde = SHIFT, Left, moveactive, -40 0
#      binde = SHIFT, Right, moveactive, 40 0
#      binde = SHIFT, Up, moveactive, 0 -40
#      binde = SHIFT, Down, moveactive, 0 40
#      bind = , escape, submap, reset
#      submap = reset
#      ### END ###
#
##      env = WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0
##      env = LIBVA_DRIVER_NAME,nvidia
##      env = XDG_SESSION_TYPE,wayland
##      env = GBM_BACKEND,nvidia-drm
##      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
##      env = WLR_NO_HARDWARE_CURSORS,1
#
#      # FLOATING TERMINAL (termfloat)
#      windowrulev2 = float, class:(termfloat)
#      windowrulev2 = size 400 400, class:(termfloat) #Moves term to cursor
#      windowrulev2 = move cursor -50% -50%, class:(termfloat)
#
#      # Matches firefox apps
#      windowrule = noblur, ^(firefox(-*)?)$
#
#      # Autostart
#      exec-once = mako &
#      exec-once = waybar &
#      #exec-once = playerctld daemon &
#      #exec-once = swww-daemon &
#    '';
#  };

}
