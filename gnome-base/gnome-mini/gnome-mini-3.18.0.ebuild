# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

DESCRIPTION="Somewhere between gnome-base/gnome and gnome-base/gnome-light"
HOMEPAGE="https://www.gnome.org/"
LICENSE="metapackage"
SLOT="3.0"
IUSE="+bluetooth +cdr cups"

KEYWORDS="amd64 x86"

RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}[cups?]
	>=gnome-base/gnome-light-${PV}[gnome-shell,cups?]
	>=gnome-base/gdm-${PV}

	>=app-crypt/gcr-${PV}
	>=gnome-base/gnome-keyring-${PV}
	>=app-crypt/seahorse-${PV}
	>=app-editors/gedit-${PV}
	>=app-text/evince-${PV}
	>=media-gfx/eog-${PV}
	>=media-video/totem-${PV}
	>=x11-terms/gnome-terminal-${PV}
	>=x11-themes/gnome-backgrounds-${PV}
	>=x11-themes/adwaita-icon-theme-${PV}
	>=x11-themes/gnome-themes-standard-${PV}

	>=app-arch/file-roller-3.16.4
	>=gnome-base/dconf-editor-${PV}
	>=gnome-extra/gconf-editor-3
	>=gnome-extra/gnome-power-manager-${PV}
	>=gnome-extra/gnome-system-monitor-${PV}
	>=gnome-extra/gnome-tweak-tool-${PV}
	>=gnome-extra/sushi-${PV}
	>=media-gfx/gnome-font-viewer-3.16.2
	>=media-gfx/gnome-screenshot-${PV}
	>=media-video/cheese-${PV}
	>=net-misc/vinagre-${PV}
	>=sys-apps/gnome-disk-utility-${PV}

	bluetooth? ( >=net-wireless/gnome-bluetooth-${PV} )
	cdr? ( >=app-cdr/brasero-3.12.1 )
"
DEPEND=""
S=${WORKDIR}
