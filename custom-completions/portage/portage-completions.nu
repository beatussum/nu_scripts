def "nu-complete ebuild list" [] {
  glob *.ebuild
}

def "nu-complete ebuild commands" [] {
  [
    "clean",
    "cleanrm",
    "compile",
    "config",
    "configure",
    "depend",
    "digest",
    "fetch",
    "fetchall",
    "help",
    "info",
    "install",
    "instprep",
    "manifest",
    "merge",
    "nofetch",
    "package",
    "postinst",
    "postrm",
    "preinst",
    "prepare",
    "prerm",
    "pretend",
    "qmerge",
    "rpm",
    "setup",
    "test",
    "unmerge",
    "unpack",
  ]
}

def "nu-complete ebuild --color" [] {
  ["y", "n"]
}

# A a low level interface to the Portage system
export extern "ebuild" [
  --force                                      # When used together with the digest or manifest command, this option forces regeneration of digests for all distfiles associated with the current ebuild. Any distfiles that do not already exist in ${DISTDIR} will be automatically fetched.
  --color: string@"nu-complete ebuild --color" # Enable or disable color output
  --debug                                      # Show debug output
  --version                                    # Show version and exit
  --ignore-default-opts                        # Do not use the EBUILD_DEFAULT_OPTS environment variable
  --skip-manifest                              # skip all manifest checks
  file?: string@"nu-complete ebuild list"
  ...commands: string@"nu-complete ebuild commands"
]
