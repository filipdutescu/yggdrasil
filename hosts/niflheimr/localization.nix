{
  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "ro_RO.UTF-8/UTF-8"
      "es_ES.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_TIME = "en_GB.UTF-8";
    };
  };
}
