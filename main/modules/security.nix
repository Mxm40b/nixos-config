{ config, lib, pkgs, inputs, ... }:

{
  security =
    {
      rtkit.enable = true;
      pam.loginLimits =
        [
          #{ domain = "*"; item = "nofile"; type = "-"; value = "32768"; }
          { domain = "*"; item = "memlock"; type = "-"; value = "unlimited"; }
          { domain = "*"; item = "nofile"; type = "-"; value = "524288"; }
          { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
          {
            domain = "@realtime";
            type = "-";
            item = "rtprio";
            value = 98;
          }
          {
            domain = "@realtime";
            type = "-";
            item = "memlock";
            value = "unlimited";
          }
          {
            domain = "@realtime";
            type = "-";
            item = "nice";
            value = -11;
          }
        ];
      polkit =
        {
          enable = true;
          extraConfig =
            ''
                polkit.addRule(function(action, subject) {
              if (subject.local) return "yes";
              });
            '';
        };
      soteria.enable = false;
    };
}
