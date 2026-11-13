{
  den.aspects.eza.homeManager = {
    programs.eza = {
      enable = true;
      colors = "always";
      extraOptions = [
        "--group-directories-first"
        "--header"
        "--hyperlink"
        "--smart-group"
      ];
      git = true;
      icons = "always";
    };
  };
}
