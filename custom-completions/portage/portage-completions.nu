def wrapped_helper []: table<name: string, is_enabled: bool> -> list<string> {
  $in | each { |v| if $v.is_enabled { $v.name } }
}

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

export def "emerge-webrsync" [
  --revert: datetime # Revert to snapshot
  --no-pgp-verify    # Disable PGP verification of snapshot
  --keep (-k)        # Keep snapshots in DISTDIR (don't delete)
  --quiet (-q)       # Only output errors
  --verbose (-v)     # Enable verbose output (no-op)
  --debug (-x)       # Enable debug output
] {
  [
    [name, is_enabled];
    [$"--revert=($revert | format date "%Y%m%d")", ($revert != null)],
    ["--no-pgp-verify", $no_pgp_verify],
    ["--keep", $keep],
    ["--quiet", $quiet],
    ["--verbose", $verbose],
    ["--debug", $debug],
  ]
    | wrapped_helper
    | ^"emerge-webrsync" ...$in
}
