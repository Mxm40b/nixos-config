{
  pkgs,
  config,
  inputs,
  ...
}
: 

{
  services =
    {
      safeeyes.enable = false;
      snixembed =
        {
          enable = false;

          beforeUnits =
            [
              # https://github.com/slgobinath/SafeEyes/wiki/How-to-install-backend-for-Safe-Eyes-tray-icon
              "safeeyes.service"
            ];
        };
    };
}
