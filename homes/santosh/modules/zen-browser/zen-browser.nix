{
  inputs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.default
  ];
  programs.zen-browser = {
    enable = true;

    profiles.default = {
      settings = {
        # Remove the border spacing around the browser content
        "zen.theme.content-element-separation" = 0;
      };
      userChrome = builtins.readFile ./zen-userChrome.css;
    };
  };
}
