{config, lib, pkgs, unstable, ...}:
{
  services.jellyfin.enable = true;
  services.jellyseerr.enable = true;

  services.radarr.enable = true;
  services.sonarr.enable = true;
  services.bazarr.enable = true;
  services.prowlarr.enable = true;
  services.lidarr.enable = true;

  services.mealie = {
    enable = true;
    package = unstable.mealie;
  };

  services.transmission = {
    enable = true;
    settings = {
      rpc-host-whitelist-enabled = true;
      rpc-host-whitelist = "127.0.0.1,10.100.0.*,*.local.clespy.fr";
      download-dir = "/media/downloads";
    };
  };

  services.trilium-server = {
    enable = true;
    package = pkgs.trilium-next-server;
    host = "0.0.0.0";
    port = 8181;
  };

  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
  };

  services.glance = {
    enable = true;
    settings = {
      server.port = 61208;
      pages = [
        {
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "calendar";
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "search";
                  search-engine = "duckduckgo";
                }
                {
                  type = "iframe";
		  height = 600;
                  source = "https://picsum.photos/920/600";
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "weather";
		  hour-format = "24h";
          	  location = "Paris, France";
                }
                # {
                #   type = "server-stats";
                # }
              ];
            }
          ];
        }
	{
          name = "News page";
	  columns = [
	    {
              size = "small";
              widgets = [
                {
                  type = "calendar";
                }
                {
                  type = "weather";
                  location = "Paris, France";
                }
                {
                  type = "releases";
                  show-source-icon = true;
                  repositories = [
                    "glanceapp/glance"
                  ];
                }
                {
                  type = "bookmarks";
                  groups = [
                    {
                      title = "Work";
                      color = "200 50 50";
                      links = [
                        {
                          title = "Gmail";
                          url = "https://mail.google.com/mail/u/0/";
                        }
                        {
                          title = "Github";
                          url = "https://github.com/";
                        }
                        {
                          title = "Gitlab";
                          url = "https://gitlab.com/";
                        }
                        {
                          title = "Wikipedia";
                          url = "https://en.wikipedia.org/";
                        }
                      ];
                    }
                    {
                      title = "Entertainment";
                      color = "10 70 50";
                      links = [
                        {
                          title = "Netflix";
                          url = "https://www.netflix.com/";
                        }
                        {
                          title = "YouTube";
                          url = "https://www.youtube.com/";
                        }
                      ];
                    }
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "rss";
                  feeds = [
                     { url = "https://lehollandaisvolant.net/rss.php"; }
                     { url = "https://lehollandaisvolant.net/rss.php?mode=links"; }
                     { url = "https://sebsauvage.net/links/?do=rss"; }
                     { url = "https://lwn.net/headlines/rss"; }
                     { url = "https://ploum.net/atom_fr.xml"; }
                     { url = "https://jvns.ca/atom.xml"; }
                     { url = "https://rachelbythebay.com/w/atom.xml"; }
                     { url = "https://drawings.jvns.ca/index.xml"; }
                     { url = "https://cp-algorithms.com/feed_rss_created.xml"; }
                  ];
                }
                {
                  type = "hacker-news";
                  sort-by = "best";
                }
                {
                  type = "rss";
                  limit = 10;
                  collapse-after = 5;
                  cache = "3h";
                  feeds = [
                    { url = "https://ciechanow.ski/atom.xml"; }
                    { url = "https://www.joshwcomeau.com/rss.xml"; }
                    { url = "https://samwho.dev/rss.xml"; }
                    { url = "https://awesomekling.github.io/feed.xml"; }
                    { url = "https://ishadeed.com/feed.xml"; }
                    { url = "https://blog.cloudflare.com/rss"; }
                    { url = "http://techblog.netflix.com/feeds/posts/default"; }
                    { url = "http://blog.stackoverflow.com/feed/"; }
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "hacker-news";
                }
                {
                  type = "reddit";
                  subreddit = "selfhosted";
                  style = "horizontal-cards";
                  limit = 5;
                }
                {
                  type = "rss";
                  title = "Le Monde";
                  feeds = [
                    { url = "https://www.lemonde.fr/rss/une.xml"; }
                    { url = "https://www.lemonde.fr/politique/rss_full.xml"; }
                    { url = "https://www.lemonde.fr/economie/rss_full.xml"; }
                  ];
                }
                {
                  type = "rss";
                  title = "Nix";
                  feeds = [
                    { url = "https://discourse.nixos.org/c/links.rss"; }
                  ];
                  limit = 3;
                }
              ];
            }
	  ];
	}
      ];
    };
  };

  users.users.radarr.extraGroups = [ "media" ];
  users.users.sonarr.extraGroups = [ "media" ];
  users.users.bazarr.extraGroups = [ "media" ];
  users.users.lidarr.extraGroups = [ "media" ];
  users.users.transmission.extraGroups = [ "media" ];
}
