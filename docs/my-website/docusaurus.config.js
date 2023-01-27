// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require("prism-react-renderer/themes/github");
const darkCodeTheme = require("prism-react-renderer/themes/dracula");

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "Yacine TV",
  tagline: "Documentation",
  url: "https://your-docusaurus-test-site.com",
  baseUrl: "/",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/favicon.ico",

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: "Gwhyyy", // Usually your GitHub org/user name.
  projectName: "PLACEHOLDER", // Usually your repo name.

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },

  presets: [
    [
      "classic",
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          routeBasePath: "/", // Serve the docs at the site's root
          sidebarPath: require.resolve("./sidebars.js"),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            "https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/",
        },
        blog: false,
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      navbar: {
        logo: {
          alt: "TV Logo",
          src: "img/yacine-tv.png",
        },
        items: [
          {
            href: "/",
            label: "Full Documentation",
            position: "left",
          },
          {
            href: "https://github.com/Gwhyyy",
            label: "GitHub",
            position: "right",
          },
          {
            href: "https://codecanyon.net/item/yacine-tv-flutter-live-streaming-sport-events-app-with-admin-panel-built-with-nodejs-mangodb/43194412",
            label: "CodeCanyon",
            position: "left",
          },
        ],
      },
      footer: {
        style: "dark",
        links: [
          {
            title: "Full Documentation",
            items: [
              {
                label: "Full Documentation",
                to: "/docs/intro",
              },
            ],
          },
          {
            title: "About",
            items: [
              {
                label: "CodeCanyon",
                href: "https://codecanyon.net/item/yacine-tv-flutter-live-streaming-sport-events-app-with-admin-panel-built-with-nodejs-mangodb/43194412",
              },
              {
                label: "Developer",
                href: "https://codecanyon.net/user/gwhyyy",
              },
              {
                label: "Facebook",
                href: "https://twitter.com/docusaurus",
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Gwhyyy, Inc. All rights reserved.`,
      },
      prism: {
        theme: darkCodeTheme,
        darkTheme: darkCodeTheme,
      },
    }),
};

module.exports = config;
