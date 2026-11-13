{
  den.aspects.matheo.yazi.homeManager = { pkgs, ... }: {
    programs.yazi.enable = true;

    home.packages = with pkgs; [
      p7zip
      ffmpeg
      jq
      fd
      ripgrep
      fzf
      resvg
      wl-clipboard
      imagemagick
    ];
  };
}
