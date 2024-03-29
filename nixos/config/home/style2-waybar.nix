{ pkgs, config, lib, waybarStyle, ... }:

let
  palette = config.colorScheme.palette;
  inherit (import ../../options.nix) waybarStyle;
in
lib.mkIf ("${waybarStyle}" == "style2") {
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [{
      layer = "top";
      position = "top";

      modules-left = [ "custom/startmenu" "hyprland/window" ];
      modules-center = [ "network" "pulseaudio" "cpu" "hyprland/workspaces" "memory" "disk" "clock" ];
      modules-right = [ "custom/audio_idle_inhibitor" "custom/themeselector" "custom/notification" "battery" "tray" ];
      "hyprland/workspaces" = {
      	format = "{icon}";
      	format-icons = {
          default = " ";
          active = " ";
          urgent = " ";
      	};
      	on-scroll-up = "hyprctl dispatch workspace e+1";
      	on-scroll-down = "hyprctl dispatch workspace e-1";
      };
      "clock" = {
        format = "{: %I:%M %p}";
      	tooltip = false;
      };
      "hyprland/window" = {
      	max-length = 25;
      	separate-outputs = false;
      };
      "memory" = {
      	interval = 5;
      	format = " {}%";
        tooltip = true;
      };
      "cpu" = {
      	interval = 5;
      	format = " {usage:2}%";
        tooltip = true;
      };
      "disk" = {
        format = " {free}";
        tooltip = true;
      };
      "network" = {
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        format-ethernet = " {bandwidthDownOctets}";
        format-wifi = "{icon} {signalStrength}%";
        format-disconnected = "󰤮";
        tooltip = false;
      };
      "tray" = {
        spacing = 12;
      };
      "pulseaudio" = {
        format = "{icon} {volume}% {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = " {volume}%";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
        };
        on-click = "pavucontrol";
      };
      "custom/themeselector" = {
        tooltip = false;
        format = "";
        # exec = "theme-selector";
        on-click = "sleep 0.1 && theme-selector";
      };
      "custom/startmenu" = {
        tooltip = false;
        format = " ";
        # exec = "rofi -show drun";
        on-click = "sleep 0.1 && rofi-launcher";
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
            activated = " ";
            deactivated = " ";
        };
        tooltip = "true";
      };
      "custom/audio_idle_inhibitor" = {
        format = "{icon}";
        exec = "sway-audio-idle-inhibit --dry-print-both-waybar";
        exec-if = "which sway-audio-idle-inhibit";
        return-type = "json";
        format-icons = {
          output = "";
          input = "";
          output-input = "  ";
          none = "";
        };
      };
      "custom/notification" = {
        tooltip = false;
        format = "{icon} {}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
       	};
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "task-waybar";
        escape = true;
      };
      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        on-click = "";
        tooltip = false;
      };
    }];
    style = ''
	* {
		font-size: 14px;
		font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
    		font-weight: bold;
	}
	window#waybar {
		    background-color: #${palette.base00};
    		border-bottom: 1px solid #${palette.base00};
    		border-radius: 0px;
		    color: #${palette.base0F};
	}
	#workspaces {
		    background: #${palette.base01};
    		margin: 4px;
    		padding: 0px 1px;
    		border-radius: 10px;
    		border: 0px;
    		font-style: normal;
    		color: #${palette.base00};
	}
	#workspaces button {
    		padding: 0px 5px;
    		margin: 4px 3px;
    		border-radius: 10px;
    		border: 0px;
    		color: #${palette.base00};
		    background: linear-gradient(45deg, #${palette.base06}, #${palette.base0E});
    		opacity: 0.5;
    		transition: all 0.3s ease-in-out;
	}
	#workspaces button.active {
    		color: #${palette.base00};
		    background: linear-gradient(45deg, #${palette.base06}, #${palette.base0E});
    		border-radius: 10px;
    		min-width: 40px;
    		transition: all 0.3s ease-in-out;
    		opacity: 1.0;
	}
	#workspaces button:hover {
    		color: #${palette.base00};
		    background: linear-gradient(45deg, #${palette.base06}, #${palette.base0E});
    		border-radius: 10px;
    		opacity: 0.8;
	}
	tooltip {
  		background: #${palette.base00};
  		border: 1px solid #${palette.base04};
  		border-radius: 10px;
	}
	tooltip label {
  		color: #${palette.base07};
	}
	#window {
    		color: #${palette.base05};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
	}
	#memory {
    		color: #${palette.base0F};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
	}
	#clock {
    		color: #${palette.base0B};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
	}
	#idle_inhibitor {
    		color: #${palette.base0A};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
	}
	#cpu {
    		color: #${palette.base07};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
	}
	#disk {
    		color: #${palette.base03};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
	}
	#battery {
    		color: #${palette.base08};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
	}
	#network {
    		color: #${palette.base09};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
	}
	#tray {
    		color: #${palette.base05};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
	}
	#pulseaudio {
    		color: #${palette.base0D};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
	}
	#custom-notification {
    		color: #${palette.base0C};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
	}
    #custom-themeselector {
    		color: #${palette.base0D};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px;
    }
	#custom-startmenu {
    		color: #${palette.base03};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 10px 2px 13px;
	}
	#custom-audio_idle_inhibitor {
    		color: #${palette.base09};
    		background: #${palette.base01};
    		border-radius: 10px;
    		margin: 4px;
    		padding: 2px 14px 2px 10px;
	}
    '';
  };
}

