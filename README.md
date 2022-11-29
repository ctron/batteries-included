# Batteries Included

> A container image for cloud side scripting.

The goal of this image is to strike a balance between having all tools available for scripting things
in e.g. init containers and jobs, but at the same time keep it small.

## Versions and compatibility

The goal is to have a sem-ver-ish approach. Ideally a newer minor versions can execute the same scripts as
previous minor versions of the same major version.

However, this highly depends on the included tools, which might not follow sem-ver rules.

Also, it is necessary to refresh the base layer, which might already bring newer version. So tracking micro
versions doesn't really make sense.

So let's try this: major versions are a breaking change, minor versions should be backwards compatible, but
might add new tools/features.
