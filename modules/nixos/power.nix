{ config, pkgs, ... }:

{
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
       governor = "powersave";
       turbo = "never";
    };
    charger = {
       governor = "performance";
       turbo = "auto";
    };
  };

  # services.tlp = {
  #   enable = false;
  #   settings = {
  #     CPU_BOOST_ON_AC = 1;
  #     CPU_BOOST_ON_BAT = 0;
  #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #   };
  # };
  #
  # services.power-profiles-daemon.enable = false;
  #
  # powerManagement.powertop.enable = false;
  #
  services.thermald.enable = true;
  #
  # #services.tlp = {
  # #  enable = true;
  # #  settings = {
  # #    CPU_SCALING_GOVERNOR_ON_AC = "performance";
  # #    CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
  #
  #    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

  #    CPU_MIN_PERF_ON_AC = 0;
  #    CPU_MAX_PERF_ON_AC = 100;
  #    CPU_MIN_PERF_ON_BAT = 0;
  #    CPU_MAX_PERF_ON_BAT = 80;
  #  };
  #};
}

