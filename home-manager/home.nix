{ config, pkgs, inputs, ... }: {
  # Initial configuration parts...

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "adnan";
  home.homeDirectory = "/home/adnan";
  home.stateVersion = "23.11";
  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Existing packages...
    qgroundcontrol
    binutils
    git
    gnutls
    ripgrep
    fd
    imagemagick
    zstd
    sqlite
    beancount
    #emacs-gtk
    flyctl
    #mnemosyne
    #anki # may not work no more
    #rescuetime
    jdk17
    deploy-rs
    # dhcp - id address
    # android-studio-canary
    #vlc
    #open-interpreter
    obsidian
    dropbox
    gnomecast

    # New packages for the setup...
    docker
    prometheus
    #grafana
    tailscale
    #nvidia-docker # for Docker support on Jetson Nano
    #robotframework # Useful for robotics testing
    #pytorch

    # Unreal Engine requires some special setup since it's not directly available via Nix packages.
    # You will likely need to manually install it or manage it through another method.
    #dropbox

    ollama
    #nix-shell -p python311Packages.litellm

    #steam
    #slack-term
    #warp.dev
    #deno / bun /
    #GO
    #gnomecast
    # hyprland
    # google-chrome
    #https://xeiaso.net/talks/nixos-pain-2021-11-10/
	#pkgs.emacs
  ];

  # Optionally add configurations for Prometheus and Grafana
  #services.prometheus.enable = true;
  #services.grafana.enable = true;

  # Docker configuration
  #virtualisation.docker.enable = true;

  # Tailscale configuration
  #services.tailscale.enable = true;

  # CI/CD tools (you can choose from Jenkins, GitLab, etc., depending on your preference)
  # Example for Jenkins
  #services.jenkins.enable = true;

  # For PyTorch, you might want to configure specific Python environments using `pythonPackages`
  # Example:
  # python3Packages = with python3Packages; [
  #   numpy
  #   matplotlib
  #   torch
  #   torchvision
  # ];

  # Nix configuration remains as you had it...
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Optional: Adjust session variables or other configurations as needed...
  # home.sessionVariables = {
  #   EDITOR = "emacs";
  # };
}

# { config, pkgs, inputs, ... }: {
# #       imports = [ inputs.hyprland-nix.homeManagerModules.default ];
# # wayland.windowManager.hyprland = {
# #         enable = true;
# #         reloadConfig = true;
# #         systemdIntegration = true;
# #         # recommendedEnvironment = false;
# #         # nvidiaPatches = true;

# #         config = {
# #             # ...
# #         };
# #         # ...
# #     };
#   # Home Manager needs a bit of information about you and the paths it should
#   # manage.
#   #
#   home.username = "adnan";
#   home.homeDirectory = "/home/adnan";

#   # This value determines the Home Manager release that your configuration is
#   # compatible with. This helps avoid breakage when a new Home Manager release
#   # introduces backwards incompatible changes.
#   #
#   # You should not change this value, even if you update Home Manager. If you do
#   # want to update the value, then make sure to first check the Home Manager
#   # release notes.
#   home.stateVersion = "23.11"; # Please read the comment before changing.

#   # The home.packages option allows you to install Nix packages into your
#   # environment.
#   nixpkgs.config.allowUnfree = true;
#   home.packages = with pkgs; [
#     # pkgs.hello
#     # # Adds the 'hello' command to your environment. It prints a friendly
#     # # "Hello, world!" when run.

#     # # It is sometimes useful to fine-tune packages, for example, by applying
#     # # overrides. You can do that directly here, just don't forget the
#     # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
#     # # fonts?
#     # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })


#     # # You can also create simple shell scripts directly inside your
#     # # configuration. For example, this adds a command 'my-hello' to your
#     # # environment:
#     # (pkgs.writeShellScriptBin "my-hello" ''
#     #   echo "Hello, ${config.home.username}!"
#     # sicp.1234.sicp
#     qgroundcontrol
#     binutils
#     git
#     gnutls
#     ripgrep
#     fd
#     imagemagick
#     zstd
#     sqlite
#     beancount
#     emacs-gtk
#     flyctl
#     mnemosyne
#     anki # may not work no more
#     rescuetime
#     jdk17


#     # dhcp - id address
#     # android-studio-canary
#     #vlc
#     #open-interpreter

#     slack
#     #discord / discordo
#     obsidian
#     dropbox


#     #steam
#     #slack-term
#     #warp.dev
#     #deno / bun /
#     #GO
#     gnomecast
#     # hyprland
#     # google-chrome
#     #https://xeiaso.net/talks/nixos-pain-2021-11-10/
# 	#pkgs.emacs
#   ];
#   #withpcre2 ripgrep

#   #x services.tailscale.enable = true;
#     #python -m http.server --bind ::


#   # Home Manager is pretty good at managing dotfiles. The primary way to manage
#   # plain files is through 'home.file'.
#   home.file = {
#     # # Building this configuration will create a copy of 'dotfiles/screenrc' in
#     # # the Nix store. Activating the configuration will then make '~/.screenrc' a
#     # # symlink to the Nix store copy.
#     # ".screenrc".source = dotfiles/screenrc;

#     # # You can also set the file content immediately.
#     # ".gradle/gradle.properties".text = ''
#     #   org.gradle.console=verbose
#     #   org.gradle.daemon.idletimeout=3600000
#     # '';
#   };

#   # Home Manager can also manage your environment variables through
#   # 'home.sessionVariables'. If you don't want to manage your shell through Home
#   # Manager then you have to manually source 'hm-session-vars.sh' located at
#   # either
#   #
#   #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#   #
#   # or
#   #
#   #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
#   #
#   # or
#   #
#   #  /etc/profiles/per-user/adnan/etc/profile.d/hm-session-vars.sh
#   #
#   home.sessionVariables = {
#     # EDITOR = "emacs";
#   };

#   # Let Home Manager install and manage itself.
#   programs.home-manager.enable = true;

#   #programs.hyprland.enable = true;
#   # Optional, hint electron apps to use wayland:
#   # environment.sessionVariables.NIXOS_OZONE_WL = "1";
#   # https://community.fly.io/t/running-reproducible-rust-a-fly-and-nix-love-story/3781
#   #
#   nix = {
#     package = pkgs.nix;

#     settings.experimental-features = [ "nix-command" "flakes" ];
#       };

# }
